USE [Sequoia]
INSERT INTO [Sequoia].[dbo].[TOPIC]
           ([PARENT_TOPIC_ID]
           ,[TOPIC_DESCRIPTION]
           ,[LEVEL])
SELECT null,'Social science',1 Union All
SELECT null,'Branded',1 Union All
SELECT null,'Science',1 Union All
SELECT 1,'General Knowledge',2 Union All
SELECT 4,'Free software',3 Union All
SELECT 4,'Capitals',3 Union All
SELECT 2,'Test',2 Union All
SELECT 7,'DMV',3 Union All
SELECT 3,'Math',2 Union All
SELECT 9,'Arithmetic',3 Union All
SELECT 9,'Algebra',3 Union All
SELECT 3,'Biology',2 Union All
SELECT 12,'Botany',3 Union All
SELECT 12,'Zoology',3;