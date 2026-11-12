from cocotb_tools.runner import get_runner

def test_runner():
    runner = get_runner("icarus")

    runner.build(
        sources=[
            "../src/project.v",
            "../src/hvsync_generator.v",
            "../src/bitmap_rom.v",
        ],
        hdl_toplevel="tt_um_tt_screensaver_project",
        waves=True,
    )

    runner.test(
        hdl_toplevel="tt_um_tt_screensaver_project",
        test_module="test",
        results_xml="results.xml",
    )

if __name__ == "__main__":
    test_runner()
