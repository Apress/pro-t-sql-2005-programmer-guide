-- Listing 7-6 from Chapter 7
USE AdventureWorks;
GO
-- DDL Trigger example
IF OBJECT_ID('Trg_CreateTable') IS NOT NULL
    DROP TRIGGER Trg_CreateTable;
GO
CREATE TRIGGER Trg_CreateTable
ON DATABASE
FOR CREATE_TABLE
AS 
BEGIN
    DECLARE @event_data XML;
    SELECT @event_data = EVENTDATA();
    DECLARE @event_type NVARCHAR(2000); 
    DECLARE @firing_command NVARCHAR(2000);
    SELECT @event_type = @event_data.value(N'(/EVENT_INSTANCE/EventType)[1]', 
        N'NVARCHAR(2000)');
    SELECT @firing_command = @event_data.value( 
        N'(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', N'NVARCHAR(2000)');
    PRINT N'Event type = ' + @event_type;
    PRINT N'Command that fired this trigger = ' + @firing_command;
    PRINT N'Event data = ' + CAST(@event_data AS NVARCHAR(MAX));
END
GO
--Test the trigger.
CREATE TABLE NewTable (Column1 INT NOT NULL PRIMARY KEY);
GO
-- Drop the table.
DROP TABLE NewTable;
GO
--Drop the trigger.
DROP TRIGGER Trg_CreateTable
ON DATABASE;
GO
