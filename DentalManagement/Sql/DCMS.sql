USE [master]
GO
/****** Object:  Database [DCMS]    Script Date: 2020-02-26 21:08:26 ******/
CREATE DATABASE [DCMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DCMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DCMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DCMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DCMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DCMS] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DCMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DCMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DCMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DCMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DCMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DCMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [DCMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DCMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DCMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DCMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DCMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DCMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DCMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DCMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DCMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DCMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DCMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DCMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DCMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DCMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DCMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DCMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DCMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DCMS] SET RECOVERY FULL 
GO
ALTER DATABASE [DCMS] SET  MULTI_USER 
GO
ALTER DATABASE [DCMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DCMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DCMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DCMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DCMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DCMS', N'ON'
GO
ALTER DATABASE [DCMS] SET QUERY_STORE = OFF
GO
USE [DCMS]
GO
/****** Object:  Table [dbo].[tblPatientProcedure]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPatientProcedure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tooth] [int] NULL,
	[Description] [varchar](max) NULL,
	[Surface] [varchar](max) NULL,
	[Status] [varchar](100) NULL,
	[Dentist] [varchar](100) NULL,
	[CreatedOn] [date] NULL,
	[Amount] [decimal](18, 0) NULL,
	[Action] [varchar](100) NULL,
	[PatientId] [int] NULL,
 CONSTRAINT [PK_tblPatientProcedure] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPatients]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPatients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Surname] [varchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[Email] [varchar](100) NULL,
	[ContactNo] [int] NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_tblPatients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProcedures]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProcedures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Name] [varchar](100) NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_tblProcedures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Get_PatientDetails]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[Get_PatientDetails]
@PatientId int
as 
begin
SELECT [Id]
      ,[FirstName]
      ,[LastName]
      ,[Surname]
      ,[DateOfBirth]
      ,[Email]
      ,[ContactNo]
      ,[Status]
  FROM [dbo].[tblPatients] where Id=@PatientId
end


GO
/****** Object:  StoredProcedure [dbo].[Get_Patients]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[Get_Patients]
as 
begin
SELECT [Id]
      ,[FirstName]
      ,[LastName]
      ,[Surname]
      ,[DateOfBirth]
      ,[Email]
      ,[ContactNo]
      ,[Status]
  FROM [DCMS].[dbo].[tblPatients]
  end
GO
/****** Object:  StoredProcedure [dbo].[Get_Treatments]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_Treatments]
As
begin	
SELECT pp.[Id]
      ,pp.[Tooth]
      ,pp.[Description]
      ,pp.[Surface]
      ,pp.[Status]
      ,pp.[Dentist]
      ,pp.[CreatedOn]
      ,pp.[Amount]
      ,pp.[Action]
     ,(p.FirstName +' '+ p.Surname) as PatientName
  FROM [dbo].[tblPatientProcedure] pp
  inner join tblPatients p on p.Id=pp.PatientId
End


GO
/****** Object:  StoredProcedure [dbo].[Save_PatientProcedure]    Script Date: 2020-02-26 21:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[Save_PatientProcedure]
@Tooth int,
@Description varchar(max),
@Surface varchar(max),
@Status varchar(100),
@Dentist varchar(100),
@CreatedOn date,
@Amount decimal(18,0),
@Action varchar(100),
@PatientId int
As
begin

INSERT INTO [dbo].[tblPatientProcedure]
           ([Tooth]
           ,[Description]
           ,[Surface]
           ,[Status]
           ,[Dentist]
           ,[CreatedOn]
           ,[Amount]
           ,[Action]
           ,[PatientId])
     VALUES
           (@Tooth
           ,@Description
           ,@Surface
           ,@Status
           ,@Dentist
           ,@CreatedOn
           ,@Amount
           ,@Action
           ,@PatientId)
end


GO
USE [master]
GO
ALTER DATABASE [DCMS] SET  READ_WRITE 
GO
