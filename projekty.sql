-- set lin 160;

DROP TABLE zalezy;
DROP TABLE zadanie;

CREATE TABLE zadanie (
  nazwa VARCHAR2(10) PRIMARY KEY, 
  projekt VARCHAR2(10) NOT NULL, 
  procent NUMBER(30),
  osoby NUMBER(2),
  poczatek DATE, 
  koniec DATE
);

CREATE TABLE zalezy (
  co VARCHAR2(10) REFERENCES zadanie,
  od VARCHAR2(10) REFERENCES zadanie,
  CONSTRAINT zalezy_pk PRIMARY KEY (co, od)
);

INSERT INTO zadanie VALUES ('Baza','SKLEP', 50, 1, '15-JAN-2019', '15-MAR-2019');
INSERT INTO zadanie VALUES ('Backend','SKLEP', 50, 2, '1-FEB-2019', '15-MAR-2019');
INSERT INTO zadanie VALUES ('API', 'SKLEP', 30, 1, '1-APR-2019', '30-APR-2019');
INSERT INTO zadanie VALUES ('Frontend', 'SKLEP', 0, 3, '15-JUL-2019', '30-OCT-2019');
INSERT INTO zadanie VALUES ('WWW', 'SKLEP', 0, 2, '20-JUL-2019', '30-OCT-2019');

INSERT INTO zalezy VALUES ('API', 'Baza');
INSERT INTO zalezy VALUES ('API', 'Backend');
INSERT INTO zalezy VALUES ('Frontend', 'API');
INSERT INTO zalezy VALUES ('WWW', 'API');

INSERT INTO zadanie VALUES ('Logika','PASJANS', 100, 1, '1-JAN-2019', '30-JAN-2019');
INSERT INTO zadanie VALUES ('Grafika','PASJANS', 0, 1, '1-MAR-2019', '30-MAR-2019');

INSERT INTO zalezy VALUES ('Grafika', 'Logika');

COMMIT;
-- Rozwiazania zadanñ z klasówki 2019/20, wersja A

-- Wypisz zadania malej±co wg liczby zadañ, od których bezpo¶rednio zale¿±. W przypadku remisów wypisaæ alfabetycznie wg nazw. 

SELECT nazwa, count(od) zalezy_od
FROM zadanie LEFT JOIN zalezy ON nazwa=co
GROUP BY nazwa
ORDER BY zalezy_od DESC;

-- Wypisz wszystkie projekty, które trwaj± d³u¿ej ni¿ ³±czna liczba osobodni sk³adaj±cych siê na nie zadañ.  

SELECT projekt
FROM zadanie
GROUP BY projekt
HAVING (MAX(koniec) - MIN(poczatek) + 1) >= SUM(osoby * (koniec - poczatek + 1));

-- Dla ka¿dego projektu wypisz ilu maksymalnie pracowników pracuje równocze¶nie nad zadaniami tego projektu.

SELECT projekt, MAX(razem) AS max_osob
FROM 
     (SELECT projekt, moment, SUM(osoby) AS razem
     FROM (SELECT DISTINCT projekt as proj, koniec AS moment FROM zadanie), zadanie
     WHERE poczatek <= moment AND moment <= koniec AND proj = projekt
     GROUP BY projekt, moment)
GROUP BY projekt;

-- Dla ka¿dego projektu wypisz liczbê niezrealizowanych zadañ, które nie zale¿± bezposrednio od ¿adnego niezrealizowanego zadania. Zadanie uznajemy za niezrealizowane, je¶li procent jego realizacji jest mniejszy ni¿ 100. 

SELECT projekt, count(*)
FROM zadanie
WHERE procent < 100 AND nazwa NOT IN (
  SELECT co
  FROM zalezy JOIN zadanie ON od = nazwa
  WHERE procent < 100
)
GROUP BY projekt;  

-- Wypisz zadania malej±co wg liczby zadañ, od których zale¿± (nie tylko bezpo¶rednio). W przypadku remisów wypisaæ alfabetycznie wg nazw. 

WITH
zal(co, od) AS (
     SELECT co, od FROM zalezy
     UNION ALL
     SELECT zalezy.co, zal.od FROM zalezy JOIN zal on zalezy.od = zal.co
)
SELECT nazwa, COUNT(DISTINCT od) AS zalezy_od
FROM zadanie LEFT JOIN zal on nazwa = co
GROUP BY nazwa
ORDER BY zalezy_od DESC, nazwa;

SELECT nazwa, COUNT(DISTINCT od) AS zalezy_od
FROM
	(SELECT od, CONNECT_BY_ROOT co AS co
	FROM zalezy
	CONNECT BY prior od = co)
	RIGHT JOIN zadanie ON nazwa = co
GROUP BY nazwa
ORDER BY zalezy_od DESC, nazwa;

-- Dla ka¿dego projektu wypisz minimalny mo¿liwy czas jego realizacji przy którym da siê zapewniæ, ¿e ka¿de zadanie jest rozpoczynane dopiero po ukoñczeniu wszystkich zadañ, od których zale¿y. (RECURSIVE WITH siê przyda)

WITH 
czas(projekt, zad, ile) AS (
     SELECT projekt, nazwa AS zad, koniec - poczatek + 1 AS ile FROM zadanie 
     UNION ALL
     SELECT zadanie.projekt AS projekt, nazwa, koniec - poczatek + 1 + ile
     FROM zadanie
     JOIN zalezy ON nazwa = co
     JOIN czas ON od = zad
)
SELECT projekt, max(ile) FROM czas GROUP BY projekt;





