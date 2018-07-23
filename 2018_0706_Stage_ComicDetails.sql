
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