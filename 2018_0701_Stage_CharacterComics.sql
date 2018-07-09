
/* 
	We are fetching data at too degrees of separation from 
	those that appear with Thanos in comic books. The reason 
	being: It's not just the characters that defeated Thanos, 
	but it's the journey that they embarked on to defeat 
	Thanos 
*/
-- drop table STAGE.CharacterComics; 
-- truncate table Stage.CharacterComics; 
CREATE TABLE STAGE.CharacterComics ( 
	CharacterId BIGINT, 
	CharacterName varchar(250), 
	ResourceURI varchar(100), 
	ComicId BIGINT, 
	SubComicId BIGINT, 
	SeparationDegrees INT 
		/* 
			If the character is in a comic with Thanos, 
			the separationDegrees = 0. If the character is 
			in a comic that features a character that is 
			in a comic with Thanos, the separationDegrees = 1 
		*/
); 
GO 
select distinct CharacterName 
from STAGE.CharacterComics 
where ComicId =12651
order by CharacterName
/* 
	Should be:
		- Adam Warlock 
		- Mephisto 
		- Thanos 
*/

select * 
from STAGE.CharacterComics