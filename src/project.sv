/*
 * Copyright (c) 2024 Yuri Panchul
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_yuri_panchul_adder_with_flow_control
(
    input  [7:0] ui_in,    // Dedicated inputs
    output [7:0] uo_out,   // Dedicated outputs
    input  [7:0] uio_in,   // IOs: Input path
    output [7:0] uio_out,  // IOs: Output path
    output [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input        ena,      // always 1 when the design is powered, so you can ignore it
    input        clk,      // clock
    input        rst_n     // reset_n - low to reset
);

    //------------------------------------------------------------------------

    // All output pins must be assigned. If not used, assign to 0.

    assign uio_out = '0;
    assign uio_oe  = '0;

    // List all unused inputs to prevent warnings

    wire _unused = & { ena, ui_in [7:2], 1'b0 };

    //------------------------------------------------------------------------

    // User design module instantiation

    wire rst   = ~ rst_n;

    wire left  = ui_in [1];
    wire right = ui_in [0];

    wire       hsync, vsync;
    wire [1:0] red, green, blue;

    game_and_vga i_game_and_vga (.*);

    //------------------------------------------------------------------------

    assign uo_out [0] = red   [1];
    assign uo_out [1] = green [1];
    assign uo_out [2] = blue  [1];
    assign uo_out [3] = vsync;
    assign uo_out [4] = red   [0];
    assign uo_out [5] = green [0];
    assign uo_out [6] = blue  [0];
    assign uo_out [7] = hsync;

endmodule
