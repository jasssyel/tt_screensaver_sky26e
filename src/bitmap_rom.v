`default_nettype none

module bitmap_rom (
    input  wire [6:0] x, // Coordenada X dentro del logo (0 a 127)
    input  wire [6:0] y, // Coordenada Y dentro del logo (0 a 79)
    output reg        pixel
);

  // Cuadro delimitador del escudo (64x64 píxeles) centrado en la región 128x80
  // X de 32 a 95 | Y de 8 a 71
  wire in_bounds = (x >= 7'd32 && x < 7'd96) && (y >= 7'd8 && y < 7'd72);

  // Coordenadas locales lx (0 a 63) y ly (0 a 63)
  wire [5:0] lx = x[5:0] - 6'd32;
  wire [5:0] ly = y[5:0] - 6'd8;

  // Centro del logo en (31, 31). Calculamos desplazamientos sin usar $signed implícito
  wire [6:0] dx = (lx >= 6'd31) ? (lx - 6'd31) : (6'd31 - lx);
  wire [6:0] dy = (ly >= 6'd31) ? (ly - 6'd31) : (6'd31 - ly);

  // Distancia al cuadrado desde el centro: r^2 = dx^2 + dy^2
  wire [13:0] r2 = (dx * dx) + (dy * dy);

  // 1. Anillo/Línea circular exterior finita (Radio ~31)
  wire outer_ring = (r2 >= 14'd880) && (r2 <= 14'd961);

  // 2. Anillo circular intermedio fino (Radio ~23)
  wire inner_ring = (r2 >= 14'd484) && (r2 <= 14'd545);

  // 3. Cuadrado blanco central (delimitado entre lx=17..45 y ly=17..45)
  wire square_box = (lx >= 6'd17 && lx <= 6'd45) && (ly >= 6'd17 && ly <= 6'd45);

  // 4. Círculo negro interior recortado dentro del cuadrado (Radio ~13 -> r^2 <= 169)
  wire inner_black_circle = (r2 <= 14'd169);

  // 5. Cruz blanca central (en el centro exacto de 64x64)
  wire cross_v = (lx >= 6'd28 && lx <= 6'd35) && (ly >= 6'd20 && ly <= 6'd43);
  wire cross_h = (ly >= 6'd28 && ly <= 6'd35) && (lx >= 6'd20 && lx <= 6'd43);
  wire is_cross = cross_v || cross_h; // Renombrado a is_cross para evitar conflicto

  always @(*) begin
    if (!in_bounds) begin
      pixel = 1'b0;
    end else begin
      // Lógica de capas del escudo
      if (outer_ring || inner_ring) begin
        pixel = 1'b1; // Anillos exteriores
      end else if (is_cross) begin
        pixel = 1'b1; // Cruz blanca sobre el círculo negro
      end else if (inner_black_circle) begin
        pixel = 1'b0; // Hueco/Círculo negro detrás de la cruz
      end else if (square_box) begin
        pixel = 1'b1; // Cuadrado blanco contenedor
      end else begin
        pixel = 1'b0; // Fondo negro del logo
      end
    end
  end

  // Bit de guarda para evitar advertencias por variables no usadas
  wire _unused = &{x[6], y[6]};

endmodule
