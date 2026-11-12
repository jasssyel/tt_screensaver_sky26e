

## How it works

This project implements a classic DVD-style bouncing screensaver on a standard VGA display (640x480 @ 60Hz), tailored for the Tiny Tapeout hardware architecture. It features alternating dynamic logos (Batman and Superman silhouettes with custom pixel ROM bitmaps) moving across the screen and bouncing off the borders.

## Features

- **Bouncing Animation:** Smooth position updates synchronized with vertical sync (`vsync`), reversing direction upon hitting the display boundaries.
- **Logo Alternating Timer:** Automatically transitions between the Batman and Superman icon bitmaps at configurable frame intervals.
- **Dynamic RGB Color Cycling:** Generates smooth, shifting color transitions across the spectrum for the logo pixels.
- **Configurable Inputs (`ui_in`):**
  - `ui_in[0]`: Enables a full-screen mosaic pattern repeating the logo.
  - `ui_in[1]`: Switches the display to a fixed solid yellow color mode.

## External Hardware

- **VGA PMOD:** Connected to the dedicated output pins (`uo_out`) following the TinyVGA standard (utilizing 2 bits per color channel for R, G, B plus HSync and VSync).
