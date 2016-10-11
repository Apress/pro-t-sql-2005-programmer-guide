-- Listing 12-28 from Chapter 12
USE AdventureWorks;
GO

DECLARE @x xml;
SELECT @x = N'';
SELECT @x.query(N'<Name>
    <ID>
        {
            sql:column("p.ContactID")
        }
    </ID>
    <FullName>
        {
            sql:column("p.FirstName"),
            sql:column("p.MiddleName"),
            sql:column("p.LastName") 
        }
    </FullName>
</Name>')
FROM Person.Contact p
WHERE p.ContactID <= 5
ORDER BY p.ContactID;
GO