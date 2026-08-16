-- 1. Wyświetlenie listy klientów wraz z zakupionymi produktami i ich cenami
SELECT klienci.imie, produkty.nazwa, produkty.cena
FROM klienci
INNER JOIN zamowienia on klienci.id = zamowienia.klient_id
INNER JOIN produkty on zamowienia.produkt_id = produkty.id;

-- 2. Podsumowanie łącznych wydatków każdego klienta (od najwyższej kwoty)
SELECT klienci.imie, SUM(zamowienia.ilosc * produkty.cena) as razem_wydano
FROM klienci
INNER JOIN zamowienia on klienci.id = zamowienia.klient_id
INNER JOIN produkty on zamowienia.produkt_id = produkty.id
GROUP BY klienci.imie
ORDER BY razem_wydano DESC;

-- 3. Sprawdzenie produktów, których stan magazynowy jest niski (poniżej 10 sztuk)
SELECT produkty.nazwa, produkty.stan_magazynowy
FROM produkty
WHERE produkty.stan_magazynowy < 10;

-- 4. Aktualizacja stanu magazynowego dla Fotela Diablo (id = 3) po dostawie
UPDATE produkty
SET stan_magazynowy = 25
WHERE id = 3;

-- 5. Podgląd całej tabeli produktów po aktualizacji stanu
SELECT * FROM produkty;

-- 6. Usunięcie produktu o id = 2 (najpierw usuwamy powiązane zamówienie, potem produkt)
DELETE FROM zamowienia WHERE produkt_id=2;
DELETE FROM produkty WHERE id = 2;

-- 7. Podgląd tabeli produktów po usunięciu Myszki Logitech
SELECT * FROM produkty;

-- 8. Obliczenie średniej oceny (zaokrąglonej do 1 miejsca) dla każdego produktu
SELECT produkty.nazwa, ROUND(AVG(recenzje.ocena), 1) AS srednia_ocena FROM produkty
INNER JOIN recenzje ON recenzje.produkt_id = produkty.id
GROUP BY produkty.nazwa;

-- Wrzucamy oceny (liczniki ID na pewno startują od 1)
INSERT INTO recenzje (produkt_id, ocena, komentarz) VALUES
(1, 5, 'Super laptop, bardzo szybki!'),
(1, 4, 'Działa świetnie, ale głośny pod obciążeniem'),
(3, 5, 'Wygodny fotel, plecy już nie bolą');

-- Sprawdzamy filtrowanie HAVING dla produktów ze średnią powyżej 4.0
SELECT produkty.nazwa, ROUND(AVG(recenzje.ocena), 1) AS srednia_ocena 
FROM produkty
INNER JOIN recenzje ON recenzje.produkt_id = produkty.id
GROUP BY produkty.nazwa
HAVING AVG(recenzje.ocena) > 4.0;
