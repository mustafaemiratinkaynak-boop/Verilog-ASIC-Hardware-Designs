// ENDÜSTRİYEL KALİTE KONTROL VE SİREN ASIC ÇİPİ
module Kalite_Kontrol (
    input  wire        saat,
    input  wire        sifirla,
    input  wire [15:0] mikron_kalinlik,
    input  wire        parca_sensorde,
    output reg         hava_pistonu,
    output reg         sesli_siren,
    output reg         bant_durdur,
    output reg  [3:0]  ardisik_hata
);

always @(posedge saat or posedge sifirla) begin
    if (sifirla) begin
        hava_pistonu  <= 1'b0;
        sesli_siren   <= 1'b0;
        bant_durdur   <= 1'b0;
        ardisik_hata  <= 4'd0;
    end else begin
        if (parca_sensorde && !bant_durdur) begin
            // 490 mikron altı veya 510 mikron üstü = Hatalı Parça
            if (mikron_kalinlik < 16'd490 || mikron_kalinlik > 16'd510) begin
                hava_pistonu <= 1'b1; // Hatalı parçayı fırlat
                
                if (ardisik_hata >= 4'd2) begin
                    // 3. ardışık hata: Acil durum
                    ardisik_hata <= ardisik_hata + 4'd1;
                    sesli_siren  <= 1'b1;
                    bant_durdur  <= 1'b1;
                end else begin
                    ardisik_hata <= ardisik_hata + 4'd1;
                end
            end else begin
                // Parça sağlam
                hava_pistonu <= 1'b0;
                ardisik_hata <= 4'd0;
            end
        end else begin
            hava_pistonu <= 1'b0;
        end
    end
end

endmodule
