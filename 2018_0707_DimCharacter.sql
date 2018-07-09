<<<<<<< HEAD


IF OBJECT_ID('Heroes.DimCharacter') IS NOT NULL DROP TABLE Heroes.DimCharacter; 
GO 
CREATE TABLE Heroes.DimCharacter ( 
	DimCharacterId INT PRIMARY KEY IDENTITY(1,1), 
	CharacterId BIGINT, 
	CharacterName varchar(250), 
	[Name] varchar(250), 
	Alias varchar(250), 
	Alignment varchar(25), 
	IsGoodGuy BIT, 
	IsTeam BIT, 
	TeamAffiliation varchar(100), 
	Intelligence FLOAT, 
	Strength FLOAT, 
	Speed FLOAT, 
	[Durability] FLOAT, 
	[Power] FLOAT, 
	Combat FLOAT, 
	RatingVariability FLOAT, 
	IsSuperior INT, 
	Rating FLOAT, 
	XFactor FLOAT, 
	OverallRank INT, 
	OverallXFactor INT, 
	OverallAlignmentRank INT, 
	OverallAlignmentXFactor INT, 	
	TeamRating INT, 
	[TeamXFactorRating] INT, 
	OverallRankTier INT, 
	OverallXFactorTier INT, 
	UniqueId uniqueidentifier default newid() 
); 
GO 

IF OBJECT_ID('tempdb..#Temp_Character') IS NOT NULL DROP TABLE #Temp_Character; 
; with CharacterCatalog AS ( 
select distinct 
	CC.CharacterId,  
	CP.CharacterName, 
	CP.[Name], 
	CP.Alias, 
	CP.Alignment, 
	CP.IsGoodGuy, 
	CP.IsTeam, 
	CP.TeamAffiliation, 
	CP.Intelligence, 
	CP.Strength, 
	CP.Speed, 
	CP.[Durability], 
	CP.[Power], 
	CP.Combat, 
	CP.X AS RatingVariability, 
	CP.IsSuperior, 
	CP.Rating, 
	CP.[X-Factor] AS XFactor 

from Stage.CharacterProfile CP with (nolock) 
	join Stage.CharacterCatalog CC  with (nolock) 
		ON CP.CharacterName = CC.CharacterName
		) 
select distinct *, 
	DENSE_RANK() OVER (PARTITION BY IsTeam ORDER BY Rating DESC) AS OverallRank, 
	DENSE_RANK() OVER (PARTITION BY IsTeam ORDER BY [XFactor] DESC) AS OverallXFactor, 
	DENSE_RANK() OVER (PARTITION BY Alignment, IsTeam ORDER BY Rating DESC) AS OverallAlignmentRank, 
	DENSE_RANK() OVER (PARTITION BY Alignment, IsTeam ORDER BY [XFactor] DESC) AS OverallAlignmentXFactor, 	
	DENSE_RANK() OVER (PARTITION BY TeamAffiliation, IsTeam ORDER BY Rating DESC) AS TeamRating, 
	DENSE_RANK() OVER (PARTITION BY TeamAffiliation, IsTeam ORDER BY Rating DESC) AS [TeamXFactorRating], 
	NTILE(5) OVER (PARTITION BY IsTeam ORDER BY Rating DESC) AS OverallRankTier, 
	NTILE(5) OVER (PARTITION BY IsTeam ORDER BY [XFactor] DESC) AS OverallXFactorTier  
			INTO #Temp_Character
from CharacterCatalog ; 


INSERT INTO Heroes.DimCharacter  
	(
	CharacterId, 
	CharacterName, 
	[Name], 
	Alias, 
	Alignment, 
	IsGoodGuy , 
	IsTeam , 
	TeamAffiliation, 
	Intelligence , 
	Strength , 
	Speed , 
	[Durability] , 
	[Power] , 
	Combat , 
	RatingVariability , 
	IsSuperior , 
	Rating , 
	XFactor , 
	OverallRank , 
	OverallXFactor , 
	OverallAlignmentRank , 
	OverallAlignmentXFactor , 	
	TeamRating , 
	[TeamXFactorRating], 
	OverallRankTier, 
	OverallXFactorTier  
	) 
select distinct 
	CharacterId, 
	CharacterName, 
	[Name], 
	Alias, 
	Alignment, 
	IsGoodGuy , 
	IsTeam , 
	TeamAffiliation, 
	Intelligence , 
	Strength , 
	Speed , 
	[Durability] , 
	[Power] , 
	Combat , 
	RatingVariability , 
	IsSuperior , 
	Rating , 
	XFactor , 
	OverallRank , 
	OverallXFactor , 
	OverallAlignmentRank , 
	OverallAlignmentXFactor , 	
	TeamRating , 
	[TeamXFactorRating], 
	OverallRankTier, 
	OverallXFactorTier 
from #Temp_Character; 

GO 
select * 
from Heroes.DimCharacter; 

/*
select * 
from Heroes.DimCharacter 
where IsTeam = 0
	and OverallRankTier = 1 
	and IsGoodGuy = 1 
order by OverallRank

select * 
from Heroes.DimCharacter 
where IsTeam = 1
order by OverallRank
=======


IF OBJECT_ID('Heroes.DimCharacter') IS NOT NULL DROP TABLE Heroes.DimCharacter; 
GO 
CREATE TABLE Heroes.DimCharacter ( 
	DimCharacterId INT PRIMARY KEY IDENTITY(1,1), 
	CharacterId BIGINT, 
	CharacterName varchar(250), 
	[Name] varchar(250), 
	Alias varchar(250), 
	Alignment varchar(25), 
	IsGoodGuy BIT, 
	IsTeam BIT, 
	TeamAffiliation varchar(100), 
	Intelligence FLOAT, 
	Strength FLOAT, 
	Speed FLOAT, 
	[Durability] FLOAT, 
	[Power] FLOAT, 
	Combat FLOAT, 
	RatingVariability FLOAT, 
	IsSuperior INT, 
	Rating FLOAT, 
	XFactor FLOAT, 
	OverallRank INT, 
	OverallXFactor INT, 
	OverallAlignmentRank INT, 
	OverallAlignmentXFactor INT, 	
	TeamRating INT, 
	[TeamXFactorRating] INT, 
	OverallRankTier INT, 
	OverallXFactorTier INT, 
	UniqueId uniqueidentifier default newid() 
); 
GO 

IF OBJECT_ID('tempdb..#Temp_Character') IS NOT NULL DROP TABLE #Temp_Character; 
; with CharacterCatalog AS ( 
select distinct 
	CC.CharacterId,  
	CP.CharacterName, 
	CP.[Name], 
	CP.Alias, 
	CP.Alignment, 
	CP.IsGoodGuy, 
	CP.IsTeam, 
	CP.TeamAffiliation, 
	CP.Intelligence, 
	CP.Strength, 
	CP.Speed, 
	CP.[Durability], 
	CP.[Power], 
	CP.Combat, 
	CP.X AS RatingVariability, 
	CP.IsSuperior, 
	CP.Rating, 
	CP.[X-Factor] AS XFactor 

from Stage.CharacterProfile CP with (nolock) 
	join Stage.CharacterCatalog CC  with (nolock) 
		ON CP.CharacterName = CC.CharacterName
		) 
select distinct *, 
	DENSE_RANK() OVER (PARTITION BY IsTeam ORDER BY Rating DESC) AS OverallRank, 
	DENSE_RANK() OVER (PARTITION BY IsTeam ORDER BY [XFactor] DESC) AS OverallXFactor, 
	DENSE_RANK() OVER (PARTITION BY Alignment, IsTeam ORDER BY Rating DESC) AS OverallAlignmentRank, 
	DENSE_RANK() OVER (PARTITION BY Alignment, IsTeam ORDER BY [XFactor] DESC) AS OverallAlignmentXFactor, 	
	DENSE_RANK() OVER (PARTITION BY TeamAffiliation, IsTeam ORDER BY Rating DESC) AS TeamRating, 
	DENSE_RANK() OVER (PARTITION BY TeamAffiliation, IsTeam ORDER BY Rating DESC) AS [TeamXFactorRating], 
	NTILE(5) OVER (PARTITION BY IsTeam ORDER BY Rating DESC) AS OverallRankTier, 
	NTILE(5) OVER (PARTITION BY IsTeam ORDER BY [XFactor] DESC) AS OverallXFactorTier  
			INTO #Temp_Character
from CharacterCatalog ; 


INSERT INTO Heroes.DimCharacter  
	(
	CharacterId, 
	CharacterName, 
	[Name], 
	Alias, 
	Alignment, 
	IsGoodGuy , 
	IsTeam , 
	TeamAffiliation, 
	Intelligence , 
	Strength , 
	Speed , 
	[Durability] , 
	[Power] , 
	Combat , 
	RatingVariability , 
	IsSuperior , 
	Rating , 
	XFactor , 
	OverallRank , 
	OverallXFactor , 
	OverallAlignmentRank , 
	OverallAlignmentXFactor , 	
	TeamRating , 
	[TeamXFactorRating], 
	OverallRankTier, 
	OverallXFactorTier  
	) 
select distinct 
	CharacterId, 
	CharacterName, 
	[Name], 
	Alias, 
	Alignment, 
	IsGoodGuy , 
	IsTeam , 
	TeamAffiliation, 
	Intelligence , 
	Strength , 
	Speed , 
	[Durability] , 
	[Power] , 
	Combat , 
	RatingVariability , 
	IsSuperior , 
	Rating , 
	XFactor , 
	OverallRank , 
	OverallXFactor , 
	OverallAlignmentRank , 
	OverallAlignmentXFactor , 	
	TeamRating , 
	[TeamXFactorRating], 
	OverallRankTier, 
	OverallXFactorTier 
from #Temp_Character; 

GO 
select * 
from Heroes.DimCharacter; 

/*
select * 
from Heroes.DimCharacter 
where IsTeam = 0
	and OverallRankTier = 1 
	and IsGoodGuy = 1 
order by OverallRank

select * 
from Heroes.DimCharacter 
where IsTeam = 1
order by OverallRank
>>>>>>> 8b0eefac84fe5495a97e9b34101742777100a87b
*/