
-- truncate table Stage.ComicDetails; 
-- drop table Stage.ComicDetails; 
CREATE TABLE STAGE.ComicDetails ( 
	ComicId BIGINT, 
	ComicName varchar(100), 
	IssueNumber BIGINT, 
	ComicDetails varchar(max), 
	SeriesResourceURI varchar(100), 
	SeriesId BIGINT, 
	SeriesName varchar(100), 
	UniqueId uniqueidentifier default newid() 
); 
GO 
/*
select * 
from STAGE.ComicDetails; 
GO
select distinct SeriesName, 
	COUNT(ComicId) 
from Stage.ComicDetails 
group by SeriesName 
having COUNT(ComicId) > 1
order by COUNT(ComicId) DESC;  
