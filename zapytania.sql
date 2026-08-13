SELECT klienci.imie, produkty.nazwa, produkty.cena
FROM klienci
INNER JOIN zamowienia on klienci.id = zamowienia.klient_id
INNER JOIN produkty on zamowienia.produkt_id = produkty.id;

