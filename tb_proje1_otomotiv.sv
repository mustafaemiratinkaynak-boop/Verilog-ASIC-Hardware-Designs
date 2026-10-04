`timescale 1ns / 1ps

module tb_Motor_Koruma;
    reg saat;
    reg [7:0] sicaklik;
    reg [15:0] devir;
    reg [7:0] yag_basinci;

    wire [1:0] fan_kademesi;
    wire gaz_kesici;
    wire acil_alarm;

    Motor_Koruma uut (
        .saat(saat),
        .sicaklik(sicaklik),
        .devir(devir),
        .yag_basinci(yag_basinci),
        .fan_kademesi(fan_kademesi),
        .gaz_kesici(gaz_kesici),
        .acil_alarm(acil_alarm)
    );

    always #5 saat = ~saat;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_Motor_Koruma);

        saat = 0;
        sicaklik = 8'd75;
        devir = 16'd1000;
        yag_basinci = 8'd45;

        #20;
        sicaklik = 8'd95;
        devir = 16'd2500;
        yag_basinci = 8'd42;

        #20;
        sicaklik = 8'd107;
        devir = 16'd3000;
        yag_basinci = 8'd40;

        #20;
        sicaklik = 8'd85;
        devir = 16'd3500;
        yag_basinci = 8'd15;

        #20;
        sicaklik = 8'd80;
        devir = 16'd1500;
        yag_basinci = 8'd40;

        #20;
        $finish;
    end
endmodule
