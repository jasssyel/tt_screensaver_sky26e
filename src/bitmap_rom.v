`default_nettype none

module bitmap_rom #(
    parameter FRAMES = 120
) (
    input  wire        clk,
    input  wire        reset,
    input  wire        vsync,
    input  wire  [6:0] x,      // Coordenada X local
    input  wire  [6:0] y,      // Coordenada Y local
    output reg         pixel,  // Parte amarilla/principal del logo
    output reg         shield  // Parte roja del escudo (si aplica)
);

  // Contador interno para alternar entre frames/logos si lo requieres
  reg [15:0] frame_counter;

  always @(posedge clk) begin
    if (reset) begin
      frame_counter <= 0;
    end else if (vsync) begin
      frame_counter <= frame_counter + 1;
    end
  end

  // Lógica combinacional básica del escudo / bitmap para cumplir con los puertos
  always @(*) begin
    // Zona de dibujo central de prueba (ejemplo 64x64)
    if (x < 64 && y < 64) begin
      pixel  = (x[3] ^ y[3]); // Patrón de prueba geométrico
      shield = (x[4] & y[4]);
    end else begin
      pixel  = 1'b0;
      shield = 1'b0;
    end
  end

  // Bit de guarda para evitar advertencias de variables no usadas
  wire _unused = &{frame_counter[15], FRAMES[0]};

endmodule
