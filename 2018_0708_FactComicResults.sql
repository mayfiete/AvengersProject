<<<<<<< HEAD
 

IF OBJECT_ID('Heroes.FactComicResults') IS NOT NULL DROP TABLE Heroes.FactComicResults; 
GO 

 CREATE TABLE Heroes.FactComicResults ( 
	FactComicResultsId INT PRIMARY KEY IDENTITY(1,1), 
	DimCharacterId INT, 
	DimComicId INT, 
	DimComicSeriesId INT, 
	IsSeriesConclusion BIT, 
	ComicSequence INT, 
	UniqueId uniqueidentifier default newid() 
 ); 
 GO 

 INSERT INTO Heroes.FactComicResults ( 
	DimCharacterId, 
	DimComicId, 
	DimComicSeriesId, 
	IsSeriesConclusion, 
	ComicSequence
 ) 
 select 
	DCh.DimCharacterId, 
	DC.DimComicId, 
	DC.DimComicSeriesId, 
	IsSeriesConclusion, 
	ComicSequence
 from Stage.CharacterCatalog CC with (nolock) 
	join Heroes.DimComic DC with (nolock) 
		ON CC.ComicId = DC.ComicId 
	join Heroes.DimCharacter DCh with (nolock) 
		ON DCh.CharacterId = CC.CharacterId; 

GO 

select * 
from Heroes.FactComicResults; 
=======
 

IF OBJECT_ID('Heroes.FactComicResults') IS NOT NULL DROP TABLE Heroes.FactComicResults; 
GO 

 CREATE TABLE Heroes.FactComicResults ( 
	FactComicResultsId INT PRIMARY KEY IDENTITY(1,1), 
	DimCharacterId INT, 
	DimComicId INT, 
	DimComicSeriesId INT, 
	IsSeriesConclusion BIT, 
	ComicSequence INT, 
	UniqueId uniqueidentifier default newid() 
 ); 
 GO 

 INSERT INTO Heroes.FactComicResults ( 
	DimCharacterId, 
	DimComicId, 
	DimComicSeriesId, 
	IsSeriesConclusion, 
	ComicSequence
 ) 
 select 
	DCh.DimCharacterId, 
	DC.DimComicId, 
	DC.DimComicSeriesId, 
	IsSeriesConclusion, 
	ComicSequence
 from Stage.CharacterCatalog CC with (nolock) 
	join Heroes.DimComic DC with (nolock) 
		ON CC.ComicId = DC.ComicId 
	join Heroes.DimCharacter DCh with (nolock) 
		ON DCh.CharacterId = CC.CharacterId; 

GO 

select * 
from Heroes.FactComicResults; 
>>>>>>> 8b0eefac84fe5495a97e9b34101742777100a87b
