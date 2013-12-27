
USE [Sequoia]
/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     10/31/2013 12:24:14 AM                       */
/*==============================================================*/


alter table QUESTION
   drop constraint FK_QUESTION_RELATIONS_TOPIC
go

alter table TOKEN
   drop constraint FK_TOKEN_RELATIONS_USER
go

alter table TOKEN
   drop constraint FK_TOKEN_RELATIONS_TOPIC
go

alter table TOPIC
   drop constraint FK_TOPIC_RELATIONS_TOPIC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('QUESTION')
            and   name  = 'TOPIC_FK'
            and   indid > 0
            and   indid < 255)
   drop index QUESTION.TOPIC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('QUESTION')
            and   type = 'U')
   drop table QUESTION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOKEN')
            and   name  = 'TOPIC_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOKEN.TOPIC_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOKEN')
            and   name  = 'USER_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOKEN.USER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOKEN')
            and   type = 'U')
   drop table TOKEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOPIC')
            and   name  = 'PARENT_TOPIC_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOPIC.PARENT_TOPIC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOPIC')
            and   type = 'U')
   drop table TOPIC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

/*==============================================================*/
/* Table: QUESTION                                              */
/*==============================================================*/
create table QUESTION (
   QUESTION_ID          numeric              identity,
   TOPIC_ID             numeric              null,
   QUESTION_DESCRIPTION varchar(500)         null,
   CORRECT_ANSWER       varchar(300)         null,
   ANSWER_1             varchar(300)         null,
   ANSWER_2             varchar(300)         null,
   ANSWER_3             varchar(300)         null,
   RANKING              int                  null,
   constraint PK_QUESTION primary key nonclustered (QUESTION_ID)
)
go

/*==============================================================*/
/* Index: TOPIC_FK                                              */
/*==============================================================*/
create index TOPIC_FK on QUESTION (
TOPIC_ID ASC
)
go

/*==============================================================*/
/* Table: TOKEN                                                 */
/*==============================================================*/
create table TOKEN (
   TOKEN_ID             numeric              identity,
   TOPIC_ID             numeric              null,
   USER_ID              numeric              null,
   CODE                 varchar(20)          null,
   constraint PK_TOKEN primary key nonclustered (TOKEN_ID)
)
go

/*==============================================================*/
/* Index: USER_FK                                               */
/*==============================================================*/
create index USER_FK on TOKEN (
USER_ID ASC
)
go

/*==============================================================*/
/* Index: TOPIC_FK                                              */
/*==============================================================*/
create index TOPIC_FK on TOKEN (
TOPIC_ID ASC
)
go

/*==============================================================*/
/* Table: TOPIC                                                 */
/*==============================================================*/
create table TOPIC (
   TOPIC_ID             numeric              identity,
   PARENT_TOPIC_ID      numeric              null,
   TOPIC_DESCRIPTION    varchar(100)         null,
   LEVEL                int                  null,
   constraint PK_TOPIC primary key nonclustered (TOPIC_ID)
)
go

/*==============================================================*/
/* Index: PARENT_TOPIC_FK                                       */
/*==============================================================*/
create index PARENT_TOPIC_FK on TOPIC (
PARENT_TOPIC_ID ASC
)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   USER_ID              numeric              identity,
   USERNAME             varchar(20)          null,
   PASSWORD             varchar(20)          null,
   STATUS               varchar(50)          null
      constraint CKC_STATUS_USER check (STATUS is null or (STATUS in ('admin','user1','user2'))),
   constraint PK_USER primary key nonclustered (USER_ID)
)
go

alter table QUESTION
   add constraint FK_QUESTION_RELATIONS_TOPIC foreign key (TOPIC_ID)
      references TOPIC (TOPIC_ID)
go

alter table TOKEN
   add constraint FK_TOKEN_RELATIONS_USER foreign key (USER_ID)
      references "USER" (USER_ID)
go

alter table TOKEN
   add constraint FK_TOKEN_RELATIONS_TOPIC foreign key (TOPIC_ID)
      references TOPIC (TOPIC_ID)
go

alter table TOPIC
   add constraint FK_TOPIC_RELATIONS_TOPIC foreign key (PARENT_TOPIC_ID)
      references TOPIC (TOPIC_ID)
go

