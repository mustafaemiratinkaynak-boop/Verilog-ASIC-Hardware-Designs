// KRİPTO GÜVENLİK VE DONANIMSAL KİLİT ASIC ÇİPİ (FSM)
module Kripto_Kilit (
    input  wire       saat,
    input  wire       sifirla,
    input  wire       tus_basildi,    // 1 = Kullanıcı bir tuşa bastı
    input  wire [3:0] girilen_tus,    // Basılan tuş (0 - 9 arası)
    output reg        kilit_acildi,   // 1 = Kasa kilidi açıldı
    output reg        sistem_bloke,   // 1 = 3 hatalı deneme, sistem kilitlendi
    output reg  [1:0] kilit_asama     // Şu an şifrenin kaçıncı hanesindeyiz (0, 1, 2, 3)
);

    // FSM Durumları (State Tanımları)
    localparam S_BEKLEME = 3'd0;
    localparam S_HANE_1  = 3'd1;
    localparam S_HANE_2  = 3'd2;
    localparam S_HANE_3  = 3'd3;
    localparam S_ACIK    = 3'd4;
    localparam S_BLOKE   = 3'd5;

    reg [2:0] mevcut_durum;
    reg [1:0] hata_sayaci;

    // Gizli Şifremiz: 4 - 2 - 7 - 9
    always @(posedge saat or posedge sifirla) begin
        if (sifirla) begin
            mevcut_durum <= S_BEKLEME;
            hata_sayaci  <= 2'd0;
            kilit_acildi <= 1'b0;
            sistem_bloke <= 1'b0;
            kilit_asama  <= 2'd0;
        end else if (!sistem_bloke && tus_basildi) begin
            case (mevcut_durum)
                S_BEKLEME: begin
                    if (girilen_tus == 4'd4) begin // 1. Hane Doğru: 4
                        mevcut_durum <= S_HANE_1;
                        kilit_asama  <= 2'd1;
                    end else begin
                        hata_sayaci  <= hata_sayaci + 2'd1;
                        if (hata_sayaci >= 2'd2) sistem_bloke <= 1'b1;
                    end
                end

                S_HANE_1: begin
                    if (girilen_tus == 4'd2) begin // 2. Hane Doğru: 2
                        mevcut_durum <= S_HANE_2;
                        kilit_asama  <= 2'd2;
                    end else begin
                        mevcut_durum <= S_BEKLEME;
                        kilit_asama  <= 2'd0;
                        hata_sayaci  <= hata_sayaci + 2'd1;
                        if (hata_sayaci >= 2'd2) sistem_bloke <= 1'b1;
                    end
                end

                S_HANE_2: begin
                    if (girilen_tus == 4'd7) begin // 3. Hane Doğru: 7
                        mevcut_durum <= S_HANE_3;
                        kilit_asama  <= 2'd3;
                    end else begin
                        mevcut_durum <= S_BEKLEME;
                        kilit_asama  <= 2'd0;
                        hata_sayaci  <= hata_sayaci + 2'd1;
                        if (hata_sayaci >= 2'd2) sistem_bloke <= 1'b1;
                    end
                end

                S_HANE_3: begin
                    if (girilen_tus == 4'd9) begin // 4. Hane Doğru: 9 -> Kasa Açılır
                        mevcut_durum <= S_ACIK;
                        kilit_acildi <= 1'b1;
                        kilit_asama  <= 2'd0;
                    end else begin
                        mevcut_durum <= S_BEKLEME;
                        kilit_asama  <= 2'd0;
                        hata_sayaci  <= hata_sayaci + 2'd1;
                        if (hata_sayaci >= 2'd2) sistem_bloke <= 1'b1;
                    end
                end

                default: mevcut_durum <= S_BEKLEME;
            endcase
        end
    end

endmodule
