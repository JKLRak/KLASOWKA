-- wypisuje ranking ex aequo, np. 1,1,1,4,5,6,6,8,...
SELECT gatunek, zwrznum,
RANK() OVER (PARTITION BY gatunek ORDER BY waga DESC) AS ranking
FROM zwierzeta
ORDER BY gatunek, ranking;


-- wypisuje normalnie (nie ma miejsca na ex aequo) 1,2,3,4,5,6,7,8,...
SELECT gatunek, zwrznum,
RANK() OVER (PARTITION BY gatunek ORDER BY waga DESC, ROWNUM) AS ranking
FROM zwierzeta
ORDER BY gatunek, ranking;

-- row_number() - unikatowy numer dla każdego wiersza partycji, różne numery przy remisach;
-- rank() - ranking w obrębie partycji, przy remisach ten sam, z lukami;
-- dense_rank() - ranking w obrębie partycji, przy remisach ten sam, bez luk

SELECT id, wplata, RANK() OVER (ORDER BY wplata DESC) AS ranga

SYSDATE
ADD_MONTHS(SYSDATE, -3*12)


-- COUNT(DISTINCT ...) ignoruje powtórzenia
SELECT opknnum, COUNT(DISTINCT zwrznum) FROM opieka GROUP BY opknnum;
SELECT opknnum, COUNT(zwrznum) FROM opieka GROUP BY opknnum;


-- wybiera do zliczania
COUNT (CASE WHEN x = t THEN 1 ELSE 0 END)


x NATURAL JOIN y

x JOIN y ON x.id = y.id



-- zastępuje NULL w kolumnie UnitsOnOrder zerem, przez co nie problemu, że NULL + liczba = NULL
SELECT ProductName, UnitPrice * (UnitsInStock + NVL(UnitsOnOrder, 0))
FROM Products; 

SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
FROM Products; 

SELECT y, SUM(CASE WHEN x IS NULL THEN 0 ELSE x END) FROM tabela GROUP BY y;


-- MAX(x,y)
(CASE WHEN x < y THEN y ELSE x END)



SELECT column_name(s)
FROM table_name
ORDER BY column_name(s)
FETCH FIRST number ROWS ONLY; 


-- konkatenacja z agregacją
SELECT kto, LISTAGG(ile, ';')
FROM sprzedaje
GROUP BY kto;

--konkatenacja stringów
SELECT k1.imie || ' ' || k1.nazwisko, concat(k2.imie, concat(' ', k2.nazwisko)) FROM kand k1, kand k2;


-- CONNECT BY NOCYCLE
-- jeśli moim dzieckiem jest mój rodzic, to mnie nie dodawaj.
-- https://forums.oracle.com/ords/apexds/post/what-do-you-mean-by-connect-by-nocycle-3216
