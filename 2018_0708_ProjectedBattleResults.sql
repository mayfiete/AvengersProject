
IF OBJECT_ID('Heroes.FactProjectedBattleResults') IS NOT NULL DROP TABLE Heroes.FactProjectedBattleResults; 
GO 
CREATE TABLE Heroes.FactProjectedBattleResults ( 
		CharacterId INT, 
		CharacterName varchar(150), 
		IsTeam BIT, 
		IsGoodGuy BIT, 
		Alignment varchar(25), 
		Intelligence FLOAT, 
		Strength FLOAT, 
		Speed FLOAT, 
		[Durability] FLOAT, 
		[Power] FLOAT, 
		Combat FLOAT, 
		Rating FLOAT, 
		XFactor FLOAT, 
		RoundRating FLOAT,  
		ThanosRating FLOAT, 
		IsThanosDefeated FLOAT, 
		IsThanosDefeatedYesNo AS 
			CASE  
				WHEN IsThanosDefeated = 0 THEN 'No' 
				ELSE 'Yes' 
			END, 
		UniqueId uniqueidentifier default newid() 
); 
GO 


DECLARE @BattleIter INT = 0 ; 

WHILE @BattleIter < 150
	BEGIN 

		INSERT INTO Heroes.FactProjectedBattleResults ( 
				CharacterId, 
				CharacterName,  
				IsTeam, 
				IsGoodGuy, 
				Alignment, 
				Intelligence, 
				Strength, 
				Speed, 
				[Durability], 
				[Power], 
				Combat, 
				Rating, 
				XFactor, 
				RoundRating,  
				ThanosRating, 
				IsThanosDefeated 
		) 
			select *, 
				CASE 
					WHEN RoundRating > ThanosRating THEN CAST(1 AS BIT) 
					ELSE CAST(0 AS BIT)
				END AS IsThanosDefeated
			from ( 
				select 
					CharacterId, 
					CharacterName, 
					IsTeam, 
					IsGoodGuy, 
					Alignment, 
					Intelligence, 
					Strength, 
					Speed, 
					[Durability], 
					[Power], 
					Combat, 
					Rating, 
					XFactor, 
					ROUND(((XFactor - Rating -1) * RAND() + Rating), 0) AS RoundRating,  
					( 
						select Rating 
						from Heroes.DimCharacter 
						where CharacterName = 'Thanos'
					) AS ThanosRating 
					-- select * 
				from Heroes.DimCharacter 
				--where CharacterName like 'Captain Marvel (Carol Danvers)' 
			) AS X

		SET @BattleIter = @BattleIter + 1 

	END 

	GO 

	select * 
	from Heroes.FactProjectedBattleResults; 




