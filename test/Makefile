# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import os
from cocotb_tools.runner import get_runner

def test_runner():
    runner = get_runner("icarus")
    
    # Compilación indicando la ruta correcta hacia la carpeta src/
    runner.build(
        sources=[
            os.path.join("../src", "project.v"),
            os.path.join("../src", "hvsync_generator.v"),
            os.path.join("../src", "bitmap_rom.v"),
        ],
        hdl_toplevel="tt_um_tt_screensaver_project",
        waves=True,
    )
    
    # Ejecución del testbench indicando que el módulo de pruebas es test.py
    # y forzando la salida del results.xml donde GitHub Actions lo espera
    runner.test(
        hdl_toplevel="tt_um_tt_screensaver_project",
        test_module="test",  # Apunta al archivo test.py que contiene el @cocotb.test()
        waves=True,
        extra_env={
            "PYTHONPATH": os.path.abspath("."),
            "COCOTB_RESULTS_FILE": "results.xml"
        },
    )

if __name__ == "__main__":
    test_runner()
