

-- drop table STAGE.ResourceURI; 
CREATE TABLE STAGE.ResourceURI ( 
	ResourceURI varchar(50), 
	ComicId BIGINT 
); 
GO
-- select distinct * from Stage.ResourceURI; 

/*
ALTER TABLE STAGE.ResourceURI 
	ADD ComicName varchar(100); 

ALTER TABLE STAGE.ResourceURI 
	ADD SeriesId INT; 

ALTER TABLE STAGE.ResourceURI 
	ADD SeriesName varchar(100);
*/
