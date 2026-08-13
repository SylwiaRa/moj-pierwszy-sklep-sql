DROP TABLE IF EXISTS zamowienia CASCADE;
DROP TABLE IF EXISTS produkty CASCADE;
DROP TABLE IF EXISTS klienci CASCADE;

CREATE TABLE produkty (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    cena DECIMAL(10, 2) NOT NULL,
    stan_magazynowy INT DEFAULT 0
);

CREATE TABLE klienci (
    id SERIAL PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE zamowienia (
    id SERIAL PRIMARY KEY,
    klient_id INT REFERENCES klienci(id),
    produkt_id INT REFERENCES produkty(id),
    ilosc INT NOT NULL,
    data_zamowienia DATE DEFAULT CURRENT_DATE
);

INSERT INTO produkty (nazwa, cena, stan_magazynowy) VALUES
('Laptop ASUS', 4500.00, 10),
('Myszka Logitech', 150.00, 40),
('Fotel Diablo', 899.00, 5);

INSERT INTO klienci (imie, email) VALUES
('Jan', 'jan@email.com'),
('Anna', 'anna@email.com'),
('Marek', 'marek@email.com');

INSERT INTO zamowienia (klient_id, produkt_id, ilosc) VALUES
(1, 2, 1),
(2, 1, 1),
(2, 3, 1);