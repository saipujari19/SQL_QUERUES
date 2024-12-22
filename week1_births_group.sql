CREATE DATABASE IF NOT EXISTS Births;
USE Births;
CREATE TABLE IF NOT EXISTS BirthData (
    Birtg_ID INT AUTO_INCREMENT PRIMARY KEY,      
	Birth_Month INT NOT NULL,                
    Birth_Day INT NOT NULL,  
    Birth_Year INT NOT NULL,
    Gender ENUM('M', 'F'),
    Weight FLOAT,                           
    City VARCHAR(50),                     
    State VARCHAR(50),                     
    Country VARCHAR(50)                    
);
