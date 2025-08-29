USE [bdBIOSTAT]
GO
/****** Object:  User [fichashsb]    Script Date: 29/08/2025 11:17:07 ******/
CREATE USER [fichashsb] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 29/08/2025 11:17:07 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT SERVICE\MSSQL$DATAHSB]    Script Date: 29/08/2025 11:17:07 ******/
CREATE USER [NT SERVICE\MSSQL$DATAHSB]
GO
/****** Object:  User [NT SERVICE\SQLAgent$DATAHSB]    Script Date: 29/08/2025 11:17:07 ******/
CREATE USER [NT SERVICE\SQLAgent$DATAHSB]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'fichashsb'
GO
/****** Object:  Table [dbo].[tblACTIVIDAD]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblACTIVIDAD](
	[IDActividad] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Color] [int] NULL,
 CONSTRAINT [PK_tblACTIVIDAD] PRIMARY KEY CLUSTERED 
(
	[IDActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAUXILIAR]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAUXILIAR](
	[hostIP] [nchar](40) NULL,
	[hostNAME] [varchar](50) NOT NULL,
	[loggedUSER] [varchar](50) NOT NULL,
	[vrecTIPDOC] [int] NOT NULL,
	[vrecNUMERO] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFICHAS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFICHAS](
	[IDFicha] [int] IDENTITY(1,1) NOT NULL,
	[IdProgramacion] [int] NULL,
	[Fecha] [date] NULL,
	[Ficha] [smallint] NULL,
	[Inicio] [datetime] NULL,
	[Fin] [datetime] NULL,
	[IdEstado] [int] NULL,
	[NoHC] [int] NULL,
	[Ticket] [int] NULL,
	[Color] [int] NULL,
	[TipoTicket] [char](1) NULL,
 CONSTRAINT [PK_tblFICHAS] PRIMARY KEY CLUSTERED 
(
	[IDFicha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLISTAGENERICA]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLISTAGENERICA](
	[Tabla] [varchar](50) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Sigla] [varchar](5) NULL,
 CONSTRAINT [PK_tblLISTAGENERICA] PRIMARY KEY CLUSTERED 
(
	[Tabla] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLLAMARFICHAS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLLAMARFICHAS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[N] [int] NULL,
	[HISTORIA_CLINICA] [varchar](20) NULL,
	[DOCTOR] [varchar](200) NULL,
	[ESPECIALIDAD] [varchar](200) NULL,
	[PACIENTE] [varchar](200) NULL,
	[FECHA] [date] NULL,
	[TURNO] [char](1) NULL,
	[id_Ficha] [int] NULL,
	[CI_DOCTOR] [varchar](50) NULL,
	[ESTADO] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPARAMETROS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPARAMETROS](
	[IDParametro] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](25) NULL,
	[Valor] [varchar](25) NULL,
 CONSTRAINT [PK_tblPARAMETROS] PRIMARY KEY CLUSTERED 
(
	[IDParametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPROFESIONAL]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPROFESIONAL](
	[IDProfesional] [int] NOT NULL,
	[Titulo] [varchar](10) NOT NULL,
	[Foto] [varbinary](max) NULL,
	[Notas] [varchar](200) NULL,
	[Vigencia] [bit] NULL,
 CONSTRAINT [PK_tblPROFESIONAL_1] PRIMARY KEY CLUSTERED 
(
	[IDProfesional] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPROFESIONALSERVICIO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPROFESIONALSERVICIO](
	[IDProfesionalservicio] [int] IDENTITY(1,1) NOT NULL,
	[IdProfesional] [int] NULL,
	[IdServicio] [int] NULL,
	[Fecha] [date] NULL,
	[HoraIni] [time](3) NULL,
	[HoraFin] [time](3) NULL,
	[Fichas] [int] NULL,
	[Turno] [nchar](10) NULL,
 CONSTRAINT [PK_tblPROFESIONALSERVICIO] PRIMARY KEY CLUSTERED 
(
	[IDProfesionalservicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPROGRAMACION]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPROGRAMACION](
	[IDProgramacion] [int] IDENTITY(1,1) NOT NULL,
	[IdProfesionalservicio] [int] NOT NULL,
	[Inicio] [datetime] NOT NULL,
	[Fin] [datetime] NOT NULL,
	[IdActividad] [int] NULL,
	[Preferencial] [bit] NULL,
	[NoFichas] [int] NULL,
 CONSTRAINT [PK_tblPROGRAMACION] PRIMARY KEY CLUSTERED 
(
	[IDProgramacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblROL]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblROL](
	[rolCODIGO] [int] IDENTITY(1,1) NOT NULL,
	[rolDESCRIPCION] [varchar](20) NULL,
	[rolFECHAHABILITACION] [datetime] NULL,
	[rolVIGENCIA] [bit] NULL,
	[rolNOTAS] [varchar](200) NULL,
 CONSTRAINT [PK_tblROL_1] PRIMARY KEY CLUSTERED 
(
	[rolCODIGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSERVICIO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSERVICIO](
	[IDServicio] [int] NOT NULL,
	[Vigencia] [bit] NULL,
	[TiempoConsulta] [tinyint] NULL,
	[cuCODIGO] [int] NULL,
	[GrupoServicio] [int] NULL,
 CONSTRAINT [PK_tblSERVICIO] PRIMARY KEY CLUSTERED 
(
	[IDServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSOLICITUDHC]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSOLICITUDHC](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[origenSOLICITUD] [int] NOT NULL,
	[IdFicha] [int] NULL,
	[hclCODIGO] [int] NOT NULL,
	[vrecNUMERO] [int] NULL,
	[ESTADO] [int] NOT NULL,
	[TIPOPACIENTE] [int] NOT NULL,
	[CONVENIO] [int] NULL,
	[funSOLICITANTE] [int] NOT NULL,
	[areaSOLICITANTE] [int] NOT NULL,
	[usrREGISTROSOLICITUD] [varchar](20) NOT NULL,
	[fechaREGISTROSOLICITUD] [datetime] NOT NULL,
	[usrREGISTROENTREGA] [varchar](20) NULL,
	[fechaREGISTROENTREGA] [datetime] NULL,
	[usrREGISTRODEVOLUCION] [varchar](20) NULL,
	[fechaREGISTRODEVOLUCION] [datetime] NULL,
 CONSTRAINT [PK_tblSOLICITUDHC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUSUARIO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUSUARIO](
	[usuCODIGO] [int] NOT NULL,
	[usuVIGENCIA] [bit] NULL,
 CONSTRAINT [PK_tblUSUARIO] PRIMARY KEY CLUSTERED 
(
	[usuCODIGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUSUARIOADMISION]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUSUARIOADMISION](
	[IDAdmision] [int] IDENTITY(1,1) NOT NULL,
	[IdCajero] [int] NOT NULL,
	[Vigencia] [bit] NOT NULL,
 CONSTRAINT [PK_tblUSUARIOSADMISION] PRIMARY KEY CLUSTERED 
(
	[IDAdmision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUSUARIOROL]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUSUARIOROL](
	[urolCODIGO] [int] IDENTITY(1,1) NOT NULL,
	[usuCODIGO] [int] NOT NULL,
	[rolCODIGO] [int] NOT NULL,
	[rolFECHASIGNACION] [datetime] NULL,
	[rolFECHALIBERACION] [datetime] NULL,
 CONSTRAINT [PK_tblUSUARIOROL_1] PRIMARY KEY CLUSTERED 
(
	[urolCODIGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp_print]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp_print](
	[IDFicha] [int] NOT NULL,
	[IdProgramacion] [int] NULL,
	[Ticket] [varchar](3) NULL,
	[Inicio] [datetime] NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Medico] [varchar](31) NULL,
	[FechaHoy] [datetime] NOT NULL,
	[Ficha] [smallint] NULL,
	[FechaImpresion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TEMPESTADISTICO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMPESTADISTICO](
	[IDProgramacion] [int] NOT NULL,
	[Inicio] [datetime] NOT NULL,
	[MEDICO] [varchar](61) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Turno] [nchar](10) NULL,
	[IdEstado] [int] NULL,
	[Caja] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempprogramacion]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempprogramacion](
	[IDProgramacion] [int] NOT NULL,
	[Inicio] [datetime] NOT NULL,
	[MEDICO] [varchar](61) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Turno] [nchar](10) NULL,
	[IdEstado] [int] NULL,
	[ticket] [int] NULL,
	[tipoticket] [char](1) NULL,
	[Caja] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwPERSONA]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPERSONA]
AS
SELECT     pperCodPer, pempCodEmp, pperIdePer, pperNombre, pperPatern, pperMatern, ptidCodTid, pperDocIde, pperTelDom, pperTelCel, pperFecNac, pperEdadpe, pperSexope, pperEstCiv, pperEmaill, 
                      pperDirecc, plugCodLug, pproCodPro, pperFecIng, pperSegCns, pperCatego, pperSubNat, pperMonNat, pperSubLac, pperMonLac, pperFecVac, pperDiaFal, pperNroCta, pperDesCta, pperSwMedi, 
                      pperNroMat, pperEspMed, pperMatCol, pperNroNua, pafpCodAfp, pperExtVig, pperCodBar, per_FechaSedes, lugarexpedicion
FROM         bdRRHH.dbo.perPersona AS GO
GO
/****** Object:  View [dbo].[vwPROFESIONAL]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPROFESIONAL]
AS
select	b.IDProfesional,b.Titulo,a.pperNOMBRE,a.pperPATERN,a.pperMATERN,
		a.pperDOCIDE,rtrim(a.pperTELDOM) as pperTELDOM,rtrim(a.pperTELCEL) as pperTELCEL,a.pperFECNAC,a.pperSEXOPE,
		a.pperESTCIV,a.pperEMAILL,a.pperDIRECC,a.plugCODLUG,a.pproCODPRO,a.pperSWMEDI,a.pperNROMAT,a.pperESPMED,b.Notas,b.Foto,b.Vigencia
from vwPERSONA a, tblPROFESIONAL b
where a.pperCODPER = b.IDPRofesional 	 
GO
/****** Object:  View [dbo].[vwCENTROCOSTO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCENTROCOSTO]

AS

select *
from bdCONTA..conCENTROCOSTO
where com_anio = year(getdate())
and ccctcodigo not in ( select ccctcodant 
					  	from bdCONTA..conCENTROCOSTO 
					  	where com_anio = year(getdate())
					  )
					  
					  
					  
					  
GO
/****** Object:  View [dbo].[vwCUADERNOS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCUADERNOS]
AS
SELECT     CUA_CODIGO, CUA_DESCRIPCION, CUA_VIGENCIA, EMP_CODIGO, CUA_TIPO, CUA_COPIAS, CUA_FECHA_INICIO, CUA_FECHA_FINAL, CUA_ESTADO, CUA_GRUPO, es_codigo, codestabl, 
                      CUA_USO_SEGSOCIAL
FROM         bdESTADISTICA.dbo.SE_CUADERNO
GO
/****** Object:  View [dbo].[vwSERVICIO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSERVICIO]
AS
SELECT     a.IDServicio,rtrim(case when charindex('CONSULTA',b.ccctDescri)=0 then b.ccctDescri else substring(b.ccctDescri,0,charindex('CONSULTA',b.ccctDescri)) end) AS Descripcion, 
a.Vigencia, a.TiempoConsulta, a.GrupoServicio, c.CUA_CODIGO, RTRIM(c.CUA_DESCRIPCION) AS cua_DESCRIPCION
FROM         dbo.tblSERVICIO AS a INNER JOIN
                      dbo.vwCENTROCOSTO AS b ON a.IDServicio = b.ccctCodigo INNER JOIN
                      dbo.vwCUADERNOS AS c ON a.cuCODIGO = c.CUA_CODIGO

GO
/****** Object:  View [dbo].[ListarTardes]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ListarTardes]
AS
SELECT     A.Descripcion, A.IDServicio, C.Inicio
FROM         dbo.vwSERVICIO AS A INNER JOIN
                      dbo.tblPROFESIONALSERVICIO AS B ON A.IDServicio = B.IdServicio INNER JOIN
                      dbo.tblPROGRAMACION AS C ON B.IDProfesionalservicio = C.IdProfesionalservicio
WHERE     (DATEPART(hh, C.Inicio) >= 12)
GROUP BY A.Descripcion, A.IDServicio, C.Inicio

GO
/****** Object:  View [dbo].[ListarMañanas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ListarMañanas]  
AS  
SELECT     A.Descripcion, A.IDServicio, convert(char(10), c.inicio, 103) As Inicio  
FROM         dbo.vwSERVICIO AS A INNER JOIN  
                      dbo.tblPROFESIONALSERVICIO AS B ON A.IDServicio = B.IdServicio INNER JOIN  
                      dbo.tblPROGRAMACION AS C ON B.IDProfesionalservicio = C.IdProfesionalservicio  
WHERE     --(CONVERT(CHAR(8), C.Inicio, 108) >= '08:00:00') AND (CONVERT(CHAR(8), C.Fin, 108) <= '12:00:00')  
datepart(hh,c.inicio)<12
GROUP BY A.Descripcion, A.IDServicio, C.Inicio

GO
/****** Object:  View [dbo].[ViMedicoTarde]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViMedicoTarde]
AS
SELECT     A.IDProfesional, A.Titulo + ' ' + A.pperPATERN + ' ' + A.pperMATERN + ' ' + A.pperNOMBRE AS Medico, A.IDProfesional AS idProgramacion, B.IdServicio
FROM         dbo.vwprofesional AS A INNER JOIN
                      dbo.tblPROFESIONALSERVICIO AS B ON A.IDProfesional = B.IdProfesional INNER JOIN
                      dbo.tblPROGRAMACION AS C ON B.IDProfesionalservicio = C.IdProfesionalservicio
WHERE     (DATEPART(hh, C.Inicio) >= 12)

GO
/****** Object:  View [dbo].[ViMedicoMañana]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViMedicoMañana]
AS
SELECT     A.IDProfesional, A.Titulo + ' ' + A.pperPATERN + ' ' + A.pperMATERN + ' ' + A.pperNOMBRE AS Medico, A.IDProfesional AS idProgramacion, B.IdServicio
FROM         dbo.vwprofesional AS A INNER JOIN
                      dbo.tblPROFESIONALSERVICIO AS B ON A.IDProfesional = B.IdProfesional INNER JOIN
                      dbo.tblPROGRAMACION AS C ON B.IDProfesionalservicio = C.IdProfesionalservicio
WHERE     (DATEPART(hh, C.Inicio) < 12)

GO
/****** Object:  View [dbo].[ViPrintFicha]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViPrintFicha]
AS
SELECT     vp.IDProfesional, vp.Titulo, vp.pperNOMBRE, vp.pperPATERN, vp.pperMATERN, 
                      dbo.tblPROGRAMACION.IdProfesionalservicio, dbo.tblPROGRAMACION.Inicio, dbo.tblPROGRAMACION.Fin, dbo.tblPROGRAMACION.Preferencial, dbo.tblFICHAS.IDFicha, 
                      dbo.tblPROGRAMACION.IDProgramacion, dbo.tblFICHAS.Fecha, dbo.tblFICHAS.Ficha, dbo.tblFICHAS.Ticket, dbo.tblFICHAS.TipoTicket, vs.Descripcion
FROM         dbo.tblPROFESIONALSERVICIO INNER JOIN
                      dbo.vwPROFESIONAL vp ON dbo.tblPROFESIONALSERVICIO.IdProfesional = vp.IDProfesional INNER JOIN
                      dbo.tblPROGRAMACION ON dbo.tblPROFESIONALSERVICIO.IDProfesionalservicio = dbo.tblPROGRAMACION.IdProfesionalservicio INNER JOIN
                      dbo.tblFICHAS ON dbo.tblPROGRAMACION.IDProgramacion = dbo.tblFICHAS.IdProgramacion INNER JOIN
                      dbo.vwSERVICIO vs ON dbo.tblPROFESIONALSERVICIO.IdServicio = vs.IDServicio

GO
/****** Object:  View [dbo].[vwBIOFICHAS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwBIOFICHAS]
AS
SELECT     TOP (100) PERCENT a.IDProgramacion, a.Inicio, p.Titulo + '' + p.pperPATERN AS 'MEDICO', s.Descripcion, b.Turno, f.IdEstado, 
                      CASE s.Descripcion WHEN 'CARDIOLOGIA' THEN '4' WHEN 'CIRUGIA BUCOMAXILOFACIAL' THEN '6' WHEN 'CIRUGIA GENERAL' THEN '1' WHEN 'CIRUGIA PLASTICA' THEN '3' WHEN 'DERMATOLOGIA'
                       THEN '2' WHEN 'ENDOCRINOLOGIA' THEN '3' WHEN 'EPIDEMIOLOGIA' THEN '5' WHEN 'GASTROENTEROLOGIA' THEN '1' WHEN 'GERIATRIA' THEN '5' WHEN 'GINECOLOGIA' THEN '3' WHEN 'HEMATOLOGIA'
                       THEN '1' WHEN 'MEDICINA FISICA Y REHABILITACION' THEN '1' WHEN 'MEDICINA INTERNA' THEN '3' WHEN 'NEFROLOGIA' THEN '2' WHEN 'NEUMOLOGIA' THEN '4' WHEN 'NEUROLOGIA' THEN '1'
                       WHEN 'NUTRICION' THEN '5' WHEN 'ODONTOLOGIA' THEN '6' WHEN 'OFTALMOLOGIA' THEN '2' WHEN 'OTORRINOLARINGOLOGIA' THEN '6' WHEN 'PSICOLOGIA' THEN '2' WHEN 'PSIQUIATRIA' THEN
                       '4' WHEN 'REUMATOLOGIA' THEN '4' WHEN 'TRAUMATOLOGIA' THEN '5' WHEN 'UROLOGIA' THEN '6' END AS 'Caja'
FROM         dbo.tblPROGRAMACION AS a INNER JOIN
                      dbo.tblPROFESIONALSERVICIO AS b ON a.IdProfesionalservicio = b.IDProfesionalservicio INNER JOIN
                      dbo.vwSERVICIO AS s ON b.IdServicio = s.IDServicio INNER JOIN
                      dbo.vwPROFESIONAL AS p ON b.IdProfesional = p.IDProfesional INNER JOIN
                      dbo.tblFICHAS AS f ON a.IDProgramacion = f.IdProgramacion
GROUP BY a.Inicio, a.IDProgramacion, p.Titulo, p.pperPATERN, s.Descripcion, b.Turno, f.IdEstado, f.Ficha
ORDER BY a.Inicio, b.Turno
GO
/****** Object:  View [dbo].[vwESTADOFICHA]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwESTADOFICHA]
AS
SELECT     Codigo AS IdEstado, Nombre AS Descripcion
FROM         dbo.tblLISTAGENERICA
WHERE     (Tabla = 'tblESTADOFICHA')
GO
/****** Object:  View [dbo].[vwINSTITU]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwINSTITU]
AS
SELECT     Emp_Codigo, VINSCODIGO, VINSNOMBRE, VINSPORCEN, VINSDIRECC, VINSNUMRUC, Cu_Codigo, Act_Codigo, VINSCATEGORIA, vinstipo, VINSESTADO, VINSInforme, VINSTIPOINS
FROM         bdVSH.dbo.VSHINSTITU
GO
/****** Object:  View [dbo].[vwPACIENTE]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwPACIENTE]
AS
SELECT     *
FROM         bdESTADISTICA..se_HC

GO
/****** Object:  View [dbo].[vwFICHASPROGRAMADAS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFICHASPROGRAMADAS]
AS
SELECT
    b.IDFicha,
    b.Ficha,
    CASE WHEN DATEPART(HOUR, a.Inicio) < 12 THEN N'Mañana' ELSE N'Tarde' END AS Periodo,
    b.IdEstado,
    c.Descripcion AS DesEstado,
    a.Inicio,
    CONVERT(varchar(5), a.Inicio, 108) + ' - ' + CONVERT(varchar(5), a.Fin, 108) AS Horario,
    CONVERT(varchar(10), b.Fecha, 103) AS Fecha,
    CASE 
        WHEN b.ticket IS NULL AND b.Fecha IS NOT NULL THEN N'Interconsulta'
        ELSE ISNULL(b.tipoticket, '') + '->' + RIGHT('000' + CONVERT(varchar(10), b.ticket), 3)
    END AS Ticket,
    e.hcl_CODIGO,
    LTRIM(RTRIM(
        ISNULL(e.hcl_APPAT, '') +
        CASE WHEN ISNULL(e.hcl_APMAT,'') = '' THEN '' ELSE ' ' + e.hcl_APMAT END +
        CASE WHEN ISNULL(e.hcl_NOMBRE,'') = '' THEN '' ELSE ', ' + e.hcl_NOMBRE END
    )) AS paciente,
    d.tipopaciente,
    CASE WHEN d.tipopaciente <> 1 THEN f.vinsnombre ELSE 'INSTITUCIONAL' END AS vinsnombre,
    ser.Descripcion,
    pro.Titulo + ' ' + pro.pperPATERN + ' ' + pro.pperMATERN + ' ' + pro.pperNOMBRE AS medico
FROM dbo.tblPROGRAMACION AS a
INNER JOIN dbo.tblFICHAS             AS b   ON b.IDProgramacion      = a.IDProgramacion
INNER JOIN dbo.vwESTADOFICHA         AS c   ON c.IdEstado            = b.IdEstado
INNER JOIN dbo.tblPROFESIONALSERVICIO AS s  ON a.IdProfesionalservicio = s.IDProfesionalservicio
INNER JOIN dbo.vwPROFESIONAL         AS pro ON s.IdProfesional       = pro.IDProfesional
INNER JOIN dbo.vwSERVICIO            AS ser ON s.IdServicio          = ser.IDServicio
INNER JOIN dbo.tblSOLICITUDHC        AS d   ON d.IdFicha             = b.IDFicha
INNER JOIN dbo.vwPACIENTE            AS e   ON e.hcl_CODIGO          = d.hclCODIGO
LEFT  JOIN dbo.vwINSTITU             AS f   ON f.vinsCODIGO          = d.CONVENIO;
GO
/****** Object:  View [dbo].[ListarFichas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListarFichas]

AS
	SELECT * FROM dbo.tblFICHAS
GO
/****** Object:  View [dbo].[ViObtenerIdProgMañanas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViObtenerIdProgMañanas]
AS
SELECT     C.IDProgramacion, A.IDProfesional, B.IdServicio, C.Inicio, C.Fin, C.IdActividad, B.IDProfesionalservicio
FROM         dbo.tblPROFESIONAL AS A INNER JOIN
                      dbo.tblPROFESIONALSERVICIO AS B ON A.IDProfesional = B.IdProfesional INNER JOIN
                      dbo.tblPROGRAMACION AS C ON C.IdProfesionalservicio = B.IDProfesionalservicio
WHERE     (DATEPART(hh, C.Inicio) < 12)
GO
/****** Object:  View [dbo].[ViObtenerIdProgTardes]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViObtenerIdProgTardes]
AS
SELECT     C.IDProgramacion, A.IDProfesional, B.IdServicio, C.Inicio, C.Fin, C.IdActividad, B.IDProfesionalservicio
FROM         dbo.tblPROFESIONAL AS A INNER JOIN
                      dbo.tblPROFESIONALSERVICIO AS B ON A.IDProfesional = B.IdProfesional INNER JOIN
                      dbo.tblPROGRAMACION AS C ON C.IdProfesionalservicio = B.IDProfesionalservicio
WHERE     (DATEPART(hh, C.Inicio) >= 12)
GO
/****** Object:  View [dbo].[vwFUNCIONHOSPITALARIA]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFUNCIONHOSPITALARIA]
AS
SELECT     lis_codigo AS fhCODIGO, RTRIM(lis_descripcion) AS fhDescripcion
FROM         bdADMIN.dbo.ad_listagenerica
WHERE     (lis_tabla = 'rh_titulo')
GO
/****** Object:  View [dbo].[vwGRUPOSERVICIO]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGRUPOSERVICIO]
AS
SELECT     Codigo AS gsCODIGO, Nombre AS gsNOMBRE, Sigla AS gsSIGLA
FROM         dbo.tblLISTAGENERICA
WHERE     (Tabla = 'tblGRUPOSERVICIO')
GO
/****** Object:  View [dbo].[vwPROFESION]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPROFESION]
AS
SELECT     pproCodPro AS IDProfesion, UPPER(RTRIM(pproDescri)) AS Descripcion
FROM         bdRRHH.dbo.perProfesi
GO
/****** Object:  View [dbo].[vwUSUARIOS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwUSUARIOS]
AS
SELECT     Usu_Codigo, Usu_NombreUsuario, Usu_Identificacion, Usu_ClaveUsuario, Usu_Vigente, Usu_sexo, Usu_Privilegio
FROM         bdADMIN.dbo.ad_Usuarios
WHERE     (Usu_Vigente = 'S')
GO
ALTER TABLE [dbo].[tblFICHAS] ADD  CONSTRAINT [DF_tblFICHAS_Estado]  DEFAULT ((0)) FOR [IdEstado]
GO
ALTER TABLE [dbo].[tblPROGRAMACION] ADD  CONSTRAINT [DF_tblPROGRAMACION_Preferencial]  DEFAULT ((0)) FOR [Preferencial]
GO
ALTER TABLE [dbo].[tblPROGRAMACION] ADD  CONSTRAINT [DF_tblPROGRAMACION_NoFichas]  DEFAULT ((0)) FOR [NoFichas]
GO
ALTER TABLE [dbo].[Temp_print] ADD  CONSTRAINT [DF_Temp_print_FechaImpresion]  DEFAULT (getdate()) FOR [FechaImpresion]
GO
ALTER TABLE [dbo].[tblFICHAS]  WITH CHECK ADD  CONSTRAINT [FK_tblFICHAS_tblPROGRAMACION] FOREIGN KEY([IdProgramacion])
REFERENCES [dbo].[tblPROGRAMACION] ([IDProgramacion])
GO
ALTER TABLE [dbo].[tblFICHAS] CHECK CONSTRAINT [FK_tblFICHAS_tblPROGRAMACION]
GO
ALTER TABLE [dbo].[tblPROFESIONALSERVICIO]  WITH CHECK ADD  CONSTRAINT [FK_tblPROFESIONALSERVICIO_tblPROFESIONAL] FOREIGN KEY([IdProfesional])
REFERENCES [dbo].[tblPROFESIONAL] ([IDProfesional])
GO
ALTER TABLE [dbo].[tblPROFESIONALSERVICIO] CHECK CONSTRAINT [FK_tblPROFESIONALSERVICIO_tblPROFESIONAL]
GO
ALTER TABLE [dbo].[tblPROFESIONALSERVICIO]  WITH CHECK ADD  CONSTRAINT [FK_tblPROFESIONALSERVICIO_tblSERVICIO] FOREIGN KEY([IdServicio])
REFERENCES [dbo].[tblSERVICIO] ([IDServicio])
GO
ALTER TABLE [dbo].[tblPROFESIONALSERVICIO] CHECK CONSTRAINT [FK_tblPROFESIONALSERVICIO_tblSERVICIO]
GO
ALTER TABLE [dbo].[tblPROGRAMACION]  WITH CHECK ADD  CONSTRAINT [FK_tblPROGRAMACION_tblACTIVIDAD1] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[tblACTIVIDAD] ([IDActividad])
GO
ALTER TABLE [dbo].[tblPROGRAMACION] CHECK CONSTRAINT [FK_tblPROGRAMACION_tblACTIVIDAD1]
GO
ALTER TABLE [dbo].[tblUSUARIOROL]  WITH CHECK ADD  CONSTRAINT [FK_tblUSUARIOROL_tblROL] FOREIGN KEY([rolCODIGO])
REFERENCES [dbo].[tblROL] ([rolCODIGO])
GO
ALTER TABLE [dbo].[tblUSUARIOROL] CHECK CONSTRAINT [FK_tblUSUARIOROL_tblROL]
GO
ALTER TABLE [dbo].[tblUSUARIOROL]  WITH CHECK ADD  CONSTRAINT [FK_tblUSUARIOROL_tblUSUARIO] FOREIGN KEY([usuCODIGO])
REFERENCES [dbo].[tblUSUARIO] ([usuCODIGO])
GO
ALTER TABLE [dbo].[tblUSUARIOROL] CHECK CONSTRAINT [FK_tblUSUARIOROL_tblUSUARIO]
GO
/****** Object:  StoredProcedure [dbo].[BuscaValorEnBBDD]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[BuscaValorEnBBDD]
(
@StrValorBusqueda nvarchar(100)
)
AS
BEGIN

CREATE TABLE #Resultado (NombreColumna nvarchar(370), ValorColumna nvarchar(3630))
SET NOCOUNT ON

DECLARE @NombreTabla nvarchar(256),
@NombreColumna nvarchar(128),
@StrValorBusqueda2 nvarchar(110)

SET  @NombreTabla = ''
SET @StrValorBusqueda2 = QUOTENAME('%' + @StrValorBusqueda + '%','''')

WHILE @NombreTabla IS NOT NULL
     BEGIN
     SET @NombreColumna = ''
     SET @NombreTabla =
     (SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_TYPE = 'BASE TABLE'
     AND QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @NombreTabla
     AND OBJECTPROPERTY(
     OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)), 'IsMSShipped') = 0)

     WHILE (@NombreTabla IS NOT NULL) AND (@NombreColumna IS NOT NULL)
         BEGIN
         SET @NombreColumna =
         (SELECT MIN(QUOTENAME(COLUMN_NAME))
         FROM INFORMATION_SCHEMA.COLUMNS
         WHERE TABLE_SCHEMA = PARSENAME(@NombreTabla, 2)
         AND TABLE_NAME = PARSENAME(@NombreTabla, 1)
         AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar')
         AND QUOTENAME(COLUMN_NAME) > @NombreColumna)

         IF @NombreColumna IS NOT NULL
              BEGIN
              INSERT INTO #Resultado
              EXEC
              ('SELECT ''' + @NombreTabla + '.' + @NombreColumna + ''', LEFT(' + @NombreColumna + ', 3630)
              FROM ' + @NombreTabla + ' (NOLOCK) ' + ' WHERE ' + @NombreColumna + ' LIKE ' + @StrValorBusqueda2)
              END 
         END
     END
     SELECT NombreColumna, ValorColumna FROM #Resultado
END
GO
/****** Object:  StoredProcedure [dbo].[EstadisticoFichas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from dbo.tblPROGRAMACION where 
--Inicio between '29/04/2019' and '06/05/2019'
--select * from dbo.tblPROFESIONALSERVICIO
--select * from dbo.tblSERVICIO
--select * from vwSERVICIO
--select * from dbo.vwPROFESIONAL
--select * from dbo.tblFICHAS where IdProgramacion = 68362


CREATE PROCEDURE [dbo].[EstadisticoFichas]
 @FAECHAINI DATE,
 @FECHAFIN DATE
As
--exec EstadisticoFichas '29/04/2019','06/05/2019'
--drop table TEMPESTADISTICO
--SET @FAECHAINI = '29/04/2019'
--SET @FECHAFIN = '06/05/2019'
select a.IDProgramacion,a.Inicio, p.Titulo + '' +p.pperPATERN as 'MEDICO', s.Descripcion, b.Turno, f.IdEstado,
CASE s.Descripcion
WHEN 'CARDIOLOGIA' THEN '4'
WHEN 'CIRUGIA BUCOMAXILOFACIAL' THEN '6'
WHEN 'CIRUGIA GENERAL' THEN '1'
WHEN 'CIRUGIA PLASTICA' THEN '3'
WHEN 'DERMATOLOGIA' THEN '2'
WHEN 'ENDOCRINOLOGIA' THEN '3'
WHEN 'EPIDEMIOLOGIA' THEN '5'
WHEN 'GASTROENTEROLOGIA' THEN '1'
WHEN 'GERIATRIA' THEN '5'
WHEN 'GINECOLOGIA' THEN '3'
WHEN 'HEMATOLOGIA' THEN '1'
WHEN 'MEDICINA FISICA Y REHABILITACION' THEN '1'
WHEN 'MEDICINA INTERNA' THEN '3'
WHEN 'NEFROLOGIA' THEN '2'
WHEN 'NEUMOLOGIA' THEN '4'
WHEN 'NEUROLOGIA' THEN '1'
WHEN 'NUTRICION' THEN '5'
WHEN 'ODONTOLOGIA' THEN '6'
WHEN 'OFTALMOLOGIA' THEN '2'
WHEN 'OTORRINOLARINGOLOGIA' THEN '6'
WHEN 'PSICOLOGIA' THEN '2'
WHEN 'PSIQUIATRIA' THEN '4'
WHEN 'REUMATOLOGIA' THEN '4'
WHEN 'TRAUMATOLOGIA' THEN '5'
WHEN 'UROLOGIA' THEN '6'
END AS 'Caja'
into TEMPESTADISTICO 
from tblPROGRAMACION a inner join tblPROFESIONALSERVICIO b on a.IdProfesionalservicio = b.IdProfesionalservicio
inner join vwSERVICIO s on b.IdServicio = s.IDServicio
inner join vwPROFESIONAL p on b.IdProfesional = p.IDProfesional
inner join tblFICHAS f on a.IDProgramacion = f.IdProgramacion
where a.Inicio between @FAECHAINI and @FECHAFIN
and f.IdEstado <> 3 
group by a.Inicio,a.IDProgramacion, p.Titulo,p.pperPATERN,s.Descripcion,b.Turno,f.IdEstado,f.Ficha
order by a.inicio, b.Turno

--select CONVERT(DATE, Inicio, 108) from tempprogramacion group by CONVERT(DATE, Inicio, 108)

SELECT * FROM TEMPESTADISTICO 

--select CAJA, COUNT(CAJA),
--CASE IdEstado
--WHEN '0' THEN 'DISPONIBLE'
--WHEN '1' THEN 'ASIGNADO'
--WHEN '2' THEN 'REGISTRADO'
--END AS 'TIPO'
-- from tempprogramacion
--GROUP BY Caja,IdEstado
--ORDER BY Caja,IdEstado
GO
/****** Object:  StoredProcedure [dbo].[MODIFICAR_FICHA]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[MODIFICAR_FICHA](@id int,@estado char(1))
as
begin
	update tblLLAMARFICHAS  set ESTADO=@estado where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[MODIFICAR_FICHA1]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[MODIFICAR_FICHA1](@CARNET varchar(15),@TURNO char(1),@ESPECIALIDAD VARCHAR(200))
as
begin
	update tblLLAMARFICHAS  set ESTADO='E' where CI_DOCTOR=@CARNET and convert(varchar(10),FECHA,103)=convert(varchar(10),getdate(),103) and Turno=@TURNO and ESPECIALIDAD=@ESPECIALIDAD and ESTADO='R'
end
GO
/****** Object:  StoredProcedure [dbo].[PaCantidadFichas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaCantidadFichas]
@idMedico INT,
@fecha datetime,
@esmañana bit,
@cantfichas INT OUTPUT
--CANTIDAD DE FICHAS DISPONIBLES
AS
DECLARE 
@idPServicio int

SET @idPServicio = (SELECT tp.IDProfesionalservicio FROM dbo.tblPROFESIONALSERVICIO tp WHERE tp.IdProfesional = @idMedico)--idmedico

IF (@esmañana = 1)
BEGIN
SELECT @cantfichas = COUNT(IdProgramacion) FROM dbo.tblFICHAS tf 
WHERE tf.IdProgramacion IN (
SELECT tp.IDProgramacion FROM dbo.tblPROGRAMACION tp 
WHERE tp.IdProfesionalservicio=@idPServicio 
AND convert(char(10), tp.Inicio, 103) = convert(char(10), @fecha, 103)
AND (DATEPART(hh,tp.Inicio)<12 and (GETDATE() < dateadd(mi,-15,tp.Fin)))
)AND tf.IdEstado = 0	
END
ELSE
BEGIN
SELECT @cantfichas = COUNT(IdProgramacion) FROM dbo.tblFICHAS tf 
WHERE tf.IdProgramacion IN (
SELECT tp.IDProgramacion FROM dbo.tblPROGRAMACION tp 
WHERE tp.IdProfesionalservicio=@idPServicio 
AND convert(char(10), tp.Inicio, 103) = convert(char(10), @fecha, 103)
AND (DATEPART(hh,tp.Inicio)>=12 and (GETDATE() < dateadd(mi,-15,tp.Fin)))
)AND tf.IdEstado = 0	
END
GO
/****** Object:  StoredProcedure [dbo].[PaCantidadFichasReserva]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaCantidadFichasReserva]
@idMedico INT,
@fecha Datetime,
@esmañana bit,
@idProServ int,
@cantfichas INT OUTPUT
--CANTIDAD DE FICHAS DISPONIBLES PARA RESERVA
AS
DECLARE 
@Porcentaje INT,
@TotalFichaReserva FLOAT = 0,
@TotalFichas INT,
@topficha INT,
@aux INT,
@idPServicio int

SET @idPServicio = (SELECT tp.IDProfesionalservicio FROM dbo.tblPROFESIONALSERVICIO tp WHERE tp.IdProfesional = @idMedico AND tp.IDProfesionalservicio = @idProServ)
SET @Porcentaje = (
		SELECT CONVERT(INT,Valor) FROM dbo.tblPARAMETROS
		WHERE	Descripcion = 'RESERVA'
)
if (@esmañana = 1)
BEGIN
SET @TotalFichas =(
		SELECT COUNT(IdProgramacion) FROM dbo.tblFICHAS tf 
WHERE tf.IdProgramacion IN (
SELECT tp.IDProgramacion FROM dbo.tblPROGRAMACION tp 
WHERE tp.IdProfesionalservicio=@idPServicio AND convert(char(10), tp.Inicio, 103) = convert(char(10), @fecha, 103)and datepart(hh,tp.inicio)<12
))
END
ELSE
BEGIN
SET @TotalFichas =(
		SELECT COUNT(IdProgramacion) FROM dbo.tblFICHAS tf 
WHERE tf.IdProgramacion IN (
SELECT tp.IDProgramacion FROM dbo.tblPROGRAMACION tp 
WHERE tp.IdProfesionalservicio=@idPServicio AND convert(char(10), tp.Inicio, 103) = convert(char(10), @fecha, 103)and datepart(hh,tp.inicio)>=12
))
END
IF (@Porcentaje = 100)
	BEGIN		
		SELECT @TotalFichaReserva = @TotalFichas
	END
ELSE
	BEGIN
		IF(@Porcentaje=0)
		BEGIN
			SELECT @TotalFichaReserva = 0
		END
		ELSE
		BEGIN
			SELECT @TotalFichaReserva = FLOOR(((CAST(@TotalFichas AS float) / CAST(100 AS float))*@Porcentaje))
		END
	END
--SET @TotalFichaReserva = cast(12/100 AS DECIMAL(9,2))

SET @topficha = CONVERT(INT,@TotalFichaReserva)

SELECT * FROM dbo.tblFICHAS tf 
WHERE tf.IdProgramacion IN (
SELECT tp.IDProgramacion FROM dbo.tblPROGRAMACION tp 
WHERE tp.IdProfesionalservicio=@idPServicio AND convert(char(10), tp.Inicio, 103) = convert(char(10), @fecha, 103)
AND (((datepart(hh,tp.inicio) < 12) and @esmañana = 1) or (datepart(hh,tp.inicio) >= 12 and @esmañana = 0))
)AND tf.IdEstado=0
SET @cantfichas = @@ROWCOUNT

SELECT TOP(@topficha)* FROM dbo.tblFICHAS tf 
WHERE tf.IdProgramacion IN (
SELECT tp.IDProgramacion FROM dbo.tblPROGRAMACION tp 
WHERE tp.IdProfesionalservicio=@idPServicio AND convert(char(10), tp.Inicio, 103) = convert(char(10), @fecha, 103)
AND (((datepart(hh,tp.inicio) < 12) and @esmañana = 1) or (datepart(hh,tp.inicio) >= 12 and @esmañana = 0))
)AND (tf.IdEstado=1 OR tf.IdEstado = 2)
order by ficha DESC

SET @aux = @@ROWCOUNT

SET @cantfichas = @topficha - @aux
GO
/****** Object:  StoredProcedure [dbo].[paDarFicha]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- OBJETIVO: Obtener una ficha para emitir al paciente:

CREATE PROCEDURE [dbo].[paDarFicha]
@i_Fecha datetime,			-- Fecha Objeto
@i_Periodo bit,				-- [1:Mañana, 0:Tarde]
@i_idProfesionalServicio int,
@i_IDFicha int out

AS

declare @hora_Actual datetime,
		@w_idFicha int,
		@w_TipoTicket char(1),
		@w_max int,
		@w_NoTicket int,
		@w_FechaInicio datetime

begin tran

	
	--set @Periodo = 0 --[1:Mañana, 0:Tarde]
	set @hora_Actual = Getdate()	---> Hora Actual en el servidor [obtenemos localmente]
	--set @w_fecha = '14/10/2014 00:00:00'		---> Fecha en el que se pretende extraer fichas


	--SELECT top 1 @w_idFicha = IDFicha, @w_TipoTicket =  CASE a.Preferencial WHEN 1 THEN 'P' WHEN 0 THEN 'N' END
	SELECT top 1 @w_idFicha = IDFicha, @w_TipoTicket =  CASE WHEN @i_Periodo = 1 THEN 'P' ELSE 'N' END
	FROM dbo.tblPROGRAMACION a, tblFICHAS b 
	WHERE a.idprogramacion = b.idprogramacion
	and a.IdProfesionalservicio = @i_idProfesionalServicio 
	AND convert(char(10), a.Inicio, 103) = CONVERT(char(10), @hora_Actual, 103)
	and ((((datepart(hh,a.inicio) < 12) and @i_Periodo = 1) or (datepart(hh,a.inicio) >= 12 and @i_Periodo = 0)) and (@hora_Actual <= dateadd(mi,-15,a.fin)))
	and b.idestado = 0
	order by b.Ficha
	-- Setear P a los del mismo dia en la mañana
	
	---------------------------------------------------------------------------------
	IF ((DATEPART(hh,@w_FechaInicio)<12)
	AND(DATEPART(hh,@hora_Actual)<12)AND(@i_Periodo = 1)
	and convert(char(10), @i_Fecha, 103) = convert(char(10), @hora_Actual, 103))
		BEGIN
			SET @w_TipoTicket = 'P' 	
		END
	---------------------------------------------------------------------------------
	
	-- Obtener el nro de ticket correspondiente
	SELECT @w_NoTicket = isnull(max(Ticket),0) + 1 
	FROM dbo.tblPROGRAMACION a, tblFICHAS b 
	WHERE a.idprogramacion = b.idprogramacion
	and convert(char(10), b.Fecha, 103) = convert(char(10), @i_Fecha, 103)
	and b.TipoTicket = @w_TipoTicket
	
	
	--select @idProgramacion as IDProgramacion,@w_idFicha as IDFicha,@w_fecha as Fecha,@w_NoTicket as NoTicket,@w_TipoTicket as TipoTicket
	
	update tblfichas
	set Fecha = @i_Fecha,
		IdEstado = 1,
		Ticket = @w_NoTicket,
		TipoTicket = @w_TipoTicket
	where IDFicha = @w_idFicha
	if @@error > 0 
	begin
		rollback tran
		return 1
	end
	
	set @i_IDFicha = @w_idFicha
	commit TRAN
GO
/****** Object:  StoredProcedure [dbo].[PaDarFichaReserva]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [PaDarFicha] 32,0

CREATE PROCEDURE [dbo].[PaDarFichaReserva]
@i_Fecha datetime,			-- Fecha Objeto
@i_Periodo bit,				-- [1:Mañana, 0:Tarde]
@i_idProfesionalServicio int,
@i_IDFicha int out

AS

declare @hora_Actual datetime,
		@w_idFicha int,
		@w_TipoTicket char(1),
		@w_max int,
		@w_NoTicket int

begin tran
		
	--set @Periodo = 0 --[1:Mañana, 0:Tarde]
	set @hora_Actual = Getdate()	---> Hora Actual en el servidor [obtenemos localmente]
	--set @w_fecha = '14/10/2014 00:00:00'		---> Fecha en el que se pretende extraer fichas


	SELECT top 1 @w_idFicha = IDFicha, @w_TipoTicket = 'N'
	FROM dbo.tblPROGRAMACION a, tblFICHAS b 
	WHERE a.idprogramacion = b.idprogramacion
	and a.IdProfesionalservicio = @i_idProfesionalServicio 
	AND convert(char(10), a.Inicio, 103) = CONVERT(char(10), @i_Fecha, 103)
	and (((datepart(hh,a.inicio) < 12) and @i_Periodo = 1) or (datepart(hh,a.inicio) >= 12 and @i_Periodo = 0))	
	and b.idestado=0
	order by b.Ficha desc
	
	
	-- Obtener el nro de ticket correspondiente
	SELECT @w_NoTicket = isnull(max(Ticket),0) + 1 
	FROM dbo.tblPROGRAMACION a, tblFICHAS b 
	WHERE a.idprogramacion = b.idprogramacion
	and convert(char(10), b.Fecha, 103) = convert(char(10), @hora_Actual, 103)
	and b.TipoTicket = @w_TipoTicket
	
	
	--select @idProgramacion as IDProgramacion,@w_idFicha as IDFicha,@w_fecha as Fecha,@w_NoTicket as NoTicket,@w_TipoTicket as TipoTicket
	
	update tblfichas
	set Fecha = @hora_Actual,
		IdEstado = 1,
		Ticket = @w_NoTicket,
		TipoTicket = @w_TipoTicket
	where IDFicha = @w_idFicha
	if @@error > 0 
	begin
		rollback tran
		return 1
	end
	
	set @i_IDFicha = @w_idFicha
	commit tran




--obtener fichas libres
GO
/****** Object:  StoredProcedure [dbo].[PaListarMañanas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaListarMañanas]

@fecha DateTime
AS
	SELECT dbo.ListarMañanas.Descripcion, dbo.ListarMañanas.IDServicio FROM ListarMañanas
	where convert(char(10), @fecha, 103)= CONVERT(char(10), Inicio, 103)
	group by Descripcion, IDSErvicio
	ORDER BY dbo.ListarMañanas.Descripcion
GO
/****** Object:  StoredProcedure [dbo].[PaListarTardes]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaListarTardes]
@fecha DateTime
AS
	SELECT dbo.ListarTardes.Descripcion, dbo.ListarTardes.IDServicio FROM ListarTardes
	where CONVERT(CHAR(10),@fecha,103)= CONVERT(CHAR(10),Inicio,103)
	group by Descripcion, IDSErvicio
	ORDER BY dbo.ListarTardes.Descripcion
	
	
	--SELECT dbo.ListarTardes.Descripcion, dbo.ListarTardes.IDServicio FROM ListarTardes
	--where N'07/10/2014'= CONVERT(CHAR(10),Inicio,103)
	--group by Descripcion, IDSErvicio
	--ORDER BY dbo.ListarTardes.Descripcion
GO
/****** Object:  StoredProcedure [dbo].[PaMedicosMañana]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaMedicosMañana]
@IdServicio INT,
@fecha date
AS

	select a.IdProfesional,c.Titulo+' '+c.pperPATERN+', '+ c.pperNOMBRE
	from tblPROFESIONALSERVICIO a,  
	tblPROGRAMACION b, 
	dbo.vwPROFESIONAL c,
	tblFICHAS d
	where a.IdServicio = @idServicio
	and a.IdProfesionalservicio = b.IdProfesionalservicio
	and a.IdProfesional  = c.IdProfesional AND b.IDProgramacion = d.IdProgramacion
	and convert(varchar(10),b.Inicio,103) = @fecha
	and (datepart(hh,b.inicio) < 12 and (GETDATE() <= dateadd(mi,-15,b.fin)))
	and d.idEstado = 0
	GROUP BY a.IdProfesional, c.Titulo,c.pperPATERN,c.pperNOMBRE
GO
/****** Object:  StoredProcedure [dbo].[PaMedicosTarde]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaMedicosTarde]
@idServicio INT,
@fecha DATE
AS
	select a.IdProfesional,c.Titulo+' '+c.pperPATERN+', '+ c.pperNOMBRE
	from tblPROFESIONALSERVICIO a,  
	tblPROGRAMACION b, 
	dbo.vwPROFESIONAL c,
	dbo.tblFICHAS d
	where a.IdServicio = @idServicio
	and a.IdProfesionalservicio = b.IdProfesionalservicio
	and a.IdProfesional  = c.IdProfesional AND b.IDProgramacion = d.IdProgramacion
	and convert(varchar(10),b.Inicio,103) = @fecha
	and datepart(hh,b.inicio) >= 12 and (GETDATE() <= dateadd(mi,-15,b.fin))
	and d.idEstado = 0
	GROUP BY a.IdProfesional, c.Titulo,c.pperPATERN,c.pperNOMBRE
	--select a.IdProfesional,c.Titulo+' '+c.ApPaterno+' '+ c.ApMaterno +', '+ c.Nombre
	--from tblPROFESIONALSERVICIO a,  
	--tblPROGRAMACION b, 
	--tblPROFESIONAL c
	--where a.IdServicio = @idServicio
	--and a.IdProfesionalservicio = b.IdProfesionalservicio
	--and a.IdProfesional  = c.IdProfesional
	--and convert(varchar(10),b.Inicio,103) = @fecha
	--and datepart(hh,b.inicio) > 12
GO
/****** Object:  StoredProcedure [dbo].[PaNumFicha]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[PaNumFicha]
@IdProg INT
AS
 SELECT TOP 1 Ficha FROM tblFICHAS WHERE IdProgramacion = @IdProg AND IdEstado IN (2,3)
 ORDER BY Ficha DESC


SELECT * FROM dbo.vwESTADOFICHA
GO
/****** Object:  StoredProcedure [dbo].[PaObtenerIdProMañanas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Obtine el ID de programacion
CREATE PROCEDURE [dbo].[PaObtenerIdProMañanas]
@ideprofesional INT,
@idservicio INT,
@fecha DATETIME,
@idProServico INT OUTPUT
--exec ObtenerIdProMañanas 1,11 
AS
SELECT @idProServico = dbo.ViObtenerIdProgMañanas.IDProfesionalservicio FROM ViObtenerIdProgMañanas WHERE IdProfesional = @ideprofesional AND IdServicio = @idservicio 
AND  (DATEPART(hh, Inicio) < 12) AND convert(char(10), @fecha, 103)= CONVERT(char(10), Inicio, 103)


select* FROM ViObtenerIdProgMañanas
GO
/****** Object:  StoredProcedure [dbo].[PaObtenerIdProTardes]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- obtener el id de fecha
CREATE PROCEDURE [dbo].[PaObtenerIdProTardes]
@ideprofesional INT,
@idservicio INT,
@fecha DATETIME,
@idProServico INT OUTPUT
--exec ObtenerIdProMañanas 1,11 
AS
SELECT @idProServico = dbo.ViObtenerIdProgTardes.IDProfesionalservicio FROM ViObtenerIdProgTardes WHERE IdProfesional = @ideprofesional AND IdServicio = @idservicio
AND  (DATEPART(hh, Inicio) >= 12) AND convert(char(10), @fecha, 103)= CONVERT(char(10), Inicio, 103)

SELECT * FROM dbo.tblPROFESIONALSERVICIO tp
GO
/****** Object:  StoredProcedure [dbo].[PaPrintFicha]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PaPrintFicha]
@idEstado INT,
@idProg INT,
@seleccion INT,
@idFicha INT
AS
DECLARE
@Abreviatura CHAR(5)

IF (@seleccion = 0)
 SET @Abreviatura = 'HSB'
ELSE 
 SET @Abreviatura = 'HSB'
--SELECT @Abreviatura = Abreviatura FROM dbo.tblGRUPOSOCIAL WHERE id = @idSocial
--RTRIM(@Abreviatura)+'-'+
-----------------------------------------------------------------------------------------------
--select * from tblFICHAS where IDFicha=599467--@idFicha



SELECT IDFicha, IdProgramacion,RTRIM(TipoTicket)+'-'+RIGHT(REPLICATE('0', 3)+ CAST(Ticket AS VARCHAR(3)),3 ) AS 'Ticket',Inicio,Fin,
Descripcion, (Titulo+' '+pperPATERN)AS 'Medico',GETDATE()AS 'FechaHoy',Ficha
FROM ViPrintFicha 
WHERE IDFicha = @idFicha and YEAR(Inicio)= year(GETDATE()) or idFicha = @idFicha and YEAR(Inicio)=YEAR(GETDATE())+1
--CONVERT(CHAR(8),GETDATE(),108)
--ORDER BY ticket 
--SELECT vpf.* FROM dbo.ViPrintFicha vpf

--------------------------------------------------------------------------------------------------

--INSERTAMOS A LA TABLA TEMPORAL PRA REIMPRIMIR 

--INSERT INTO Temp_print ([IDFicha],[IdProgramacion],[Ticket],[Inicio],[Descripcion],[Medico],[FechaHoy],[Ficha])
--SELECT IDFicha, IdProgramacion,RIGHT(REPLICATE('0', 3)+ CAST(Ticket AS VARCHAR(3)),3 ) AS 'Ticket',Inicio,  
--Descripcion, (Titulo+' '+pperPATERN)AS 'Medico',GETDATE()AS 'FechaHoy',Ficha
--FROM ViPrintFicha 
--WHERE IDFicha = @idFicha
--CONVERT(CHAR(8),GETDATE(),108)
--ORDER BY ticket
GO
/****** Object:  StoredProcedure [dbo].[REGISTRAR_LLAMAR_FICHAS]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[REGISTRAR_LLAMAR_FICHAS](@CI varchar(50),@Especialidad varchar(50),@Turno char(1))
as
begin
	insert into tblLLAMARFICHAS(N,HISTORIA_CLINICA,DOCTOR,ESPECIALIDAD,PACIENTE,id_Ficha,FECHA,TURNO,CI_DOCTOR,ESTADO) select N=ROW_NUMBER() OVER (ORDER BY Ficha asc ), HISTORIA_CLINICA=NoHC,DOCTOR=pperNOMBRE+' '+pperPATERN,ESPECIALIDAD=pperESPMED,PACIENTES=ext.HCL_NOMBRE+' '+HCL_APPAT+' '+HCL_APMAT,f.IDFicha,f.Fecha,Turno,pro.pperDOCIDE,'E' from tblFICHAS f inner join tblPROGRAMACION  pr on (f.IdProgramacion=pr.IDProgramacion) inner join tblPROFESIONALSERVICIO s on (s.IDProfesionalservicio=pr.IdProfesionalservicio) inner join vwPROFESIONAL pro on (s.IdProfesional=pro.IDProfesional) inner join bdESTADISTICA.dbo.SE_HC ext on (f.NoHC=ext.HCL_CODIGO)  where pro.pperDOCIDE=@CI and f.Fecha=getdate() and Turno=@Turno and NoHC is not null  ORDER BY f.Ficha asc
end	
GO
/****** Object:  StoredProcedure [dbo].[restantefichas]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[restantefichas]
@FECHA_ACTUAL datetime
AS
DECLARE
@dia int,
@mes int,
@año int,
@AUX VARCHAR(10)

---Exec restantefichas 30,08,2018
--------------------------------DATOS FECHAS-----------------------------------------------------
SET @dia = DAY(@FECHA_ACTUAL)
SET @mes = MONTH(@FECHA_ACTUAL)
SET @año = YEAR(@FECHA_ACTUAL)
-------------------------------------SCRIPT--------------------------------------------------------
SELECT --tp.IdProfesional, 
vp.pperESPMED 'ESPECIALIDAD',
vp.Titulo 'TITULO',
vp.pperPATERN 'MEDICO',
count (tf.IdProgramacion)AS 'FICHAS RESTANTES',
CONVERT(VARCHAR, tp2.Inicio, 108)AS 'HORA'
--datepart(hour,tp2.Inicio) as 'HORA',
--CONVERT(date,tp2.Inicio,102)

FROM dbo.vwPROFESIONAL vp 
INNER JOIN dbo.tblPROFESIONALSERVICIO tp ON vp.IDProfesional = tp.IdProfesional
INNER JOIN dbo.tblPROGRAMACION tp2 ON tp.IDProfesionalservicio = tp2.IdProfesionalservicio
INNER JOIN dbo.tblFICHAS tf ON tp2.IDProgramacion = tf.IdProgramacion
WHERE DAY(tp2.Inicio)=@dia AND MONTH(tp2.Inicio)=@mes AND YEAR(tp2.Inicio)=@año
AND tf.IdEstado = 0
group by tp.IdProfesional,vp.pperESPMED,vp.Titulo,vp.pperPATERN,tp2.Inicio
order by pperESPMED, pperPATERN



--SELECT DATENAME(year, '12:10:30.123')
--    ,DATENAME(month, '12:10:30.123')
--    ,DATENAME(day, '12:10:30.123')
--    ,DATENAME(dayofyear, '12:10:30.123')
--    ,DATENAME(weekday, '12:10:30.123');
GO
/****** Object:  StoredProcedure [dbo].[usp_ADMISION_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
EXEC usp_ADMISION_adm 'L',NULL,NULL,''
*/
CREATE PROCEDURE [dbo].[usp_ADMISION_adm]
	@i_OPERACION	char(1),
	@i_usuCODIGO	int				= null,
	@i_usuVIGENCIA	bit				= null,
	@i_valorBUSQUEDA varchar(100)	= null
AS

declare @strCommand varchar(4000)

IF @i_OPERACION = 'B' -- Carga datos de los usuarios de de admision
BEGIN
	set @strCommand = 
		'select a.usu_CODIGO,a.usu_NOMBREUSUARIO,a.usu_IDENTIFICACION,b.VIGENCIA
		 from vwUSUARIOS a, tblUSUARIOADMISION b
		 where a.usu_CODIGO = b.idCajero
		 and a.usu_NOMBREUSUARIO like ''%' + @i_valorBUSQUEDA + '%'''
		 
	exec(@strCommand)
END

IF @i_OPERACION = 'L' -- Carga el listado de usuarios del SIAF
BEGIN
	set @strCommand = 
		'select usu_CODIGO, usu_NOMBREUSUARIO, usu_IDENTIFICACION
		 from vwUSUARIOS
		 where usu_NOMBREUSUARIO LIKE ''%' + @i_valorBUSQUEDA + '%'''
		 
	exec(@strCommand)
END


IF @i_OPERACION = 'I' -- Insert
BEGIN
	BEGIN TRAN
	
	select 1 from tblUSUARIOADMISION where IdCajero = @i_usuCODIGO
	IF @@ROWCOUNT = 0
		insert into tblUSUARIOADMISION
			(idCAJERO,VIGENCIA)
		values 
			(@i_usuCODIGO,@i_usuVIGENCIA)		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END

IF @i_OPERACION = 'U' -- Update
BEGIN
	BEGIN TRAN
	
	update tblUSUARIOADMISION
	set
		Vigencia = @i_usuVIGENCIA
	where idCAJERO = @i_usuCODIGO
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END

IF @i_OPERACION = 'D' -- Insertar
BEGIN
	BEGIN TRAN

	delete from tblUSUARIOADMISION
	where idCAJERO = @i_usuCODIGO
			
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ESPECIALIDAD_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ESPECIALIDAD_adm]
	@i_OPERACION		CHAR(1),
	
	@i_IDEspecialidad	INT			= NULL,
	@i_Nombre			VARCHAR(50) = NULL

AS


IF @i_OPERACION = 'S'	--Select
BEGIN
	SELECT * FROM tblESPECIALIDAD
END
IF @i_OPERACION = 'I'	--Insert
BEGIN
	BEGIN TRAN
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END
IF @i_OPERACION = 'U'	--Update
BEGIN
	BEGIN TRAN
	
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END
IF @i_OPERACION = 'D'	--Delete
BEGIN
	BEGIN TRAN
	
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[usp_FICHAS_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 exec usp_FICHAS_adm	@i_OPERACION = '1',
						@i_hclAPPAT= '',
						@i_hclAPMAT= '',
						@i_hclNOMBRE= ''
						
*/

CREATE PROCEDURE [dbo].[usp_FICHAS_adm]
	@i_OPERACION		CHAR(1),
	@i_IDFicha			int		= null,
	@i_IdProgramacion	int		= null,
	@i_IdProfesionalservicio int = null,
	@i_NoHC				int		= null,
	@i_hclAPPAT			varchar(50) = '',
	@i_hclAPMAT			varchar(50) = '',
	@i_hclNOMBRE		varchar(50) = '',
	@i_IdEstado			int		= null,
	@i_Reacomodar		bit		= null,
	@i_fechaINICIO		datetime = null,
	@i_noFICHAS			int		= null,
	@i_idSERVICIO		int		= null,
	@i_vinsCODIGO		int		= null,
	@i_valorBUSQUEDA	varchar(100) = null,
	@i_vtpaCODIGO		int			= null,
	@i_vrecCODCLI		int			= null,
	@i_ref_CODIGO		int			= 0
	
AS

DECLARE @w_IdProgramacion int,
		@w_Fecha	date,
		@w_IdEstado	int,
		@w_NoHC		int,
		@w_Ticket	int,
		@w_Color	int,
		@strCommand varchar(4000)

IF @i_OPERACION = 'S'	--Localizar 
BEGIN
	--Verificar la existencia de datos	
	SELECT  isnull(count(IDFicha),0)
	FROM tblFICHAS
	WHERE IdProgramacion = @i_IdProgramacion
	AND IdEstado <> 0
	AND ticket IS NOT NULL

END

IF @i_OPERACION = '1'	--Listado de Pacientes
BEGIN
	--Verificar la existencia de datos	
	set @strCommand = 
		'select top 100 hcl_CODIGO,hcl_APPAT,hcl_APMAT,hcl_NOMBRE,hcl_FECNAC 
		 from vwPACIENTE
		 where hcl_APPAT like ''' + @i_hclAPPAT + '%'' and hcl_APMAT like ''' + @i_hclAPMAT + '%'' and hcl_NOMBRE like ''%' + @i_hclNOMBRE + '%''
		 order by hcl_Fecha desc'
	print @strCommand
	exec(@strCommand)
END

IF @i_OPERACION = '2'	--Listado de Establecimientos
BEGIN
	--Verificar la existencia de datos	
	set @strCommand = 
		'select top 100 codestabl as codigo,rtrim(sedes) as sedes,rtrim(red_establ) as Red, rtrim(establecimien) as Establecimiento 
		 from bdsnis..c_establ  
		 where sedes like  ''%' + @i_hclAPPAT + '%'' and red_ESTABL like ''%' + @i_hclAPMAT + '%'' and establecimien like ''%' + @i_hclNOMBRE + '%''
		 group by codestabl ,sedes ,red_establ ,establecimien 
		 order by establecimien'
	print @strCommand
	exec(@strCommand)
END

IF @i_OPERACION = '3'	--Establecimiento
BEGIN
	--Verificar la existencia de datos	
	select distinct min(establecimien) as Establecimiento,sedes,red_establ as Red  
	from bdsnis..c_establ
	where codestabl = @i_NoHC
	group by codestabl ,sedes ,red_establ
END

IF @i_OPERACION = '4'	--Listado de HC's que no llegaron a ARchivo Clinico
BEGIN
	--Verificar la existencia de datos	
	select 1 as origeNSOLICITUD,b.idficha,B.NOHC,1 as estado,NULL AS TIPOPACIENTE,NULL AS CONVENIO, C.IDPROFESIONAL,C.IDSERVICIO,'' as usrregistrosolicitud, CONVERT(VARCHAR(10),A.INICIO,103) as fecharegistrosolicitud,null,null,null,null
	from tblprogramacion a
		inner join tblfichas b
			on  a.idprogramacion= b.idprogramacion
		inner join tblprofesionalservicio c
			INNER JOIN VWPROFESIONAL D
				ON C.IDPROFESIONAL = D.IDPROFESIONAL
			INNER JOIN VWSERVICIO E
				ON C.IDSERVICIO = E.IDSERVICIO
			ON A.IDPROFESIONALSERVICIO = C.IDPROFESIONALSERVICIO
	where convert(varchar(10),b.fecha,103) = convert(varchar(10),@i_fechaINICIO,103)
	and a.inicio >= @i_fechaINICIO
	--and datepart(hh,a.inicio) > 12
	and nohc is not null
	and b.idficha not in (
	select a.idficha
	from tblsolicitudhc a
		inner join tblprogramacion b
			inner join tblfichas c
				on b.idprogramacion = c.idprogramacion
			on a.idficha = c.idficha
	where convert(varchar(10),fecharegistrosolicitud,103) = convert(varchar(10),b.inicio,103) 
	and b.inicio >= @i_fechaINICIO
	--and datepart(hh,b.inicio) > 12
	)
END

IF @i_OPERACION = '5'	--Listado de Fichas solicitadas que no han sido confirmadas
BEGIN
	--Verificar la existencia de datos	
	
	SELECT top 100 c.Fecha as [Fecha Admision],convert(varchar(10),b.Inicio,103) as [Fecha Atencion], d.Descripcion as Especialidad ,e.Titulo+' '+e.pperpatern+', '+e.ppernombre as Medico, Ficha, TipoTicket + '-' + convert(varchar,ticket) as Ticket
	from tblPROFESIONALSERVICIO a 
		INNER JOIN tblPROGRAMACION b
			INNER JOIN tblfichas c
				ON b.IDProgramacion = c.IdProgramacion
			ON a.idprofesionalservicio = b.idprofesionalservicio
		INNER JOIN vwSERVICIO d
			ON a.idservicio = d.idservicio
		INNER JOIN vwPROFESIONAL e
			ON a.idprofesional = e.idprofesional
	where convert(varchar(10),c.fecha,103) <= @i_fechaINICIO
	and  convert(varchar(10),b.Inicio,103) > @i_fechaINICIO
	and c.IdEstado = 1	
	order by c.fecha,b.inicio,d.descripcion,Medico
	
END


IF @i_OPERACION = 'R'	-- Regenerar las fichas si hubiera comprometidas se las reasigna si la hora final de la actividad es menor que la anterior
BEGIN
	BEGIN TRAN
	
		if (@i_reacomodar = 1)
		begin
			DECLARE Ticket_Cursor CURSOR FOR
				SELECT IdProgramacion,Fecha,IdEstado,NoHC,Ticket,Color
				FROM tblFICHAS
				WHERE IdProgramacion = @i_IdProgramacion
				AND IdEstado <> 0
				AND ticket IS NOT NULL
			OPEN Ticket_Cursor
			
			FETCH NEXT FROM Ticket_Cursor
			INTO @w_IdProgramacion,@w_Fecha,@w_IdEstado,@w_NoHC,@w_Ticket,@w_Color
			WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Eliminar registros
				-- Generar registros con el nuevo intervalo
				-- Reingresar las fichas comprometidas
				
				FETCH NEXT FROM Ticket_Cursor
				INTO @w_IdProgramacion,@w_Fecha,@w_IdEstado,@w_NoHC,@w_Ticket,@w_Color
			END
			CLOSE Ticket_Cursor
			DEALLOCATE Ticket_Cursor
		end
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END

IF @i_OPERACION = 'G'	-- Generar fichas para una programacion especifica
BEGIN
	BEGIN TRAN  

	declare @w_fichaACTUAL tinyint, -- de 0 a 255
			@w_totalFICHAS tinyint
	
	-- verificar si hay una programacion anterior en el mismo periodo
	select top 1 
		@w_fichaACTUAL = isnull(max(Ficha),0), 
		@w_IdProgramacion = isnull(max(a.IDProgramacion),0)
	from 
		tblPROGRAMACION a
		INNER JOIN tblFICHAS b
			on a.IDProgramacion = b.IdProgramacion
	where 
		a.IdProfesionalservicio = @i_IdProfesionalservicio
	and convert(varchar(10),a.Inicio,103) = convert(varchar(10),@i_fechaINICIO,103)
	and (((datepart(hh,a.Inicio) < 12) and (datepart(hh,@i_fechaINICIO) < 12)) or 
		 ((datepart(hh,a.Inicio) >= 12) and (datepart(hh,@i_fechaINICIO) >= 12)))
	order by max(a.IDProgramacion) desc
	
	IF @w_fichaACTUAL <> 0
		update tblPROGRAMACION
		set Preferencial = 0
		where IDProgramacion in (@i_IdProgramacion,@w_IdProgramacion)

	set @w_totalFICHAS = @w_fichaACTUAL + @i_noFICHAS
		
	WHILE (@w_fichaACTUAL < @w_totalFICHAS)
	BEGIN
		SET @w_fichaACTUAL = @w_fichaACTUAL + 1
		INSERT INTO tblFICHAS (idProgramacion,Fecha,Ficha,IdEstado,NoHC,Ticket,Color,TipoTicket)
					VALUES (@i_IdProgramacion,null,@w_fichaACTUAL,0,null,null,null,null)
	END
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END


IF @i_OPERACION = 'I'	-- Insertamos fichas manualmente uno a uno
BEGIN
	BEGIN TRAN
	
	select top 1 
		@w_fichaACTUAL = isnull(max(Ficha),0), 
		@w_IdProgramacion = isnull(max(a.IDProgramacion),0)
	from 
		tblPROGRAMACION a
		INNER JOIN tblFICHAS b
			on a.IDProgramacion = b.IdProgramacion
	where 
		a.IdProfesionalservicio = @i_IdProfesionalservicio
	and convert(varchar(10),a.Inicio,103) = convert(varchar(10),@i_fechaINICIO,103)
	and (((datepart(hh,a.Inicio) < 12) and (datepart(hh,@i_fechaINICIO) < 12)) or 
		 ((datepart(hh,a.Inicio) >= 12) and (datepart(hh,@i_fechaINICIO) >= 12)))
	order by max(a.IDProgramacion) desc	

	insert into tblFICHAS
		(IdProgramacion,Fecha,Ficha,IdEstado,NoHC,Ticket,Color,TipoTicket)
	values
		(@w_IdProgramacion,null,@w_fichaACTUAL + 1,0,null,null,null,null)	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END

IF @i_OPERACION = 'W'	--Carga el paciente
BEGIN
	select hcl_APPAT + ' ' + hcl_APMAT + ', ' + hcl_NOMBRE as paciente from vwPACIENTE where hcl_CODIGO = @i_NoHC
END

IF @i_OPERACION = 'X'	-- Listado de Instituciones de convenio
BEGIN
	set @strCommand = 
		'select vinsCODIGO,vinsNOMBRE 
		 from vwINSTITU 
		 WHERE VINSESTADO = ''V'' and vinsNOMBRE like ''%' + @i_valorBUSQUEDA + '%'''
	print @strCommand
	exec(@strCommand)
END

IF @i_OPERACION = 'Y'	-- Carga InstitucioneS de convenio
BEGIN
	select vinsNOMBRE from vwINSTITU WHERE vinsESTADO = 'V' and vinsCODIGO = @i_vinsCODIGO
END


IF @i_OPERACION = 'Z'	--Update
BEGIN
	BEGIN TRAN
	
	update tblFICHAS
	set idEstado = @i_IdEstado
	where IDFicha = @i_IDFicha
	if (@@error > 0)
	begin
		ROLLBACK TRAN
		RETURN 1		
	end
	
	COMMIT TRAN
end


IF @i_OPERACION = 'A'	--Libera los tickets asignados que no hayan sido confirmados
BEGIN
	BEGIN TRAN
	
	update tblfichas
	set IdEstado = 0,
		Ticket = NULL,
		TipoTicket = NULL,
		Fecha = NULL
	from tblPROGRAMACION a
		INNER JOIN tblfichas b
			ON a.IDProgramacion = b.IdProgramacion
	where convert(varchar(10),b.fecha,103) <= convert(varchar(10),@i_fechaINICIO,103)
	and  convert(varchar(10),a.Inicio,103) > convert(varchar(10),@i_fechaINICIO,103)
	and b.IdEstado = 1	
	
	if (@@error > 0)
	begin
		ROLLBACK TRAN
		RETURN 1		
	end
	
	COMMIT TRAN
end

IF @i_OPERACION = 'U'	--Update
BEGIN
	BEGIN TRAN
	
	-- Verifica si la ficha no haya sido ya utilizada de ser asi, anula accion
	select 1 
	from tblFICHAS 
	where IDFicha = @i_IDFicha 
	and (Fecha <> null or IdEstado not in  (0,3))
	
	if (@@ROWCOUNT > 0)
	begin
		ROLLBACK TRAN
		RETURN 1		
	end
	
	-- Actualiza datos de ficha, ocupando de esta manera la ficha, 
	-- evitando registrar el dato nro ticket ya que este no sera llamado por el LLAMADOR 
	-- ni será dispuesto por el DISPENSADOR
	update tblFICHAS
	set	Fecha = convert(varchar(10),getdate(),103),
		IdEstado = @i_IdEstado, --estado 2 OCUPADO
		NoHC = @i_NoHC
	where IDFicha = @i_IDFicha
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	---inserta en el sice y biostat
	exec dbo.usp_SICE_adm2
		@i_IDFicha		= @i_IDFicha,
		@i_HC			= @i_NoHC,
		@i_vtpaCODIGO	= @i_vtpaCODIGO,
		@i_vrecCODCLI	= @i_vrecCODCLI,
		@i_ref_CODIGO	= @i_ref_CODIGO		
	
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END
IF @i_OPERACION = 'D'	--Delete
BEGIN
	BEGIN TRAN
	
	delete from tblFICHAS
	where IDFicha = @i_IDFicha
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[usp_LOCALIZARORDEN_sel]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC usp_LOCALIZARORDEN_sel

CREATE procedure [dbo].[usp_LOCALIZARORDEN_sel]
AS

declare @w_HOST_NAME varchar(50),
		@w_HOST_IP nchar(40)

SELECT  @w_HOST_NAME = hostname,
		@w_HOST_IP	 = client_net_address
FROM    sys.sysprocesses AS S
INNER JOIN    sys.dm_exec_connections AS decc ON S.spid = decc.session_id
WHERE   spid = @@SPID	

select hostIP,hostNAME,a.vrecTIPDOC,a.vrecNUMERO,b.vclihiccli, hcl_APPAT + ' ' + hcl_APMAT + ', ' + hcl_NOMBRE
from tblAUXILIAR a, bdVSH..vshRECIBOS b, bdESTADISTICA..se_HC c
where a.vrecTIPDOC = b.vrecTIPDOC
and a.vrecNUMERO = b.vrecNUMERO
and b.vclihiccli = c.hcl_CODIGO
and hostIP = @w_HOST_IP
GO
/****** Object:  StoredProcedure [dbo].[usp_PROFESIONAL_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC usp_PROFESIONAL_adm 'B',2,'MAR','CAN',''
*/

CREATE PROCEDURE [dbo].[usp_PROFESIONAL_adm]
	@i_OPERACION		CHAR(1),
	@i_opcionBUSQUEDA	tinyint		= null,
	@i_valorBUSQUEDA	varchar(100)= null,
	@i_valorBUSQUEDA1	varchar(100)= null,
	@i_valorBUSQUEDA2	varchar(100)= null,
	
	@i_IDProfesional	INT			= null,
	@i_Titulo			VARCHAR(10) = null,
	@i_Foto				varbinary(MAX)= null,
	@i_Notas			varchar(200)= null,	
	@i_Vigencia			bit			= null,
	@i_pperNombre		varchar(50)	= null,
	@i_pperPatern		varchar(50)	= null,
	@i_pperMatern		varchar(50)	= null,
	@i_pperDocIde		varchar(15)	= null,
	@i_pperTelDom		varchar(10)	= null,
	@i_pperTelCel		varchar(10)	= null,
	@i_pperFecNac		datetime	= null,
	@i_pperSexope		bit			= null,
	@i_pperEmaill		varchar(100)= null,
	@i_pperDirecc		varchar(150)= null,
	@i_plugCodLug		smallint	= null,
	@i_pproCodPro		smallint	= null,
	@i_pperSwMedi		int			= null,
	@i_pperNroMat		varchar(20)	= null,
	@i_pperEspMed		varchar(100)= null

AS

declare @w_campoBUSQUEDA varchar(50),
		@strCommand varchar(4000),
		@FechaActual datetime


IF @i_OPERACION = '1'-- 'S'	--Select
BEGIN

	select @w_campoBUSQUEDA = case @i_opcionBUSQUEDA  when 1 then 'Titulo'
												when 2 then 'pperPATERN'
												when 3 then 'pperMATERN'
												when 4 then 'pperNOMBRE'
												when 5 then 'pperNROMAT'
							  end	
						

	set @strCommand =  'select b.IDProfesional,b.Titulo,a.pperNOMBRE,a.pperPATERN,a.pperMATERN,
						a.pperDOCIDE,rtrim(a.pperTELDOM) as pperTELDOM,rtrim(a.pperTELCEL) as pperTELCEL,a.pperFECNAC,a.pperSEXOPE,
						a.pperESTCIV,a.pperEMAILL,a.pperDIRECC,a.plugCODLUG,a.pproCODPRO,a.pperSWMEDI,a.pperNROMAT,a.pperESPMED,b.Notas,b.Foto,b.Vigencia
						from vwPERSONA a, tblPROFESIONAL b
						where a.pperCODPER = b.IDPRofesional 
						and ' +@w_campoBUSQUEDA + ' Like ' + case when @i_opcionBUSQUEDA = 4 then '''%' else '''' end  + @i_valorBUSQUEDA + '%'''	

	exec (@strCommand)

END

IF @i_OPERACION = '2'--'B'	--Busqueda Personalizada en BIOSTAT
BEGIN
	SET @strCommand = 	
		'select b.IDProfesional,a.pperNOMBRE,a.pperPATERN,a.pperMATERN
		 from vwPERSONA a, tblPROFESIONAL b
		 where a.pperCODPER = b.IDPRofesional
		 and a.pperPATERN LIKE ''' + @i_valorBUSQUEDA + '%''
		 and a.pperMATERN LIKE ''' + @i_valorBUSQUEDA1 + '%''
		 and a.pperNOMBRE LIKE ''%' + @i_valorBUSQUEDA2 + '%'''
		 
	EXEC (@strCommand)	
END

IF @i_OPERACION = '3'		--Busqueda Personalizada en SIAF
BEGIN
	SET @strCommand = 	
		'select TOP 1000 a.pperCodPer,a.pperNOMBRE,a.pperPATERN,a.pperMATERN, a.pperDOCIDE,a.pperTELDOM,a.pperTELCEL,
		 a.pperFECNAC,a.pperSEXOPE,a.pperESTCIV,a.pperEMAILL,a.pperDIRECC,a.plugCODLUG,a.pproCODPRO,a.pperNROMAT,a.pperESPMED,
		 b.fhCODIGO,b.fhDESCRIPCION
		 from vwPERSONA a,vwFUNCIONHOSPITALARIA b
		 WHERE a.pperswMEDI = b.fhCODIGO
		 AND a.pperPATERN LIKE ''' + @i_valorBUSQUEDA + '%''
		 AND a.pperMATERN LIKE ''' + @i_valorBUSQUEDA1 + '%''
		 AND a.pperNOMBRE LIKE ''%' + @i_valorBUSQUEDA2 + '%'''
		 
	EXEC (@strCommand)	
END

IF @i_OPERACION = 'Y'	--Indirect Insert 
BEGIN
	BEGIN TRAN
		insert into tblPROFESIONAL
			(IDProfesional,Titulo,Foto,Notas,Vigencia)
		values
			(@i_IDProfesional,@i_Titulo,@i_Foto,@i_Notas,@i_Vigencia)
		if @@error > 0
		begin
			--select @o_numerror = 18030 --Poner código de error
			ROLLBACK TRAN
			return 1
		end	

		update vwPERSONA
		set
			pperNombre	= @i_pperNombre, 
			pperPatern	= @i_pperPatern, 
			pperMatern	= @i_pperMatern, 
			pperDocIde	= @i_pperDocIde, 
			pperTelDom	= @i_pperTelDom, 
			pperTelCel	= @i_pperTelCel,
			pperFecNac	= @i_pperFecNac, 
			pperSexope	= @i_pperSexope, 
			pperEmaill	= @i_pperEmaill, 
			pperDirecc	= @i_pperDirecc, 
			plugCodLug	= @i_plugCodLug, 
			pproCodPro	= @i_pproCodPro, 
			pperSwMedi	= @i_pperSwMedi,
			pperNroMat	= @i_pperNroMat,	
			pperEspMed	= @i_pperEspMed
		where
			pperCodPer	= @i_IDProfesional
		
		if @@error <> 0
		begin
			--select @o_numerror = 18030 --Poner código de error
			ROLLBACK TRAN
			return 1
		end
			
	COMMIT TRAN
END

IF @i_OPERACION = 'I'	--Direct Insert
BEGIN
	BEGIN TRAN
	
	select @FechaActual = getdate(),@i_IDProfesional = isnull(max(pperCODPER),0) + 1
	from vwPERSONA
		
	insert into tblPROFESIONAL
		(IDProfesional,Titulo,Foto,Notas,Vigencia)
	values
		(@i_IDProfesional,@i_Titulo,@i_Foto,@i_Notas,@i_Vigencia)
	if @@error > 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end	
	
	Insert into vwPERSONA
		(pperCodPer, pempCodEmp, pperIdePer, pperNombre, pperPatern, pperMatern, ptidCodTid, pperDocIde, pperTelDom, pperTelCel,
		 pperFecNac, pperEdadpe, pperSexope, pperEstCiv, pperEmaill, pperDirecc, plugCodLug, pproCodPro, pperFecIng, pperSegCns,
		 pperCatego, pperSubNat, pperMonNat, pperSubLac, pperMonLac, pperFecVac, pperDiaFal, pperNroCta, pperDesCta, pperSwMedi,
		 pperNroMat, pperEspMed, pperMatCol, pperNroNua, pafpCodAfp, pperExtVig, pperCodBar, per_FechaSedes, lugarexpedicion)	
	values 
		(@i_IDProfesional, 
		 12,			--pempCodEmp
		 '',			--pperIdePer
		 @i_pperNombre, 
		 @i_pperPatern, 
		 @i_pperMatern, 
		 2,				--ptidCodTid
		 @i_pperDocIde, 
		 @i_pperTelDom, 
		 @i_pperTelCel,
		 @i_pperFecNac, 
		 0,				--pperEdadpe
		 @i_pperSexope, 
		 0,				--pperEstCiv, 
		 @i_pperEmaill, 
		 @i_pperDirecc, 
		 @i_plugCodLug, 
		 @i_pproCodPro, 
		 @FechaActual,	--pperFecIng 
		 '',			--pperSegCns
		 0,				--pperCatego 
		 0,				--pperSubNat
		 0,				--pperMonNat
		 0,				--pperSubLac
		 0,				--pperMonLac
		 @FechaActual,	--pperFecVac, 
		 0,				--pperDiaFal
		 '',			--pperNroCta
		 '',			--pperDesCta
		 @i_pperSwMedi,
		 @i_pperNroMat,	
		 @i_pperEspMed,	   
		 '',			--pperMatCol, 
		 '',			--pperNroNua, 
		 1,				--pafpCodAfp, 
		 'S',			--pperExtVig, 
		 '',			--pperCodBar, 
		 null,			--per_FechaSedes, 
		 null			--lugarexpedicion 
		 )	
	if @@error > 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end	
	
	COMMIT TRAN
END
IF @i_OPERACION = 'U'	--Update
BEGIN
	BEGIN TRAN
	
		update tblPROFESIONAL
		set
			Titulo	= @i_Titulo,
			Foto	= @i_Foto,
			Notas	= @i_Notas,
			Vigencia= @i_Vigencia
		where 
			IDProfesional = @i_IDProfesional
		
		if @@error <> 0
		begin
			--select @o_numerror = 18030 --Poner código de error
			ROLLBACK TRAN
			return 1
		end		
		
		update vwPERSONA
		set
			pperNombre	= @i_pperNombre, 
			pperPatern	= @i_pperPatern, 
			pperMatern	= @i_pperMatern, 
			pperDocIde	= @i_pperDocIde, 
			pperTelDom	= @i_pperTelDom, 
			pperTelCel	= @i_pperTelCel,
			pperFecNac	= @i_pperFecNac, 
			pperSexope	= @i_pperSexope, 
			pperEmaill	= @i_pperEmaill, 
			pperDirecc	= @i_pperDirecc, 
			plugCodLug	= @i_plugCodLug, 
			pproCodPro	= @i_pproCodPro, 
			pperSwMedi	= @i_pperSwMedi,
			pperNroMat	= @i_pperNroMat,	
			pperEspMed	= @i_pperEspMed
		where
			pperCodPer	= @i_IDProfesional
		
		if @@error <> 0
		begin
			--select @o_numerror = 18030 --Poner código de error
			ROLLBACK TRAN
			return 1
		end
	
	COMMIT TRAN
END
IF @i_OPERACION = 'D'	--Delete
BEGIN
	BEGIN TRAN
	
	select 1 from dbo.tblPROFESIONALSERVICIO
	where IdProfesional = @i_IDProfesional
			
	if @@ROWCOUNT > 0  --Tiene programaciones
	begin
		update tblPROFESIONAL
		set Vigencia = 0
		where IdProfesional = @i_IDProfesional
	end
	else
	begin
		delete from tblPROFESIONAL
		where IDProfesional = @i_IDProfesional
	end	
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[usp_PROGRAMACION_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec usp_PROGRAMACION_adm '1',42,'11/11/2014'

CREATE PROCEDURE [dbo].[usp_PROGRAMACION_adm]
	@i_OPERACION			CHAR(1),
	@i_ProfesionalServicio	int		= null,
	@i_fechaINICIO			datetime= null,
	@i_fechaFIN				datetime= null
AS

DECLARE @w_IdProgramacion int,
		@w_Fecha	date,
		@w_IdEstado	int,
		@w_NoHC		int, 
		@w_Ticket	int,
		@w_Color	int

IF @i_OPERACION = '1'	-- Fichas generadas para un profesional en servicio(Programacion)
BEGIN

	--select 
	--	b.IDFicha,b.Ficha,
	--	case when (datepart(hh,a.Inicio)< 12) then 'Mañana' else 'Tarde' end as Periodo,
	--	b.IdEstado, 
	--	c.Descripcion as DesEstado,
	--	a.Inicio,
	--	convert(varchar(5),a.Inicio,108) + ' - ' + convert(varchar(5),a.Fin,108) as Horario
	--from 
	--	tblPROGRAMACION a
	--	INNER JOIN tblFICHAS b
	--		INNER JOIN vwESTADOFICHA c
	--			ON b.IdEstado = c.IdEstado
	--		ON a.IDProgramacion = b.IdProgramacion
	--where 
	--	a.IdProfesionalServicio = @i_ProfesionalServicio
	--and convert(varchar(10), a.inicio,103) = convert(varchar(10), @i_fechaINICIO,103)
	--order by Periodo,b.Ficha
	
	select 
		b.IDFicha,b.Ficha,
		case when (datepart(hh,a.Inicio)< 12) then 'Mañana' else 'Tarde' end as Periodo,
		b.IdEstado, 
		c.Descripcion as DesEstado,
		a.Inicio,
		convert(varchar(5),a.Inicio,108) + ' - ' + convert(varchar(5),a.Fin,108) as Horario, convert(varchar(10),b.Fecha,103) as Fecha,
		case when ticket is null and fecha is not null then 'Interconsulta' else b.tipoticket + '->' + replicate('0',3-len(convert(varchar(4),b.ticket)))+ convert(varchar(4),b.ticket) end as Ticket,
		e.hcl_CODIGO,e.hcl_APPAT + ' '+e.hcl_APMAT +', '+e.hcl_NOMBRE as paciente,
		d.tipopaciente,f.vinsnombre
	from 
		tblPROGRAMACION a
		INNER JOIN tblFICHAS b
			INNER JOIN vwESTADOFICHA c
				ON b.IdEstado = c.IdEstado
			ON a.IDProgramacion = b.IdProgramacion
			LEFT OUTER JOIN tblSOLICITUDHC d
				INNER JOIN vwPACIENTE e
					ON d.hclCODIGO = e.hcl_CODIGO
				ON b.IDFicha = d.IdFicha
				LEFT OUTER JOIN vwINSTITU f
					ON d.CONVENIO = f.vinsCODIGO
	where 
		a.IdProfesionalServicio = @i_ProfesionalServicio
	and convert(varchar(10), a.inicio,103) = convert(varchar(10), @i_fechaINICIO,103)
	order by Periodo,b.Ficha	
	
END

IF @i_OPERACION = 'R'	-- 
BEGIN
	select 1
END

IF @i_OPERACION = 'G'	-- Generar fichas para una programacion especifica
BEGIN
	select 1
END


IF @i_OPERACION = 'I'	--Insert
BEGIN
	select 1
END
IF @i_OPERACION = 'U'	--Update
BEGIN
	select 1
END
IF @i_OPERACION = 'D'	--Delete
BEGIN
	select 1
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ROL_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
EXEC usp_ROL_adm 'C',null,null,null,null,null,''
*/
CREATE PROCEDURE [dbo].[usp_ROL_adm]
	@i_OPERACION			char(1),
	@i_rolCODIGO			int			= null,
	@i_rolDESCRIPCION		varchar(20) = null,
	@i_rolFECHAHABILITACION datetime	= null,
	@i_rolVIGENCIA			bit			= null,
	@i_rolNOTAS				varchar(200)= null,
	@i_valorBUSQUEDA		varchar(100)= null
AS

declare @strCommand varchar(4000)

IF @i_OPERACION = 'L' -- Cargar
BEGIN
	set @strCommand = 
		'select rolCODIGO,rolDESCRIPCION,rolFECHAHABILITACION,rolVIGENCIA,rolNOTAS 
		 from tblROL
		 where rolDESCRIPCION LIKE ''%' + @i_valorBUSQUEDA + '%'''
	exec(@strCommand)
END
IF @i_OPERACION = 'I' -- Insertar
BEGIN
	Select 1
END

IF @i_OPERACION = 'U' -- Insertar
BEGIN
	Select 1
END

IF @i_OPERACION = 'D' -- Insertar
BEGIN
	Select 1
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SERVICIO_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec usp_SERVICIO_adm '5',null,null,null,null,null,''

CREATE PROCEDURE [dbo].[usp_SERVICIO_adm]
	@i_OPERACION	CHAR(1),
	
	@i_IDServicio		int		= null,
	@i_Vigencia			bit		= null,
	@i_TiempoConsulta	tinyint	= null,
	@i_GrupoServicio	int		= null,
	@i_cuCODIGO			int		= null,
	@i_valorBUSQUEDA	varchar(100) = null
	
AS

declare @strCommand varchar(4000)
/*
	Busquedas
	1: Busqueda en Listado de servicios vigentes
	2: Busqueda en Listado de centros de costo
*/


IF @i_OPERACION = '1'	-- Listado de servicios en conexcion con los cuadernos de estadistica
BEGIN

	set @strCommand = 
		'select *
		 from vwSERVICIO
		 where Descripcion like ''%' + @i_valorBUSQUEDA + '%''' +
		 case when (@i_Vigencia is null) then '' else 'and Vigencia = ' + convert(char(1), @i_Vigencia) end +
		 ' order by Descripcion'
		 
	print 	 @strCommand
	exec(@strCommand)		
END

IF @i_OPERACION = '2'	-- Listado de Servicios definidas para centros de costo
BEGIN

	set @strCommand = 
		'select ccctCODIGO as IDServicios,ccctDESCRI as Descripcion
		 from vwCENTROCOSTO
		 where ccctDESCRI like  ''%' + @i_valorBUSQUEDA + '%'' order by ccctDESCRI'
		 
	print 	 @strCommand
	exec(@strCommand)		
END

IF @i_OPERACION = '3'	-- Listado de cuadernos
BEGIN

	set @strCommand = 
		'select cua_CODIGO,rtrim(cua_DESCRIPCION) as cua_DESCRIPCION
		 from vwcuadernos
		 where cua_VIGENCIA = 1
		 and cua_DESCRIPCION like ''%' + @i_valorBUSQUEDA + '%'''
	exec(@strCommand)		
END

IF @i_OPERACION = '4'	-- Listado de Grupos de Servicios
BEGIN

	select * from vwGRUPOSERVICIO

END

IF @i_OPERACION = '5'	-- Listado de Servicios x Grupos de Servicios
BEGIN
	
	if @i_GrupoServicio = 0 set @i_GrupoServicio = null

	select * from vwSERVICIO
	where (grupoSERVICIO = @i_GrupoServicio or @i_GrupoServicio is null)

END


IF @i_OPERACION = '6'	--Listado de profesionales por servicio
BEGIN
	select a.IDProfesionalservicio,b.pperPATERN + ', ' + b.pperNOMBRE as Medico , c.Descripcion
	from 
		tblPROFESIONALSERVICIO a
		INNER JOIN vwPROFESIONAL b
			ON a.IdProfesional = b.IDProfesional
		INNER JOIN vwSERVICIO c
			ON a.IdServicio = c.IDServicio
	where
		a.IdServicio = @i_IDServicio
	and b.Vigencia = 1
END

IF @i_OPERACION = 'I'	--Insert
BEGIN
	BEGIN TRAN
	
	insert into tblSERVICIO
		(IDServicio,Vigencia,TiempoConsulta,cuCODIGO)
	values
		(@i_IDServicio,@i_Vigencia,@i_TiempoConsulta,@i_cuCODIGO)
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END
IF @i_OPERACION = 'U'	--Update
BEGIN
	BEGIN TRAN
	
	update tblSERVICIO
	set 
		Vigencia		= @i_Vigencia,
		TiempoConsulta	= @i_TiempoConsulta,
		cuCODIGO		= @i_cuCODIGO
	where IDServicio = @i_IDServicio
				
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END
IF @i_OPERACION = 'D'	--Delete
BEGIN
	BEGIN TRAN
	
	select TOP 5 1 
	from tblPROFESIONALSERVICIO
	where idSERVICIO = @i_IDServicio
	
	if @@ROWCOUNT > 0
	begin
		ROLLBACK TRAN
		return 2
	end
	
	delete from tblSERVICIO
	where IDServicio = @i_IDServicio
			
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[usp_SICE_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
exec usp_SICE_adm 2,3668569,'27/10/2014','N',1
*/

CREATE PROCEDURE [dbo].[usp_SICE_adm]
@i_vrecTIPDOC int,
@i_vrecNUMERO int,
@i_FechaRegistro datetime, --fecha de atencion en admision
@i_tipoTicket char(1),
@i_NoTicket	int   --no de ticket de la fecha actual de atencion en admision

/*
	se tiene el nro de orden
			 el cuaderno
			 el codigo de empresa
			 vgrucodigo(vshrecdet)
			 
*/
AS

DECLARE  
@w_empCODIGO		int,
@w_empNOMBRE		VARCHAR(100),
@w_cuCODIGO			INT,
@w_HC				INT,
@w_vrecUSRCOD		VARCHAR(20),
@w_vtpaCODIGO		INT,
@w_vrecCODCLI		INT,
@w_vrecMEDICO		INT,
@w_zon_codigo		INT,
@w_pprocodpro		INT,
@w_dep_codigo_Res	INT,
@w_pro_codigo_res	INT,
@w_mun_codigo_Res	INT,
@w_dep_codigo_Nac	INT,
@w_pro_codigo_Nac	INT,
@w_mun_codigo_Nac	INT,
@w_hcl_estciv		INT,
@w_sexo				CHAR(1),	
@w_fechaNAC			DATETIME,						--fecha de nacimiento del paciente
@w_fechaAtencion	datetime,				--Fecha de atencion en consultorio
@w_anio	int,									--edad anios
@w_mes	int,								--edad mes
@w_dia	int,									--edad dia
@w_fila INT,
@w_pro_codigo INT,		--PRO_CODIGO
@w_forCODIGO int,
@w_datDATA	int,
@w_DocyRecibo int,
@w_vdepCODIGO int,
@w_IDFicha int,
@w_IdProfesional int,
@w_IdServicio int,
@w_CodRef int
set @w_DocyRecibo = @i_vrecTIPDOC * 100000000 + @i_vrecNUMERO --- modificado aumento 0 para los recnumero

IF EXISTS (select codEstabl from bdVSH..vshReferenciaOrdenAtencion where VRECNUMERO=@i_vrecNUMERO)
BEGIN 
SET @w_CodRef = (select codEstabl from bdVSH..vshReferenciaOrdenAtencion where VRECNUMERO=@i_vrecNUMERO)
END
ELSE
BEGIN
SET @w_CodRef = 0
END

 --11181288 MODIFICADO POR AMED
-- Datos de la empresa vigente
select @w_empCODIGO = a.Emp_Codigo, @w_empNOMBRE = a.Emp_Nombre
from bdadmin..Empresas a,
	 bdadmin..Cierres b
where a.Emp_codigo = b.Emp_Codigo and b.c_vigente = 1

-- Informacion relacionada con el ticket
select	@w_IDFicha = d.IDFicha,
		@w_cuCODIGO = b.cuCODIGO,
		@w_fechaAtencion = convert(varchar(10), c.Inicio,103), 
		@w_IdProfesional = a.IdProfesional,
		@w_IdServicio = a.IdServicio
from 
	tblPROFESIONALSERVICIO a
	INNER JOIN tblSERVICIO b
		ON a.IdServicio = b.IDServicio
	INNER JOIN tblPROGRAMACION c
				INNER JOIN tblFICHAS d
					ON c.IdProgramacion = d.IDProgramacion
		ON a.IDProfesionalservicio = c.IdProfesionalservicio
where
	d.TipoTicket = @i_tipoTicket
and d.ticket = @i_NoTicket
and d.fecha = @i_FechaRegistro

-- Datos relacionados con la OA registrada previamente
select	@w_HC = a.vcliHICCLI,
		@w_vrecUSRCOD = a.vrecusrcod,
		@w_vtpaCODIGO = a.vtpacodigo,
		@w_vrecCODCLI = a.vreccodcli
from bdvsh..vshRECIBOS a, 
	 bdvsh..vshRECDET b
where a.vrectipdoc = b.vrectipdoc
and a.vrecnumero = b.vrecnumero
and a.vrectipdoc = @i_vrecTIPDOC
and a.vrecnumero = @i_vrecNUMERO
and a.emp_CODIGO = @w_empCODIGO

--select	@w_ccctCODIGO = isnull(cct_codigo,0) --FUERA
--from bdCONTA..cb_parametro_valor 
--where emp_codigo = @w_empCODIGO
--and com_anio = year(getdate())
--and par_modulo = 3
--and par_valor = @w_vgruCODIGO --vgrucodigo del arancel
--and par_parametro = 'INGRESOSGRUPO'

select @w_pro_codigo = cod5 
from bdsnis..t_gestion 
where idgestion in (year(@w_fechaAtencion)) 

select	@w_fechaNAC = hcl_FECNAC,
		@w_sexo = hcl_SEXO,
		@w_zon_codigo = zon_codigo, 
		@w_pprocodpro = pprocodpro, 
		@w_dep_codigo_Res = dep_codigo_Res, 
		@w_pro_codigo_res = pro_codigo_res, 
		@w_mun_codigo_Res = mun_codigo_Res, 
		@w_dep_codigo_Nac = dep_codigo_Nac, 
		@w_pro_codigo_Nac = pro_codigo_Nac, 
		@w_mun_codigo_Nac = mun_codigo_Nac,
		@w_hcl_estciv = hcl_estciv 
from bdESTADISTICA..se_HC 
where hcl_codigo = @w_HC 
and emp_codigo = @w_empCODIGO 
  
  
exec bdestadistica..sp_calcula_edad @w_fechaNAC,@w_fechaAtencion,@w_anio out,@w_mes out,@w_dia out,'a'

select @w_forCODIGO = for_CODIGO,@w_datDATA = dat_DATA + 1 
from bdESTADISTICA..se_cua_param 
where cua_codigo = @w_cuCODIGO

select @w_fila = isnull(max(d.dat_fila),0) + 1
from bdESTADISTICA..se_formulario f, 
	 bdESTADISTICA..se_datos d 
where f.CUA_CODIGO = @w_cuCODIGO 
and d.for_codigo = f.for_codigo
and d.dat_fecha = @w_fechaAtencion
and f.emp_codigo = @w_empCODIGO
and d.emp_codigo = @w_empCODIGO

-- Insertamos en la se_DATOS
insert into bdESTADISTICA..se_DATOS 
select	@w_fila,
		@w_forCODIGO,
		@w_fechaAtencion,
		@w_HC,
		@w_datDATA,
		@w_empCODIGO,
		@w_IdServicio,
		@w_DocyRecibo,
		@w_IdProfesional,
		@w_CodRef,0, --MODIFICADO AMED
		'N',
		0,
		@w_anio,
		@w_mes,
		@w_dia,
		@w_sexo,	
		0,
		null,
		@w_pro_codigo,
		0,
		@w_vtpaCODIGO,
		@w_vrecCODCLI,
		@w_zon_codigo,
		@w_pprocodpro,
		@w_dep_codigo_Res,
		@w_pro_codigo_res,
		@w_mun_codigo_Res,
		@w_hcl_estciv,
		@w_dep_codigo_Nac,
		@w_pro_codigo_Nac,
		@w_mun_codigo_Nac,
		NULL,
		NULL,
		NULL

-- Insertamos en la bdestadistica..tbl_SOLICITUD_HC

declare @w_error int

exec	@w_error = usp_SOLICITUDHC_adm
		@i_OPERACION				= 'G',
		@i_origenSOLICITUD			= 1,
		@i_IdFicha					= @w_IDFicha,
		@i_hclCODIGO				= @w_HC,
		@i_vrecNUMERO				=@i_vrecNUMERO,
		@i_ESTADO					= 1,
		@i_TIPOPACIENTE				= @w_vtpaCODIGO,
		@i_CONVENIO					= @w_vrecCODCLI,
		@i_funSOLICITANTE			= @w_IdProfesional,
		@i_areaSOLICITANTE			= @w_IdServicio,
		@i_usrREGISTROSOLICITUD		= @w_vrecUSRCOD,
		@i_fechaREGISTROSOLICITUD	= @w_fechaAtencion
		--@o_numerror = @o_numerror out 

GO
/****** Object:  StoredProcedure [dbo].[usp_SICE_adm2]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
exec usp_SICE_adm 2,3668569,'27/10/2014','N',1
*/

CREATE PROCEDURE [dbo].[usp_SICE_adm2]
@i_IDFicha int,
@i_HC		int,
@i_vtpaCODIGO int,
@i_vrecCODCLI int,
@i_ref_CODIGO int = '0'

AS

DECLARE  
@w_empCODIGO		int,
@w_cuCODIGO			INT,
@w_zon_codigo		INT,
@w_pprocodpro		INT,
@w_dep_codigo_Res	INT,
@w_pro_codigo_res	INT,
@w_mun_codigo_Res	INT,
@w_dep_codigo_Nac	INT,
@w_pro_codigo_Nac	INT,
@w_mun_codigo_Nac	INT,
@w_hcl_estciv		INT,
@w_sexo				CHAR(1),	
@w_fechaNAC			DATETIME,						--fecha de nacimiento del paciente
@w_fechaAtencion	datetime,				--Fecha de atencion en consultorio
@w_anio	int,									--edad anios
@w_mes	int,								--edad mes
@w_dia	int,									--edad dia
@w_fila INT,
@w_pro_codigo INT,		--PRO_CODIGO
@w_forCODIGO int,
@w_datDATA	int,
@w_DocyRecibo int,
@w_IdProfesional int,
@w_IdServicio int

set @w_DocyRecibo = 0


-- Datos de la empresa vigente
select @w_empCODIGO = a.Emp_Codigo
from bdadmin..Empresas a,
	 bdadmin..Cierres b
where a.Emp_codigo = b.Emp_Codigo and b.c_vigente = 1

-- Informacion relacionada con el ticket
select	@w_cuCODIGO = b.cuCODIGO,
		@w_fechaAtencion = convert(varchar(10), c.Inicio,103), 
		@w_IdProfesional = a.IdProfesional,
		@w_IdServicio = a.IdServicio
from 
	tblPROFESIONALSERVICIO a
	INNER JOIN tblSERVICIO b
		ON a.IdServicio = b.IDServicio
	INNER JOIN tblPROGRAMACION c
				INNER JOIN tblFICHAS d
					ON c.IdProgramacion = d.IDProgramacion
		ON a.IDProfesionalservicio = c.IdProfesionalservicio
where
	d.IDFicha = @i_IDFicha

select @w_pro_codigo = cod5 
from bdsnis..t_gestion 
where idgestion in (year(@w_fechaAtencion)) 

select	@w_fechaNAC = hcl_FECNAC,
		@w_sexo = hcl_SEXO,
		@w_zon_codigo = zon_codigo, 
		@w_pprocodpro = pprocodpro, 
		@w_dep_codigo_Res = dep_codigo_Res, 
		@w_pro_codigo_res = pro_codigo_res, 
		@w_mun_codigo_Res = mun_codigo_Res, 
		@w_dep_codigo_Nac = dep_codigo_Nac, 
		@w_pro_codigo_Nac = pro_codigo_Nac, 
		@w_mun_codigo_Nac = mun_codigo_Nac,
		@w_hcl_estciv = hcl_estciv 
from bdESTADISTICA..se_HC 
where hcl_codigo = @i_HC 
and emp_codigo = @w_empCODIGO 
  
  
exec bdestadistica..sp_calcula_edad @w_fechaNAC,@w_fechaAtencion,@w_anio out,@w_mes out,@w_dia out,'a'

select 
	@w_forCODIGO = for_CODIGO,
	@w_datDATA = dat_DATA + 1 
from bdESTADISTICA..se_cua_param 
where cua_codigo = @w_cuCODIGO

select @w_fila = isnull(max(d.dat_fila),0) + 1
from bdESTADISTICA..se_formulario f, 
	 bdESTADISTICA..se_datos d 
where f.CUA_CODIGO = @w_cuCODIGO 
and d.for_codigo = f.for_codigo
and d.dat_fecha = @w_fechaAtencion
and f.emp_codigo = @w_empCODIGO
and d.emp_codigo = @w_empCODIGO

-- Insertamos en la se_DATOS

declare @codconvenio int
IF @i_vrecCODCLI = -1
	set @codconvenio = @i_HC
else
	set @codconvenio = @i_vrecCODCLI

insert into bdESTADISTICA..se_DATOS 
select	@w_fila,
		@w_forCODIGO,
		@w_fechaAtencion,
		@i_HC,
		@w_datDATA,
		@w_empCODIGO,
		@w_IdServicio,
		@w_DocyRecibo,
		@w_IdProfesional,
		@i_ref_CODIGO,0,
		'N',
		0,
		@w_anio,
		@w_mes,
		@w_dia,
		@w_sexo,	
		0,
		null,
		@w_pro_codigo,
		0,
		@i_vtpaCODIGO,
		@codconvenio,
		@w_zon_codigo,
		@w_pprocodpro,
		@w_dep_codigo_Res,
		@w_pro_codigo_res,
		@w_mun_codigo_Res,
		@w_hcl_estciv,
		@w_dep_codigo_Nac,
		@w_pro_codigo_Nac,
		@w_mun_codigo_Nac,
		NULL,
		NULL,
		NULL

-- Insertamos en la bdestadistica..tbl_SOLICITUD_HC

declare @w_error int

IF @i_vrecCODCLI = -1
	set @codconvenio = null
else
	set @codconvenio = @i_vrecCODCLI

exec	@w_error = usp_SOLICITUDHC_adm
		@i_OPERACION				= 'G',
		@i_origenSOLICITUD			= 1,
		@i_IdFicha					= @i_IDFicha,
		@i_hclCODIGO				= @i_HC,
		@i_vrecNUMERO				= null,
		@i_ESTADO					= 3, -- Para interconsultas se envia directamente con el estado[3:Entregado]
		@i_TIPOPACIENTE				= @i_vtpaCODIGO,
		@i_CONVENIO					= @codconvenio,
		@i_funSOLICITANTE			= @w_IdProfesional,
		@i_areaSOLICITANTE			= @w_IdServicio,
		@i_usrREGISTROSOLICITUD		= '',
		@i_fechaREGISTROSOLICITUD	= @w_fechaAtencion,
		@i_usrREGISTROENTREGA		= '',
		@i_fechaREGISTROENTREGA		= @w_fechaAtencion
		
		--@o_numerror = @o_numerror out 

GO
/****** Object:  StoredProcedure [dbo].[usp_SOLICITUDHC_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec sp_SOLICITUD_adm @i_OPERACION='A', @i_empCODIGO=12,@i_ESTADO = 1, @i_origenSOLICITUD = 1, @i_destinoSOLICITUD = '133,87,46,97,88,90,146,93,135,69,143,66,92,91,99,144,131,101,96,95,130,145,86,94',@i_fecINICIAL='13/10/2014',@i_fecFINAL='13/10/2014',@i_hclCODIGO=0

CREATE proc [dbo].[usp_SOLICITUDHC_adm]
	@i_OPERACION char(1),
	@i_Id int						= null,
	@i_origenSOLICITUD int			= null,		--Origen Solicitud [1 = VentaServicios, 2 = ArchivoClinico]
	@i_IdFicha int					= null,
	@i_hclCODIGO int				= null,
	@i_vrecNUMERO int				= null,
	@i_ESTADO int					= null,		--Estado Solicitud [1 = Solicitado, 2 = Cancelado, 3 = Entregado, 4 = Devuelto]
	@i_TIPOPACIENTE int				= null,		--Tipo Paciente [1 = Institucional 4 = Convenio]
	@i_CONVENIO int					= null,		--Institucion de convenio

	@i_funSOLICITANTE int			= null,
	@i_areaSOLICITANTE int			= null,
	@i_usrREGISTROSOLICITUD varchar(20)	= null,
	@i_fechaREGISTROSOLICITUD datetime  = null,
	@i_usrREGISTROENTREGA varchar(20)	= null,
	@i_fechaREGISTROENTREGA datetime	= null,
	@i_usrREGISTRODEVOLUCION varchar(20)= null,
	@i_fechaREGISTRODEVOLUCION datetime = null,

	@i_destinoSOLICITUD varchar(1000) = null,		-- Lista de servicios a filtar
	@i_fecINICIAL varchar(10) = null,
	@i_fecFINAL	varchar(10) = null

as

	declare @gestion_VIGENTE int
	declare @strCommand varchar(4000)

			
	select @gestion_VIGENTE = c_ANIO	
	from bdadmin..ad_Cierres 
	where C_Vigente = 1

if @i_OPERACION = 'G' -- Generar nueva solicitud [sol_ESTADO=1], Generar solicitud para interconsulta [ESTADO=3]
begin 
	BEGIN TRAN
	insert tblSOLICITUDHC
			(
			origenSOLICITUD,IdFicha,hclCODIGO,vrecNUMERO,ESTADO,TIPOPACIENTE,
			CONVENIO,funSOLICITANTE,areaSOLICITANTE,usrREGISTROSOLICITUD,fechaREGISTROSOLICITUD,
			usrREGISTROENTREGA,fechaREGISTROENTREGA,usrREGISTRODEVOLUCION,fechaREGISTRODEVOLUCION			
			)
	values(
			@i_origenSOLICITUD,@i_IdFicha,@i_hclCODIGO,@i_vrecNUMERO,@i_ESTADO,@i_TIPOPACIENTE,
			case when @i_TIPOPACIENTE <> 1 then @i_CONVENIO else null end,@i_funSOLICITANTE,@i_areaSOLICITANTE,@i_usrREGISTROSOLICITUD,@i_fechaREGISTROSOLICITUD,
			@i_usrREGISTROENTREGA,@i_fechaREGISTROENTREGA,@i_usrREGISTRODEVOLUCION,@i_fechaREGISTRODEVOLUCION			
			 )
			 		 
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN			
end
if @i_OPERACION = 'C' -- Cancelar solicitud generada		[sol_ESTADO=2]
begin
	BEGIN TRAN
	
	update tblSOLICITUDHC
	set ESTADO = 2
	where Id = @i_ID
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
end
if @i_OPERACION = 'E' -- Entregar documentos solicitados	[sol_ESTADO=3]
begin
	BEGIN TRAN
	
	update tblSOLICITUDHC
	set ESTADO = @i_ESTADO,
		usrREGISTROENTREGA = @i_usrREGISTROENTREGA,
		fechaREGISTROENTREGA = @i_fechaREGISTROENTREGA
	where Id = @i_ID

	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
end
if @i_OPERACION = 'D' -- Devolver documentos entregados		[sol_ESTADO=4]
begin
	BEGIN TRAN
	
	update tblSOLICITUDHC
	set ESTADO = @i_ESTADO,
		usrREGISTRODEVOLUCION = @i_usrREGISTRODEVOLUCION,
		fechaREGISTRODEVOLUCION = GETDATE()
	where Id = @i_ID
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
end
if @i_OPERACION = 'A' -- Listar documentos
begin
	-- Dependiendo del Tipo de estado de la solicitud, este tomara campos diferentes
	declare @campoFECHA VARCHAR(50)
	select @campoFECHA = CASE @i_ESTADO	  when 1 then 'fechaREGISTROSOLICITUD'
										  when 2 then 'fechaREGISTROSOLICITUD'
										  when 3 then 'fechaREGISTROENTREGA'
										  when 4 then 'fechaREGISTRODEVOLUCION'
						 END

	if @i_hclCODIGO = 0 set @i_hclCODIGO = null

	set @strCommand =  'SELECT  
							a.Id,
							a.Estado,
							convert(varchar(10),' + rtrim(@campoFECHA) + ',103) as Fecha,
							--convert(varchar(5),' + rtrim(@campoFECHA) + ',108) as Hora,
							b.HCL_CODIGO as [No. HC],
							b.hcl_APPAT + '' '' + b.hcl_APMAT + '', '' + b.hcl_NOMBRE as Paciente,
							CASE WHEN g.Inicio is not null then 
								CASE WHEN DATEPART(HH,g.Inicio) < 12 then ''Mañana''
									 else ''Tarde''
								end
							end as [Periodo Ficha],
							f.Ficha as [No. Ficha],
							c.pperPATERN + '', '' + c.pperNOMBRE as [Profesional Medico],
							e.Descripcion,
							case a.TIPOPACIENTE when  1 then ''Institucional'' when 4 then ''Convenio'' end as [Tipo Paciente],
							case when a.TIPOPACIENTE = 4 then vinsNOMBRE end as [Inst. Convenio], 
							b.hcl_FECHA as [FecCreacion]	
						FROM	
							tblSOLICITUDHC a
								INNER JOIN vwPACIENTE b 
									ON a.hclCODIGO = b.HCL_CODIGO
								INNER JOIN vwPROFESIONAL c
									ON a.funSOLICITANTE = c.IDProfesional 
								LEFT OUTER JOIN vwINSTITU d
									ON a.CONVENIO = d.VINSCODIGO
								INNER JOIN vwSERVICIO e
									ON a.areaSOLICITANTE = e.IDServicio
								LEFT OUTER JOIN tblFICHAS f
												 INNER JOIN tblPROGRAMACION g
													ON f.IdProgramacion = g.IDProgramacion
									ON a.IdFicha = f.IDFicha
						WHERE
							CONVERT(CHAR(10),a.' + rtrim(@campoFECHA) + ',103) BETWEEN ''' + @i_fecINICIAL + ''' AND ''' + @i_fecFINAL + '''' + '	
						AND	a.origenSOLICITUD = ' + str(@i_origenSOLICITUD) + '
						AND a.areaSOLICITANTE in (' + case when @i_destinoSOLICITUD='' then '0' else @i_destinoSOLICITUD end + ')' +
						CASE WHEN @i_hclCODIGO is not null THEN ' AND a.hclCODIGO = ' + STR(@i_hclCODIGO) ELSE ' AND a.ESTADO = ' + str(@i_ESTADO) END + 
						' order by id' 
	
	print @strCommand
	exec (@strCommand)
end


GO
/****** Object:  StoredProcedure [dbo].[usp_USUARIO_adm]    Script Date: 29/08/2025 11:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
EXEC usp_USUARIO_adm 'V','sa','411431021411721411','soli'
EXEC usp_USUARIO_adm 'B',null,null,null,null,''
*/
CREATE PROCEDURE [dbo].[usp_USUARIO_adm]
	@i_OPERACION	char(1),
	@i_usuCODIGO	int				= null,
	@i_usuVIGENCIA	bit				= null,
	@i_rolCODIGO	int				= null,
	@i_USER			varchar(20)		= null,
	@i_PASSWORD		varchar(50)		= null,
	@i_valorBUSQUEDA varchar(100)	= null

AS

declare @strCommand varchar(4000)

IF @i_OPERACION = 'V' -- Valida si un usuario tiene acceso al sistema
BEGIN
	select 1 
	from vwUSUARIOS a, tblUSUARIO b
	where a.usu_CODIGO = b.usuCODIGO
	and a.usu_IDENTIFICACION = @i_USER 
	and a.usu_CLAVEUSUARIO = @i_PASSWORD
END

IF @i_OPERACION = 'L' -- Carga el listado de usuarios del SIAF
BEGIN
	set @strCommand = 
		'select usu_CODIGO, usu_NOMBREUSUARIO, usu_IDENTIFICACION
		 from vwUSUARIOS
		 where usu_NOMBREUSUARIO LIKE ''%' + @i_valorBUSQUEDA + '%'''
	exec(@strCommand)
END

IF @i_OPERACION = 'B' -- Carga el listado de usuario del biostat
BEGIN
	set @strCommand = 
		'select a.usu_CODIGO,a.usu_NOMBREUSUARIO,a.usu_IDENTIFICACION
		 from vwUSUARIOS a, tblUSUARIO b
		 where a.usu_CODIGO = b.usuCODIGO
		 and b.usuVIGENCIA = 1
		 and a.usu_NOMBREUSUARIO like ''%' + @i_valorBUSQUEDA + '%'''
	print @strCommand
	exec(@strCommand)
	
END

IF @i_OPERACION = 'I'  -- Insertar un usuario
BEGIN
	BEGIN TRAN
	
	select 1 from tblUSUARIO where usuCODIGO = @i_usuCODIGO
	IF @@ROWCOUNT > 0 
		exec usp_USUARIO_adm 'U',@i_usuCODIGO, true
	ELSE
		insert into tblUSUARIO
			(usuCODIGO,usuVIGENCIA)
		values 
			(@i_usuCODIGO,@i_usuVIGENCIA)		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END

IF @i_OPERACION = 'U' -- Actualiza estado del usuario
BEGIN
	BEGIN TRAN
	
	update tblUSUARIO
	set
		usuVIGENCIA = @i_usuVIGENCIA
	where usuCODIGO = @i_usuCODIGO
		
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END

IF @i_OPERACION = 'D' -- Actualiza estado del usuario y elimina privilegios asignados
BEGIN
	BEGIN TRAN
	
	exec usp_USUARIO_adm 'U',@i_usuCODIGO, @i_usuVIGENCIA
	delete from tblUSUARIOROL where usuCODIGO = @i_usuCODIGO	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END


--Bloque ROLES DE USUARIO

IF @i_OPERACION = '1' -- Carga roles de usuario
BEGIN
	select a.rolCODIGO,a.rolDESCRIPCION,a.rolNOTAS 
	from tblROL a, tblUSUARIOROL b
	where a.rolCODIGO = b.rolCODIGO
	and usuCODIGO = @i_usuCODIGO
END

IF @i_OPERACION = '2' -- Asigna roles a usuario
BEGIN
	BEGIN TRAN
	
	select 1 
	from tblUSUARIOROL 
	where usuCODIGO = @i_usuCODIGO 
	and rolCODIGO = @i_rolCODIGO
	if @@ROWCOUNT <= 0
		insert into tblUSUARIOROL
			(usuCODIGO,rolCODIGO,rolFECHASIGNACION,rolFECHALIBERACION)
		values
			(@i_usuCODIGO,@i_rolCODIGO,GETDATE(),null)
	
	if @@error <> 0
	begin
		--select @o_numerror = 18030 --Poner código de error
		ROLLBACK TRAN
		return 1
	end
	
	COMMIT TRAN	
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Permite registrar el tipo de Ticket [P: Preferencial, N: Normal] para que el llamado sea prioritariamente para atenciones en admision por que estos tienen el horario de atencion temprano' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblFICHAS', @level2type=N'COLUMN',@level2name=N'TipoTicket'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[7] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 56
               Left = 359
               Bottom = 161
               Right = 573
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 31
               Left = 694
               Bottom = 151
               Right = 908
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3405
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListarMañanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListarMañanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 49
               Left = 438
               Bottom = 154
               Right = 652
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 54
               Left = 770
               Bottom = 174
               Right = 984
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListarTardes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListarTardes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 111
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 114
               Left = 274
               Bottom = 234
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViMedicoMañana'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViMedicoMañana'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 111
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 114
               Left = 274
               Bottom = 234
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViMedicoTarde'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViMedicoTarde'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 111
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 114
               Left = 274
               Bottom = 234
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViObtenerIdProgMañanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViObtenerIdProgMañanas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 111
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 114
               Left = 274
               Bottom = 234
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViObtenerIdProgTardes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViObtenerIdProgTardes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[25] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[48] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblPROFESIONALSERVICIO"
            Begin Extent = 
               Top = 39
               Left = 456
               Bottom = 144
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblPROFESIONAL"
            Begin Extent = 
               Top = 24
               Left = 917
               Bottom = 144
               Right = 1115
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tblPROGRAMACION"
            Begin Extent = 
               Top = 34
               Left = 233
               Bottom = 154
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tblFICHAS"
            Begin Extent = 
               Top = 43
               Left = 0
               Bottom = 163
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tblSERVICIO"
            Begin Extent = 
               Top = 28
               Left = 706
               Bottom = 148
               Right = 904
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViPrintFicha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViPrintFicha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViPrintFicha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 126
               Right = 485
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 523
               Bottom = 126
               Right = 720
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 758
               Bottom = 126
               Right = 934
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 972
               Bottom = 126
               Right = 1152
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwBIOFICHAS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'20
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwBIOFICHAS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwBIOFICHAS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SE_CUADERNO (bdESTADISTICA.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCUADERNOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCUADERNOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblLISTAGENERICA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwESTADOFICHA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwESTADOFICHA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ad_listagenerica (bdADMIN.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1665
         Width = 10050
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFUNCIONHOSPITALARIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwFUNCIONHOSPITALARIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblLISTAGENERICA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGRUPOSERVICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGRUPOSERVICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VSHINSTITU (bdVSH.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwINSTITU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwINSTITU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 35
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPERSONA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPERSONA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[26] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "perProfesi (bdRRHH.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 96
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3150
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPROFESION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPROFESION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 658
               Bottom = 204
               Right = 856
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 12
               Left = 42
               Bottom = 269
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 12
               Left = 347
               Bottom = 146
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2175
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 750
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSERVICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSERVICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ad_Usuarios (bdADMIN.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3645
         Width = 2640
         Width = 4440
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUSUARIOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUSUARIOS'
GO
