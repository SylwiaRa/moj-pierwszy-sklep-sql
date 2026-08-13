SELECT klienci.imie, produkty.nazwa, produkty.cena
FROM klienci
INNER JOIN zamowienia on klienci.id = zamowienia.klient_id
INNER JOIN produkty on zamowienia.produkt_id = produkty.id;

SELECT klienci.imie, SUM(zamowienia.ilosc * produkty.cena) as razem_wydano
FROM klienci
INNER JOIN zamowienia on klienci.id = zamowienia.klient_id
INNER JOIN produkty on zamowienia.produkt_id = produkty.id
GROUP BY klienci.imie
ORDER BY razem_wydano DESC;

SELECT produkty.nazwa, produkty.stan_magazynowy
FROM produkty
WHERE produkty.stan_magazynowy < 10;
