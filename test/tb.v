//# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
//# SPDX-License-Identifier: Apache-2.0

import os
from cocotb_tools.runner import get_runner

def test_runner():
   // # Seleccionamos el simulador Icarus Verilog
    runner = get_runner("icarus")
    
  //  # Compilamos los archivos fuente del proyecto ubicados en ../src/
    runner.build(
        sources=[
            os.path.join("../src", "project.v"),
            os.path.join("../src", "hvsync_generator.v"),
            os.path.join("../src", "bitmap_rom.v"),
        ],
        hdl_toplevel="tt_um_tt_screensaver_project",
        waves=True,  //# Habilita la generación de ondas (.vcd / .fst)
    )
    
   // # Ejecutamos las pruebas definidas en test.py
    runner.test(
        hdl_toplevel="tt_um_tt_screensaver_project",
        test_module="test", // # Busca el archivo test.py
        waves=True,
       extra_env={"PYTHONPATH": os.path.abspath("."), "COCOTB_RESULTS_FILE": "results.xml"},
    )

if __name__ == "__main__":
    test_runner()
