USE [dbAdmin]
GO
/****** Object:  Index [IX_PerformanceCountersAggregation_ObjectName]    Script Date: 2014-06-04 10:50:54 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_ObjectName')
DROP INDEX [IX_PerformanceCountersAggregation_ObjectName] ON [dbo].[PerformanceCountersAggregation]
GO
/****** Object:  Index [IX_PerformanceCountersAggregation_MachineName]    Script Date: 2014-06-04 10:50:54 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_MachineName')
DROP INDEX [IX_PerformanceCountersAggregation_MachineName] ON [dbo].[PerformanceCountersAggregation]
GO
/****** Object:  Index [IX_PerformanceCountersAggregation_Counter_Instance]    Script Date: 2014-06-04 10:50:54 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_Counter_Instance')
DROP INDEX [IX_PerformanceCountersAggregation_Counter_Instance] ON [dbo].[PerformanceCountersAggregation]
GO
/****** Object:  Index [IX_PerformanceCountersAggregation_AggregationSetDate]    Script Date: 2014-06-04 10:50:54 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_AggregationSetDate')
DROP INDEX [IX_PerformanceCountersAggregation_AggregationSetDate] ON [dbo].[PerformanceCountersAggregation] WITH ( ONLINE = OFF )
GO
/****** Object:  Table [dbo].[PerformanceCountersAggregation]    Script Date: 2014-06-04 10:50:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND type in (N'U'))
DROP TABLE [dbo].[PerformanceCountersAggregation]
GO
/****** Object:  Table [dbo].[PerformanceCountersAggregation]    Script Date: 2014-06-04 10:50:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PerformanceCountersAggregation](
	[MachineName] [varchar](50) NOT NULL,
	[ObjectName] [varchar](50) NOT NULL,
	[CounterName] [varchar](128) NOT NULL,
	[InstanceName] [varchar](128) NULL,
	[AggregationSet] [int] NOT NULL,
	[AggregationSetDateTime] [datetime] NOT NULL,
	[MinimumValue] [float] NULL,
	[MaximumValue] [float] NULL,
	[AvgerageValue] [float] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_PerformanceCountersAggregation_AggregationSetDate]    Script Date: 2014-06-04 10:50:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_AggregationSetDate')
CREATE CLUSTERED INDEX [IX_PerformanceCountersAggregation_AggregationSetDate] ON [dbo].[PerformanceCountersAggregation]
(
	[AggregationSetDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PerformanceCountersAggregation_Counter_Instance]    Script Date: 2014-06-04 10:50:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_Counter_Instance')
CREATE NONCLUSTERED INDEX [IX_PerformanceCountersAggregation_Counter_Instance] ON [dbo].[PerformanceCountersAggregation]
(
	[CounterName] ASC,
	[InstanceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PerformanceCountersAggregation_MachineName]    Script Date: 2014-06-04 10:50:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_MachineName')
CREATE NONCLUSTERED INDEX [IX_PerformanceCountersAggregation_MachineName] ON [dbo].[PerformanceCountersAggregation]
(
	[MachineName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PerformanceCountersAggregation_ObjectName]    Script Date: 2014-06-04 10:50:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PerformanceCountersAggregation]') AND name = N'IX_PerformanceCountersAggregation_ObjectName')
CREATE NONCLUSTERED INDEX [IX_PerformanceCountersAggregation_ObjectName] ON [dbo].[PerformanceCountersAggregation]
(
	[ObjectName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
