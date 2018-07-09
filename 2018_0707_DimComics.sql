<<<<<<< HEAD





IF OBJECT_ID('Heroes.DimComicSeries') IS NOT NULL DROP TABLE Heroes.DimComicSeries; 
GO 
CREATE TABLE Heroes.DimComicSeries ( 
	DimComicSeriesId INT PRIMARY KEY IDENTITY(1,1), 
	SeriesID INT UNIQUE, 
	SeriesName varchar(250), 
	ComicsInSeries INT, 
	UniqueId uniqueidentifier default newid() 
); 
GO  
IF OBJECT_ID('Heroes.DimComic') IS NOT NULL DROP TABLE Heroes.DimComic; 
GO 
CREATE TABLE Heroes.DimComic ( 
	DimComicId INT PRIMARY KEY IDENTITY(1,1), 
	ComicId INT UNIQUE, 
	ComicName varchar(250), 
	IssueNumber INT, 
	DimComicSeriesId INT, 
	ComicSequence INT, 
	IsSeriesConclusion BIT, 
	UniqueId uniqueidentifier default newid() 
); 
GO  
ALTER TABLE Heroes.DimComic 
	ADD CONSTRAINT FK_DimComic_DimComicSeriesId 
		FOREIGN KEY (DimComicSeriesId) 
			REFERENCES Heroes.DimComicSeries (DimComicSeriesId); 


IF OBJECT_ID('tempdb..#Temp_Comics') IS NOT NULL DROP TABLE #Temp_Comics; 
;with Comics AS ( 
		select  
			ComicID, 
			ComicName, 
			IssueNumber, 
			SeriesId, 
			SeriesName, 
			RANK() OVER (PARTITION BY SeriesId ORDER BY ComicId ASC) AS ComicSequence
		from Stage.ComicDetails
		--order by SeriesId ASC; 
		), 
	LastComic AS ( 
		select *, MAX(ComicSequence) OVER (PARTITION BY SeriesId) AS LastInSeries 
		from Comics 
		) 
select 
	ComicId, 
	ComicName,
	IssueNumber, 
	SeriesId, 
	SeriesName, 
	ComicSequence,   
	COUNT(ComicId) OVER (PARTITION BY SeriesId) AS ComicsInSeries, 
	CASE 
		WHEN ComicSequence = LastInSeries THEN CAST(1 AS BIT) 
		ELSE CAST(0 AS BIT) 
	END AS IsSeriesConclusion 
				INTO #Temp_Comics
from LastComic; 

INSERT INTO Heroes.DimComicSeries ( 
	SeriesId, 
	SeriesName, 
	ComicsInSeries 
) 
		select 
			SeriesId, 
			SeriesName, 
			ComicsInSeries
		from (
		select distinct 
			SeriesId, 
			SeriesName, 
			ComicsInSeries
		from #Temp_Comics
			)  AS X; 


INSERT INTO Heroes.DimComic ( 
	ComicId, 
	ComicName, 
	IssueNumber, 
	DimComicSeriesId, 
	ComicSequence, 
	IsSeriesConclusion
) 
select 
	C.ComicId, 
	C.ComicName, 
	C.IssueNumber, 
	DC.DimComicSeriesId, 
	C.ComicSequence, 
	C.IsSeriesConclusion 
from #Temp_Comics C
	join Heroes.DimComicSeries DC with (nolock) 
		ON C.SeriesId = DC.SeriesId 
-- select * from Heroes.DimComic


select * 
from Heroes.DimComicSeries; 

select * 
from Heroes.DimComic; 
=======





IF OBJECT_ID('Heroes.DimComicSeries') IS NOT NULL DROP TABLE Heroes.DimComicSeries; 
GO 
CREATE TABLE Heroes.DimComicSeries ( 
	DimComicSeriesId INT PRIMARY KEY IDENTITY(1,1), 
	SeriesID INT UNIQUE, 
	SeriesName varchar(250), 
	ComicsInSeries INT, 
	UniqueId uniqueidentifier default newid() 
); 
GO  
IF OBJECT_ID('Heroes.DimComic') IS NOT NULL DROP TABLE Heroes.DimComic; 
GO 
CREATE TABLE Heroes.DimComic ( 
	DimComicId INT PRIMARY KEY IDENTITY(1,1), 
	ComicId INT UNIQUE, 
	ComicName varchar(250), 
	IssueNumber INT, 
	DimComicSeriesId INT, 
	ComicSequence INT, 
	IsSeriesConclusion BIT, 
	UniqueId uniqueidentifier default newid() 
); 
GO  
ALTER TABLE Heroes.DimComic 
	ADD CONSTRAINT FK_DimComic_DimComicSeriesId 
		FOREIGN KEY (DimComicSeriesId) 
			REFERENCES Heroes.DimComicSeries (DimComicSeriesId); 


IF OBJECT_ID('tempdb..#Temp_Comics') IS NOT NULL DROP TABLE #Temp_Comics; 
;with Comics AS ( 
		select  
			ComicID, 
			ComicName, 
			IssueNumber, 
			SeriesId, 
			SeriesName, 
			RANK() OVER (PARTITION BY SeriesId ORDER BY ComicId ASC) AS ComicSequence
		from Stage.ComicDetails
		--order by SeriesId ASC; 
		), 
	LastComic AS ( 
		select *, MAX(ComicSequence) OVER (PARTITION BY SeriesId) AS LastInSeries 
		from Comics 
		) 
select 
	ComicId, 
	ComicName,
	IssueNumber, 
	SeriesId, 
	SeriesName, 
	ComicSequence,   
	COUNT(ComicId) OVER (PARTITION BY SeriesId) AS ComicsInSeries, 
	CASE 
		WHEN ComicSequence = LastInSeries THEN CAST(1 AS BIT) 
		ELSE CAST(0 AS BIT) 
	END AS IsSeriesConclusion 
				INTO #Temp_Comics
from LastComic; 

INSERT INTO Heroes.DimComicSeries ( 
	SeriesId, 
	SeriesName, 
	ComicsInSeries 
) 
		select 
			SeriesId, 
			SeriesName, 
			ComicsInSeries
		from (
		select distinct 
			SeriesId, 
			SeriesName, 
			ComicsInSeries
		from #Temp_Comics
			)  AS X; 


INSERT INTO Heroes.DimComic ( 
	ComicId, 
	ComicName, 
	IssueNumber, 
	DimComicSeriesId, 
	ComicSequence, 
	IsSeriesConclusion
) 
select 
	C.ComicId, 
	C.ComicName, 
	C.IssueNumber, 
	DC.DimComicSeriesId, 
	C.ComicSequence, 
	C.IsSeriesConclusion 
from #Temp_Comics C
	join Heroes.DimComicSeries DC with (nolock) 
		ON C.SeriesId = DC.SeriesId 
-- select * from Heroes.DimComic


select * 
from Heroes.DimComicSeries; 

select * 
from Heroes.DimComic; 
>>>>>>> 8b0eefac84fe5495a97e9b34101742777100a87b
