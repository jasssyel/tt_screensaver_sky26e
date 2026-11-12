import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def tt_um_tt_screensaver_project(dut):
    """
    Testbench para verificar el proyecto VGA tt_um_vga_example
    """
    # 1. Iniciar reloj principal (periodo de 10 ns -> 100 MHz)
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())

    # 2. Inicializar señales de control y entradas (Reset activo en bajo: rst_n)
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await Timer(100, unit="ns")

    # Liberar el reset
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1
    dut._log.info("Reset liberado. Iniciando simulación del proyecto VGA...")

    # 3. Probar cambios en las entradas de configuración (ui_in)
    await Timer(50, unit="us")
    dut.ui_in.value = 2  # Activa modo amarillo
    dut._log.info("Cambiando a modo amarillo...")

    await Timer(50, unit="us")
    dut.ui_in.value = 1  # Activa modo tile
    dut._log.info("Cambiando a modo tile...")

    # 4. Dejar correr la simulación para capturar ondas suficientes
    await Timer(100, unit="us")
    dut._log.info("Simulación finalizada exitosamente.")
