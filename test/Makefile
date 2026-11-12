# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

SRC_DIR = $(PWD)/../src
PROJ_SOURCES = project.v hvsync_generator.v bitmap_rom.v

VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJ_SOURCES)) tb.v
TOPLEVEL = tb
MODULE = test

# Forzar la generación del archivo XML de resultados para GitHub Actions
export COCOTB_RESULTS_FILE = $(PWD)/results.xml

include $(shell cocotb-config --makefiles)/Makefile.sim
