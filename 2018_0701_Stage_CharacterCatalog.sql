<<<<<<< HEAD
/* 
	Contains list of all characters fetched 
	from the Marvel API 
*/
-- drop table STAGE.CharacterCatalog; 
-- truncate table STAGE.CharacterCatalog; 
CREATE TABLE STAGE.CharacterCatalog ( 
	CharacterId BIGINT, 
	CharacterName varchar(250), 
	CharacterDescription varchar(max), 
	ComicId BIGINT, 
	UniqueId uniqueidentifier default newid() 

); 
GO 
/*
select count(*) from Stage.CharacterCatalog; 

select * from Stage.CharacterCatalog; 

select distinct CharacterName 
from Stage.CharacterCatalog
*/
=======
/* 
	Contains list of all characters fetched 
	from the Marvel API 
*/
-- drop table STAGE.CharacterCatalog; 
-- truncate table STAGE.CharacterCatalog; 
CREATE TABLE STAGE.CharacterCatalog ( 
	CharacterId BIGINT, 
	CharacterName varchar(250), 
	CharacterDescription varchar(max), 
	ComicId BIGINT, 
	UniqueId uniqueidentifier default newid() 

); 
GO 
/*
select count(*) from Stage.CharacterCatalog; 

select * from Stage.CharacterCatalog; 

select distinct CharacterName 
from Stage.CharacterCatalog
*/
>>>>>>> 8b0eefac84fe5495a97e9b34101742777100a87b
