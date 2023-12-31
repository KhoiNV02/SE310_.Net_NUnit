USE [master]
GO
/****** Object:  Database [QLTV]    Script Date: 11/6/2023 6:37:52 PM ******/
CREATE DATABASE [QLTV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLTV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLTV.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLTV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLTV_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QLTV] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLTV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLTV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLTV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLTV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLTV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLTV] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLTV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLTV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLTV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLTV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLTV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLTV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLTV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLTV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLTV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLTV] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLTV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLTV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLTV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLTV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLTV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLTV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLTV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLTV] SET RECOVERY FULL 
GO
ALTER DATABASE [QLTV] SET  MULTI_USER 
GO
ALTER DATABASE [QLTV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLTV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLTV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLTV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLTV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLTV] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLTV', N'ON'
GO
ALTER DATABASE [QLTV] SET QUERY_STORE = ON
GO
ALTER DATABASE [QLTV] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QLTV]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_CS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	-----------------
CREATE FUNCTION [dbo].[AUTO_CS]()--
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MaCuonSach) FROM CuonSACH) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaCuonSach, 3)) FROM CuonSach--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MCS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MCS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDDG]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------
CREATE FUNCTION [dbo].[AUTO_IDDG]()
RETURNS VARCHAR(5)--
AS
BEGIN
	DECLARE @ID VARCHAR(5)--
	IF (SELECT COUNT(MaDocGia) FROM DOCGIA) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaDocGia, 3)) FROM DocGia--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DG00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'DG0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDLDG]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
----------------
CREATE FUNCTION [dbo].[AUTO_IDLDG]()--
RETURNS VARCHAR(7)--
AS
BEGIN
	DECLARE @ID VARCHAR(7)--
	IF (SELECT COUNT(MaLoaiDocGia) FROM LOAIDOCGIA) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaLoaiDocGia, 3)) FROM LOAIDOCGIA--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MLDG00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MLDG0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------
CREATE FUNCTION [dbo].[AUTO_IDS]()--
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MaSach) FROM SACH) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaSach, 3)) FROM Sach--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MBCMS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MBCMS]()--
RETURNS VARCHAR(8)
AS
BEGIN
	DECLARE @ID VARCHAR(8)
	IF (SELECT COUNT(MaBaoCaoMuonSach) FROM BAOCAOMUONSACH) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaBaoCaoMuonSach, 3)) FROM BAOCAOMUONSACH--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MBCMS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MBCMS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MCTBCMS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MCTBCMS]()--
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(MaCTBCMS) FROM CTBCMS) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaCTBCMS, 3)) FROM CTBCMS--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MCTBCMS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MCTBCMS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MCTPM]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MCTPM]()--
RETURNS VARCHAR(8)
AS
BEGIN
	DECLARE @ID VARCHAR(8)
	IF (SELECT COUNT(MaChiTietPhieuMuon) FROM CTPHIEUMUON) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaChiTietPhieuMuon, 3)) FROM CTPHIEUMUON--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MCTPM00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MCTPM0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MCTPN]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MCTPN]()--
RETURNS VARCHAR(8)
AS
BEGIN
	DECLARE @ID VARCHAR(8)
	IF (SELECT COUNT(MaCTPN) FROM CT_PHIEUNHAP) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaCTPN, 3)) FROM CT_PHIEUNHAP--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MCTPN00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MCTPN0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MCTPTS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MCTPTS]()--
RETURNS VARCHAR(8)
AS
BEGIN
	DECLARE @ID VARCHAR(8)
	IF (SELECT COUNT(MaChiTietPhieuTra) FROM CTPT) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaChiTietPhieuTra, 3)) FROM CTPT--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MCTPT00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MCTPT0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MDS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MDS]()--
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MaDauSach) FROM DAUSACH) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaDauSach, 3)) FROM DAUSACH--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MDS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MDS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MPMS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MPMS]()--
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @ID VARCHAR(7)
	IF (SELECT COUNT(MaPhieuMuonSach) FROM PHIEUMUON) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaPhieuMuonSach, 3)) FROM PHIEUMUON--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MPMS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MPMS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MPNS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MPNS]()--
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @ID VARCHAR(7)
	IF (SELECT COUNT(MaPhieuNhapSach) FROM PHIEUNHAPSACH) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaPhieuNhapSach, 3)) FROM PHIEUNHAPSACH--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MPNS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MPNS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MPT]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE FUNCTION [dbo].[AUTO_MCTPN]()--
--RETURNS VARCHAR(8)
--AS
--BEGIN
--	DECLARE @ID VARCHAR(8)
--	IF (SELECT COUNT(MaCTPN) FROM CT_PHIEUNHAP) = 0--
--		SET @ID = '0'
--	ELSE
--		SELECT @ID = MAX(RIGHT(MaCTPN, 3)) FROM CT_PHIEUNHAP--
--		SELECT @ID = CASE
--			WHEN @ID >= 0 and @ID < 9 THEN 'MCTPN00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
--			WHEN @ID >= 9 THEN 'MCTPN0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
--		END
--	RETURN @ID
--END
--go
--CREATE TABLE CT_PHIEUNHAP(
--	MaCTPN Varchar(50) primary key default ([dbo].[AUTO_MCTPN]()),
--	MaPhieuNhapSach Varchar(50) not null,
--	MaSach Varchar(50) not null,
--	SoLuong int not null,
--	DonGia money not null,
--	)
--	alter table CT_PHIEUNHAP
--add ThanhTien as (DonGia*SoLuong) 
--GO
CREATE FUNCTION [dbo].[AUTO_MPT]()--
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MaPhieuThu) FROM PHIEUTHUTIEN) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaPhieuThu, 3)) FROM PHIEUTHUTIEN--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MPT00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MPT0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MPTS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MPTS]()--
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @ID VARCHAR(7)
	IF (SELECT COUNT(MaPhieuTraSach) FROM PHIEUTraSach) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaPhieuTraSach, 3)) FROM PhieuTraSach--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MPTS00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MPTS0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MTG]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MTG]()--
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MaTacGia) FROM TACGIA) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaTacGia, 3)) FROM TacGia--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MTG00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MTG0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MTL]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MTL]()--
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MaTheLoai) FROM TheLOAI) = 0--
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MaTheLoai, 3)) FROM TheLoai--
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'MTL00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
			WHEN @ID >= 9 THEN 'MTL0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)--
		END
	RETURN @ID
END
GO
/****** Object:  Table [dbo].[BAOCAOMUONSACH]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAOCAOMUONSACH](
	[MaBaoCaoMuonSach] [varchar](50) NOT NULL,
	[ThangNam] [date] NOT NULL,
	[TongSoLuotMuon] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBaoCaoMuonSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BCTRATRE]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BCTRATRE](
	[NgayThangNam] [date] NOT NULL,
	[MaCuonSach] [varchar](50) NOT NULL,
	[MaPhieuMuonSach] [varchar](50) NOT NULL,
	[SoNgayTraTre] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NgayThangNam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_PHIEUNHAP]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_PHIEUNHAP](
	[MaCTPN] [varchar](50) NOT NULL,
	[MaPhieuNhapSach] [varchar](50) NOT NULL,
	[MaSach] [varchar](50) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [money] NOT NULL,
	[ThanhTien]  AS ([DonGia]*[SoLuong]),
PRIMARY KEY CLUSTERED 
(
	[MaCTPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTBCMS]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTBCMS](
	[MaCTBCMS] [varchar](50) NOT NULL,
	[MaBaoCaoMuonSach] [varchar](50) NOT NULL,
	[MaTheLoai] [varchar](50) NOT NULL,
	[SoLuotMuon] [int] NOT NULL,
	[TiLe] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCTBCMS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTPHIEUMUON]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPHIEUMUON](
	[MaChiTietPhieuMuon] [varchar](50) NOT NULL,
	[MaPhieuMuonSach] [varchar](50) NOT NULL,
	[MaCuonSach] [varchar](50) NOT NULL,
	[TinhTrangPM] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietPhieuMuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTPT]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPT](
	[MaChiTietPhieuTra] [varchar](50) NOT NULL,
	[MaPhieuTraSach] [varchar](50) NOT NULL,
	[MaCuonSach] [varchar](50) NOT NULL,
	[MaPhieuMuonSach] [varchar](50) NOT NULL,
	[SoNgayMuon] [int] NOT NULL,
	[TienPhat] [money] NOT NULL,
	[SoNgayTraTre] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietPhieuTra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTTACGIA]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTTACGIA](
	[MaDauSach] [varchar](50) NOT NULL,
	[MaTacGia] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDauSach] ASC,
	[MaTacGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUONSACH]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUONSACH](
	[MaCuonSach] [varchar](50) NOT NULL,
	[MaSach] [varchar](50) NOT NULL,
	[TinhTrang] [bit] NOT NULL,
	[MaCTPN] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCuonSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DAUSACH]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DAUSACH](
	[MaDauSach] [varchar](50) NOT NULL,
	[TenDauSach] [nvarchar](100) NOT NULL,
	[MaTheLoai] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDauSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOCGIA]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOCGIA](
	[MaDocGia] [varchar](50) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[MaLoaiDocGia] [varchar](50) NOT NULL,
	[NgSinh] [date] NOT NULL,
	[DChi] [nvarchar](200) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[NgLapThe] [date] NOT NULL,
	[NgHetHan] [date] NULL,
	[TongNo] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDocGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAIDOCGIA]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAIDOCGIA](
	[MaLoaiDocGia] [varchar](50) NOT NULL,
	[TenLoaiDocGia] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiDocGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAPN]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAPN](
	[MaPhieuNhap] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUMUON]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUMUON](
	[MaPhieuMuonSach] [varchar](50) NOT NULL,
	[MaDocGia] [varchar](50) NOT NULL,
	[NgMuon] [date] NOT NULL,
	[HanTra] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuMuonSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUNHAPSACH]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUNHAPSACH](
	[MaPhieuNhapSach] [varchar](50) NOT NULL,
	[NgLap] [date] NOT NULL,
	[TongTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuNhapSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUTHUTIEN]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUTHUTIEN](
	[MaPhieuThu] [varchar](50) NOT NULL,
	[MaDocGia] [varchar](50) NOT NULL,
	[NgThu] [date] NOT NULL,
	[SoTienThu] [money] NOT NULL,
	[ConLai] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuThu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUTRASACH]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUTRASACH](
	[MaPhieuTraSach] [varchar](50) NOT NULL,
	[MaDocGia] [varchar](50) NOT NULL,
	[NgTra] [date] NOT NULL,
	[TienPhatKyNay] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuTraSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SACH]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SACH](
	[MaSach] [varchar](50) NOT NULL,
	[MaDauSach] [varchar](50) NOT NULL,
	[NhaXuatBan] [nvarchar](100) NOT NULL,
	[NamXuatBan] [int] NOT NULL,
	[SoLuong] [int] NULL,
	[TriGia] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TACGIA]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TACGIA](
	[MaTacGia] [varchar](50) NOT NULL,
	[TenTacGia] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTacGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THAMSO]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THAMSO](
	[ThoiHanThe] [int] NOT NULL,
	[TuoiToiThieu] [int] NOT NULL,
	[TuoiToiDa] [int] NOT NULL,
	[ThoiGianLuuHanh] [int] NOT NULL,
	[SoNgayMuonMax] [int] NOT NULL,
	[SoSachMuonMax] [int] NOT NULL,
	[MucThuTienPhat] [money] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THELOAI]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THELOAI](
	[MaTheLoai] [varchar](50) NOT NULL,
	[TenTheLoai] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TraCuu]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TraCuu](
	[MaSach] [varchar](50) NULL,
	[TenDauSach] [nvarchar](100) NULL,
	[TenTheLoai] [nvarchar](100) NULL,
	[TenTacGia] [nvarchar](100) NULL,
	[TinhTrang] [varchar](50) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[BAOCAOMUONSACH] ([MaBaoCaoMuonSach], [ThangNam], [TongSoLuotMuon]) VALUES (N'MBCMS001', CAST(N'2022-01-03' AS Date), 1)
INSERT [dbo].[BAOCAOMUONSACH] ([MaBaoCaoMuonSach], [ThangNam], [TongSoLuotMuon]) VALUES (N'MBCMS002', CAST(N'2022-03-03' AS Date), 1)
INSERT [dbo].[BAOCAOMUONSACH] ([MaBaoCaoMuonSach], [ThangNam], [TongSoLuotMuon]) VALUES (N'MBCMS003', CAST(N'2022-04-30' AS Date), 3)
INSERT [dbo].[BAOCAOMUONSACH] ([MaBaoCaoMuonSach], [ThangNam], [TongSoLuotMuon]) VALUES (N'MBCMS004', CAST(N'2022-05-03' AS Date), 5)
GO
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN001', N'MPNS001', N'MS001', 1, 100000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN002', N'MPNS001', N'MS002', 1, 100000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN003', N'MPNS001', N'MS003', 1, 200000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN004', N'MPNS001', N'MS004', 1, 150000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN005', N'MPNS001', N'MS005', 1, 100000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN006', N'MPNS001', N'MS006', 1, 105000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN007', N'MPNS001', N'MS007', 1, 100000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN008', N'MPNS001', N'MS008', 1, 120000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN009', N'MPNS001', N'MS009', 1, 170000.0000)
INSERT [dbo].[CT_PHIEUNHAP] ([MaCTPN], [MaPhieuNhapSach], [MaSach], [SoLuong], [DonGia]) VALUES (N'MCTPN010', N'MPNS001', N'MS010', 1, 150000.0000)
GO
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS001', N'MBCMS001', N'MTL001', 1, 0.1)
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS002', N'MBCMS002', N'MTL002', 1, 0.1)
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS003', N'MBCMS003', N'MTL003', 1, 0.1)
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS004', N'MBCMS003', N'MTL002', 2, 0.2)
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS005', N'MBCMS004', N'MTL001', 2, 0.2)
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS006', N'MBCMS004', N'MTL002', 2, 0.2)
INSERT [dbo].[CTBCMS] ([MaCTBCMS], [MaBaoCaoMuonSach], [MaTheLoai], [SoLuotMuon], [TiLe]) VALUES (N'MCTBCMS007', N'MBCMS004', N'MTL003', 1, 0.1)
GO
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM001', N'MPMS001', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM002', N'MPMS001', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM003', N'MPMS001', N'MCS005', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM004', N'MPMS002', N'MCS001', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM005', N'MPMS002', N'MCS002', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM006', N'MPMS002', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM007', N'MPMS002', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM008', N'MPMS003', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM009', N'MPMS003', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM010', N'MPMS003', N'MCS005', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM011', N'MPMS003', N'MCS006', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM012', N'MPMS004', N'MCS001', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM013', N'MPMS004', N'MCS002', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM014', N'MPMS004', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM015', N'MPMS004', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM016', N'MPMS004', N'MCS006', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM017', N'MPMS004', N'MCS008', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM018', N'MPMS005', N'MCS002', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM019', N'MPMS005', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM020', N'MPMS005', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM021', N'MPMS005', N'MCS006', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM022', N'MPMS005', N'MCS007', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM023', N'MPMS005', N'MCS009', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM024', N'MPMS006', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM025', N'MPMS006', N'MCS006', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM026', N'MPMS006', N'MCS007', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM027', N'MPMS006', N'MCS008', 0)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM028', N'MPMS006', N'MCS009', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM029', N'MPMS006', N'MCS010', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM030', N'MPMS007', N'MCS001', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM031', N'MPMS007', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM032', N'MPMS007', N'MCS006', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM033', N'MPMS008', N'MCS009', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM034', N'MPMS008', N'MCS010', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM035', N'MPMS009', N'MCS002', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM036', N'MPMS009', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM037', N'MPMS009', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM038', N'MPMS009', N'MCS006', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM039', N'MPMS009', N'MCS007', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM040', N'MPMS010', N'MCS001', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM041', N'MPMS010', N'MCS002', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM042', N'MPMS010', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM043', N'MPMS011', N'MCS003', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM044', N'MPMS011', N'MCS004', 1)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM045', N'MPMS011', N'MCS005', 0)
INSERT [dbo].[CTPHIEUMUON] ([MaChiTietPhieuMuon], [MaPhieuMuonSach], [MaCuonSach], [TinhTrangPM]) VALUES (N'MCTPM046', N'MPMS012', N'MCS004', 0)
GO
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT014', N'MPTS013', N'MCS002', N'MPMS005', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT015', N'MPTS013', N'MCS003', N'MPMS005', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT016', N'MPTS013', N'MCS004', N'MPMS005', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT017', N'MPTS013', N'MCS006', N'MPMS005', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT018', N'MPTS013', N'MCS007', N'MPMS005', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT019', N'MPTS013', N'MCS008', N'MPMS004', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT020', N'MPTS013', N'MCS009', N'MPMS005', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT026', N'MPTS017', N'MCS003', N'MPMS007', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT027', N'MPTS017', N'MCS010', N'MPMS008', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT028', N'MPTS018', N'MCS001', N'MPMS007', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT029', N'MPTS018', N'MCS006', N'MPMS007', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT030', N'MPTS019', N'MCS002', N'MPMS009', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT031', N'MPTS019', N'MCS003', N'MPMS009', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT032', N'MPTS019', N'MCS004', N'MPMS009', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT033', N'MPTS019', N'MCS006', N'MPMS009', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT034', N'MPTS019', N'MCS007', N'MPMS009', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT045', N'MPTS025', N'MCS009', N'MPMS008', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT046', N'MPTS026', N'MCS003', N'MPMS011', 0, 0.0000, 0)
INSERT [dbo].[CTPT] ([MaChiTietPhieuTra], [MaPhieuTraSach], [MaCuonSach], [MaPhieuMuonSach], [SoNgayMuon], [TienPhat], [SoNgayTraTre]) VALUES (N'MCTPT047', N'MPTS026', N'MCS004', N'MPMS011', 0, 0.0000, 0)
GO
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS001', N'MTG002')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS002', N'MTG005')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS003', N'MTG006')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS004', N'MTG003')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS005', N'MTG009')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS006', N'MTG008')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS007', N'MTG004')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS008', N'MTG003')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS009', N'MTG010')
INSERT [dbo].[CTTACGIA] ([MaDauSach], [MaTacGia]) VALUES (N'MDS010', N'MTG007')
GO
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS001', N'MS001', 1, N'MCTPN001')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS002', N'MS002', 1, N'MCTPN002')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS003', N'MS003', 1, N'MCTPN003')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS004', N'MS004', 0, N'MCTPN004')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS005', N'MS005', 0, N'MCTPN005')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS006', N'MS006', 1, N'MCTPN006')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS007', N'MS007', 1, N'MCTPN007')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS008', N'MS008', 0, N'MCTPN008')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS009', N'MS009', 1, N'MCTPN009')
INSERT [dbo].[CUONSACH] ([MaCuonSach], [MaSach], [TinhTrang], [MaCTPN]) VALUES (N'MCS010', N'MS010', 1, N'MCTPN010')
GO
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS001', N'Đắc Nhân Tâm', N'MTL001')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS002', N'Tắt Đèn', N'MTL002')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS003', N'Số Đỏ', N'MTL003')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS004', N'Chí Phèo', N'MTL002')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS005', N'Nhà Giả Kim', N'MTL002')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS006', N'Đời Thay Đổi', N'MTL001')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS007', N'Vợ Nhặt', N'MTL002')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS008', N'Sống Mòn', N'MTL001')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS009', N'Thơ Thơ', N'MTL003')
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (N'MDS010', N'Nhật Ký Trong Tù', N'MTL002')
GO
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG001', N'Nguyễn Phúc Khang', N'MLDG001', CAST(N'2001-05-10' AS Date), N'Hồ Chí Minh', N'NguyenVanA@gmail.com', CAST(N'2022-01-02' AS Date), CAST(N'2022-07-02' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG002', N'Nguyễn Văn Pháp', N'MLDG001', CAST(N'2002-05-22' AS Date), N'Bình Dương', N'NguyenVanB@gmail.com', CAST(N'2022-03-12' AS Date), CAST(N'2022-09-12' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG003', N'Nguyễn Khúc Thùy Tiên', N'MLDG001', CAST(N'2000-02-01' AS Date), N'Thủ Đức', N'NguyenVanC@gmail.com', CAST(N'2022-04-01' AS Date), CAST(N'2022-10-01' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG004', N'Trần Đình Phúc', N'MLDG002', CAST(N'1999-06-23' AS Date), N'Thủ Đức', N'NguyenVanD@gmail.com', CAST(N'2022-04-13' AS Date), CAST(N'2022-10-13' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG005', N'Nguyễn Thị Linh', N'MLDG002', CAST(N'1998-01-02' AS Date), N'Bình Dương', N'NguyenVanE@gmail.com', CAST(N'2022-04-10' AS Date), CAST(N'2022-10-10' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG006', N'Trần Bảo Ngọc', N'MLDG001', CAST(N'2000-01-01' AS Date), N'Hồ Chí Minh', N'NguyenVanF@gmail.com', CAST(N'2023-08-22' AS Date), CAST(N'2024-02-22' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG007', N'Nguyễn Hoàng Linh Chi', N'MLDG002', CAST(N'1997-10-01' AS Date), N'Thủ Đức', N'NguyenVanG@gmail.com', CAST(N'2023-05-17' AS Date), CAST(N'2023-11-17' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG008', N'Trần Dư Gia Bảo', N'MLDG001', CAST(N'2002-01-08' AS Date), N'Thủ Đức', N'NGuyenVanH@gmail.com', CAST(N'2023-08-24' AS Date), CAST(N'2024-02-24' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG009', N'Nguyễn Cát Thiên Di', N'MLDG001', CAST(N'2002-02-20' AS Date), N'Hồ Chí Minh', N'NguyenVanI@gmail.com', CAST(N'2023-05-26' AS Date), CAST(N'2023-11-26' AS Date), 0.0000)
INSERT [dbo].[DOCGIA] ([MaDocGia], [HoTen], [MaLoaiDocGia], [NgSinh], [DChi], [Email], [NgLapThe], [NgHetHan], [TongNo]) VALUES (N'DG010', N'Hoàng Ngọc Bảo Tiên', N'MLDG002', CAST(N'1991-02-01' AS Date), N'Hồ Chí Minh', N'NguyenVanK@gmail.com', CAST(N'2023-08-30' AS Date), CAST(N'2024-02-29' AS Date), 0.0000)
GO
INSERT [dbo].[LOAIDOCGIA] ([MaLoaiDocGia], [TenLoaiDocGia]) VALUES (N'MLDG001', N'Sinh Viên')
INSERT [dbo].[LOAIDOCGIA] ([MaLoaiDocGia], [TenLoaiDocGia]) VALUES (N'MLDG002', N'Giảng Viên')
GO
INSERT [dbo].[MAPN] ([MaPhieuNhap]) VALUES (N'MPNS003')
GO
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS001', N'DG009', CAST(N'2023-11-05' AS Date), CAST(N'2023-11-09' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS002', N'DG007', CAST(N'2023-11-05' AS Date), CAST(N'2023-11-09' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS003', N'DG007', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS004', N'DG008', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS005', N'DG008', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS006', N'DG009', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS007', N'DG008', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS008', N'DG008', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS009', N'DG006', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS010', N'DG006', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS011', N'DG008', CAST(N'2023-11-06' AS Date), CAST(N'2023-11-10' AS Date))
INSERT [dbo].[PHIEUMUON] ([MaPhieuMuonSach], [MaDocGia], [NgMuon], [HanTra]) VALUES (N'MPMS012', N'DG007', CAST(N'2023-05-11' AS Date), CAST(N'2023-09-11' AS Date))
GO
INSERT [dbo].[PHIEUNHAPSACH] ([MaPhieuNhapSach], [NgLap], [TongTien]) VALUES (N'MPNS001', CAST(N'2015-05-01' AS Date), 1295000.0000)
INSERT [dbo].[PHIEUNHAPSACH] ([MaPhieuNhapSach], [NgLap], [TongTien]) VALUES (N'MPNS002', CAST(N'2023-10-22' AS Date), 0.0000)
INSERT [dbo].[PHIEUNHAPSACH] ([MaPhieuNhapSach], [NgLap], [TongTien]) VALUES (N'MPNS003', CAST(N'2015-05-01' AS Date), 0.0000)
GO
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS003', N'DG008', CAST(N'2023-11-05' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS004', N'DG009', CAST(N'2023-11-05' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS013', N'DG008', CAST(N'2023-11-06' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS017', N'DG008', CAST(N'2023-11-06' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS018', N'DG008', CAST(N'2023-11-06' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS019', N'DG006', CAST(N'2023-11-06' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS025', N'DG008', CAST(N'2023-11-06' AS Date), 0.0000)
INSERT [dbo].[PHIEUTRASACH] ([MaPhieuTraSach], [MaDocGia], [NgTra], [TienPhatKyNay]) VALUES (N'MPTS026', N'DG008', CAST(N'2023-11-06' AS Date), 0.0000)
GO
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS001', N'MDS001', N'NXB Trẻ', 2018, 1, 100000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS002', N'MDS002', N'NXB Văn Học', 2019, 1, 100000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS003', N'MDS003', N'NXB Văn Học', 2019, 1, 200000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS004', N'MDS004', N'NXB Văn Học', 2018, 1, 150000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS005', N'MDS005', N'NXB Văn Học', 2019, 1, 100000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS006', N'MDS006', N'NXB Trẻ', 2020, 1, 105000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS007', N'MDS007', N'NXB Văn Học', 2021, 1, 100000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS008', N'MDS008', N'NXB Văn Học', 2020, 1, 120000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS009', N'MDS009', N'NXB Văn Học', 2019, 1, 170000.0000)
INSERT [dbo].[SACH] ([MaSach], [MaDauSach], [NhaXuatBan], [NamXuatBan], [SoLuong], [TriGia]) VALUES (N'MS010', N'MDS010', N'NXB Văn Học', 2020, 1, 150000.0000)
GO
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG001', N'Nguyễn Nhật Ánh')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG002', N'Dale Caregie')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG003', N'Nam Cao')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG004', N'Kim Lân')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG005', N'Ngô Tất Tố')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG006', N'Vũ Trọng Phụng')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG007', N'Hồ Chí Minh')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG008', N'Andrew Matthews')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG009', N'Paulo Coelho')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (N'MTG010', N'Xuân Diệu')
GO
INSERT [dbo].[THAMSO] ([ThoiHanThe], [TuoiToiThieu], [TuoiToiDa], [ThoiGianLuuHanh], [SoNgayMuonMax], [SoSachMuonMax], [MucThuTienPhat]) VALUES (6, 18, 55, 8, 4, 5, 1000.0000)
GO
INSERT [dbo].[THELOAI] ([MaTheLoai], [TenTheLoai]) VALUES (N'MTL001', N'Văn Học Nghệ Thuật')
INSERT [dbo].[THELOAI] ([MaTheLoai], [TenTheLoai]) VALUES (N'MTL002', N'Khoa Học')
INSERT [dbo].[THELOAI] ([MaTheLoai], [TenTheLoai]) VALUES (N'MTL003', N'Truyện')
GO
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS001', N'Đắc Nhân Tâm', N'Văn Học Nghệ Thuật', N'Dale Caregie', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS002', N'Tắt Đèn', N'Khoa Học', N'Ngô Tất Tố', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS003', N'Số Đỏ', N'Truyện', N'Vũ Trọng Phụng', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS004', N'Chí Phèo', N'Khoa Học', N'Nam Cao', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS005', N'Nhà Giả Kim', N'Khoa Học', N'Paulo Coelho', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS006', N'Đời Thay Đổi', N'Văn Học Nghệ Thuật', N'Andrew Matthews', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS007', N'Vợ Nhặt', N'Khoa Học', N'Kim Lân', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS008', N'Sống Mòn', N'Văn Học Nghệ Thuật', N'Nam Cao', N'0')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS009', N'Thơ Thơ', N'Truyện', N'Xuân Diệu', N'1')
INSERT [dbo].[TraCuu] ([MaSach], [TenDauSach], [TenTheLoai], [TenTacGia], [TinhTrang]) VALUES (N'MCS010', N'Nhật Ký Trong Tù', N'Khoa Học', N'Hồ Chí Minh', N'1')
GO
ALTER TABLE [dbo].[BAOCAOMUONSACH] ADD  DEFAULT ([dbo].[AUTO_MBCMS]()) FOR [MaBaoCaoMuonSach]
GO
ALTER TABLE [dbo].[BCTRATRE] ADD  DEFAULT (getdate()) FOR [NgayThangNam]
GO
ALTER TABLE [dbo].[CT_PHIEUNHAP] ADD  DEFAULT ([dbo].[AUTO_MCTPN]()) FOR [MaCTPN]
GO
ALTER TABLE [dbo].[CTBCMS] ADD  DEFAULT ([dbo].[AUTO_MCTBCMS]()) FOR [MaCTBCMS]
GO
ALTER TABLE [dbo].[CTPHIEUMUON] ADD  DEFAULT ([dbo].[AUTO_MCTPM]()) FOR [MaChiTietPhieuMuon]
GO
ALTER TABLE [dbo].[CTPT] ADD  DEFAULT ([dbo].[AUTO_MCTPTS]()) FOR [MaChiTietPhieuTra]
GO
ALTER TABLE [dbo].[CUONSACH] ADD  DEFAULT ([DBO].[AUTO_CS]()) FOR [MaCuonSach]
GO
ALTER TABLE [dbo].[DAUSACH] ADD  DEFAULT ([dbo].[AUTO_MDS]()) FOR [MaDauSach]
GO
ALTER TABLE [dbo].[DOCGIA] ADD  DEFAULT ([DBO].[AUTO_IDDG]()) FOR [MaDocGia]
GO
ALTER TABLE [dbo].[DOCGIA] ADD  CONSTRAINT [macdinh1]  DEFAULT ((0)) FOR [TongNo]
GO
ALTER TABLE [dbo].[LOAIDOCGIA] ADD  DEFAULT ([DBO].[AUTO_IDLDG]()) FOR [MaLoaiDocGia]
GO
ALTER TABLE [dbo].[PHIEUMUON] ADD  DEFAULT ([dbo].[AUTO_MPMS]()) FOR [MaPhieuMuonSach]
GO
ALTER TABLE [dbo].[PHIEUNHAPSACH] ADD  DEFAULT ([dbo].[AUTO_MPNS]()) FOR [MaPhieuNhapSach]
GO
ALTER TABLE [dbo].[PHIEUNHAPSACH] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[PHIEUTHUTIEN] ADD  DEFAULT ([dbo].[AUTO_MPT]()) FOR [MaPhieuThu]
GO
ALTER TABLE [dbo].[PHIEUTRASACH] ADD  DEFAULT ([dbo].[AUTO_MPTS]()) FOR [MaPhieuTraSach]
GO
ALTER TABLE [dbo].[SACH] ADD  DEFAULT ([DBO].[AUTO_IDS]()) FOR [MaSach]
GO
ALTER TABLE [dbo].[SACH] ADD  DEFAULT ((0)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[TACGIA] ADD  DEFAULT ([dbo].[AUTO_MTG]()) FOR [MaTacGia]
GO
ALTER TABLE [dbo].[THELOAI] ADD  DEFAULT ([dbo].[AUTO_MTL]()) FOR [MaTheLoai]
GO
ALTER TABLE [dbo].[BCTRATRE]  WITH CHECK ADD  CONSTRAINT [FK_BCTT] FOREIGN KEY([MaCuonSach])
REFERENCES [dbo].[CUONSACH] ([MaCuonSach])
GO
ALTER TABLE [dbo].[BCTRATRE] CHECK CONSTRAINT [FK_BCTT]
GO
ALTER TABLE [dbo].[BCTRATRE]  WITH CHECK ADD  CONSTRAINT [FK_BCTT02] FOREIGN KEY([MaPhieuMuonSach])
REFERENCES [dbo].[PHIEUMUON] ([MaPhieuMuonSach])
GO
ALTER TABLE [dbo].[BCTRATRE] CHECK CONSTRAINT [FK_BCTT02]
GO
ALTER TABLE [dbo].[CT_PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CTPN] FOREIGN KEY([MaPhieuNhapSach])
REFERENCES [dbo].[PHIEUNHAPSACH] ([MaPhieuNhapSach])
GO
ALTER TABLE [dbo].[CT_PHIEUNHAP] CHECK CONSTRAINT [FK_CTPN]
GO
ALTER TABLE [dbo].[CT_PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CTPN01] FOREIGN KEY([MaSach])
REFERENCES [dbo].[SACH] ([MaSach])
GO
ALTER TABLE [dbo].[CT_PHIEUNHAP] CHECK CONSTRAINT [FK_CTPN01]
GO
ALTER TABLE [dbo].[CTBCMS]  WITH CHECK ADD  CONSTRAINT [FK_CTBCMS] FOREIGN KEY([MaTheLoai])
REFERENCES [dbo].[THELOAI] ([MaTheLoai])
GO
ALTER TABLE [dbo].[CTBCMS] CHECK CONSTRAINT [FK_CTBCMS]
GO
ALTER TABLE [dbo].[CTBCMS]  WITH CHECK ADD  CONSTRAINT [FK_CTBCMS01] FOREIGN KEY([MaBaoCaoMuonSach])
REFERENCES [dbo].[BAOCAOMUONSACH] ([MaBaoCaoMuonSach])
GO
ALTER TABLE [dbo].[CTBCMS] CHECK CONSTRAINT [FK_CTBCMS01]
GO
ALTER TABLE [dbo].[CTPHIEUMUON]  WITH CHECK ADD  CONSTRAINT [FK_CTPM] FOREIGN KEY([MaCuonSach])
REFERENCES [dbo].[CUONSACH] ([MaCuonSach])
GO
ALTER TABLE [dbo].[CTPHIEUMUON] CHECK CONSTRAINT [FK_CTPM]
GO
ALTER TABLE [dbo].[CTPHIEUMUON]  WITH CHECK ADD  CONSTRAINT [FK_CTPM01] FOREIGN KEY([MaPhieuMuonSach])
REFERENCES [dbo].[PHIEUMUON] ([MaPhieuMuonSach])
GO
ALTER TABLE [dbo].[CTPHIEUMUON] CHECK CONSTRAINT [FK_CTPM01]
GO
ALTER TABLE [dbo].[CTPT]  WITH CHECK ADD  CONSTRAINT [FK_CTPT] FOREIGN KEY([MaCuonSach])
REFERENCES [dbo].[CUONSACH] ([MaCuonSach])
GO
ALTER TABLE [dbo].[CTPT] CHECK CONSTRAINT [FK_CTPT]
GO
ALTER TABLE [dbo].[CTPT]  WITH CHECK ADD  CONSTRAINT [FK_CTPT01] FOREIGN KEY([MaPhieuTraSach])
REFERENCES [dbo].[PHIEUTRASACH] ([MaPhieuTraSach])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CTPT] CHECK CONSTRAINT [FK_CTPT01]
GO
ALTER TABLE [dbo].[CTPT]  WITH CHECK ADD  CONSTRAINT [FK_CTPT02] FOREIGN KEY([MaPhieuMuonSach])
REFERENCES [dbo].[PHIEUMUON] ([MaPhieuMuonSach])
GO
ALTER TABLE [dbo].[CTPT] CHECK CONSTRAINT [FK_CTPT02]
GO
ALTER TABLE [dbo].[CTTACGIA]  WITH CHECK ADD  CONSTRAINT [FK_CTTG] FOREIGN KEY([MaDauSach])
REFERENCES [dbo].[DAUSACH] ([MaDauSach])
GO
ALTER TABLE [dbo].[CTTACGIA] CHECK CONSTRAINT [FK_CTTG]
GO
ALTER TABLE [dbo].[CTTACGIA]  WITH CHECK ADD  CONSTRAINT [FK_CTTG01] FOREIGN KEY([MaTacGia])
REFERENCES [dbo].[TACGIA] ([MaTacGia])
GO
ALTER TABLE [dbo].[CTTACGIA] CHECK CONSTRAINT [FK_CTTG01]
GO
ALTER TABLE [dbo].[CUONSACH]  WITH CHECK ADD  CONSTRAINT [cs_fk] FOREIGN KEY([MaCTPN])
REFERENCES [dbo].[CT_PHIEUNHAP] ([MaCTPN])
GO
ALTER TABLE [dbo].[CUONSACH] CHECK CONSTRAINT [cs_fk]
GO
ALTER TABLE [dbo].[CUONSACH]  WITH CHECK ADD  CONSTRAINT [FK_CS] FOREIGN KEY([MaSach])
REFERENCES [dbo].[SACH] ([MaSach])
GO
ALTER TABLE [dbo].[CUONSACH] CHECK CONSTRAINT [FK_CS]
GO
ALTER TABLE [dbo].[DAUSACH]  WITH CHECK ADD  CONSTRAINT [FK_DS] FOREIGN KEY([MaTheLoai])
REFERENCES [dbo].[THELOAI] ([MaTheLoai])
GO
ALTER TABLE [dbo].[DAUSACH] CHECK CONSTRAINT [FK_DS]
GO
ALTER TABLE [dbo].[DOCGIA]  WITH CHECK ADD  CONSTRAINT [FK_DG] FOREIGN KEY([MaLoaiDocGia])
REFERENCES [dbo].[LOAIDOCGIA] ([MaLoaiDocGia])
GO
ALTER TABLE [dbo].[DOCGIA] CHECK CONSTRAINT [FK_DG]
GO
ALTER TABLE [dbo].[PHIEUMUON]  WITH CHECK ADD  CONSTRAINT [FK_PM] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOCGIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[PHIEUMUON] CHECK CONSTRAINT [FK_PM]
GO
ALTER TABLE [dbo].[PHIEUTHUTIEN]  WITH CHECK ADD  CONSTRAINT [FK_PTT] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOCGIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[PHIEUTHUTIEN] CHECK CONSTRAINT [FK_PTT]
GO
ALTER TABLE [dbo].[PHIEUTRASACH]  WITH CHECK ADD  CONSTRAINT [FK_PT] FOREIGN KEY([MaDocGia])
REFERENCES [dbo].[DOCGIA] ([MaDocGia])
GO
ALTER TABLE [dbo].[PHIEUTRASACH] CHECK CONSTRAINT [FK_PT]
GO
ALTER TABLE [dbo].[SACH]  WITH CHECK ADD  CONSTRAINT [FK_S] FOREIGN KEY([MaDauSach])
REFERENCES [dbo].[DAUSACH] ([MaDauSach])
GO
ALTER TABLE [dbo].[SACH] CHECK CONSTRAINT [FK_S]
GO
/****** Object:  StoredProcedure [dbo].[DeleteBorrowCard]    Script Date: 11/6/2023 6:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBorrowCard](@BorrowId varchar(50))
AS
BEGIN
	DELETE FROM PHIEUTRASACH WHERE MaPhieuTraSach IN 
		(SELECT MaPhieuTraSach FROM PHIEUTRASACH WHERE MaPhieuTraSach IN 
			(SELECT DISTINCT CTPT1.MaPhieuTraSach FROM CTPT CTPT1
			WHERE (SELECT COUNT(MaCuonSach) FROM CTPT CTPT2 WHERE CTPT2.MaPhieuTraSach = CTPT1.MaPhieuTraSach AND CTPT2.MaCuonSach IN 
				(SELECT CTPM.MaCuonSach FROM CTPHIEUMUON CTPM WHERE CTPM.MaPhieuMuonSach = @BorrowId)) = 
			(SELECT COUNT(*) FROM CTPT CTPT3 WHERE CTPT3.MaPhieuTraSach = CTPT1.MaPhieuTraSach)))

	UPDATE CUONSACH SET TinhTrang = 1 WHERE CUONSACH.MaCuonSach IN 
	(SELECT CTPHIEUMUON.MaCuonSach FROM CTPHIEUMUON WHERE CTPHIEUMUON.MaPhieuMuonSach = @BorrowId)
	DELETE FROM CTPT WHERE MaPhieuMuonSach = @BorrowId
	DELETE FROM CTPHIEUMUON WHERE MaPhieuMuonSach = @BorrowId
	DELETE FROM PHIEUMUON WHERE MaPhieuMuonSach = @BorrowId
END
GO
USE [master]
GO
ALTER DATABASE [QLTV] SET  READ_WRITE 
GO
