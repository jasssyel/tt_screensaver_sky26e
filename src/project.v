/*
 * Logo de Batman / Superman rebotando (estilo DVD), cambia de logo cada ~10 s
 * Basado en el ejemplo de Tiny Tapeout (Uri Shaked, Apache-2.0)
 *
 * ui_in[0] = 1 -> repite el logo en mosaico por toda la pantalla
 * ui_in[1] = 1 -> amarillo fijo (0 = colores RGB cambiando)
 */

`default_nettype none

parameter LOGO_W = 128;          // Ancho del logo en pixeles
parameter LOGO_H = 90;           // Alto del logo en pixeles
parameter DISPLAY_WIDTH = 640;   // Ancho VGA
parameter DISPLAY_HEIGHT = 480;  // Alto VGA

module tt_um_tt_screensaver_project (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // VGA signals
  wire hsync;
  wire vsync;
  reg [1:0] R;
  reg [1:0] G;
  reg [1:0] B;
  wire video_active;
  wire [9:0] pix_x;
  wire [9:0] pix_y;

  // Configuration
  wire cfg_tile = ui_in[0];
  wire cfg_yellow = ui_in[1];

  // TinyVGA PMOD
  assign uo_out  = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};

  // Unused outputs assigned to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

  // Suppress unused signals warning
  wire _unused_ok = &{ena, ui_in[7:2], uio_in};

  reg [9:0] prev_y;

  hvsync_generator vga_sync_gen (
      .clk(clk),
      .reset(~rst_n),
      .hsync(hsync),
      .vsync(vsync),
      .display_on(video_active),
      .hpos(pix_x),
      .vpos(pix_y)
  );

  reg [9:0] logo_left;
  reg [9:0] logo_top;
  reg dir_x;
  reg dir_y;

  wire pixel_value;    // parte amarilla / del logo
  wire shield_value;   // rojo del escudo (solo Superman)

  wire [9:0] x = pix_x - logo_left;
  wire [9:0] y = pix_y - logo_top;
  wire logo_pixels = cfg_tile || (x[9:7] == 0 && y < LOGO_H);

  // Alterna Batman <-> Superman cada FRAMES cuadros (60 cuadros = 1 s)
  // Pruebas en el playground: 120 (~2 s). Version final: 600 (~10 s)
  bitmap_rom #(.FRAMES(120)) rom1 (
      .clk(clk),
      .reset(~rst_n),
      .vsync(vsync),
      .x(x[6:0]),
      .y(y[6:0]),
      .pixel(pixel_value),
      .shield(shield_value)
  );

  // Color RGB: rojo -> amarillo -> verde -> cian -> azul -> magenta -> rojo
  reg [2:0] frame_cnt;
  reg [2:0] seg;    // segmento (0..5)
  reg [1:0] ramp;   // rampa 0..3 dentro del segmento
  reg [1:0] cr, cg, cb;

  always @* begin
    case (seg)
      3'd0:    begin cr = 2'd3;        cg = ramp;         cb = 2'd0;        end
      3'd1:    begin cr = 2'd3 - ramp; cg = 2'd3;         cb = 2'd0;        end
      3'd2:    begin cr = 2'd0;        cg = 2'd3;         cb = ramp;        end
      3'd3:    begin cr = 2'd0;        cg = 2'd3 - ramp;  cb = 2'd3;        end
      3'd4:    begin cr = ramp;        cg = 2'd0;         cb = 2'd3;        end
      default: begin cr = 2'd3;        cg = 2'd0;         cb = 2'd3 - ramp; end
    endcase
  end

  // RGB output logic
  always @(posedge clk) begin
    if (~rst_n) begin
      R <= 0;
      G <= 0;
      B <= 0;
    end else begin
      R <= 0;
      G <= 0;
      B <= 0;
      if (video_active && logo_pixels) begin
        if (pixel_value) begin
          R <= cfg_yellow ? 2'd3 : cr;
          G <= cfg_yellow ? 2'd3 : cg;
          B <= cfg_yellow ? 2'd0 : cb;
        end else if (shield_value) begin
          R <= 2'd2;          // escudo rojo de Superman
          G <= 2'd0;
          B <= 2'd0;
        end
      end
    end
  end

  // Bouncing logic + avance del color (una vez por cuadro)
  always @(posedge clk) begin
    if (~rst_n) begin
      logo_left <= 200;
      logo_top <= 200;
      dir_y <= 0;
      dir_x <= 1;
      frame_cnt <= 0;
      seg <= 0;
      ramp <= 0;
    end else begin
      prev_y <= pix_y;
      if (pix_y == 0 && prev_y != pix_y) begin
        logo_left <= logo_left + (dir_x ? 1 : -1);
        logo_top  <= logo_top + (dir_y ? 1 : -1);
        if (logo_left - 1 == 0 && !dir_x) begin
          dir_x <= 1;
        end
        if (logo_left + 1 == DISPLAY_WIDTH - LOGO_W && dir_x) begin
          dir_x <= 0;
        end
        if (logo_top - 1 == 0 && !dir_y) begin
          dir_y <= 1;
        end
        if (logo_top + 1 == DISPLAY_HEIGHT - LOGO_H && dir_y) begin
          dir_y <= 0;
        end

        // el color avanza cada 4 cuadros
        frame_cnt <= frame_cnt + 1;
        if (frame_cnt[1:0] == 2'd3) begin
          ramp <= ramp + 1;
          if (ramp == 2'd3) seg <= (seg == 3'd5) ? 3'd0 : seg + 1;
        end
      end
    end
  end

endmodule
