-- Listing 12-29 from Chapter 12
USE AdventureWorks;
GO

/* 10% discount */
DECLARE @discount NUMERIC(3, 2);
SELECT @discount = 0.10;
DECLARE @x xml;
SELECT @x = N'';
SELECT @x.query(N'<Product>
    <Model-ID> 
        {
            sql:column("ProductModelID") 
        }
    </Model-ID>
    <Name>
        { 
            sql:column("Name") 
        }
    </Name>
    <Price> 
        { 
            sql:column("ListPrice") 
        }
    </Price>
    <DiscountPrice>
        {
            sql:column("ListPrice") - (sql:column("ListPrice") * sql:variable("@discount") ) 
        }
    </DiscountPrice>
</Product>')
FROM Production.Product p
WHERE ProductModelID = 30;
GO