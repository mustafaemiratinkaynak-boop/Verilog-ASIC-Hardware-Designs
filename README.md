# Endüstriyel Seviye Verilog ASIC & Donanım Güvenliği Tasarımları

Bu depo; otomotiv güvenliği, endüstriyel kalite kontrol ve donanımsal kriptografik erişim kontrolü alanlarında geliştirilmiş, simülasyon ve elektriksel dalga analizleri ile doğrulanmış 3 adet ASIC (Application-Specific Integrated Circuit) mikroçip tasarımını içermektedir.

Tüm tasarımlar **Icarus Verilog 12.0** derleyicisi kullanılarak simüle edilmiş ve **EPWave** üzerinde zamanlama analizleri (timing diagrams) yapılarak elektriksel olarak doğrulanmıştır.

---

## 1. Otomotiv Motor Güvenlik ve Yağ Koruma Çipi (ASIC)

Yüksek performanslı içten yanmalı motorlar ve hibrit tahrik üniteleri için geliştirilen bu donanım katmanı; sensörlerden gelen sıcaklık, devir ve yağ basıncı verilerini donanımsal mantık kapılarıyla analiz ederek motor bloğunu korur.

### Temel Özellikler
* **Kademeli Fan Kontrolü:** 90°C altında kapalı, 90°C–104°C arasında Düşük Güç (Kademe 1), 105°C ve üzerinde Tam Güç (Kademe 2).
* **Kritik Yağ Basıncı Koruması:** Motor devri 2000 RPM üzerindeyken yağ basıncının 20 PSI altına düşmesi durumunda donanımsal gecikmesiz gaz kesici ve acil alarm aktivasyonu.
* **Aşırı Isınma Kilidi:** 115°C üzeri blok sıcaklığında koruma protokolü devreye girer.

### Doğrulama ve Simülasyon Analizi (EPWave)
![Otomotiv Motor Koruma Dalga Grafiği](Otomotiv_Motor_Koruma_ASICcopy)

---

## 2. Endüstriyel Üretim Bandı Hata Ayıklama ve Siren Çipi (ASIC)

Yüksek hızlı seri üretim hatlarında optik kalınlık sensörlerinden gelen mikron hassasiyetindeki verileri analiz eden gerçek zamanlı kalite kontrol ASIC'i.

### Temel Özellikler
* **Mikronluk Tolerans Denetimi:** 490 µm – 510 µm aralığı dışındaki tüm parçaların anında tespit edilmesi.
* **Pnömatik Hatalı Parça Fırlatma:** Tolerans dışı parçalar tespit edildiğinde mikrosaniyeler içinde pnömatik hava pistonunun tetiklenmesi.
* **Arka Arkaya Hata Zinciri & Acil Durdurma:** Kalıp veya makine arızalarını önlemek amacıyla üst üste 3 hatalı parça algılandığında ana üretim hattını kilitleme ve acil durum sesli sirenini (buzzer) devreye sokma.

### Doğrulama ve Simülasyon Analizi (EPWave)
![Fabrika Kalite Kontrol Dalga Grafiği](Fabrika_Kalite_Kontrol_ve_Siren_ASIC)

---

## 3. Donanımsal Kriptografik Kilit ve HSM Çipi (FSM Mimarisi)

Fiziksel Güvenlik Modülleri (Hardware Security Module - HSM) ve donanımsal kasa kilitleri için tasarlanmış Sonlu Durum Makinesi (Finite State Machine - FSM) tabanlı mikroçip.

### Temel Özellikler
* **FSM Durum Mimarisi:** Yazılımsal bellek (RAM) saldırılarını engellemek adına doğrudan donanım durum geçişleri (`S_BEKLEME` -> `S_HANE_1` -> `S_HANE_2` -> `S_HANE_3` -> `S_ACIK`) ile şifre doğrulama.
* **Donanımsal Bloke Mekanizması:** Arka arkaya 3 hatalı şifre denemesinde çipin kendini kalıcı olarak bloke moduna (`S_BLOKE`) alarak kilitlenmesi.
* **Gecikmesiz Kilit Sinyali:** Doğru 4 basamaklı sekans girildiği anda gecikmesiz `kilit_acildi = 1` çıkışı.

### Doğrulama ve Simülasyon Analizi (EPWave)
![Kripto Kilit Dalga Grafiği](Kripto_Donanim_Kilidi_FSM_ASIC)

---

## Geliştirme ve Simülasyon Ortamı
* **Donanım Tanımlama Dili:** Verilog / SystemVerilog
* **Simülasyon Derleyicisi:** Icarus Verilog 12.0
* **Dalga ve Zamanlama Analiz Aracı:** EPWave
* **Tasarım Mimarisi:** ASIC / RTL Dijital Mantık Tasarımı
