SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Siquoia` ;
CREATE SCHEMA IF NOT EXISTS `Siquoia` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
DROP SCHEMA IF EXISTS `siquoia` ;
CREATE SCHEMA IF NOT EXISTS `siquoia` DEFAULT CHARACTER SET utf8 ;
USE `Siquoia` ;

-- -----------------------------------------------------
-- Table `Siquoia`.`User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`User` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Username` VARCHAR(45) NOT NULL ,
  `Password` VARCHAR(20) NOT NULL ,
  `Type` VARCHAR(45) NOT NULL ,
  `Point` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Topic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Topic` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(100) NULL ,
  `Parent_ID` BIGINT NULL ,
  `Level` INT NULL ,
  `Type` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Topic_Topic1_idx` (`Parent_ID` ASC) ,
  CONSTRAINT `fk_Topic_Topic1`
    FOREIGN KEY (`Parent_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Multimedia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Multimedia` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NULL ,
  `Type` VARCHAR(45) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Question`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Question` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NOT NULL ,
  `Answer_C` VARCHAR(300) NULL ,
  `Answer_W1` VARCHAR(300) NULL ,
  `Answer_W2` VARCHAR(300) NULL ,
  `Answer_W3` VARCHAR(300) NULL ,
  `Ranking` INT NOT NULL ,
  `Topic_ID` BIGINT NOT NULL ,
  `Multimedia_ID` BIGINT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Question_Topic1_idx` (`Topic_ID` ASC) ,
  INDEX `fk_Question_Multimedia1_idx` (`Multimedia_ID` ASC) ,
  CONSTRAINT `fk_Question_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Question_Multimedia1`
    FOREIGN KEY (`Multimedia_ID` )
    REFERENCES `Siquoia`.`Multimedia` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Token` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Code` VARCHAR(45) NOT NULL ,
  `Description` VARCHAR(500) NULL ,
  `Status` VARCHAR(45) NULL ,
  `NumberQuestion` INT NOT NULL ,
  `User_ID` BIGINT NULL ,
  `Topic_ID` BIGINT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Token_User1_idx` (`User_ID` ASC) ,
  INDEX `fk_Token_Topic1_idx` (`Topic_ID` ASC) ,
  CONSTRAINT `fk_Token_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Token_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Point_History`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Point_History` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `PointEarned` INT NULL ,
  `PointUsed` INT NULL ,
  `User_ID` BIGINT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Point_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Point_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Purchase`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Purchase` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `Description` VARCHAR(500) NULL ,
  `User_ID` BIGINT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Purchase_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Purchase_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Siquoia`.`Quiz`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Siquoia`.`Quiz` (
  `ID` BIGINT NOT NULL ,
  `User_ID` BIGINT NOT NULL ,
  `Topic_ID` BIGINT NOT NULL ,
  `Current_QuestionID` BIGINT NULL ,
  `QuestionList` VARCHAR(500) NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Quiz_User1_idx` (`User_ID` ASC) ,
  INDEX `fk_Quiz_Topic1_idx` (`Topic_ID` ASC) ,
  CONSTRAINT `fk_Quiz_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `Siquoia`.`User` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quiz_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `Siquoia`.`Topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `siquoia` ;

-- -----------------------------------------------------
-- Table `siquoia`.`multimedia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`multimedia` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  `Type` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`user` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Username` VARCHAR(45) NOT NULL ,
  `Password` VARCHAR(20) NOT NULL ,
  `Type` VARCHAR(45) NOT NULL ,
  `Point` INT(11) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`point_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`point_history` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `PointEarned` INT(11) NULL DEFAULT NULL ,
  `PointUsed` INT(11) NULL DEFAULT NULL ,
  `User_ID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Point_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Point_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `siquoia`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`purchase`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`purchase` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `DateTime` DATETIME NOT NULL ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  `User_ID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Purchase_User1_idx` (`User_ID` ASC) ,
  CONSTRAINT `fk_Purchase_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `siquoia`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`topic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`topic` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(100) NULL DEFAULT NULL ,
  `Parent_ID` BIGINT(20) NULL DEFAULT NULL ,
  `Level` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Topic_Topic1_idx` (`Parent_ID` ASC) ,
  CONSTRAINT `fk_Topic_Topic1`
    FOREIGN KEY (`Parent_ID` )
    REFERENCES `siquoia`.`topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`question`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`question` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Description` VARCHAR(500) NOT NULL ,
  `Answer_C` VARCHAR(300) NULL DEFAULT NULL ,
  `Answer_W1` VARCHAR(300) NULL DEFAULT NULL ,
  `Answer_W2` VARCHAR(300) NULL DEFAULT NULL ,
  `Answer_W3` VARCHAR(300) NULL DEFAULT NULL ,
  `Ranking` INT(11) NOT NULL ,
  `Topic_ID` BIGINT(20) NOT NULL ,
  `Multimedia_ID` BIGINT(20) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Question_Topic1_idx` (`Topic_ID` ASC) ,
  INDEX `fk_Question_Multimedia1_idx` (`Multimedia_ID` ASC) ,
  CONSTRAINT `fk_Question_Multimedia1`
    FOREIGN KEY (`Multimedia_ID` )
    REFERENCES `siquoia`.`multimedia` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Question_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `siquoia`.`topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 435
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `siquoia`.`token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `siquoia`.`token` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `Code` VARCHAR(45) NOT NULL ,
  `Description` VARCHAR(500) NULL DEFAULT NULL ,
  `Status` VARCHAR(45) NULL DEFAULT NULL ,
  `NumberQuestion` INT(11) NOT NULL ,
  `User_ID` BIGINT(20) NULL DEFAULT NULL ,
  `Topic_ID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Token_User1_idx` (`User_ID` ASC) ,
  INDEX `fk_Token_Topic1_idx` (`Topic_ID` ASC) ,
  CONSTRAINT `fk_Token_Topic1`
    FOREIGN KEY (`Topic_ID` )
    REFERENCES `siquoia`.`topic` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Token_User1`
    FOREIGN KEY (`User_ID` )
    REFERENCES `siquoia`.`user` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

USE `Siquoia` ;
USE `siquoia` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insert Topic

INSERT INTO TOPIC
           (PARENT_ID
           ,DESCRIPTION
           ,LEVEL
		   ,TYPE)
Values
(null,'Social science',1, 'public' ),
(null,'Branded',1 , 'public'),
(null,'Science',1 , 'public'),
(1,'General Knowledge',2, 'public' ),
(4,'Free software',3 , 'public'),
(4,'Capitals',3 , 'public'),
(2,'Test',2 , 'public'),
(7,'DMV',3 , 'public'),
(3,'Math',2, 'public' ),
(9,'Arithmetic',3, 'public' ),
(9,'Algebra',3 , 'public'),
(3,'Biology',2 , 'public'),
(12,'Botany',3 , 'public'),
(12,'Zoology',3, 'public'),
(null,'Demo',1,'private')
;

-- Insert MULTIMEDIA
INSERT INTO MULTIMEDIA
			(DESCRIPTION
			,TYPE)
Values
('./media/image/Flag1.png','image'),			
('./media/video/VideoQuestion.mp4','video'),			
('./media/audio/audio1.mp3','audio')
;			

-- Insert User, Token, Point_History
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
(3, null, 'AAAA',null,'',20),
(11, null, 'BBBB',null,'',20);

/*INSERT INTO POINT_HISTORY
			(USER_ID
			,DATETIME
			,POINTEARNED
			,POINTUSED)
Values();*/

-- Insert Question
INSERT INTO QUESTION
           (TOPIC_ID
           ,DESCRIPTION
           ,ANSWER_C
           ,ANSWER_W1
           ,ANSWER_W2
           ,ANSWER_W3
           ,RANKING)
VALUES
   ( 8,'You must notify DMV within 5 days if you:','Sell your vehicle','Paint your vehicle a different colour','Are cited for a traffic violation','transfer your vehicle',0)
 ,( 8,'It is illegal for a person 21 years of age or older to drive with a blood alcohol concentration (BAC) that is ____________ or higher.','0.08% - Eight hundredths of one percent','0.10% - One tenth of one percent','0.05% - Five hundredths of one percent','0.02% - Two hundredths of one percent',0)
 ,( 8,'There is a vehicle stopped on the right shoulder of the road ahead with its hazard lights on.You should:                               ','Slow down and pass very carefully','Change lanes to the left and speed up','Stop your vehicle until you can see what has happened','Ignore it',0)
 ,( 8,'It is legal to drive with an alcoholic beverage container that has been opened if the container is:','In the trunk','Under the front seat','In the glove compartment','In the Drivers Hand',0)
 ,( 8,'You see a pedestrian with a white cane at the corner ready to cross the street. The person takes a step back and pulls in his cane .You should:','Stop and then proceed through the intersection because the person is not ready to cross','Stop your car a minimum of six feet from the crosswalk and wait for the person to cross the street','Honk your horn to let the person know when to cross the street','Shout out and enquire if the person wants to cross the street',0)
 ,( 8,'You were parked and have been waiting a long time with your turn signal on to re-enter traffic. However, traffic is heavy. You should:','Continue waiting and yielding to the traffic in the lane','Slowly inch your vehicle into the traffic lane','Drive on the shoulder until a gap in traffic appears','Stop the car',0)
 ,( 8,'You enter a designated turn lane to make a left turn at an upcoming intersection. There is oncoming traffic. You should','Signal before you arrive at the intersection','Move to the left of the center lane','Turn your front wheels to the left to be prepared to turn','',0)
 ,( 8,'Which child requires a child passenger restraint system?','A five year old weighing 55 pounds','A six year old weighing 60 pounds','A five year old weighing 65 pounds','A eight year old who is less than 40'''' of height',0)
 ,( 8,'You want to turn left at an upcoming corner. Give the right-of-way to:','Vehicles coming towards you','Oncoming vehicles also turning left','Pedestrians on the sidewalk waiting for a WALK signal','Nobody',0)
 ,( 8,'You are driving on a city street and see an emergency vehicle with flashing lights behind you. What should you do?','Drive to the right edge of the road and stop','Drive to the right edge of the road and slow down','Stay in the lane, slow down and let it pass','Pull over and wait for vehicle to pass',0)
 ,( 8,'If you drive 55 mph in a 55 mph zone, you can be given a speeding ticket:','If road or weather conditions require a slower speed','Under no circumstances because it is always legal','Only if you are approaching a sharp curve in the road','None of these',0)
 ,( 8,'Before you change lanes, you should check your mirrors and:','Look over your shoulder','Never look over your right shoulder','Always slow down in your traffic lane','All of the above',0)
 ,( 8,'Your driving lane is next to a bicycle lane. You want to make a right turn at the upcoming intersection. You:','Must merge into the bicycle lane before making your turn','May not enter the bicycle lane to make your turn','Should only merge into the bicycle lane if you stop before turning','Must stop ,look for bicyclists  and only then merge into the lane',0)
 ,( 8,'Which of the following blocks the smooth flow of traffic?','Slowing down to look at an accident scene','Avoiding unnecessary lane changes','Using public transportation instead of your car','Not following the speed limit',0)
 ,( 8,'You are approaching an intersection at the posted speed limit when the signal light turns yellow. You should:','Stop before entering the intersection, if you can do so safely','Slow down and proceed through the intersection with caution','Speed up to cross the intersection before the light turns red','Stop at the intersection',0)
 ,( 8,'Which of the following roadways freezes first when wet?','Bridges','Intersections','Tunnels','Roads at high elevation',0)
 ,( 8,'The speed limit at an uncontrolled railroad crossing is:','25 mph','15 mph','20 mph','30 mph',0)
 ,( 8,'Which of the following is true about vehicles displaying a diamond shaped sign (indicating a hazardous load)?','They must stop before crossing railroad tracks','They are not allowed to drive on freeways','They are not allowed to exceed 35 mph','None of these',0)
 ,( 8,'The driver ahead of you stops at the crosswalk. What should you do?','Stop, and then proceed when all pedestrians have crossed','Cautiously pass the vehicle at 10 mph or less','Change lanes, look carefully, and pass the stopped vehicle','All of theses',0)
 ,( 8,'You hit a parked car and can’t find the owner. What must you do?','Leave a note with your name and address on the parked car','Call your insurance company when you get home','Wait for the owner to return','Inform the police',0)
 ,( 8,'You are driving in an area with few street lights on a clear night. If you cannot see well with your low-beam headlights, which of these actions would help?','Using your high beams','Adjusting your instrument lights so they are brighter','Turning on your vehicle’s parking lights','None of these',0)
 ,( 8,'You want to park downhill on a two-way road and there is no curb. Which way do you turn your front wheels?','Right – towards the side of the road','So they face straight ahead','Left – towards the center of the road','Must not park Downhill',0)
 ,( 8,'If you want to pass a bicyclist in a narrow traffic lane when an oncoming car is approaching:','Slow down and let the car pass, then pass the bicyclist','Honk your horn, and then pass the bicyclist','Wait until the bicyclist rides off the roadway','Stop the car and let the car pass, then pass the bicyclist',0)
 ,( 8,'When merging onto a freeway, you should be driving:','At or near the same speed as the freeway traffic','At the legal freeway speed limit','Slower than the freeway traffic','None of the above',0)
 ,( 8,'You must show proof of insurance to law enforcement:','If you are involved in an accident or stopped for a citation','Only if you are involved in an accident','Only if you are stopped and cited','At any time',0)
 ,( 8,'You are on a two-way road and the vehicle ahead of you is turning left in a driveway. You may legally pass the vehicle on the right:','If there is enough road between the curb and the vehicle','Even if you must drive in a bicycle lane to do so','Even if you must cross a solid white line painted on the road','None of the above',0)
 ,( 8,'Cargo extending more than four feet from your rear bumper:','Must be marked with a red flag or lights','Is illegal under all circumstances','Does not legally to be marked, but it is a good idea','Must be on the right most lane',0)
 ,( 8,'When you change lanes or merge with another lane you:','Need at least a four-second gap in traffic','Have the right-of-way','Should first stop and check for cross traffic','Need at least a three car gap',0)
 ,( 8,'Your wheels should be pointed straight ahead, unless you are:','Parked on a hill or slopping driveway','Waiting to make a left turn at a traffic light','Parked on the side of a level roadway and there is no curb','Waiting to make a right turn at a traffic light',0)
 ,( 8,'You are crossing an intersection and an emergency vehicle is approaching with a siren and flashing lights. You should:','Continue through the intersection, pull to the right, and stop','Stop immediately in the intersection until it passes','Pull to the right in the intersection and stop','Pull to the left in the intersection and stop',0)
 ,( 8,'You may legally park your car:','In a bicycle lane if there is no sign forbidding it','At the corner in a intersection','Across a sidewalk if you are partially in a driveway','None of the above',0)
 ,( 8,'A pedestrian who is blind or visually impaired uses traffic sounds before deciding to cross the street. If you see a pedestrian with a guide dog or white cane waiting to cross at a corner, you should:','Pull up to the crosswalk so the person can hear your engine','Stop at the cross walk and honk your horn','Drive into the crosswalk so the person can hear your engine','Shout out ask if the pedestrian wants to cross the road',0)
 ,( 8,'You are driving in the far right lane of a multilane freeway. A line of five cars is merging into your lane ahead from an onramp. You:','Must slow down to let the other vehicles merge','Must maintain your speed and position','Have the legal right-of-way, but should make room for the merging vehicles if possible.','None of these',0)
 ,( 8,'The speed limit in any valley is:','15 mph','20 mph','25 mph','30 mph',0)
 ,( 8,'You should stop before crossing railroad tracks:','Any time a train may be approaching, whether or not you can see it','Even when the railroad tracks are out-of-service','If your vehicle has three or more axles','At all times',0)
 ,( 8,'Two vehicles are approaching an uncontrolled “T” intersection. One vehicle is on the through road and the other is on the road that ends. Who has the right-of-way at the intersection?','The vehicle on the through road','The vehicle on the right','The vehicle that arrives first','The vehicel on the left',0)
 ,( 8,'Which of these statements is true about driving and taking medications?','Most cold medications can make the person drowsy','Over-the-counter medications cannot impair driving ability if taken in the recommended dosages','Medications are safe to take at any time if prescribed by a doctor','None of these',0)
 ,( 8,'Which of these statements is true about child passengers?','Children under age one should not ride in the front seat in airbag-equipped vehicles','Children 1 or older and over 20 pounds should ride in the front seat','The front seat is generally the safest place in the car for children six years of age and older','',0)
 ,( 8,'If there is a deep puddle in the road ahead, you should:','Shift into neutral as you drive through the water','Maintain the posted speed to make it through the water','Steer your vehicle around the water, if possible','Drive fast through puddle',0)
 ,( 8,'All of the following are dangerous while driving. Which is also illegal?','Wearing a headset that covers both ears','Having one or more interior lights on','Using cruise control on residential streets','None of the above',0)
 ,( 8,'You are driving in the far right lane of a four-lane freeway and notice thick broken white lines on the left side of your lane. You are driving in:','An exit lane','The carpool lane and must merge into the next lane','A special lane for slow moving vehicles','The shoulder',0)
 ,( 8,'Which of the following is true about large trucks?','Trucks often appear to travel slower because of their large size','Trucks have fewer blind spots due to the vehicle’s height','It is best to pass trucks very slowly and on the right side','It is best to pass trucks very slowly and on the left side',0)
 ,( 8,'You must make a written report (SR 1) to DMV if you:','Are involved in an accident and there is more than $750 in damages','Fail to pay your registration fees within 90 days of receiving your renewal notice','Allow a licensed driver from another state drive your vehicle','Fail to pay your registration fees within 120 days of receiving your renewal notice',0)
 ,( 8,'A police officer is signalling you to drive to the edge of the roadway. You decide to ignore the officer’s warning and flee the scene. You are guilty of a misdemeanour and can be punished by being:','Given an warning and a citation','Fined up to $1000','Jailed in the county jail for not more than one year','Fined up to $500',0)
 ,( 8,'To be sure a lane is clear before you change lanes, you should:','Look over your shoulder into the lane you want to enter','Look in your outside mirrors only','Always turn your head and look over your right shoulder','None of the above',0)
 ,( 8,'When a traffic signal light isn’t working at an intersection, you should:','Come to a complete stop, and then proceed when it is safe','Stop before entering and let all other traffic go first','Slow down or stop, if necessary','Inform the police',0)
 ,( 8,'The speed limit for school zone where children are present is _______ unless otherwise posted','25 mph','15 mph','30 mph','20 mph',0)
 ,( 8,'To turn left from a one-way street onto a one-way street, start from','The lane closest to the left curb','The center lane','Any lane as long as it seems safe to do so','The lane closest to the right curb',0)
 ,( 8,'Allow extra space in front of your vehicle when following a:','Motorcycle','Station wagon','Passenger car','Large tour bus',0)
 ,( 8,'If there are two solid yellow lines dividing opposite lanes of traffic, you may:','Cross over these lines to make a U-turn unless there is a sign prohibiting U-turns','Cross over the lines to make a left turn from or into a side street','Cross over the lines to pass another vehicle unless there is a “No Passing” sign posted','None of these',0)
 ,( 8,'Which of the following is a proper use of vehicle lights?','Using low beams during the day on narrow country roads','Using high beams because your low beams are not working','Use parking lights while driving through a tunnel','Use break lights while driving',0)
 ,( 8,'When driving on a slippery surface such as snow or ice:','Shift to a low gear before going down steep hills','Maintain traction by following other vehicles closely','Pump your brakes to keep them from freezing','Shift to neutral gear before going down steep hills',0)
 ,( 8,'When parking your vehicle on any hill:','Use your parking brake and leave the vehicle in gear or “park”','One of your rear wheels should touch the curb','Your front wheels should be parallel to the road if there is no curb','None of these',0)
 ,( 8,'You can make a right turn at a solid red light after you check for pedestrians and other traffic:','If you stop first and there is no sign to prohibit the turn','Only if there is a sign that permits the turn','At any time, if you slow down and signal before making the turn','None of these',0)
 ,( 8,'Check your rear view mirrors:','Often to see how traffic is moving behind you','To see if a vehicle is in your blind spot','Only when you are slowing down','Every five minutes',0)
 ,( 8,'At dawn or dusk, or in rian or snow, it can be hard ti see and be seen, a good way to let other drivers know you are there is to turn:','Up the instrument panel lights','On your parking lights','On your headlights','',0)
 ,( 8,'You must not cross a solid double line in the center of the roadway to ','Overtake and pass another vehicle','Make a left turn','Enter a private driveway','Enter a parking lot',0)
 ,( 8,'You are driving a slow moving vehicle on a winding two-lane highway. You must pull over when it is safe and let other drivers pass when you are followed by ','5 or more vehicles','3 vehicles','4 vehicles','2 vehicles',0)
 ,( 8,'When you approach a "blind" intersection (you can''t see 100 feet down the cross street) and there is no STOP or YIELD sign placed at the corner, the speed limit is ','15 m.p.h.','20 m.p.h.','25 m.p.h.','35 m.p.h.',0)
 ,( 8,'Where a left turn at an intersection can be started from either of two lanes, a U-turn can be started from ','Only the left lane','Either of the two lanes','Any lane that is open','Only the right lane',0)
 ,( 8,'Pedestrians using guide dogs or carrying white canes must be ','Given the right-of-way at all times','Given the right-of-way at corners only','Told when to cross the street','Never be given the right-of-way',0)
 ,( 8,'You must always look carefully for motorcycles before you change lanes or make a left turn because they ','Are hard to see','Have the right-of-way','Are driven too fast','Have many blind spots',0)
 ,( 8,'To be sure a lane is clear before moving into it, you should ','Turn your head and look','Look in the left side mirror','Look into the rear-view mirror','None of these',0)
 ,( 8,'You may cross over a double line on the road to pass another vehicle if the line on your side of the road is ','Broken','Solid white','Solid yellow','Divider',0)
 ,( 8,'If you become angry or upset, you should ','"Cool off" before driving','Go for a drive to forget your problems','Control your emotions while driving','Take it out on someone',0)
 ,( 8,'It is against the law to enter an intersection or crosswalk when ','You cannot cross without obstructing traffic from either side','The light is yellow','The light is flashing red','The light is green',0)
 ,( 8,'Which one of the following is NOT a safe driving habit? ','Fix your eyes on the vehicle ahead','Keep parking lights on at all times','Turn your head and look before you turn the steering wheel','None of these',0)
 ,( 8,'Driving under the influence of any drug which makes you drive unsafely is ','Against the law','Permitted if it is prescribed by a doctor','Permitted if it is a diet pill or cold medicine','None of these',0)
 ,( 8,'If you see orange construction signs and cones on a freeway, you must ','Be prepared for workers and slow moving equipment','Slow down because the road ends','Change lanes and maintain speed','Stop your car at the shoulder',0)
 ,( 8,'You must make a financial responsibility report after an accident when damage to one of the vehicles is over $750  ','No matter who was at fault','Only if you are not insured','Only if it was your fault','Only if you are insured',0)
 ,( 8,'At an intersection with stop signs at all four (or more) corners, when two cars arrive at the same time you must yield the right-of way to the driver ','On your right','On your left','Signaling a turn','In front of you',0)
 ,( 8,'Carpool lanes are marked with a diamond symbol. To use these lanes during the special hours shown on the signs you must ','Have the minimum number of passengers shown on the signs.','Be driving a van or bus','Drive at the speed limit or have your lights on','Be driving a motorcycle',0)
 ,( 8,'If you are arrested for drunk driving and refuse to submit to a chemical test of the alcohol content of your blood ','Your driving privilege will be withdrawn','You will receive an additional fine','You will not be allowed to post bail','You will be in jail for 3 months',0)
 ,( 8,'When you come to a corner where there is a flashing yellow light you must ','Slow down and cross carefully','Stop before crossing','Wait for the green light','None of these',0)
 ,( 8,'You are passing a school and see children near the street. You may not drive faster than ','25 m.p.h','35 m.p.h.','20 m.p.h.','15 m.p.h',0)
 ,( 8,'It has been proven that safety belts: ','Can reduce injury and death','Sometimes cause drivers to be trapped in their cars','Can make it harder to steer during an emergency','None of these',0)
 ,( 8,'When you reach a corner without a traffic light or sign at the same time as vehicles on the cross street, you must yield the right-of-way to ','The driver on your right','The driver on your left','Neither driver','The driver behind you',0)
 ,( 8,'When both right and left turn signals are flashing at the same time on a moving vehicle, it means ','There may be a hazard or an accident ahead','It is carrying children to or from school','Let the vehicle have the right-of-way','There may be a construction zone ahead',0)
 ,( 8,'California''s basic speed law" says, in addition to obeying the maximum speed limit, drivers must keep in mind ','Road, traffic and weather conditions','The posted speed limit','Synchronized stop lights','None of these',0)
 ,( 8,'When coming to a corner where there is a stop sign, you must first stop ','In back of the crosswalk','After crossing the crosswalk','Out far enough to see cross traffic','None of these',0)
 ,( 8,'When a school bus with flashing red lights has stopped on the road ahead of you, you must ','Stop until the lights stop flashing','Slow to 10 m.p.h.','Change lanes and pass cautiously','Slow to 20 m.p.h.',0)
 ,( 8,'Using the unpaved shoulder of the road to pass to the right of a vehicle ahead of you is ','Forbidden by law','Permitted if you are turning right','Permitted if the vehicle ahead is turning left','Permitted if you have an emergency',0)
 ,( 8,'If you become sleepy while driving, it is best to ','Drive to a safe place, stop and rest','Increase your speed to get away from other vehicles','Move over to the right lane and continue driving','Drink coffee and drive',0)
 ,( 8,'If traffic light is red, but a police officer or fire fighter on duty tells you to go ahead, you should ','Do as he or she tells you','Wait for the green light','Report him or her to police','None of these',0)
 ,( 8,'How many days do you have to report to DMV the sale or transfer of your vehicle? ','5 days','10 days','20 days','30 days',0)
 ,( 8,'If you are repeatedly convicted for traffic violations ','Your driving privilege may be suspended by DMV','DMV may impound your vehicle','You may be fined','All of the above',0)
 ,( 8,'You may not "double park" ','At any time','Except when making a delivery','Except while waiting in the vehicle','None of these',0)
 ,( 8,'Bicycle riders must ','Be given a safe amount of space when being passed by automobile drivers','Ride facing traffic when there is no bike lane','Never walk the bicycle across the street','Be given the right of way',0)
 ,( 8,'Driving so slowly as to interfere with normal or reasonable flow of traffic, except when necessary for safety, is ','A violation of the law','The right of any driver','Legal, but not advisable','Allowed at all times',0)
 ,( 8,'If a police officer asks you to take an alcohol test, you may choose: ','A blood, breath, or urine test','A field sobriety test','To say the alphabet backwards','Not give the test',0)
 ,( 8,'If you are involved in an accident ','Notify the local law enforcement agency or CHP if anyone is injured or killed','Show evidence that you have insurance only to a police officer','Stop and identify yourself only if someone is injured','None of these',0)
 ,( 8,'Sleeping pills, tranquilizers, pain medicine, or cold or allergy medications ','All of these','May impair your driving','May increase the bad effects of alcohol on your driving','May be effect your judgement',0)
 ,( 8,'A passenger vehicle may NOT tow ','Two trailers','One trailer','Another passenger vehicle','Three trailers',0)
 ,( 8,'If a driver ahead of you has stopped at a crosswalk, you should ','Stop then proceed when safe','Change lanes, look carefully, and pass','Tap your horn to let the driver know you are waiting','None of these',0)
 ,( 8,'You should not drive ','All of these','After you have taken any drink, drug, or medication which changes how you think, or act, or causes you to be less careful','If you are not alert','If you are drowsy',0)
 ,( 8,'When you enter a freeway from an on ramp and merge with traffic, you should be driving at ','About the same speed as the freeway traffic','The legal speed limit on the freeway','About 10 m.p.h. slower than the freeway speed limit','About 20 m.p.h. slower than the freeway speed limit',0)
 ,( 8,'Coasting with the gear shift in neutral is: ','Against the law','Recommended in the mountains','Safe and conserves gas','Allowed at all times',0)
 ,( 8,'You are driving alongside a bicycle lane and want to turn right at a corner. You should signal, look carefully for bike riders, then ','Merge into the bike lane before turning','Make your turn, being careful to stay out of the bike lane','Speed up and pass any bicycle riders before they get to the corner','None of these',0)
 ,( 8,'You may open your vehicle''s door on the traffic side ','Only when it is safe','At any time while parked','To leave but not to enter your vehicle','To enter but not to leave your vehicle',0)
 ,( 8,'If you are the first person to stop to give assistance at a collision scene, you should drive to the side of the road: ','After you have passed the collision scene','Before you reach the collision scene','Next to the collision scene','All of these',0)
 ,( 8,'The ''implied consent law” says you have agreed to take a test for the alcohol content of your blood ','Whenever you drive in California','On advice of an attorney','If an accident has occurred','All of these',0)
 ,( 8,'Give extra space to drivers backing out of parking spaces because','They may not see you','They have the right of way','It is required by law','All of these',0)
 ,( 8,'You are entering a freeway, you should check traffic by','Checking all mirrors and turning your head','Looking over your shoulder','Using the inside and outside mirrors only','Using rear view mirrors',0)
 ,( 8,'Which is true about other drivers','Never assume other drivers will give you the right of way','Drivers always obey traffic signs and signals','Drivers using turn signals always turn in the direction indicated','Drivers always follow the speed limit',0)
 ,( 8,'You are traveling at 55 mph on a two-lane highway, one lane in each direction, and you want to pass the car ahead of you. To pass safely you need to','Have at least a 10 - 12 second gap in the oncoming traffic','Wait until solid double yellow lines separate the lanes','Increase your speed to 65 mph','None of these',0)
 ,( 8,'When driving near road construction zones you should','Pass the construction zone carefully and avoid "rubbernecking"','Slow down and watch the construction as you pass','Step on your brakes just before you pass the construction','Stop your vehicle and then proceed',0)
 ,( 8,'When you back up in a passenger vehicle','Look over your right shoulder through the rear window','Rely on your rearview mirror','Only use your side and rearview mirrors','None of these',0)
 ,( 8,'You exit a freeway on a ramp that curves downhill, you should','Slow to a safe speed before the curve','Slow to the posted speed limit for the freeway','Wait until you have entered the curve to begin braking','Stop to a safe speed before the curve',0)
 ,( 8,'If there is a single set of solid yellow lines in the center of the roadway you','May cross the lines to turn left into a private driveway','Are on a two lane one way street','Should not cross for any reason','All of these',0)
 ,( 8,'On a sharp curve you should use your brakes to slow the vehicle','Before you enter the curve','Just after you enter the curve','During the entire time you drive through the curve','None of these',0)
 ,( 8,'When sharing the road with a light rail vehicle','Never turn in front of a light rail vehicle','Always pass a light rail vehicle slowly on the right','Remember they are loud and move slowly like freight trains','The light rail vehicle has the right of way',0)
 ,( 8,'You can be fined up to $1,0)00 and jailed for six months if you are cited for','Dumping or abandoning an animal on the highway','Making a U-turn from a center left turn lane','Parking in a bicycle lane','Drinking and Driving',0)
 ,( 8,'The "Three second rule" applies to the space ______ of your vehicle','Ahead','In back','To the sides','None of these',0)
 ,( 8,'What is the best advice for driving when heavy fog or dust occurs','Try not to drive until the conditions improve','Do not drive too slowly because others may hit you','Alternate your high and low beams to improve your vision','Drive only with high beams lights',0)
 ,( 8,'When driving a vehicle with air bags you are safest when seated','At least 10 inches away from the steering wheel','Within 6 1/2 inches of the steering wheel','With your head positioned directly above the steering wheel','None of these',0)
 ,( 8,'During the first 12 months after you are licensed, you must be accompanied by your parent or guardian if you','Transport minors between the hours of 11 pm and 5 am','Drive between the hours of 5 am and 11 pm','Transport adults between the hours of 5 am and midnight','Transport minors between the hours of 5 am and 11 pm',0)
 ,( 8,'If you are a minor and your cell phone rings while you are driving, you should','Let the call go to voice mail','Answer it if you have a hands free device','Answer the call if it is from your parents','None of these',0)
 ,( 8,'Smoking inside a vehicle when a person younger than 18 years of age is present is:','Illegal at all times','Legal, if it is your child','Not restricted by law','Legal, if it is an adult',0)
 ,( 8,'Which of these is a legal U turn','On a highway where there is a paved opening for a turn','150 feet from a hill or curve','Over two sets of double yellow lines in the roadway','None of these',0)
 ,( 8,'Use your high beam headlights at night','Whenever it is legal and safe','As little as possible','Only on unlighted streets','Only when there is fog',0)
 ,( 8,'If another driver "cuts" in front of you, it would be better if you','Take your foot off the gas','Brake suddenly','Accelerate to avoid being "cut off"','None of these',0)
 ,( 8,'The speed limit in any alley is','15 mph','20 mph','10 mph','30 mph',0)
 ,( 8,'The speed limit posted on a road is 55 mph. When the road is wet','Drive 5 to 10 mph under the speed limit','Maintain a 55 mph speed','Drive 20 to 25 mph under the speed limit','Avoid driving',0)
 ,( 6,'What is the capital of Indonesia?','Jakarta','Delhi','Harare','Juda',0)
 ,( 6,'What is the capital of Uganda?','Kampala','Kiev','Bombo','Bondo',0)
 ,( 6,'Havana is the capital of which country?','Cuba','Czech Republic','Cyprus','Egypt',0)
 ,( 6,'What is the capital of India?','New Delhi','Banglore','Hyderabad','Bombay',0)
 ,( 6,'What is the capital of Angola?','Luanda','Kabul','Nassau','None of these',0)
 ,( 6,'What is the capital of United Arab Emirates?','Abu Dhabi','Dubai','Sharjah','Ajman',0)
 ,( 6,'What is the capital of Japan?','Tokyo','Kansai','Kyoto','Kyushu',0)
 ,( 6,'What is the capital of  Libiya?','Tripoli','Misrata','Zawiya','Kufra',0)
 ,( 6,'Seoul is the capital of which country?','South Korea','North Korea','China','Japan',0)
 ,( 6,'What is the capital of Italy?','Rome','Paris','Venice','Pristina',0)
 ,( 6,'What is the capital of Malaysia?','Kuala Lumpur','Penang','Ipoh','Kuching',0)
 ,( 6,'What is the capital of Australia?','Canberra','Sydney','Albury','Armidale',0)
 ,( 6,'Dhaka is the capital of which country?','Bangladesh','Nepal','India','Sri Lanka',0)
 ,( 6,'What is the capital of The Bahamas?','Nassau','Ottawa','Praia','Bangui',0)
 ,( 6,'What is the capital of Arizona?','Phoenix','Denver','Adamana','Aguila',0)
 ,( 6,'Sacramento is the capital of which state?','California','Florida','Idaho','Indiana',0)
 ,( 6,'What is the capital of Colarado?','Denver','Fort Collins','Agate','Agro',0)
 ,( 6,'What is the capital Hawaii?','Honolulu','Kona','Hilo','Maui',0)
 ,( 6,'What is the capital of Connecticut?','Hartford','Norwalk','New Haven','Grotons',0)
 ,( 6,'What is the capital of Iowa?','Des Moines','Adams','Cedar','Linn',0)
 ,( 6,'What is the capital of Illinois?','Springfield','Chicago','Ashley','Blue Island',0)
 ,( 6,'What is the capital of Georgia?','Atlanta','Abba','Bronco','Brinson',0)
 ,( 6,'What is the capita of Kansas?','Topeka','Manhattan','Lenexa','Dodge City',0)
 ,( 6,'What is the capital of Idaho?','Boise','Cedar','Carey','Challis',0)
 ,( 6,'What is the capital of Florida ?','Tallahassee','San Jose','East Hope','Hammett',0)
 ,( 6,'What is the capital of Louisiana?','Baton Rouge','Gloster','Mound','Monroe',0)
 ,( 6,'What is the capital of New Mexico?','Santa Fe','Quito','Cairo','San Salvador',0)
 ,( 6,'What is the capital of New York?','Albany','Manhattan','Ilion','Ira',0)
 ,( 6,'What is the capital of North Dakota?','Bismarck','Portland','Seaside','Albany',0)
 ,( 6,'What is the capital of Montana?','Helena','Angela','Avon','Portland',0)
 ,( 6,'What is the capital Nebraska?','Lincoln','Loup','Merrick','Howard',0)
 ,( 6,'What is the capital of Nevada?','Carson City','Las Vegas','Elko','Mesquite',0)
 ,( 6,'Richmond is the capital of which state?','Virginia','Tennessee','Utah','Vermont',0)
 ,( 6,'Columbus is the capital of which state?','Ohio','North Dakota','South Carolina','Texas',0)
 ,( 6,'What is the capital of Texas?','Austin','Dallas','Columbia','Albany',0)
 ,( 6,'What is the capital of Wyoming?','Cheyenne','Platte','Johnson','Campbell',0)
 ,( 6,'What is the capital of Utah?','Salt Lake City','Logan','Mohab','Castle County',0)
 ,( 6,'What is the capital of China?','Beijing','Moroni','Havana','Zagreb',0)
 ,( 6,'What is the capital of Colombia?','Bogota','Ottawa','India','Russia',0)
 ,( 6,'What is the capital of Jamaica?','Kingston','Dublin','Tehran','San Jose',0)
 ,( 6,'What is the capital of Kazakhstan?','Astana','Kabul','Nairobi','Jakarta',0)
 ,( 6,'What is the capital of Kuwait?','Kuwait City','Abu Dhabi','Riyadh','Ajman',0)
 ,( 6,'Bishkek is the capital of which country?','Kyrgyzstan','Pakistan','Maldives','Mali',0)
 ,( 6,'What is the capital of Macedonia?','Skopje','Vaduz','Riga','Maseru',0)
 ,( 6,'What is the capital of Luxembourg ?','Luxembourg','Vaduz','Majuro','Male',0)
 ,( 6,'What is the capital of Morocco ?','Rabat','Windhoek','Monaco','Palikir',0)
 ,( 6,'What is the capital of Netherlands ?','Amsterdam','Wellington','Kathmandu','Rabat',0)
 ,( 6,'What is the capital of Myanmar?','Rangoon','Bangladesh','Bamako','Male',0)
 ,( 6,'What is the capital of Montenegro ?','Podgorica','Vilnius','Ulaanbaatar','Bamako',0)
 ,( 6,'What is the capital of Oman?','Muscat','Kuwait','Riyadh','Syria',0)
 ,( 6,'What is the capital of Peru ?','Lima','Manila','Libson','Port Louis',0)
 ,( 6,'What is the capital of Paraguay?','Asuncion','Maputo','Oslo','None of these',0)
 ,( 6,'What is the capital of Philippines ?','Manila','Doha','Apia','Dakar',0)
 ,( 6,'What is the capital of Serbia?','Belgrade','Kigali','Lisbon','None of these',0)
 ,( 6,'What is the capital of Oregon?','Salem','Portland','Ashland','Vientiane',0)
 ,( 6,'What is the capital of Oklahoma?','Oklahoma City','Columbus','Austin','Pierre',0)
 ,( 6,'What is the capital of Mississippi?','Jackson','Saint Paul','Carson City','Concord',0)
 ,( 6,'What is the capital Wisconsin?','Madison','Richmond','Olympia','Salt Lake City',0)
 ,( 6,'What is the capital of Kentucky?','Frankfort','Topeka','Springfield','Boise',0)
 ,( 6,'What is the capital of Georgia?','Atlanta','Des Moines','Augusta','Indianapolis',0)
 ,( 6,'What is the capital of Qatar?','Doha','Libiya','Lima','Panama City',0)
 ,( 6,'What is the capital of Romania ?','Bucharest','Sao Tome','Apia','Freetown',0)
 ,( 6,'What is the capital of Senegal?','Dakar','Riyadh','Castries','Fremont',0)
 ,( 6,'What is the capital of Singapore?','Singapore','Dakar','Victoria','Honiara',0)
 ,( 6,'What is the capital of South Africa ?','Cape Town','San Mateo','Lima','Asuncion',0)
 ,( 6,'What is the capital of Slovakia ?','Bratislava','Riyadh','Moscow','Lima',0)
 ,( 6,'What is the capital of Somalia?','Mogadishu','Cuba','Singapore','Kigali',0)
 ,( 6,'What is the capital of Seychelles ?','Victoria','Dakar','Riyadh','Kigali',0)
 ,( 6,'What is the capital of South Sudan?','Juba','Lome','Honiara','None of these',0)
 ,( 6,'What is the capital of Spain ?','Madrid','Colombo','Bern','Taipei',0)
 ,( 6,'What is the capital of Sweden?','Stockholm','Sao Tome','Honiara','None of these',0)
 ,( 6,'What is the capital of Taiwan ?','Taipei','Thailand','Fujairah','Damascus',0)
 ,( 6,'What is the capital of Tunisia?','Tunis','Berlin','Madrid','Salem',0)
 ,( 6,'What is the capital of Ukraine?','Kyiv','London','Lome','Nuku''alofa',0)
 ,( 6,'What is the capital of Turkey ?','Ankara','Juba','Jordon','Honolulu',0)
 ,( 6,'What is the capital of United Kingdom ?','London','Portland','Sydney','None of these',0)
 ,( 6,'What is the capital of Uzbekistan ?','Tashkent','Kabul','Tirana','Baku',0)
 ,( 6,'What is the capital of Vanuatu ?','Port-Vila','Canberra','Dhaka','Nassau',0)
 ,( 6,'What is the capital of Vatican City?','Vatican City','La Paz','Manama','None of these',0)
 ,( 6,'What is the capital of  Venezuela ?','Caracas','Minsk','Port Vila','Panama',0)
 ,( 6,'What is the capital of Vietnam?','Hanoi','Sofia','Yaounde','None of these',0)
 ,( 6,'What is the capital of Yemen ?','Sanaa','Brussels','Thimpu','None of these',0)
 ,( 6,'What is the capital of Zambia ?','Lusaka','Santiago','San Jose','Santa Cruz',0)
 ,( 6,'What is the capital of Zimbabwe ?','Harare','Brazzaville','Sab Francisco','None of these',0)
 ,( 6,'What is the capital of Belgium?','Brussels','Ottawa','Bangui','None of these',0)
 ,( 6,'What is the capital of Bolivia ?','La Paz','Yaounde','Brasilia','Faso',0)
 ,( 6,'What is the capital of Cameroon?','Yaounde','Sarajevo','Thimphu','None of these',0)
 ,( 6,'What is the capital of Burkina?','Faso - Ouagadougou','Beijing','San Francisco','None of these',0)
 ,( 6,'What is the capital of Cape Verde?','Praia','Bangui','Brazzaville','None of these',0)
 ,( 6,'What is the capital of Chad?','N''Djamena','Moroni','Bangui','None of these',0)
 ,( 6,'What is the capital of Egypt?','Cairo','Quito','Dili','None of these',0)
 ,( 6,'What is the capital of Ecuador?','Quito','Cairo','Berlin','None of these',0)
 ,( 6,'What is the capital of Eritrea ?','Asmara','Havana','Nicosia','Dili',0)
 ,( 6,'What is the capital of Equatorial Guinea?','Malabo','Accra','San Jose','None of these',0)
 ,( 6,'What is the capital of Czech Republic?','Prague','Tallinn','Moroni','None of these',0)
 ,( 6,'What is the capital of Fiji?','Suva','Conakry','Athens','None of these',0)
 ,( 6,'What is the capital of France?','Paris','Conakry','Jakarta','Bissau',0)
 ,( 6,'What is the capital of Germany ?','Berlin','Georgetown','Paris','Suva',0)
 ,( 6,'What is the capital of Greece?','Athens','Budapest','Accra','Quito',0)
 ,( 6,'What is the capital of Haiti?','Port-au-Prince','Riga','Kuwait','None of these',0)
 ,( 6,'Vientiane is the capital of which country?','Laos','Israel','Kenya','None of these',0)
 ,( 6,'What is the capital of Iceland?','Reykjavik','Amman','Riga','None of these',0)
 ,( 6,'What is the capital of Kosovo?','Pristina','Kingston','Dublin','None of these',0)
 ,( 6,'What is the capital of Lebanon ?','Beirut','Riga','Vilnius','None of these',0)
 ,( 6,'What is the capital of Iraq?','Baghdad','Tehran','Nairobi','None of these',0)
 ,( 6,'What is the capital of Ireland?','Dublin','Budapest','Tripoli','None of these',0)
 ,( 6,'What is the capital of Israel?','Jerusalem','Pyongyang','Astana','None of these',0)
 ,( 6,'What is the capital of Hungary?','Budapest','Port-au-Prince','Tarawa Atoll','Seoul',0)
 ,( 6,'What is the capital of Mali?','Bamako','Port Louis','Male','None of these',0)
 ,( 6,'What is the capital of Malta?','Valletta','Majuro','Mexico City','Vaduz',0)
 ,( 6,'What is the capital of Malawi?   ','Lilongwe','Luxembourg','Antananarivo','Palikir',0)
 ,( 6,'What is the capital of North Korea?','Pyongyang','Rabat','Managua','Ulaanbaatar',0)
 ,( 6,'What is the capital of Namibia?','Windhoek','Abuja','Wellington','None of these',0)
 ,( 6,'What is the capital of Nepal?','Kathmandu','Chisinau','Amsterdam','Oslo',0)
 ,( 6,'What is the capital of New Zealand?','Wellington','Nouakchott','Abuja','Lilongwe',0)
 ,( 6,'What is the capital of Palau?','Melekeok','Basseterre','San Marino','None of these',0)
 ,( 6,'What is the capital of Rwanda?','Kigali','Doha','Manila','Oslo',0)
 ,( 6,'What is the capital of Samoa?','Apia','Dakar','Victoria','San Marino',0)
 ,( 6,'What is the capital of Papua New Guinea?','Port Moresby','Muscat','Victoria','Kingstown',0)
 ,( 6,'What is the capital of Sri Lanka?','Colombo','Singapore','Freetown','Taipei',0)
 ,( 6,'What is the capital of Tajikistan?','Dushanbe','Bern','Lome','Juba',0)
 ,( 6,'What is the capital of Suriname?','Paramaribo','Khartoum','London','None of these',0)
 ,( 6,'What is the capital of Tanzania?','Dar es Salaam','Hanoi','Bangkok','Harare',0)
 ,( 6,'What is the capital of Algeria?','Algiers','Bridgetown','Brussels','Canberra',0)
 ,( 6,'What is the capital of Bahrain?','Manama','Majuro','Rabat','Chisinau',0)
 ,( 6,'What is the capital of Mozambique ?','Maputo','Beirut','Pristina','None of these',0)
 ,( 10,'100 / 20 * 6 =','30','1,400','26','36',0)
 ,( 10,'Lisa must read 31 pages for history class, 17 pages for English, 29 pages for civics, and 13 pages for biology. If Lisa currently read 1/6 of the entire number of pages, how many pages has she read?','15','45','60','90',0)
 ,( 10,'44 / 2 * 4 =','88','78','86','92',0)
 ,( 10,'A 2-ton truck is taxed at a rate of $0.12 per pound. How much is the total tax bill?','$480','$120','$240','$600',0)
 ,( 10,'4 - 3 * 20 =','-56','-64','20','240',0)
 ,( 10,'Fred plans to jog for one hour per day, five days a week. This week, he cut his workout short on Tuesday by 40 minutes but was able to make up 13 minutes on Wednesday and 20 minutes on Friday. How many minutes of jogging did Fred lose for the week?','7','20','13','3',0)
 ,( 10,'2 + 3 - 1 + 4 =','8','7','9','10',0)
 ,( 10,'Jack loaned Jill $1,500 at an annual interest rate of 7%. After one year, how much will Jill owe Jack?','$1,605','$1,650','$105','$1,395',0)
 ,( 10,'5 * 2 + 1 - 3 * 4 = ','-1','3','20','32',0)
 ,( 10,'A student buys a science textbook for $18.00, a math textbook for $14.50, and a dictionary for $9.95. What is the total cost of the books?','$42.45','$27.95','$38.50','$41.95',0)
 ,( 10,'25 * 3 - 25 + 50 =','100','75','125','150',0)
 ,( 10,'A train travels 300 miles in six hours. If it travelled at a constant speed the entire time, what was the speed of the train?','50 miles per hour','60 miles per hour','180 miles per hour','1,800 miles per hour',0)
 ,( 10,'159 - 24 =','135','125','134','137',0)
 ,( 10,'At a cost of $1.50 per gallon, how much will 15 gallons of gas cost?','$22.50','$15.00','$20.00','$21.50',0)
 ,( 10,'14 - 7 * 3 - 7 =','-14','0','14','28',0)
 ,( 10,'Bob is 10 years older than Marley, who is 16. How old is Bob?','26 years old','6 years old','10 years old','20 years old',0)
 ,( 10,'3 * 6 / 9 =','2','1','3','9',0)
 ,( 10,'If 1/3 of a 12-foot board is sawed off, how much is left?','8 feet','3 feet','4 feet','6 feet',0)
 ,( 10,'1 + 1 - 1 + 1 - 1 + 1 - 1 + 1 =','2','0','1','4',0)
 ,( 10,'Of 150 students polled, 105 said they rode the bus at least three times per week. How many students out of 100,0)00 could be expected to ride the bus at least three times each week?','70,0)00','55,0)00','72,500','75,0)00',0)
 ,( 10,'How many quarters are there in $12?','48','12','24','120',0)
 ,( 10,'77 + 77 - 7 =','147','157','167','177',0)
 ,( 10,'Robert left his workplace at 5:16 P.M. on Thursday and returned at 7:58 A.M. on Friday. How much time elapsed between the time Robert left work on Thursday and the time he returned on Friday?','14 hours 42 minutes','2 hours 42 minutes','13 hours 42 minutes','14 hours 52 minutes',0)
 ,( 10,'7 * 3 / 7 * 3 =','9','0','1','21',0)
 ,( 10,'George buys three books for a total cost of $70. Two of the books are on sale for $15 each. How much does the third book cost?','$40','$30','$50','$70',0)
 ,( 10,'1000 * 1000 =','1,0)00,0)00','10,0)00','100,0)00','10,0)00,0)00',0)
 ,( 10,'If Ashley can run around the block five times in 20 minutes, how many times can she run around the block in one hour?','15','25','30','100',0)
 ,( 10,'1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 =','45','40','50','55',0)
 ,( 10,'Which of the following is a translation of the statement "Twice the sum of six and four"?','2 * (6 + 4)','2 + 6 + 4','2 * 6 + 4','(2 * 6) + 4',0)
 ,( 10,'4 * 4 + 4 * 4 + 4 =','36','40','84','256',0)
 ,( 10,'Each week, Justin saves $25. How long will it take him to save $350?','14 weeks','12 weeks','16 weeks','18 weeks',0)
 ,( 10,'-5 * 20 + 47 =','-53','-355','32','147',0)
 ,( 10,'A train moving at a constant speed of 60 miles per hour leaves Los Angeles for Chicago (at time t = 0). If Chicago is 2,0)00 miles from Los Angeles, which of the following equations describes the distance (D) from Los Angeles at any time t?','D(t) = 2000 – 60t','D(t) = 60t','D(t) = 60t – 2000','D(t) = 2000 + 60t',0)
 ,( 10,'6 * 6 * 6 =','216','18','72','266',0)
 ,( 10,'Fred''s Fish Market was shipped 400 pounds of cod packed into 20-pound crates. How many crates were needed for the shipment?','20','10','40','80',0)
 ,( 10,'29 * 3 - 25 =','62','-638','63','800',0)
 ,( 10,'Which of the following is a translation of the following sentence? Aaron (A) is ten years older than Rachel (R).','s = R + 10','R - 10 = S','S + R = 10','10 + S = R',0)
 ,( 10,'2000 - 20 * 2 =','1,960','1,980','3,960','3,980',0)
 ,( 10,'Find the next number in the following pattern: 320, 160, 80, 40','20','10','30','35',0)
 ,( 10,'John is 5 feet 11 inches tall, and Perry is 6 feet 5 inches tall. How much taller is Perry than John?','6 inches','7 inches','1 foot','1 foot 7 inches',0)
 ,( 10,'450 / 3 * 5 =','750','30','2,235','2,265',0)
 ,( 10,'Third graders Sara and Courtney both have lemonade stands. Sara sells her lemonade at five cents a glass, and Courtney sells hers at seven cents a glass. Sara sold 17 glasses of lemonade today, and Courtney sold 14 glasses. Who earned the most money and by what amount?','Courtney by 13 cents','Sara by 13 cents','Sara by 85 cents','Courtney by 98 cents',0)
 ,( 10,'1,555 + 35 / 5 =','1,562','304','318','1,585',0)
 ,( 10,'Carrie and Mary got summer jobs at the ice cream shop and were each supposed to work 15 hours per week for eight weeks. During that time, Mary was sick for one week and Carrie took her shifts. How many hours did Carrie work during the eight weeks?','135','120','150','185',0)
 ,( 10,'9 + 0 * 9 + 0 * 9 + 0 =','9','0','729','27',0)
 ,( 10,'The total ages of Joseph, Jordan, and Joel is 80 years old. What was the total of their ages three years ago?','71','72','74','77',0)
 ,( 10,'0 + 1 + 2 + 3 * 2 * 1 * 0 =','3','0','6','9',0)
 ,( 10,'What is the product of all the numbers (0 through 9) in the dial of a telephone?','0','27','45','362,880',0)
 ,( 10,'2 * (9 + 5) - 16 + 5 * 2','22','6','10','16',0)
 ,( 10,'12 year old Mark is three times as old as his brother Brandon. How old will Mark be when he is twice as old as Brandon?','16 years old','14 years old','18 years old','20 years old',0)
 ,( 11,'If you multiply an inequality by a negative number, when should you reverse the inequality symbol?','Always','Never','Sometimes','Only if the negative number is a fraction',0)
 ,( 11,'What is the additive inverse of x - y?','-x + y','x + y','y - x','-x - y',0)
 ,( 11,'If the square root of x is greater than x, then x could be','1/2','0','2','4',0)
 ,( 11,'If n - 5 is an even integer, what is the next larger consecutive even integer','n - 3','n - 7','n - 4','n + 2',0)
 ,( 11,'The side of a square measures 6 cm. What is the exact length of the diagonal of the square?','6*sqrt(2) cm','2*sqrt(6) cm','6*sqrt(3) cm','4*sqrt(3) cm',0)
 ,( 11,'The choices below contain the lengths of the sides of four separate triangles. Which of the choices is NOT a right triangle?','20, 24, 26','12, 16, 20','15, 36, 39','30, 40, 50',0)
 ,( 11,'Which of the following sets is a subset of {2, 4, 6, 8, 10, 12}?','{4, 8, 12}','{14}','{2, 3, 4}','{1, 3, 5}',0)
 ,( 11,'Given the relation D = {(6,4), (8,-1), (x,7), (-3,-6)}. Which of the following values for x will make relation D a function?','-6','-3','8','6',0)
 ,( 11,'The larger root of the equation (x + 4)(x - 3) = 0 is','3','-4','-3','4',0)
 ,( 11,'The graph of  y = 2^x  lies in which Quadrants? ','I, II','I, III','I, IV','II, III',0)
 ,( 11,'Expressed in simplest form, 12a^3c/4ac is equivalent to','3a^2','8a^2','3a^3','3a^3c',0)
 ,( 11,'Which trinomial is equivalent to (3x - 2)(x + 4)? ','3x^2 + 10x - 8','3x^2 + 10x + 8','3x^2 - 10x + 8','3x^2 - 10x - 8',0)
 ,( 11,'Which property is illustrated by the equation  (a + b) + c = c + (a + b) ?','commutative','associative','distributive','identity',0)
 ,( 11,'What is the value of  y in the equation   2(3y - 4) = 10 ?','3','1','2(1/3)','1/3',0)
 ,( 11,'What is the slope of the line containing the points (-9,2) and (3,14)?','1','-1','-8/3','-2',0)
 ,( 11,'What is the value of w in the equation (3/4)w + 8 = (1/3)w - 7?','-36','-0.2','-13.846','2.4',0)
 ,( 11,'One of the roots of the equation  x^2 + 3x - 18 = 0 is 3.  What is the other root?','-6','6','15','-21',0)
 ,( 11,'Which ordered pair is not in the solution set of  y > 2x + 1 ?','(2,5)','(3,8)','(1,6)','(1,4)',0)
 ,( 11,'What is the sum of 5sqrt(7) and 3sqrt(28) ?','11sqrt(7)','9sqrt(7)','6sqrt(9)','8sqrt(35)',0)
 ,( 11,'Given the equations  y = x^2 - 4x - 5  and  y + x = -1, one point that satisfies both equations is:','(4,-5)','(-2,1)','(2,-9)','(5,0))',0)
 ,( 11,'At Bison High School, there are 16 students in English Club, 16 students in Science Club and 20 students in Math Club.  Of these students, there are 5 students in both the English and Science Clubs; 6 students in both the Science and Math Clubs; and 8 in both the English and Math Clubs.  If only 2 students are in all three clubs, how many students are in at least one of the clubs?','35','20','30','52',0)
 ,( 11,'In a cup there are 4 quarters, 5 dimes, 6 nickels and 10 pennies.  If one coin is selected at random, what is the probability that the coin has a letter "n" in its name?','16/25','6/25','2/4','9/16',0)
 ,( 11,'The expression (3x/4) - (x/3) is equivalent to','(5x/12)','(14x/7)','(14x/12)','(5x/7)',0)
 ,( 11,'For which value of  x  is (x - 2)/(x^2 + 3x + 2) undefined?','-2','2','1','4',0)
 ,( 11,'The height, h, of a cylinder is 3 units less than 4 times its radius, r.  Which expression represents the height of the cylinder in terms of its radius?','4r - 3','4r - 3h','3 - 4r','4r + 3',0)
 ,( 11,'The length of a rectangular garden is 3 yards more than its width.  If the area of the garden is 36 square yards, which equation could be used to find the dimensions of the garden?','x^2 + 3x - 36 = 0','x^2 - 3x - 36 = 0','x^2 + 3x + 36 = 0','x^2 - 3x + 36 = 0',0)
 ,( 11,'Which expression represents the product of 6.5 * 10e4 and 2.4 * 10e3 ?  ','1.56 x 10e8','1.56 x 10e12','8.9 x 10e7','15.6 x 10e8',0)
 ,( 11,'An LCD panel is used for a computer monitor.  When rounded to the nearest inch, the length of the monitor is 16 inches and the width is 12 inches.  Which of these cannot be the area of the monitor?','174 sq. in.','186 sq. in.','192 sq. in.','204 sq. in.',0)
 ,( 11,'Trina has a college fund started with a deposit of  $10,0)00 which earns 5% annually.  If no other monies are deposited, how much money will Trina have in her fund at the end of three years?','$11576.25','$15000','$25000','$11500',0)
 ,( 11,'A company is designing a cylinder to hold marbles for a new game it is inventing.  The cylinder has a height of 18 inches and a diameter of 6 inches.  Find the volume of the cylinder to the nearest tenth of a cubic inch.','508.9','678.6','1065.92','122.33',0)
 ,( 11,'Given the following system of equations, find the value for x in the solution. 5x - 4y = 28  3x + y = 44','12','9','8','4',0)
 ,( 11,'Throughout history, many people have contributed to the development of mathematics.  These mathematicians include Pythagoras, Euclid, Hypatia, Euler, Einstein, Agnesi, Fibonacci, and Pascal.  What is the probability that a mathematician''s name selected at random from those listed will start with either the letter E or the letter A?','4/8','6/8','3/8','2/8',0)
 ,( 11,'Which expression represents(2x^3)(8x^5)/4x^6 in simplest form?','4x^2','4x^9','x^9','x^2',0)
 ,( 11,'Which interval notation represents the set of all numbers from 2 through 7, inclusive?','[2,7]','[2,7)','(2,7)','(2,7]',0)
 ,( 11,'Which property is illustrated by the equation ax + ay = a(x + y)?','distributive','identity','commutative','associative',0)
 ,( 11,'The expression x² - 16 is equivalent to','(x + 4)(x - 4)','(x + 8)(x - 8)','(x - 2)(x + 8)','(x + 2)(x - 8)',0)
 ,( 11,'Which situation describes a correlation that is not a causal relationship?','The rooster crows, and the sun rises.','The more powerful the microwave, the faster the food cooks.','The more miles driven, the more gasoline needed.','The faster the pace of a runner, the quicker the runner finishes.',0)
 ,( 11,'The equations 5x + 2y = 48 and 3x + 2y = 32 represent the money collected from school concert ticket sales during two class periods.  If x represents the cost for each adult ticket and y represents the cost for each student ticket, what is the cost for each adult ticket?','$8','$3','$2','$5',0)
 ,( 11,'Given:  Set A = {(-2,-1), (-1,0)), (1,8)}   and   Set B = {(-3,-4), (-2,-1), (-1,2), (1,8)}. What is the intersection of sets A and B?','{(-2,-1), (1,8)}','{(1,8)}','{(-2,-1)}','{(-3,-3), (-2,-1), (-1,2), (-1,0)), (1,8)}',0)
 ,( 11,'What is an equation for the line that passes through the coordinates (2,0)) and (0,3)?','y = -3/2x + 3','y = -3/2x - 3','y = -2/3x + 2','y = -2/3x - 2',0)
 ,( 11,'Which situation should be analyzed using bivariate data?','Mr. Benjamin tries to see if his students'' shoe sizes are directly related to their heights.','Mr. DeStefan records his customers'' best video game scores during the summer.','Mr. Chan keeps track of his daughter''s algebra grades for the quarter.','Ms. Saleem keeps a list of the amount of time her daughter spends on her social studies homework.',0)
 ,( 11,'An electronics store sells DVD players and cordless telephones.  The store makes a $75 profit on the sale of each DVD player (d) and a $30 profit on the sale of each cordless telephone (c).  The store wants to make a profit of at least $255.00 from its sale of DVD players and cordless phones.  Which inequality describes this situation?','75d + 30c > 255','75d + 30c < 255','75d + 30c < 255','75d + 30c > 255',0)
 ,( 11,'What is the slope of the line containing the points (3,4) and (-6,10)?','-2/3','-2/2','3/4','5/6',0)
 ,( 11,'The expression is (9x^4 - 27x^6)/(3x^6) equivalent to','3x(1 - 3x^2)','3x(1 - 3x)','3x(1 - 9x^5)','9x^3(1 - x)',0)
 ,( 11,'Daniel''s Print Shop purchased a new printer for $35,0)00.  Each year it depreciates (loses value) at a rate of 5%.  What will its approximate value be at the end of the fourth year?','$28,507.72','$30,0)08.13','$33,250.00','$27,0)82.33',0)
 ,( 11,'In triangle MCT, the measure of  angle T = 90 degrees, MC = 85 cm, CT = 84 cm, and TM = 13 cm. Which ratio represents the sine of angle C?','13/85','84/85','13/84','84/13',0)
 ,( 11,'The groundskeeper is replacing the turf on a football field.  His measurements of the field are 130 yard by 60 yards.  The actual measurements are 120 yards by 54 yards.  Which expression represents the relative error in the measurement?','[(130)(60)-(120)(54)] / [(120)(54)]','[(130)(60)-(120)(54)] / [(120)(60)]','[(120)(54)] / [(120)(54)-(120)(54)]','[(120)(54)] / [(130)(60)-(120)(54)]',0)
 ,( 11,'Which value of x is in the solution set of the inequality  -2x + 5 > 17 ?','-8','-6','-4','12',0)
 ,( 11,'The length of a rectangular window is 5 feet more than its width, w.  The area of the window is 36 square feet.  Which equation could be used to find the dimensions of the window?','w² + 5w  - 36 = 0','w² - 5w + 36 = 0','w² + 5w + 36 = 0','w² - 5w  - 36 = 0',0)
 ,( 11,'Which verbal expression represents 2(n - 6) ?','two times the quantity six less than n','two times n minus six','two times six minus n','two times the quantity n less than six',0)
 ,( 11,'What is the sum of d/2 and 2d/3 expressed in simplest form?','7d/6','7d/5','3d/5','3d/6',0)
 ,( 11,'What is the quotient of 8.05 * 10^6 and 3.5 * 10^6 ?','2.3*10^4','2.3*10^3','2.3*10^8','2.3*10^12',0)
 ,( 11,'For which value of x is (x - 3)/(x^2 - 4)undefined?','-2','0','3','4',0)
 ,( 11,'Which property is displayed in the following equation?    (xy)z = x(yz)','associative property of multiplication','multiplicative inverse property','distributive property','commutative property of multiplication',0)
 ,( 11,'A large pizza has a circumference of 72.5 inches.  Which of the perimeters listed could belong to the smallest box capable of holding a large pizza?','96','73','24','23',0)
 ,( 11,'The ages of two brothers can be represented as consecutive even integers.  If the younger brother''s age is x + 3, which expression represents the age of the older brother.','2x + 3','x + 5','x + 4','x + 1',0)
 ,( 11,'Given the relation A = {(5,2), (7,4), (9,10), (x, 5)}.  Which of the following values for x will make relation A a function?','4','3','5','7',0)
 ,( 11,'The expression 2(3x^2)^3 is equivalent to','54x^6','6x^6','18x^6','6x^6',0)
 ,( 11,'The slope of a line parallel to the line whose equation is 3y + 2x = 6 is','-2/3','2/3','-3/2','3/2',0)
 ,( 11,'The heights of all the students in grade 9 are arranged from least to greatest. Which statistical measure separates the top half of this set of data from the bottom half?','median','mode','mean','average',0)
 ,( 11,'Which ordered pair is not a solution set of  y > 5x - 1?','(2, 5)','(1, 8)','(1, 6)','(1, 5)',0)
 ,( 11,'When solved graphically, which system of equations will have exactly one point of intersection?','y = -x - 20,  y = x + 17','y = 0.5x + 30, y = 0.5x - 30','y = 0.6x + 12, y = 0.6x - 19','y = -x + 15,  y = -x + 25',0)
 ,( 11,'What is the sum of 6sqrt(7) and 2sqrt(63)?','12sqrt(7)','36sqrt(7)','8sqrt(7)','3sqrt(7)',0)
 ,( 11,'The expression (3x^2 + 2xy + 7) – (6x^2 - 4xy + 3) is equivalent to','-3x^2 + 6xy + 4','3x^2 - 6xy - 4','3x^2 - 2xy + 4','-3x^2 - 2xy + 4',0)
 ,( 11,'If x = –4 and y = 3, what is the value of x – 3y^2?','-31','-85','-23','-13',0)
 ,( 11,'The formula for potential energy is P = mgh, where P is potential energy, m is mass, g is gravity, and h is height. Which expression can be used to represent g?','P/mh','(P/m) - h','P - mh','P - m - h',0)
 ,( 11,'A deli has five types of meat, two types of cheese, and three types of bread. How many different sandwiches, consisting of one type of meat, one type of cheese, and one type of bread, does the deli serve?','30','75','25','10',0)
 ,( 11,'What is the solution set of the equation  x/5 + x/2 = 14?','{20}','{10}','{49}','{4}',0)
 ,( 11,'If n represents an odd number, which computation results in an answer that is an even number?','3*n + 1','3*n - 2','2*n - 1','2*n + 1',0)
 ,( 11,'If point (–1,0)) is on the line whose equation is y = 2x + b, what is the value of b?','2','3','0','1',0)
 ,( 11,'What are the factors of x^2 - 5x + 6?','(x - 2) and (x - 3)','(x + 6) and (x - 1)','(x - 6) and (x + 1)','(x + 2) and (x + 3)',0)
 ,( 11,'The length of a side of a square window in Jessica’s bedroom is represented by 2x – 1. Which expression represents the area of the window?','4x^2 - 4x + 1','4x^2 + 4x + 1','4x^2 + 1','2x^2 + 1',0)
 ,( 11,'Andy has grades of  84, 65, and 76 on three math tests.  What grade must he obtain on the next test to have an average of exactly 80 for the four tests?','95','85','90','70',0)
 ,( 11,'The baby T-Rex at the museum weighs 851 pounds, to the nearest pound.  Which weight listed cannot be the actual weight of the baby T-Rex?','851.6 lb','851.0 lb','850.6 lb','851.4 lb',0)
 ,( 11,'What is the equation of the axis of symmetry  of the graph  y = 3x^2 + 12x - 2 ?','x = -2','x = 2','y = -2','y = 2',0)
 ,( 11,'For what values is (x + 1)/(x^2 - 5x - 14) undefined?','{-2, 7}','{2, 7}','{-2, -7}','{2, -7}',0)
 ,( 11,'If 18x^2y + 12x^2y^2 - 6xy^2 is divided by 6xy, the quotient is  ','3x + 2xy - y','2x + 2xy - y','3x + 2y - 1','3xy + 2x^2y - y^2',0)
 ,( 11,'Evaluate (10 - 3)^2 + 20 ÷ 4 ','54','69/4','6','-29/4',0)
 ,( 11,'Evaluate (3a)^2 – 2b when a = 2 and b = 4 ','28','4','12','22',0)
 ,( 11,'Solve for x: 5x + 12 = -3x + 60','6','-4','-6','8',0)
 ,( 11,'Solve for x: 68 = 100 – 4x ','8','-8','42','-42',0)
 ,( 11,'Solve for x: 2(4x + 12) + 4x = -12','-2','-3','-1','1',0)
 ,( 11,'Solve for x: ¾ x – 6 = 6','16','-16','12','4',0)
 ,( 11,'Which of the following means “a number less than 8”?','n < 8','8 < n','n – 8','8 - n',0)
 ,( 11,'If a and b are both odd integers, which of the following MUST also be an odd integer?','a•b','a/b','a - b','a + b',0)
 ,( 11,'The expression (3c - 3d) - (c - 3d) when simplified is','2c','2c - 6d','4c - 6d','4c',0)
 ,( 11,'If the square root of x is greater than x, then x could be','1/2','2','4','0',0)
 ,( 11,'If  3x^2 - 7y + 6 is subtracted from 4x^2 - 3y + 4, the result is','x^2 + 4y - 2','-x^2 - 4y + 2','x^2 - 10y - 2','7x^2 - 10y + 10',0)
 ,( 11,'1/(x + 1) + 1/x, where x is not equal to 0, -1 simplifies to','(2x + 1) / (x^2 + x)','2 / (2x + 1)','3 / x^2','(2x + 3) / (x^2 + x)',0)
 ,( 11,'If n - 5 is an even integer, what is the next larger consecutive even integer','n - 3','n - 4','n + 2','n - 7',0)
 ,( 11,'Find the sum of  3x^2 + x + 8  and  x^2 - 9.','4x^2 + x - 1','4x^2 + x - 17','4x^4 + x - 1','3x^4 + x - 1',0)
 ,( 11,'The expression (4a + 2b) - (2a - 3b) - (a - b) when simplified is','a + 6b','-2b','6b','6a + 6b',0)
 ,( 11,'The Pentagon building in Washington, D.C., is shaped like a regular pentagon. If the length of one side of the Pentagon is represented by n + 2, its perimeter would be represented by','5n + 10','5n + 2','n + 10','10n',0)
 ,( 11,'The expression (5x + 6y) - (7x - 2y) + (x - 2y) when simplified is','-x + 6y','x + 6y','13x - 2y','13x + 10y',0)
 ,( 11,'Which expression represents "eight less than the product of five and a number"?','5n - 8','8 - (5 + n)','8 - 5 + n','8 - 5n',0)
 ,( 11,'Find the missing terms:  (x^2 + 8x + __) - (___+ 7x + 4)  = -3x^2 + x + 11    ','15; 4x2','15; -2x2','-15; -2x2','5; 4x2',0)
 ,( 11,'(x + 4)^2 =','x^2 + 8x + 16','x^2 + 4x + 8','x^2 + 4x + 16','x^2 + 16',0)
 ,( 11,'(x + 1)(x^2 + 2x +1) =','x^3 + 3x^2 + 3x + 1','x^3 + 3x^2 + x + 1','x^2 + 2x + 2','x^3 + 2x^2 +x + 1',0)
 ,( 11,'The side of a cube is represented by 2x - 1.  Find, in terms of x, the volume of the cube.','8x^3 - 12x^2 + 6x - 1','4x^2 - 4x + 1','8x^3 - 12x^2 - 6x - 1','8x^3 - 1',0)
 ,( 11,'(x^2 - 25)/(x - 5) = ','x + 5','5x','x - 5','5',0)
 ,( 11,'For what value of x is this expression undefined? 3xyz/(2x - 4)','2','0','4','-2',0)
 ,( 11,'(d^2 + 4d -32) / (d - 4) = ','d + 8','d - 8','d + 9','4d - 8',0)
 ,( 11,'Solve for x:[(5x + 1)/2] + [(x - 2)/3] = [(8x + 8)/6]','1','2','-1','-2',0)
 ,( 11,'Factor:  25x^6 - 121y^4','(5x^3 - 11y^2)(5x^3 + 11y^2)','55(x^3 - y^2)(x3 + y^2)','(5x^3 - 11y^2)(5x3 - 11y^2)','(5x^3 + 11y^2)(5x3 + 11y^2)',0)
 ,( 11,'When 20 is subtracted from -4, the result is','-24','-16','16','24',0)
 ,( 11,'(x + y) + z = x + ( y + z) is an example of the _____ property of addition.','associative','identify','distributive','commutative',0)
 ,( 11,'The value of  -3^2  is','9','3','-9','-3',0)
 ,( 11,'Given:  a $ b =  | a - b |. What is the value of  6 $ 8','-2','2','14','No Answer',0)
 ,( 11,'Linda paid $38 for a jacket that was on sale for 25% of the original price.  What was the original price of the jacket?','$152','$96','$72','$60',0)
 ,( 11,'The expression sqrt(27) + sqrt(12) is equivalent to','5sqrt(3)','13sqrt(3)','5sqrt(6)','sqrt(39)',0)
 ,( 11,'In a hockey league, 87 players play on seven different teams. Each team has at least 12 players. What is the largest possible number of players on any one team?','15','21','14','13',0)
 ,( 11,'14sqrt(150)/7sqrt(2)','10sqrt(3)','sqrt(150)','10sqrt(2)','7sqrt(3)',0)
 ,( 11,'The number 0.06022 expressed in scientific notation is','6.022 x 10e-2','0.6022 x 10e-1','60.22 x 10e-3','6022 x 10e-5',0)
 ,( 11,'Solve for x: 5/15 = x/(x + 8)','4','5','7','3',0)
 ,( 11,'The resistance (R) of a copper wire, varies directly as its length (L).  Write this relation as a formula using k as the constant of variation.','R = kL','R = k/L','L = k/R','L = kR',0)
 ,( 11,'(3x^3)^3 is equivalent to','27x^9','27x^6','9x^9','9x^6',0)
 ,( 11,'If x = -3 and y = 7. find the value of x^2y^3','3087','-343','343','-3087',0)
 ,( 11,'Daniel''s Print Shop purchased a new printer for $35,0)00.  Each year it depreciates (loses value) at a rate of 5%.  What will its approximate value be at the end of the fourth year?','$28,507.72','$27,0)82.33','$30,0)08.13','$33,250.00',0)
 ,( 11,'Simplify:  |(8 - 4)| + |-3|','7','9','15','1',0)
 ,( 11,'There are about 200 calories in 50 grams of Swiss cheese.  Willie ate 70 grams of this cheese.  About how many calories were in the cheese that he ate if the number of calories varies directly as the weight of the cheese.','280','290','240','210',0)
 ,( 11,'(sqrt(7) - 3)^2 is equivalent to','16 - 6sqrt(7)','9 - 6sqrt(7)','7 - 6sqrt(7)','-2 - 6sqrt(7)',0)
 ,( 11,'The expression (2x^4)*(3x^3) is equivalent to','6x^7','6x^12','5x^12','5x^7',0)
 ,( 11,'The value of (9 - 4)! is','120','60','20','5',0)
 ,( 11,'What is the quotient of 8.05*10^6 and 3.5*10^6?','2.3*10^4','2.3*10^3','2.3*10^5','2.3*10^12',0)
 ,( 11,'Which statement is not true for the set of integers?','The set of integers is closed under division.','The set of integers is closed under multiplication.','Every integer has an additive inverse.','Every integer has an multiplicative identity.',0)
 ,( 13,'What is the smallest angiosperm among the following?','Wolffia','Nepenthes','Adansonia','Pistia and eichornia',0)
 ,( 13,'Who is the father of Indian botany?','Parasara','Susrutha','Aristotle','Charaka',0)
 ,( 13,'Which among the following is an algae with air bladders?','Fucus','Ginkgo','Lemma','Pinus',0)
 ,( 13,'Which among the following has largest seed?','Cycas','Cedrus','Lemna','Pinus',0)
 ,( 13,'Who coined the term genetics?','Bateson','Mendel','Theophrastus','Heackel',0)
 ,( 13,'Term botany is derived from?','Greek','Urdu','Telugu','Latin',0)
 ,( 13,'Which is know as cord moss?','Funaria','Spirogyra','Pteris vittata','Ginkgo',0)
 ,( 13,'Which among the following is colonial?','Volvox','Sargassum','Chlamydomonas','Laminaria',0)
 ,( 13,'Number of chromosomes in endosperm of onion?','24','30','42','111',0)
 ,( 13,'What is the chemical basis of heredity?','DNA','Nucleosome','Chromatin','Chromosome',0)
 ,( 15,'What is SJSU?','San Jose State University', 'San Jose Suncor Energy', 'San Jose Shenandoah University', 'San Jose Syracuse University',0)
 ;
 -- Insert Question with media
 INSERT INTO QUESTION
           (TOPIC_ID
           ,DESCRIPTION
           ,ANSWER_C
           ,ANSWER_W1
           ,ANSWER_W2
           ,ANSWER_W3
           ,RANKING
		   ,MULTIMEDIA_ID)
VALUES
 ( 15,'This flag belongs to which one of the following countries?','China','India','Canada','Australia',0,1)
 ,( 15,'Where is the quarter?','Under the right cup','Under the middle cup','Under the left cup','Under the table',0,2)
 ,( 15,'Who sings this song?','Taylor Swift','Dianna Agron','Kelleigh Bannen','Jeanne Black',0,3)
;