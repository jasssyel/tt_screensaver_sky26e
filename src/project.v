# Tiny Tapeout project information
project:
  title:        "tt_screensaver_project"      # Project title
  author:       "Kevin Martinez, Emilio Cruz, Salvador Pineda"      # Your name
  discord:      ""      # Your discord username, for communication and automatically assigning you a Tapeout role (optional)
  description:  "VGA screensaver bouncing logos (Batman and Superman)"      # One line description of what your project does
  language:     "Verilog" # other examples include SystemVerilog, Amaranth, VHDL, etc
  clock_hz:     25000000        # Clock frequency in Hz (25 MHz para VGA clásico)

  # How many tiles your design occupies? A single tile is about 167x108 uM.
  tiles: "1x1"           # Valid values: 1x1, 1x2, 2x2, 3x2, 4x2, 6x2 or 8x2

  # Tu módulo principal DEBE empezar obligatoriamente con el prefijo "tt_um_"
  top_module:  "tt_um_tt_screensaver_project"

  # List your project's source files here.
  # Source files must be in ./src and you must list each source file separately, one per line.
  # Don't forget to also update `PROJECT_SOURCES` in test/Makefile.
  source_files:
    - "project.v"
    - "hvsync_generator.v"
    - "bitmap_rom.v"

# The pinout of your project. Leave unused pins blank. DO NOT delete or add any pins.
pinout:
  # Inputs
  ui[0]: "mosaic mode"
  ui[1]: "fixed yellow color"
  ui[2]: ""
  ui[3]: ""
  ui[4]: ""
  ui[5]: ""
  ui[6]: ""
  ui[7]: ""

  # Outputs
  uo[0]: "VGA Blue 0"
  uo[1]: "VGA Green 0"
  uo[2]: "VGA Red 0"
  uo[3]: "VGA HSync"
  uo[4]: "VGA Blue 1"
  uo[5]: "VGA Green 1"
  uo[6]: "VGA Red 1"
  uo[7]: "VGA VSync"

  # Bidirectional pins
  uio[0]: ""
  uio[1]: ""
  uio[2]: ""
  uio[3]: ""
  uio[4]: ""
  uio[5]: ""
  uio[6]: ""
  uio[7]: ""

# Do not change!
yaml_version: 6
