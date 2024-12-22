show databases;
use fruitshop;
Describe fruit;
INSERT INTO Units 
VALUES 
(1,'Piece','2015-02-15 10:30:00','2015-02-15 10:30:00'),
(2,'Kilogram','2015-02-15 10:30:00','2015-02-15 10:30:00'),
(3,'Gram','2015-02-15 10:30:00','2015-02-15 10:30:00'),
(4,'Pound','2015-02-15 10:30:00','2015-02-15 10:30:00'),
(5,'Ounce','2015-02-15 10:30:00','2015-02-15 10:30:00'),
(6,'Bunch','2015-02-15 10:30:00','2015-02-15 10:30:00'),
(7,'Container','2015-02-15 10:30:00','2015-02-15 10:30:00');
	
INSERT INTO Fruit 
VALUES 
(1,'Apple',10,1,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
(2,'Orange',5,2,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
(3,'Banana',20,6,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
(4,'Watermelon',10,1,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
(5,'Grapes',15,6,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
(6,'Strawberry',12,7,'2015-02-15 10:30:00','2015-02-15 10:30:00');

-- select * from Fruit

select * from Units;

UPDATE Fruit
SET UnitId = 2
 WHERE FruitId = 1;
 
 UPDATE Fruit
SET UnitId = 2
WHERE FruitName = 'Apple' AND UnitId = 1;

select * from Fruit;

UPDATE Fruit
SET UnitId = 2
WHERE FruitName = 'Apple';

UPDATE Fruit
SET FruitName = 'Banana';

set sql_safe_updates = 0;
set sql_safe_updates = 1;

set sql_safe_updates = 0;

UPDATE Fruit
SET UnitId = 2
WHERE FruitName = 'Apple';

select * from Fruit;

set sql_safe_updates = 1;

UPDATE Fruit
SET FruitName = 'Red Grapes', Inventory = '11'
WHERE FruitId = 5;

DELETE
            FROM Fruit
            WHERE FruitId = 5;


SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;


