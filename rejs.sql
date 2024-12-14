
SELECT * FROM port;
SELECT * FROM statek;
SELECT * FROM rejs;
SELECT * FROM manifest;

/*
-- zad 1

SELECT r1.statek, r1.dokad AS miejsce1, r1.koniec AS koniec1, r2.skad AS miejsce2, r2.poczatek AS poczatek2
FROM rejs r1, rejs r2
WHERE r2.numer IN (
	SELECT numer FROM rejs r3
	WHERE r3.statek = r1.statek AND r3.poczatek >= r1.koniec AND r1.dokad != r3.skad
	ORDER BY r3.poczatek ASC
	FETCH FIRST 1 ROWS ONLY
);
*/

/*
-- zad 2

WITH przewoz AS (
	SELECT skad, dokad, SUM(ilosc) AS transfer
	FROM rejs JOIN manifest ON rejs.numer = manifest.rejs
	GROUP BY skad, dokad
),
wywoz AS (
	SELECT skad, SUM(transfer) AS wywieziono
	FROM przewoz
	GROUP BY skad
),
dowoz AS (
	SELECT dokad, SUM(transfer) AS dowieziono
	FROM przewoz
	GROUP BY dokad
)
SELECT nazwa, NVL(dowieziono, 0) - NVL(wywieziono, 0) AS bilans
FROM port LEFT JOIN wywoz ON nazwa = skad LEFT JOIN dowoz ON nazwa = dokad
ORDER BY bilans DESC;
*/

/*
-- zad 3

WITH lekkie AS (
	SELECT numer AS rejs, rejs.statek, SUM(NVL(ilosc, 0)) AS przewoz
	FROM rejs LEFT JOIN manifest ON numer = manifest.rejs JOIN statek on rejs.statek = nazwa
	GROUP BY numer, rejs.statek
	HAVING 2 * SUM(NVL(ilosc, 0)) <= MIN(ladownosc)
),
rejsow AS (
	SELECT statek, COUNT(numer) AS ile
	FROM rejs
	GROUP BY statek
)
SELECT rejsow.statek
FROM rejsow JOIN lekkie ON rejsow.statek = lekkie.statek
GROUP BY rejsow.statek, rejsow.ile
HAVING rejsow.ile <= 2 * COUNT(*)
ORDER BY SUM(przewoz) DESC;
*/


/*
-- zad 4

WITH manifest2 AS (
	SELECT rejs, towar, ilosc, ROW_NUMBER() OVER (PARTITION BY rejs ORDER BY ilosc DESC) AS ranga
	FROM manifest
),
tot AS (
	SELECT rejs, SUM(ilosc) AS masa
	FROM manifest2
	GROUP BY rejs
),
top3 AS (
	SELECT rejs, SUM(ilosc) AS masa
	FROM manifest2
	WHERE ranga <= 3
	GROUP BY rejs
)
SELECT COUNT(rejs) FROM (
	SELECT top3.rejs
	FROM tot JOIN top3 ON tot.rejs = top3.rejs
	WHERE 2 * top3.masa <= tot.masa
);
*/

/*

-- zad 5

WITH infekcja(skad, dokad, poczatek, koniec) AS (
	SELECT skad, dokad, poczatek, koniec FROM rejs WHERE numer = 111
	UNION ALL
	SELECT rejs.skad, rejs.dokad, rejs.poczatek, rejs.koniec
	FROM rejs, infekcja
	WHERE rejs.skad = infekcja.dokad AND rejs.poczatek >= infekcja.koniec
)
SELECT dokad AS port, MIN(koniec) AS kiedy
FROM infekcja
GROUP BY dokad;

*/


/*
-- zad 5

SELECT dokad AS port, MIN(koniec) AS kiedy
FROM rejs
START WITH numer = 111
CONNECT BY NOCYCLE PRIOR dokad = skad AND PRIOR koniec <= poczatek
GROUP BY dokad;

*/


/*
-- zad 6

-- część wspólna wszystkich rejsów, które mogły doprowadzić do zarażenia 222, 333, 444 (3 zbiory)
WITH potrejsy AS (
	SELECT * FROM rejs
	START WITH numer = 222 OR numer = 333 OR numer = 444
	CONNECT BY NOCYCLE PRIOR skad = dokad AND PRIOR poczatek >= koniec
)
SELECT numer
FROM potrejsy
GROUP BY numer
HAVING COUNT(numer) = 3;
*/
