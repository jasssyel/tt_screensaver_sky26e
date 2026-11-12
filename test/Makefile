# Makefile de integración para Cocotb en Tiny Tapeout

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Nombre de tu archivo de pruebas en Python (sin la extensión .py)
MODULE ?= test

# Módulo principal de tu diseño en Verilog
TOPLEVEL ?= tt_um_tt_screensaver_project

# Archivos fuente del proyecto ubicados en src/
VERILOG_SOURCES += $(PWD)/../src/project.v
VERILOG_SOURCES += $(PWD)/../src/hvsync_generator.v
VERILOG_SOURCES += $(PWD)/../src/bitmap_rom.v

# Incluir las reglas comunes de cocotb para compilar y ejecutar
include $(shell cocotb-config --makefiles)/Makefile.sim
