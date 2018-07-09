
/* 
	COMIC BOOK QUESTIONS THAT NEED TO BE ANSWERED 

	NOTE: The good guys win at the end of each series. So, the 
		assumption is:
			1. If it is not the end of a series, the good guys are losing 
			2. The bad guy never wins 
			3. Every hero involved in the penultimate issue in a series, 
				contributes to the victory 
*/ 

-- Which characters are most often associated with a victory over Thanos
IF OBJECT_ID('tempdb..#Temp_Victories') IS NOT NULL DROP TABLE #Temp_Victories; 
select DCh.CharacterName, 
	COUNT(FCR.UniqueId) AS VictoryCount 
		INTO #Temp_Victories 
from Heroes.FactComicResults FCR with (nolock)
	join Heroes.DimCharacter DCh with (nolock) 
		ON FCR.DimCharacterId = DCh.DimCharacterId 
	join Heroes.DimComic DC with (nolock) 
		ON FCR.DimComicId = DC.DimComicId  
where DC.IsSeriesConclusion = 1 
	and DCh.IsGoodGuy = 1  
	and DCh.IsTeam = 0 
group by DCh.CharacterName 
--having COUNT(FCR.UniqueID) >= 5 
order by COUNT(FCR.UniqueId) DESC;  

select * 
from #Temp_Victories 
where VictoryCount >= 5
order by VictoryCount DESC; 


/* 
	What are the average power stats of a hero that 
	has been a part of a Thanos defeat 
*/
IF OBJECT_ID('tempdb..#Temp_PowerStats') IS NOT NULL DROP TABLE #Temp_PowerStats; 
;with Metrics AS ( 
	select 
		SUM(VictoryCount * Intelligence) AS IntelligenceAvg, 
		SUM(VictoryCount * Strength) AS StrengthAvg, 
		SUM(VictoryCount * Speed) AS SpeedAvg, 
		SUM(VictoryCount * [Durability]) AS DurabilityAvg, 
		SUM(VictoryCount * [Power]) AS PowerAvg, 
		SUM(VictoryCount * Combat) AS CombatAvg, 
		SUM(VictoryCount * Rating) AS RatingAvg, 
		SUM(VictoryCount * XFactor) AS XFactorAvg, 

		SUM(VictoryCount) AS VictoryCount
	from #Temp_Victories V 
		join Heroes.DimCharacter DC with (nolock)
			ON V.CharacterName = DC.CharacterName 
	--where DC.CharacterName IN ('Adam Warlock', 'Aurora') 
		) 
select 
	 ROUND(CAST(IntelligenceAvg AS FLOAT) / VictoryCount, 2) AS AvgIntelligence, 
	 ROUND(CAST(StrengthAvg AS FLOAT) / VictoryCount, 2) AS AvgStrength, 
	 ROUND(CAST(SpeedAvg AS FLOAT) / VictoryCount, 2) AS AvgSpeed, 
	 ROUND(CAST(DurabilityAvg AS FLOAT) / VictoryCount, 2) AS AvgDurability, 
	 ROUND(CAST(PowerAvg AS FLOAT) / VictoryCount, 2) AS AvgPower, 
	 ROUND(CAST(CombatAvg AS FLOAT) / VictoryCount, 2) AS AvgCombat, 
	 ROUND(CAST(RatingAvg AS FLOAT) / VictoryCount, 2) AS AvgRating,
	 ROUND(CAST(XFactorAvg AS FLOAT) / VictoryCount, 2) AS AvgXFactor,
	 newid() AS UniqueID 
	 				INTO #Temp_PowerStats 
from Metrics; 

select * from #Temp_PowerStats; 

/* 
	Are there any characters that are better than average 
	in all of the power stats relative to characters that 
	have previously beat Thanos? 
*/
select CharacterName	
	Intelligence, 
	Strength, 
	Speed, 
	[Durability], 
	[Power], 
	Combat, 
	Rating, 
	XFactor 
from Heroes.DimCharacter DC 
where 1=1
	and IsGoodGuy = 1 
	and IsTeam = 0 
	and Intelligence > (select AvgIntelligence from #Temp_PowerStats) 
	and Strength > (select AvgStrength from #Temp_PowerStats) 
	and Speed > (select AvgSpeed from #Temp_PowerStats) 
	and [Power] > (select AvgPower from #Temp_PowerStats) 
	and [Durability] > (select AvgDurability from #Temp_PowerStats) 
	and Combat > (select AvgCombat from #Temp_PowerStats); 

/*
/* 
	 What is the Attribute make-up of Heroes 
	 that help defeat Thanos 
*/
select  
	ROUND(AVG(Intelligence), 2) AS Intelligence, 
	ROUND(AVG(Strength), 2) AS [Strength], 
	ROUND(AVG(Speed), 2) AS [Speed], 
	ROUND(AVG([Durability]), 2) AS [Durability], 
	ROUND(AVG([Combat]), 2) AS Combat, 
	ROUND(AVG(Rating), 2) AS Rating, 
	ROUND(AVG(XFactor), 2) AS XFactor, 
	ROUND(AVG(OverallRankTier), 2) AS OverallRankTier, 
	ROUND(AVG(OverallXFactorTier), 2) AS OverallXFactorTier 
from Heroes.DimCharacter
where CharacterName IN ( 
	select distinct CharacterName 
	from #Temp_Victories 
		)
*/


-- Which bad guys help Thanos defeat good guys most often
select DCh.CharacterName, 
	COUNT(FCR.UniqueId) AS VictoryCount 
from Heroes.FactComicResults FCR with (nolock)
	join Heroes.DimCharacter DCh with (nolock) 
		ON FCR.DimCharacterId = DCh.DimCharacterId 
	join Heroes.DimComic DC with (nolock) 
		ON FCR.DimComicId = DC.DimComicId  
where DC.IsSeriesConclusion = 0 
	and DCh.IsGoodGuy = 0 
	and DCh.Alignment <> 'Neutral'
	and DCh.IsTeam = 0  
	and DCh.CharacterName <> 'Thanos'
group by DCh.CharacterName 
having COUNT(FCR.UniqueID) >= 5
order by COUNT(FCR.UniqueId) DESC; 


-- Which Heroes are most often on the losing side of things 
IF OBJECT_ID('tempdb..#Temp_Loses') IS NOT NULL DROP TABLE #Temp_Loses; 
select DCh.CharacterName, 
	COUNT(FCR.UniqueId) AS LossCount 
			INTO #Temp_Loses 
from Heroes.FactComicResults FCR with (nolock)
	join Heroes.DimCharacter DCh with (nolock) 
		ON FCR.DimCharacterId = DCh.DimCharacterId 
	join Heroes.DimComic DC with (nolock) 
		ON FCR.DimComicId = DC.DimComicId  
where DC.IsSeriesConclusion = 0 
	and DCh.IsGoodGuy = 1
	and DCh.Alignment = 'Good'
	and DCh.IsTeam = 0  
group by DCh.CharacterName 
--having COUNT(FCR.UniqueID) >= 5
order by COUNT(FCR.UniqueId) DESC; 

select top 5 * 
from #Temp_Loses 
order by LossCount DESC; 


/* 
	Who has the best win percentage?
*/
select 
	COALESCE(V.CharacterName, L.CharacterName) AS CharacterName, 
	ROUND(CAST(ISNULL(V.VictoryCount, 0) AS FLOAT) /
	(CAST(ISNULL(L.LossCount, 0) AS FLOAT) + V.VictoryCount), 
		2) AS VictoryPercentage, 
	V.VictoryCount, 
	(CAST(ISNULL(L.LossCount, 0) AS FLOAT) + V.VictoryCount) AS Encounters
from #Temp_Victories V 
	join #Temp_Loses L 
		ON V.CharacterName = L.CharacterName 
order by VictoryPercentage DESC; 


/* 
	Which teams have fought and defeated Thanos 
	most often? 
*/
;with TeamBattle AS ( 
		select DCh.CharacterName, 
			FCR.IsSeriesConclusion, 
			COUNT(FCR.UniqueId) AS Cnt
		from Heroes.FactComicResults FCR with (nolock)
			join Heroes.DimCharacter DCh with (nolock) 
				ON FCR.DimCharacterId = DCh.DimCharacterId 
			join Heroes.DimComic DC with (nolock) 
				ON FCR.DimComicId = DC.DimComicId  
		where 1=1
			and DCh.IsGoodGuy = 1
			and DCh.Alignment = 'Good'
			and DCh.IsTeam = 1  
		group by 
			FCR.IsSeriesConclusion, 
			DCh.CharacterName 
		--having COUNT(FCR.UniqueID) >= 5
				), 
		CalcWinPct AS ( 
			select CharacterName, 
				ISNULL([1], 0) AS Wins, ISNULL([0], 0) AS Losses, 
				CAST(ISNULL([1], 0) AS FLOAT) + ISNULL([0], 0) AS Total
			from TeamBattle 
				PIVOT(MAX(Cnt) 
					FOR IsSeriesConclusion IN ([1], [0]) 
				) AS P 
			) 
		select *, 
			ROUND(CAST(Wins AS FLOAT) / Total, 2) AS WinPct 
		from CalcWinPct 
		order by CAST(Wins AS FLOAT) / Total DESC; 
	


/* 
	What are the average Power Stats 
	of Good Guys, Bad Guys, Neutral Guys 
*/
select 
	DCh.Alignment, 
	ROUND(AVG(Intelligence), 2) AS Intelligence, 
	ROUND(AVG(Strength), 2) AS [Strength], 
	ROUND(AVG(Speed), 2) AS [Speed], 
	ROUND(AVG([Durability]), 2) AS [Durability], 
	ROUND(AVG([Combat]), 2) AS Combat, 
	ROUND(AVG(Rating), 2) AS Rating, 
	ROUND(AVG(XFactor), 2) AS XFactor
from Heroes.DimCharacter DCh with (nolock) 
group by DCh.Alignment; 
