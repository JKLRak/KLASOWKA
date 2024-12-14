DROP TABLE opieka;
DROP TABLE opiekunowie;
DROP TABLE zwierzeta;

CREATE TABLE opiekunowie (
  opknnum NUMBER (4) primary key,
  nazwisko VARCHAR2(20),
  zatrudnienie DATE,
  pensja NUMBER(4)
);

CREATE TABLE zwierzeta (
  zwrznum NUMBER (4) primary key,
  gatunek VARCHAR2(20),
  urodzony DATE,
  plec VARCHAR2(10),
  waga NUMBER (5,1),
  miesozernosc NUMBER (3,2),
  dziennespozycie NUMBER (5,2)
);


CREATE TABLE opieka (
  opknnum NUMBER (4) REFERENCES opiekunowie,
  zwrznum NUMBER (4) REFERENCES zwierzeta
);

INSERT INTO opiekunowie VALUES (301, 'Kowalski', '01-FEB-2017', 3000);
INSERT INTO opiekunowie VALUES (302, 'Nowak', '01-FEB-2002', 2500);
INSERT INTO opiekunowie VALUES (303, 'Wisniewski', '09-JAN-1985', 4000);
INSERT INTO opiekunowie VALUES (304, 'Julian', '05-JUL-2013', 2800);
INSERT INTO opiekunowie VALUES (305, 'Walesa', '01-DEC-2000', 3200);
INSERT INTO opiekunowie VALUES (306, 'Pilsudski', '01-JUL-2015', 3300);

INSERT INTO zwierzeta VALUES (701, 'Panda', '05-JUL-2015', 'Samiec', 100, 0.01, 13);
INSERT INTO zwierzeta VALUES (702, 'Panda', '01-JUN-2017', 'Samica', 110, 0.01, 12);
INSERT INTO zwierzeta VALUES (703, 'Panda', '01-JUN-2014', 'Samiec', 140, 0.01, 14);

INSERT INTO zwierzeta VALUES (704, 'Lew', '11-NOV-2011', 'Samiec', 181, 1, 7);
INSERT INTO zwierzeta VALUES (705, 'Lew', '11-NOV-2011', 'Samica', 141, 1, 5);

INSERT INTO zwierzeta VALUES (706, 'Slon', '05-JUL-2005', 'Samiec', 7500, 0, 253);
INSERT INTO zwierzeta VALUES (707, 'Slon', '01-JUN-1998', 'Samica', 4000, 0, 212);
INSERT INTO zwierzeta VALUES (708, 'Slon', '01-JUN-2012', 'Samica', 5000, 0, 264);

INSERT INTO zwierzeta VALUES (709, 'Lemur', '05-JUL-2005', 'Samiec', 3, 0, 0.1);
INSERT INTO zwierzeta VALUES (710, 'Lemur', '01-JUN-2012', 'Samica', 2, 0, 0.2);
INSERT INTO zwierzeta VALUES (711, 'Lemur', '01-JUN-2016', 'Samica', 4, 0, 0.13);
INSERT INTO zwierzeta VALUES (712, 'Lemur', '05-JUL-2017', 'Samica', 3.8, 0, 0.1);
INSERT INTO zwierzeta VALUES (713, 'Lemur', '01-JUN-2011', 'Samica', 2, 0, 0.18);
INSERT INTO zwierzeta VALUES (714, 'Lemur', '01-JUN-2013', 'Samica', 4, 0, 0.3);
INSERT INTO zwierzeta VALUES (715, 'Lemur', '05-JUL-2005', 'Samica', 3, 0, 0.2);
INSERT INTO zwierzeta VALUES (716, 'Lemur', '01-JUN-2014', 'Samica', 2, 0, 0.01);
INSERT INTO zwierzeta VALUES (717, 'Lemur', '01-JUN-2013', 'Samica', 4, 0, 0.08);

INSERT INTO zwierzeta VALUES (801, 'Tygrys', '05-MAR-2011', 'Samiec', 210, 1, 6);
INSERT INTO zwierzeta VALUES (802, 'Tygrys', '06-JUN-2015', 'Samica', 150, 1, 4);
INSERT INTO zwierzeta VALUES (803, 'Tygrys', '01-JUN-2014', 'Samica', 140, 1, 5);

INSERT INTO zwierzeta VALUES (804, 'Szympans', '01-JUN-2011', 'Samica', 55, 0.15, 1);
INSERT INTO zwierzeta VALUES (805, 'Szympans', '01-JUN-2016', 'Samiec', 55, 0.15, 1.1);
INSERT INTO zwierzeta VALUES (806, 'Szympans', '01-JUN-2017', 'Samiec', 55, 0.15, 1.2);
INSERT INTO zwierzeta VALUES (807, 'Szympans', '01-JUN-1985', 'Samica', 55, 0.15, 0.9);

INSERT INTO opieka VALUES (306, 709);
INSERT INTO opieka VALUES (306, 701);
INSERT INTO opieka VALUES (305, 807);
INSERT INTO opieka VALUES (305, 806);
INSERT INTO opieka VALUES (305, 706);
INSERT INTO opieka VALUES (305, 707);
INSERT INTO opieka VALUES (305, 708);
INSERT INTO opieka VALUES (304, 709);
INSERT INTO opieka VALUES (304, 710);
INSERT INTO opieka VALUES (304, 711);
INSERT INTO opieka VALUES (304, 712);
INSERT INTO opieka VALUES (304, 713);
INSERT INTO opieka VALUES (304, 714);
INSERT INTO opieka VALUES (304, 715);
INSERT INTO opieka VALUES (304, 716);
INSERT INTO opieka VALUES (304, 717);
INSERT INTO opieka VALUES (303, 802);
INSERT INTO opieka VALUES (303, 714);
INSERT INTO opieka VALUES (303, 801);
INSERT INTO opieka VALUES (303, 804);
INSERT INTO opieka VALUES (303, 804);
INSERT INTO opieka VALUES (303, 701);
INSERT INTO opieka VALUES (303, 701);
INSERT INTO opieka VALUES (303, 701);
INSERT INTO opieka VALUES (303, 807);

INSERT INTO opieka VALUES (302, 704);
INSERT INTO opieka VALUES (302, 705);
INSERT INTO opieka VALUES (302, 801);
INSERT INTO opieka VALUES (302, 802);
INSERT INTO opieka VALUES (302, 803);
INSERT INTO opieka VALUES (301, 701);
INSERT INTO opieka VALUES (301, 704);
INSERT INTO opieka VALUES (301, 713);
INSERT INTO opieka VALUES (301, 714);
INSERT INTO opieka VALUES (301, 801);
INSERT INTO opieka VALUES (301, 804);
INSERT INTO opieka VALUES (301, 805);
INSERT INTO opieka VALUES (301, 806);

-- Rozwiazania zadan z klasowki 2018/19, wersja A


-- 1. Wypisz zwięrzęta, które urodziły się wcześniej niż któryś z ich opiekunów został zatrudniony.

SELECT DISTINCT zwrznum, gatunek
FROM zwierzeta NATURAL JOIN opieka NATURAL JOIN opiekunowie
WHERE urodzony < zatrudnienie
ORDER BY zwrznum ASC;


-- 2. Dla każdego z opiekunów wypisz ilość mięsa, które musi dostarczyć swoim podopiecznym. (W przypadku gdy zwierzę ma więcej niż jednego opiekuna zakładamy, że dzielą się obowiązkami po równo.)

WITH zoo AS (
  SELECT DISTINCT o.*, z.*
  FROM opiekunowie o
       LEFT JOIN opieka ON opieka.opknnum = o.opknnum
       LEFT JOIN zwierzeta z ON opieka.zwrznum = z.zwrznum 
) 
SELECT
  opknnum,
  nazwisko,
  SUM(miesozernosc * dziennespozycie/(
    SELECT count(DISTINCT opknnum)
    FROM opieka
    WHERE zwrznum = zoo.zwrznum
  )) ile_miesa
FROM zoo
GROUP BY opknnum, nazwisko
ORDER BY opknnum;


-- 3. Okazuje się że opieka nad całkowicie mięsożernymi zwierzętami jest niebiezpieczna. Napisz zapytanie wyliczające podwyżkę dla każdego opiekuna w wysokości tylu procent jego pensji, ile procent z jego podopiecznych jest całkowicie mięsożerne.

WITH zoo AS (
  SELECT DISTINCT o.*, z.*
  FROM opiekunowie o
       LEFT JOIN opieka ON opieka.opknnum = o.opknnum
       LEFT JOIN zwierzeta z ON opieka.zwrznum = z.zwrznum 
) 
SELECT
  opknnum,
  nazwisko,
  pensja / count(*) * sum(
    CASE
	WHEN miesozernosc = 1 THEN 1
ELSE 0
    END
  ) podwyzka
FROM zoo
GROUP BY opknnum, nazwisko, pensja
ORDER BY opknnum;

-- 4.Kowalski zginął w nieszczęśliwym wypadku. Zwierzęta, których był jedynym opiekunem, muszą mieć przypisanego nowego opiekuna. Aby uniknąć wypadków w przyszłości, kierownictwo zdecydowało się każdemu "osieroconemu" zwierzęciu przypisać najbardziej doświadczonego opiekuna. Napisz zapytanie, które dla każdego zwierzęcia X, które było pod wyłączną opieką Kowalskiego, wypisuje opiekuna najstarszego stażem spośród tych, którzy już zajmują jakimś zwierzęciem tego samego gatunku co X. Dla pozostałych zwierząt wypisz null (czyli puste miejsce).


WITH doswiadczeni AS (
  SELECT DISTINCT
    gatunek, opknnum, nazwisko,
    dense_rank() over (PARTITION BY gatunek
	 	      ORDER BY zatrudnienie) rank
  FROM zwierzeta NATURAL JOIN opieka NATURAL JOIN opiekunowie
  WHERE nazwisko <> 'Kowalski'
),
osierocone AS (
  SELECT DISTINCT zwrznum
  FROM opieka NATURAL JOIN opiekunowie
  GROUP BY zwrznum
  HAVING count(*) = 1 and min(nazwisko) = 'Kowalski'
)
SELECT z.zwrznum, z.gatunek, d.opknnum, d.nazwisko
FROM zwierzeta z
     LEFT JOIN osierocone o ON z.zwrznum = o.zwrznum
     LEFT JOIN doswiadczeni d ON z.gatunek = d.gatunek
     	       		AND rank = 1
			AND o.zwrznum IS NOT NULL;

WITH doswiadczeni AS (
  SELECT DISTINCT
    gatunek, opknnum, nazwisko,
    dense_rank() over (PARTITION BY gatunek
	 	      ORDER BY zatrudnienie) rank
  FROM zwierzeta NATURAL JOIN opieka NATURAL JOIN opiekunowie
  WHERE nazwisko <> 'Kowalski'
)
SELECT z.zwrznum, z.gatunek, d.opknnum, d.nazwisko
FROM zwierzeta z LEFT JOIN doswiadczeni d
     ON z.gatunek = d.gatunek AND rank = 1 AND zwrznum in (
       	SELECT zwrznum
       	FROM opieka NATURAL JOIN opiekunowie
       	GROUP BY zwrznum
       	HAVING count(DISTINCT opknum) = 1
	       AND min(nazwisko) = 'Kowalski'
     );

WITH doswiadczeni AS (
  SELECT DISTINCT
    gatunek, opknnum, nazwisko,
    dense_rank() over (PARTITION BY gatunek
	 	      ORDER BY zatrudnienie) rank
  FROM zwierzeta NATURAL JOIN opieka NATURAL JOIN opiekunowie
  WHERE nazwisko <> 'Kowalski'
)
SELECT z.zwrznum, z.gatunek, d.opknnum, d.nazwisko
FROM zwierzeta z LEFT JOIN doswiadczeni d
  ON z.gatunek = d.gatunek AND rank = 1
    AND 1 = (SELECT count(DISTINCT opknnum)
    	     FROM opieka WHERE zwrznum=z.zwrznum)
    AND 'Kowalski' in (SELECT nazwisko
	               FROM opieka NATURAL JOIN opiekunowie
	               WHERE zwrznum=z.zwrznum);

-- 5. Zbliża się okres godowy w ZOO i kierownictwo zastanawia się nad zatrudnieniem nowej położnej. Dla każdego gatunku wypisz 5 najcięższych samic spośród tych, które mają co najmniej 3 lata.

SELECT zwrznum, gatunek, waga FROM (
  SELECT zwierzeta.*,
  	 rank() over (PARTITION BY gatunek
       		      ORDER BY waga DESC, zwrznum) pozycja 
  FROM zwierzeta
  WHERE plec = 'Samica'
  	AND urodzony <= add_months(SYSDATE, -3*12)
)
WHERE pozycja <= 5
ORDER BY gatunek, pozycja;



-- 6. Odszkodowanie za śmierć Kowalskiego okazało się zbyt duże dla ZOO, trzeba będzie przyciąć koszty. Wypisz wszystkie zwierzęta w kolejności miesięcznych kosztów ich utrzymania. Załóż że pensja opiekunów rozkłada się równomiernie pomiędzy zwierzęta, kilogram mięsa kosztuje 5zł, natomiast kilogram roślin 1zł.

WITH opiekaIle AS (
  SELECT DISTINCT
    zwrznum,
    opknnum,
    (SELECT count(DISTINCT zwrznum)
     FROM opieka o
     WHERE o.opknnum = opieka.opknnum) ile
  FROM opieka
  ORDER BY zwrznum, opknnum
)
SELECT
  zwierzeta.*,
  (4 * miesozernosc + 1) * dziennespozycie * 30 + (
    SELECT NVL(sum(pensja/ile),0)
    FROM opiekaIle NATURAL JOIN opiekunowie
    WHERE zwrznum=zwierzeta.zwrznum
   ) koszt
FROM zwierzeta
ORDER BY koszt; 


-- 7. Niektórzy pracownicy mają swoich pupilków. Wypisz dla każdego pracownika zwierzę, którym się zajmuje najdłużej, sposród tych których jest jedynym opiekunem.

WITH jedyni AS (
  SELECT zwrznum, min(opknnum) opknnum
  FROM opieka
  GROUP BY zwrznum
  HAVING count(distinct opknnum) = 1
), zoo AS (
SELECT o.opknnum, o.nazwisko, o.zatrudnienie,
       z.zwrznum, z.gatunek, z.urodzony,
       greatest(zatrudnienie, urodzony) kiedy
FROM opiekunowie o LEFT JOIN jedyni j ON o.opknnum = j.opknnum
     		   LEFT JOIN zwierzeta z ON j.zwrznum = z.zwrznum
)
SELECT opknnum, nazwisko, zatrudnienie, zwrznum, gatunek, urodzony
FROM 
  (SELECT zoo.*, rank() over (PARTITION BY opknnum
      	   	             ORDER BY kiedy, zwrznum) rank
  FROM zoo)
WHERE rank <=1;






