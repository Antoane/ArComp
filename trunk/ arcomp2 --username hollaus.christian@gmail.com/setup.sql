USE [ArComp]
GO

/****** Object:  Table [dbo].[TURNIER]    Script Date: 24.08.2013 08:32:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TURNIER](
	[TU_ID] [varchar](36) NULL,
	[TA_ID] [varchar](36) NULL,
	[TU_NAME] [varchar](100) NULL,
	[TU_BEGINN] [datetime] NULL,
	[TU_ENDE] [datetime] NULL,
	[TU_VERANSTALTER] [varchar](100) NULL,
	[TU_TURNIERLEITUNG] [varchar](100) NULL,
	[TU_SCHIEDSRICHTER] [varchar](100) NULL
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[TURNIER_ZUTEILUNG]    Script Date: 24.08.2013 08:33:07 ******/


CREATE TABLE [dbo].[TURNIER_ZUTEILUNG](
	[TZ_ID] [varchar](36) NULL,
	[TU_ID] [varchar](36) NULL,
	[PE_ID] [varchar](36) NULL
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[TURNIERART]    Script Date: 24.08.2013 08:33:15 ******/
SET ANSI_NULLS ON
GO


CREATE TABLE [dbo].[TURNIERART](
	[TA_ID] [varchar](36) NULL,
	[TA_NAME] [varchar](100) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[VEREIN]    Script Date: 24.08.2013 08:33:24 ******/

CREATE TABLE [dbo].[VEREIN](
	[VE_ID] [varchar](36) NULL,
	[VE_NAME] [varchar](100) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[PERSON]    Script Date: 24.08.2013 08:32:51 ******/

CREATE TABLE [dbo].[PERSON](
	[PE_ID] [varchar](36) NOT NULL,
	[PE_VORNAME] [varchar](50) NULL,
	[PE_NACHNAME] [varchar](50) NULL,
	[PE_NATION] [varchar](50) NULL,
	[PE_BUNDESLAND] [varchar](50) NULL,
	[PE_BOGENKATEGORIE] [varchar](50) NULL,
	[PE_ALTERSKLASSE] [varchar](50) NULL,
	[PE_GEBURTSDATUM] [datetime] NULL,
	[PE_GESCHLECHT] [varchar](50) NULL,
	[PE_LIZENZ] [int] NULL,
	[PE_LANDESWERTUNG] [int] NULL,
	[VE_ID] [varchar](36) NULL,
PRIMARY KEY CLUSTERED 
(
	[PE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[GESCHLECHT]    Script Date: 24.08.2013 08:32:40 ******/

CREATE TABLE [dbo].[GESCHLECHT](
	[GE_ID] [varchar](36) NULL,
	[GE_NAME] [varchar](50) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[DISTANZ]    Script Date: 24.08.2013 08:32:33 ******/

CREATE TABLE [dbo].[DISTANZ](
	[DI_ID] [varchar](36) NULL,
	[TA_ID] [varchar](36) NULL,
	[BK_ID] [varchar](36) NULL,
	[AK_ID] [varchar](36) NULL,
	[GE_ID] [varchar](36) NULL,
	[DI_RUNDE] [int] NULL,
	[DI_DISTANZ] [decimal](18, 2) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[BOGENKATEGORIE]    Script Date: 24.08.2013 08:32:21 ******/

CREATE TABLE [dbo].[BOGENKATEGORIE](
	[BK_ID] [varchar](36) NULL,
	[BK_NAME] [varchar](36) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[ALTERSKATEGORIE]    Script Date: 24.08.2013 08:32:12 ******/

CREATE TABLE [dbo].[ALTERSKATEGORIE](
	[AK_ID] [varchar](36) NULL,
	[AK_NAME] [varchar](36) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE TURNIER
ADD TU_SCHEIBENANZAHL integer

ALTER TABLE TURNIER
ADD TU_PERSONEN_PRO_SCHEIBE integer


CREATE TABLE SCHEIBENEINTEILUNG(
  SE_ID varchar(36),
  TU_ID varchar(36),
  PE_ID varchar(36),
  SE_NUMMER integer,
  SE_PLATZ varchar(10)
)

CREATE TABLE FINALBERECHTIGUNG(
  FB_ID varchar(36),
  TA_ID varchar(36),
  AK_ID varchar(36),
  BK_ID varchar(36),
  GE_ID varchar(36),
  FB_FINALBERECHTIGT integer
)

CREATE TABLE SCORES(
  SC_ID varchar(36),
  TU_ID varchar(36),
  PE_ID varchar(36),
  SC_RUNDE varchar(36),
  SC_SCORE integer,
  SC_ZEHNER integer,
  SC_NEUNER integer,
  SC_X integer
)

