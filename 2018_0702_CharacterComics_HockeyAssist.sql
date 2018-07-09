
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
from STAGE.CharacterComics_HockeyAssist; 