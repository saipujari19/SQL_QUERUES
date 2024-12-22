DROP DATABASE IF EXISTS FruitShop; # using drop statement in creation of data base and it's created.
CREATE DATABASE FruitShop; # creating the required data base 
USE FruitShop; # using the created database fruitshop.

#  select statements to select everything from the table.
select * from units;
select * from fruit;

# creating the table units and used primary key to make certain data unique.

CREATE TABLE Units (
UnitId TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
UnitName VARCHAR(10) NOT NULL,
DateEntered DATETIME NOT NULL,
DateUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (UnitId)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

# creating the table fruit and used primary key to make certain data unique.
CREATE TABLE Fruit (
FruitId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
FruitName VARCHAR(45) NOT NULL, 
Inventory SMALLINT UNSIGNED NOT NULL,
UnitId TINYINT UNSIGNED NOT NULL,
DateEntered DATETIME NOT NULL,
DateUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (FruitId),
CONSTRAINT fkFruitUnits FOREIGN KEY (UnitId) REFERENCES Units (UnitId) ON DELETE RESTRICT ON UPDATE CASCADE 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


# we added a foreign key constraint to the Fruit table. Here's the code we used to create the constraint:
# CONSTRAINT fkFruitUnits FOREIGN KEY (UnitId) REFERENCES Units (UnitId) ON DELETE RESTRICT ON UPDATE CASCADE

# inserting the data into the tables that has been created earlier using the insert statement.
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
(6,'Strawberry',12,7,'2015-02-15 10:30:00','2015-02-15 10:30:00')
;

# disabling foreign key using this command.
SET FOREIGN_KEY_CHECKS = 0;


# enabling foreign key using this command.
SET FOREIGN_KEY_CHECKS = 1;





