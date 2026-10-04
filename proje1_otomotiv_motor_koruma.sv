// GELİŞMİŞ MOTOR VE YAĞ KORUMA ÇİPİ (ASIC)
module Motor_Koruma (
    input  wire        saat,
    input  wire [7:0]  sicaklik,
    input  wire [15:0] devir,
    input  wire [7:0]  yag_basinci,
    output reg  [1:0]  fan_kademesi,
    output reg         gaz_kesici,
    output reg         acil_alarm
);

always @(posedge saat) begin
    // 1. Fan Kademesi Kontrolü
    if (sicaklik >= 8'd105)
        fan_kademesi <= 2'b10; // 105°C üstü: 2. Kademe (Tam Güç)
    else if (sicaklik >= 8'd90)
        fan_kademesi <= 2'b01; // 90°C - 104°C arası: 1. Kademe (Düşük Hız)
    else
        fan_kademesi <= 2'b00; // 90°C altı: Fan kapalı

    // 2. Kritik Güvenlik ve Yağ Koruması
    if (yag_basinci < 8'd20 && devir > 16'd2000) begin
        gaz_kesici <= 1'b1;
        acil_alarm <= 1'b1;
    end else if (sicaklik >= 8'd115) begin
        gaz_kesici <= 1'b1;
        acil_alarm <= 1'b1;
    end else begin
        gaz_kesici <= 1'b0;
        acil_alarm <= 1'b0;
    end
end

endmodule
