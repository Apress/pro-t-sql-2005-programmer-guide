-- Listing 12-26 from Chapter 12
USE AdventureWorks;
GO

DECLARE @x xml;
SET @x = N'<?xml version = "1.0"?>
<Root>
    <NodeA>Test Node</NodeA>
    <NodeA>Test Node</NodeA>
    <NodeB>Test Node</NodeB>
</Root>';
SELECT @x.query('((/Root/NodeA)[1] is (//NodeA)[1])     (: true :)');
SELECT @x.query('((/Root/NodeA)[1] is (/Root/NodeA)[2]) (: false :)');
SELECT @x.query('((/Root/NodeA)[2] << (/Root/NodeB)[1]) (: true :)');
GO