-- 1. CZYSZCZENIE STARYCH TABEL (Kolejność ma znaczenie!)
-- ==========================================
DROP TABLE IF EXISTS recenzje CASCADE;
DROP TABLE IF EXISTS zamowienia CASCADE;
DROP TABLE IF EXISTS produkty CASCADE;
DROP TABLE IF EXISTS klienci CASCADE;

-- ==========================================
-- 2. TWORZENIE STRUKTURY BAZY (TABELE)
-- ==========================================

-- Tabela z asortymentem sklepu
CREATE TABLE produkty (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    cena DECIMAL(10, 2) NOT NULL,
    stan_magazynowy INT DEFAULT 0
);

-- Tabela z danymi klientów
CREATE TABLE klienci (
    id SERIAL PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela wiążąca klientów z produktami (zamówienia)
CREATE TABLE zamowienia (
    id SERIAL PRIMARY KEY,
    klient_id INT REFERENCES klienci(id),
    produkt_id INT REFERENCES produkty(id) ON DELETE CASCADE,
    ilosc INT NOT NULL,
    data_zamowienia DATE DEFAULT CURRENT_DATE
);

-- Tabela z opiniami i gwiazdkami od klientów
CREATE TABLE recenzje (
    id SERIAL PRIMARY KEY,
    produkt_id INT REFERENCES produkty(id) ON DELETE CASCADE,
    ocena INT NOT NULL CHECK (ocena >= 1 AND ocena <= 5),
    komentarz VARCHAR(200)
);

-- ==========================================
-- 3. ZASILANIE BAZY DANYCH (DANE TESTOWE)
-- ==========================================

-- Wrzucamy pełny asortyment produktów
INSERT INTO produkty (nazwa, cena, stan_magazynowy) VALUES
('Laptop ASUS', 4500.00, 10),
('Myszka Logitech', 150.00, 40),
('Fotel Diablo', 899.00, 5),
('Słuchawki Razer', 350.00, 15);

-- Wrzucamy konta klientów
INSERT INTO klienci (imie, email) VALUES
('Jan', 'jan@email.com'),
('Anna', 'anna@email.com'),
('Marek', 'marek@email.com');

-- Wrzucamy pierwsze zakupy
INSERT INTO zamowienia (klient_id, produkt_id, ilosc) VALUES
(1, 2, 1),
(2, 1, 1),
(2, 3, 1);

INSERT INTO recenzje (produkt_id, ocena, komentarz) VALUES
(1, 5, 'Super laptop, bardzo szybki!'),
(1, 4, 'Działa świetnie, ale głośny pod obciążeniem'),
(3, 5, 'Wygodny fotel, plecy już nie bolą');

ALTER TABLE klienci ADD COLUMN telefon VARCHAR(20);

UPDATE klienci 
SET telefon = '+48 500 600 700' 
WHERE id = 1;
