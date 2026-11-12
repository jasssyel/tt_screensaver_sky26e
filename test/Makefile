# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Rutas hacia la carpeta src donde están tus fuentes de Verilog
SRC_DIR = $(PWD)/../src
PROJ_SOURCES = project.v hvsync_generator.v bitmap_rom.v

# Archivos que se van a compilar (incluyendo el testbench tb.v)
VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJ_SOURCES)) tb.v

# Top level del módulo de pruebas (debe coincidir con el nombre en tb.v)
TOPLEVEL = tb

# Módulo de Python que contiene las pruebas con @cocotb.test()
MODULE = test

# Incluir las reglas estándar de cocotb para la simulación
include $(shell cocotb-config --makefiles)/Makefile.sim
