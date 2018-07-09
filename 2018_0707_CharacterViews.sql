

/* 
	Character Views: GoodGuys, BadGuys, Neutral
*/
-- drop view Heroes.GoodCharacters
CREATE VIEW Heroes.vwGoodCharacters
	WITH VIEW_METADATA 
		AS 
	select * 
	from Heroes.DimCharacter 
	where Alignment = 'Good'; 
-- select * from Heroes.vwGoodCharacters; 
-- select AVG(XFactor) from Heroes.vwGoodCharacters; 
GO 
-- drop view Heroes.BadCharacters
CREATE VIEW Heroes.vwBadCharacters
	WITH VIEW_METADATA 
		AS 
	select * 
	from Heroes.DimCharacter 
	where Alignment = 'Bad'; 
-- select * from Heroes.vwBadCharacters; 
-- select AVG(XFactor) from Heroes.vwBadCharacters;
GO 

-- drop view Heroes.NeutralCharacters
CREATE VIEW Heroes.vwNeutralCharacters
	WITH VIEW_METADATA 
		AS 
	select * 
	from Heroes.DimCharacter 
	where Alignment = 'Neutral'; 
-- select * from Heroes.vwNeutralCharacters; 
-- select AVG(XFactor) from Heroes.vwNeutralCharacters; 
GO 