`timescale 1ns / 1ps

module tb_Kalite_Kontrol;
    reg saat;
    reg sifirla;
    reg [15:0] mikron_kalinlik;
    reg parca_sensorde;

    wire hava_pistonu;
    wire sesli_siren;
    wire bant_durdur;
    wire [3:0] ardisik_hata;

    Kalite_Kontrol uut (
        .saat(saat),
        .sifirla(sifirla),
        .mikron_kalinlik(mikron_kalinlik),
        .parca_sensorde(parca_sensorde),
        .hava_pistonu(hava_pistonu),
        .sesli_siren(sesli_siren),
        .bant_durdur(bant_durdur),
        .ardisik_hata(ardisik_hata)
    );

    always #5 saat = ~saat;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_Kalite_Kontrol);

        saat = 0;
        sifirla = 1;
        mikron_kalinlik = 16'd0;
        parca_sensorde = 0;

        #15 sifirla = 0;

        // 1. Parça: Uygun (502 mikron)
        #10;
        parca_sensorde = 1;
        mikron_kalinlik = 16'd502;
        #10 parca_sensorde = 0;

        // 2. Parça: Hatalı (480 mikron)
        #15;
        parca_sensorde = 1;
        mikron_kalinlik = 16'd480;
        #10 parca_sensorde = 0;

        // 3. Parça: Hatalı (525 mikron)
        #15;
        parca_sensorde = 1;
        mikron_kalinlik = 16'd525;
        #10 parca_sensorde = 0;

        // 4. Parça: Hatalı (470 mikron) -> 3. ardışık hata, acil durdurma ve siren!
        #15;
        parca_sensorde = 1;
        mikron_kalinlik = 16'd470;
        #10 parca_sensorde = 0;

        #20;
        $finish;
    end
endmodule
