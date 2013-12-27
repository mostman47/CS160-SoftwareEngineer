USE Siquoia;
INSERT INTO USER
           (USERNAME
           ,PASSWORD
           ,TYPE
		   ,POINT)
Values		   
('admin1', 'admin1', 'admin',0),
('user1', 'user1', 'user1',100),
('user2', 'user2', 'user2',100);

INSERT INTO TOKEN
           (TOPIC_ID
           ,USER_ID
           ,CODE
		   ,STATUS
		   ,DESCRIPTION
		   ,NUMBERQUESTION)
Values		   
(3, null, 'JFFK35DOEP',null,'',20),
(11, null, 'FFDSKR23FO',null,'',20);

/*INSERT INTO POINT_HISTORY
			(USER_ID
			,DATETIME
			,POINTEARNED
			,POINTUSED)
Values();
*/