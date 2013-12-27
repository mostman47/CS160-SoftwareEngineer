CS160-SoftwareEngineer
======================

Authors: Nam Phan and Team SQ06
Read instruction for testing

=========INSTRUCTION=============

System, Applications, & Source Code
________________________________________
•	Win 7 64 bit
•	Netbeans 7.4
•	Glassfish Server 4.0
•	MySql server 5.6
•	MySql Workbench 6.0
•	SiquoiaJavaWeb-master.zip OR https://github.com/mostman47/CS160-SoftwareEngineer



Database
________________________________________
Tools
•	MySql server 5.6
•	MySql Workbench 6.0
•	AllQuery.sql (in \SiquoiaJavaWeb-master\MySql Sql\)
Download & Installation
•	Link: http://dev.mysql.com/downloads/mysql/
•	Choose: Windows (x86, 64-bit), MySQL Installer MSI)
•	Continue to choose: Windows (x86, 32-bit), MSI Installer (mysql-installer-web-community-5.6.15.0.msi)
•	Choose: login >> using my Oracle Web Account
•	Log in, download now
•	Get mysql-installer-web-community-5.6.15.0.msi
•	Run it to install MySQL installer
•	Run MySQL installer
•	Choose MySql server 5.6, MySql Workbench 6.0, and Connector JDBC to install
•	If don’t have Oracle support account, please install one per time
•	When installing MySql server 5.6, remember to set password for root user that meomap
Setup
•	Open MySql Workbench 6.0
•	Choose new connection, connect to localhost by user root and password meomap
•	Open and run AllQuery.sql
•	It should automatically create table and insert data


Application
________________________________________
Tools
•	Netbeans IDE 7.4
•	Glassfish Server 4.0
•	SiquoiaWebGame folder (in \SiquoiaJavaWeb-master\)
•	mysql-connector-java-5.1.23-bin.jar (in \SiquoiaJavaWeb-master\SiquoiaWebGame\)
Download & Installation
•	Link: https://netbeans.org/downloads/
•	Choose the version with all supports (204 MB)
•	Get netbeans-7.4-windows.exe
•	Run it to install, it should also install the Glassfish Server 4.0
Setup
•	Copy and past the mysql-connector-java-5.1.23-bin.jar to the glassfish directory: C:\Program Files\glassfish-4.0\glassfish\lib
•	Open netbeans 7.4
•	Open the SiquoiaWebGame folder as a project
•	Check the library, if it does not have MySQL JDBC driver, add mysql-connector-java-5.1.23-bin.jar into the project
•	Check Services tab, if do not see Glassfish server in Servers, choose add Server with directory: C:\Program Files\glassfish-4.0\
Test
________________________________________
In Netbeans project, run Web Pages/index.jsp to test

