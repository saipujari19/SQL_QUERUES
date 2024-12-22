# Stored procedures are created using the CREATE PROCEDURE statement.

# using the previsously created data base
use fruitshop;

#1 example of creating a stored procedure. Running the following code against our FruitShop database will create a stored procedure called spCheckFruitStock

DELIMITER //

CREATE PROCEDURE spCheckFruitStock(thisFruit SMALLINT)
BEGIN
	SELECT 
		Fruit.FruitName, 
		Fruit.Inventory, 
		Units.UnitName
	FROM 
		Fruit INNER JOIN Units ON
		Fruit.UnitId = Units.UnitId
	WHERE 
		Fruit.FruitId = thisFruit;
END //

DELIMITER ;

#2 calling the created store procedure

CALL spCheckFruitStock(1);

#3 altering the store procedure

DROP PROCEDURE IF EXISTS spCheckFruitStock; #droping the created store procedure

DELIMITER //

CREATE PROCEDURE spCheckFruitStock(thisFruit SMALLINT)
BEGIN
	SELECT 
		Fruit.FruitId, 
		Fruit.FruitName, 
		Fruit.Inventory, 
		Units.UnitName
	FROM 
		Fruit INNER JOIN Units ON
		Fruit.UnitId = Units.UnitId
	WHERE 
		Fruit.FruitId = thisFruit;
END //

DELIMITER ;

#4 more about store procedure example for the created fruit shop database.

DROP PROCEDURE IF EXISTS spCheckFruitStockLevel;

DELIMITER //

CREATE PROCEDURE spCheckFruitStockLevel(
	IN pFruitId SMALLINT(5),
    OUT pStockLevel VARCHAR(6))
BEGIN
	DECLARE stockNumber SMALLINT;
    
	SELECT 
		Fruit.Inventory into stockNumber
	FROM 
		Fruit INNER JOIN Units ON
		Fruit.UnitId = Units.UnitId
	WHERE 
		Fruit.FruitId = pFruitId;
        
	IF stockNumber > 10 THEN
		SET pStockLevel = 'High';
    ELSEIF (stockNumber <= 10 AND stockNumber >= 5) THEN
		SET pStockLevel = 'Medium';
    ELSEIF (stockNumber < 5) THEN
		SET pStockLevel = 'Low - Please Replace Now!';
	END IF;
    
END //

DELIMITER ;

# 5 Calling a Stored Procedure with an OUT or INOUT Parameter

CALL spCheckFruitStockLevel(1, @stockLevel);
select @stockLevel;