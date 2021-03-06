USE [dbAdmin]
GO
/****** Object:  StoredProcedure [dbo].[AggregatePerformanceCounters]    Script Date: 2014-06-04 10:50:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AggregatePerformanceCounters]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AggregatePerformanceCounters]
GO
/****** Object:  StoredProcedure [dbo].[AggregatePerformanceCounters]    Script Date: 2014-06-04 10:50:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AggregatePerformanceCounters]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AggregatePerformanceCounters] AS' 
END
GO
ALTER PROCEDURE [dbo].[AggregatePerformanceCounters](@collectionInterval INT=10,@aggregationInterval INT =1800)

AS

SET NOCOUNT ON;

BEGIN TRAN;

/*
 @collectionInterval --in seconds
 @aggregationInterval --in seconds
*/

DECLARE @numberOfRecords int=@aggregationInterval/@collectionInterval;  --number of records per aggregation set. 

DECLARE @rowData Table
(
RecordIndex Int,
GUID varchar(1024) Not Null,
CounterID int Not Null,
MachineName varchar(1024) Not Null,
ObjectName varchar(1024) Not Null,
CounterName varchar(1024) Not Null,
InstanceName varchar(1024) Null,
CounterDateTime DateTime Not Null,
CounterValue float Null,
AggregationSet Int Not Null
);

Insert @rowData
SELECT data.RecordIndex,data.GUID,data.CounterID,details.MachineName,details.ObjectName,details.CounterName,details.InstanceName,CONVERT(DateTime,LEFT(data.CounterDateTime,23),121) 'CounterDateTime',data.CounterValue
,((data.RecordIndex -1)/ @numberOfRecords)+1 as 'AggregationSet'
FROM CounterDetails details WITH (NOLOCK) JOIN CounterData data WITH(NOLOCK) on details.CounterID=data.CounterID;


INSERT PerformanceCountersAggregation
Select MachineName,ObjectName,CounterName,InstanceName,AggregationSet,Max(CounterDateTime) as 'AggregationSetDateTime'
,Min(counterValue) as 'MinimumValue', Max(counterValue) as 'MaximumValue', Avg(counterValue) as 'AvgerageValue'
FROM @rowData
Where AggregationSet < (Select Max(AggregationSet) from @rowData)
GROUP BY MachineName,ObjectName,CounterName,InstanceName,AggregationSet
ORDER BY AggregationSet,MachineName,ObjectName,CounterName,InstanceName;


DELETE dbo.CounterData
FROM dbo.CounterData data JOIN @rowData tmpData
ON data.CounterID=tmpData.CounterID AND data.RecordIndex=tmpData.RecordIndex;

COMMIT TRAN;
GO
