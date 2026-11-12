import os
from cocotb_tools.runner import get_runner

def test_runner():
    runner = get_runner("icarus")
    
    # Compilación de todos los módulos del diseño
    runner.build(
        sources=["project.v", "hvsync_generator.v", "bitmap_rom.v"],
        hdl_toplevel="tt_um_tt_screensaver_project",
        waves=True,  # Activa la generación de ondas (.fst / .vcd)
    )
    
    # Ejecución del testbench indicando la ruta absoluta del directorio actual
    runner.test(
        hdl_toplevel="tt_um_tt_screensaver_project",
        test_module="project_tb",
        waves=True,
        extra_env={"PYTHONPATH": os.path.abspath(".")},
    )

if __name__ == "__main__":
    test_runner()
