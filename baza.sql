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
