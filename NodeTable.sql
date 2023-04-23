USE master;

DROP DATABASE
IF EXISTS Project;
CREATE DATABASE Project;

USE Project
GO

CREATE TABLE Owner (
	id INT NOT NULL PRIMARY KEY
	,name NVARCHAR(50) NOT NULL
	) AS NODE
GO

CREATE TABLE City (
	id INT NOT NULL PRIMARY KEY
	,name NVARCHAR(30) NOT NULL
	,region NVARCHAR(30) NOT NULL
	) AS NODE
GO

CREATE TABLE Cinema (
	id INT NOT NULL PRIMARY KEY
	,name NVARCHAR(50) NOT NULL
	,city NVARCHAR(30) NOT NULL
	) AS NODE;
GO


INSERT INTO Owner (id,name)
VALUES      (1,
             N'Никита'),
            ( 2,
              N'Антон' ),
            ( 3,
              N'Даниил' ),
            ( 4,
              N'Олег' ),
            ( 5,
              N'Машука' ),
            ( 6,
              N'Ведьма' ),
            ( 7,
              N'Пётр' ),
            ( 8,
              N'Саня' ),
            ( 9,
              N'Альберт' ),
            ( 10,
              N'Падре' );
GO

--SELECT *
--FROM Owner;

INSERT INTO City (id,NAME,region)
VALUES      ( 1,
              N'Минск',
              N'Минская' ),
            ( 2,
              N'Борисов',
              N'Минская' ),
            ( 3,
              N'Гомель',
              N'Гомельская ' ),
            ( 4,
              N'Брест',
              N'Брестская' ),
            ( 5,
              N'Гродно',
              N'Гродненская' ),
            ( 6,
              N'Полоцк',
              N'Витебская' ),
            ( 7,
              N'Калинковичи',
              N'Гомельская' ),
            ( 8,
              N'Светлогорск',
              N'Гомельская' ),
            ( 9,
              N'Новополоцк',
              N'Витебская' ),
            ( 10,
              N'Солигорск',
              N'Минская' );
GO

--SELECT *
--FROM City;

INSERT INTO Cinema (id,NAME,city)
VALUES     ( 1,
              N'Skyline',
              N'Минск' ),
            ( 2,
              N'Мир',
              N'Борисов' ),
            ( 3,
              N'Октябрь',
              N'Гомель' ),
            ( 4,
              N'Маладосць',
              N'Брест' ),
            ( 5,
              N'Беларусь',
              N'Минск' ),
            ( 6,
              N'Зорка Венера',
              N'Солигорск' ),
            ( 7,
              N'Родина',
              N'Полоцк' ),
            ( 8,
              N'Кинотеатр Минск',
              N'Новополоцк' ),
            ( 9,
              N'Спутник',
              N'Светлогорск' ),
            ( 10,
              N'Гастелло',
              N'Гродно' ),
			  ( 11,
              N'Знамя',
              N'Калинковичи' );
GO
--SELECT *
--FROM Cinema;

CREATE TABLE PartnerOf AS EDGE;
ALTER TABLE PartnerOf
ADD CONSTRAINT EC_OwnerOf CONNECTION (Owner TO Owner);

CREATE TABLE LivesIn AS EDGE;
ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (Owner TO City);

CREATE TABLE LocatedIn AS EDGE;
ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Cinema TO City);

CREATE TABLE OwnerOf (invested MONEY) AS EDGE;
ALTER TABLE OwnerOf
ADD CONSTRAINT EC_Likes CONNECTION (Owner TO Cinema);
GO

INSERT INTO PartnerOf (
	$FROM_ID
	,$TO_ID
	)
VALUES (
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 1
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 2
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 1
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 5
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 2
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 3
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 3
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 1
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 3
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 6
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 4
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 2
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 5
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 4
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 6
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 7
		)
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 7
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 10
		)
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 10
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 9
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 6
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 8
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 8
		)
	,(
		SELECT $NODE_ID
		FROM Owner
		WHERE id = 3
		)
	);
GO

SELECT *
FROM PartnerOf;

INSERT INTO LivesIn (
	$FROM_ID
	,$TO_ID
	)
VALUES (
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 1
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 1
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 2
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 2
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 3
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 4
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 4
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 3
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 5
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 8
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 10
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 9
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 6
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 6
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 7
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 10
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 9
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 5
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 8
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 7
		)
	);
GO

Select *
From LivesIn


INSERT INTO LocatedIn (
	$FROM_ID
	,$TO_ID
	)
VALUES (
	(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 1
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 1
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 2
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 2
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 3
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 3
		)
	)
	,(
	(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 4
		)
	,(
		SELECT $NODE_ID
		FROM City
		WHERE ID = 4
		)
	);
GO

INSERT INTO OwnerOf (
	$FROM_ID
	,$TO_ID
	,invested
	)
VALUES (
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 1
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 1
		)
	,103234
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 2
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID =2
		)
	,812341
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 3
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 3
		)
	,953253
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 4
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 3
		)
	,75463
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 5
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID =11
		)
	,22345
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 6
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 4
		)
	,10532
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 6
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 5
		)
	,4521
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 7
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 6
		)
	,10232
	)
	,(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 7
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 7
		)
	,2951
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 8
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 8
		)
	,7295
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 9
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 1
		)
	,23981
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 9
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 9
		)
	,1178
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 9
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 10
		)
	,5091
	),(
	(
		SELECT $NODE_ID
		FROM Owner
		WHERE ID = 10
		)
	,(
		SELECT $NODE_ID
		FROM Cinema
		WHERE ID = 11
		)
	,234
	)
	;
GO

Select *
from OwnerOf

SELECT Owner1.name
	,Owner2.name AS [Partner name]
FROM Owner AS Owner1
	,PartnerOf
	,Owner AS Owner2
WHERE MATCH(Owner1 - (PartnerOf) - > Owner2)
	AND Owner1.name = N'Антон';

SELECT Owner1.name
	,Cinema.name AS Property
FROM Owner AS Owner1
	,OwnerOf
	,Cinema AS Cinema
WHERE MATCH(Cinema < - (OwnerOf) - Owner1)
	AND Owner1.name = N'Даниил';

SELECT Owner1.name + N' Сотрудничает с ' + Owner2.name AS Level1
	,Owner2.name + N' Сотрудничает с ' + Owner3.name AS Level2
FROM Owner AS Owner1
	,PartnerOf AS partner1
	,Owner AS Owner2
	,PartnerOf AS partner2
	,Owner AS Owner3
WHERE MATCH(Owner1 - (partner1) - > Owner2 - (partner2) - > Owner3)
	AND Owner1.name = N'Антон';

SELECT Owner2.name AS Owner
	,Cinema.name AS Cinema
	,OwnerOf.invested
FROM Owner AS Owner1
	,Owner AS Owner2
	,OwnerOf
	,PartnerOf
	,Cinema
WHERE MATCH(Owner1 - (PartnerOf) - > Owner2 - (OwnerOf) - > Cinema)
	AND Owner1.name = N'Даниил';

SELECT Owner3.name AS Owner
	,Cinema.name AS Cinema
	,OwnerOf.invested
FROM Owner AS Owner1
	,Owner AS Owner2
	,Owner AS Owner3
	,OwnerOf
	,PartnerOf AS PartnerOf1
	,PartnerOf AS PartnerOf2
	,Cinema
WHERE MATCH(Owner1 - (PartnerOf1) - > Owner2 - (PartnerOf2) - > Owner3 - (OwnerOf) - > Cinema)
	AND Owner1.name = N'Никита';

SELECT Owner1.name AS OwnerName
	,STRING_AGG(Owner2.name, '->') WITHIN
GROUP (GRAPH PATH) AS Partners
FROM Owner AS Owner1
	,PartnerOf
FOR PATH AS fo
	,Owner
FOR PATH AS Owner2
WHERE MATCH(SHORTEST_PATH(Owner1(- (fo) - > Owner2) +))
	AND Owner1.name = N'Антон';

SELECT Owner1.name AS OwnerName
	,STRING_AGG(Owner2.name, '->') WITHIN
GROUP (GRAPH PATH) AS Partners
FROM Owner AS Owner1
	,PartnerOf
FOR PATH AS fo
	,Owner
FOR PATH AS Owner2
WHERE MATCH(SHORTEST_PATH(Owner1(- (fo) - > Owner2) {1,3}))
	AND Owner1.name = N'Антон';