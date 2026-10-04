`timescale 1ns / 1ps

module tb_Kripto_Kilit;
    reg saat;
    reg sifirla;
    reg tus_basildi;
    reg [3:0] girilen_tus;

    wire kilit_acildi;
    wire sistem_bloke;
    wire [1:0] kilit_asama;

    Kripto_Kilit uut (
        .saat(saat),
        .sifirla(sifirla),
        .tus_basildi(tus_basildi),
        .girilen_tus(girilen_tus),
        .kilit_acildi(kilit_acildi),
        .sistem_bloke(sistem_bloke),
        .kilit_asama(kilit_asama)
    );

    always #5 saat = ~saat;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_Kripto_Kilit);

        saat = 0;
        sifirla = 1;
        tus_basildi = 0;
        girilen_tus = 4'd0;

        #15 sifirla = 0;

        // Şifre: 4 - 2 - 7 - 9
        #10; girilen_tus = 4'd4; tus_basildi = 1;
        #10; tus_basildi = 0;

        #15; girilen_tus = 4'd2; tus_basildi = 1;
        #10; tus_basildi = 0;

        #15; girilen_tus = 4'd7; tus_basildi = 1;
        #10; tus_basildi = 0;

        #15; girilen_tus = 4'd9; tus_basildi = 1;
        #10; tus_basildi = 0;

        #30;
        $finish;
    end
endmodule
