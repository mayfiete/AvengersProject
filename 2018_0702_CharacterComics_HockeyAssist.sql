<<<<<<< HEAD

-- truncate table STAGE.CharacterComics_HockeyAssist; 
-- drop table STAGE.CharacterComics_HockeyAssist; 
CREATE TABLE STAGE.CharacterComics_HockeyAssist ( 
	SubCharacterId BIGINT, 
	SubCharacterName varchar(250), 
	SubCharacterDescription varchar(max), 
	SubComicId BIGINT, 
	IsGoodGuy BIT, 
	UniqueId uniqueidentifier default newid() 
); 
GO 
select distinct SubCharacterName 
from STAGE.CharacterComics_HockeyAssist; 
GO 
select *  
=======

-- truncate table STAGE.CharacterComics_HockeyAssist; 
-- drop table STAGE.CharacterComics_HockeyAssist; 
CREATE TABLE STAGE.CharacterComics_HockeyAssist ( 
	SubCharacterId BIGINT, 
	SubCharacterName varchar(250), 
	SubCharacterDescription varchar(max), 
	SubComicId BIGINT, 
	IsGoodGuy BIT, 
	UniqueId uniqueidentifier default newid() 
); 
GO 
select distinct SubCharacterName 
from STAGE.CharacterComics_HockeyAssist; 
GO 
select *  
>>>>>>> 8b0eefac84fe5495a97e9b34101742777100a87b
from STAGE.CharacterComics_HockeyAssist; 