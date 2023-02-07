## Create schema
CREATE SCHEMA `local`;

## Create table
CREATE TABLE `local`.`test1` (
  `idproduct` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(100) NOT NULL,
  `manufacturer` VARCHAR(100) NOT NULL,
  `product_count` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idproduct`),
  UNIQUE INDEX `idproduct_UNIQUE` (`idproduct` ASC) VISIBLE);

## Fill table
INSERT INTO test1 (product_name, manufacturer, product_count, price) VALUES
('iphone8', 'APPLE', 9, 1000),
('iphoneX', 'APPLE', 12, 1500),
('iphone11', 'APPLE', 5, 1600),
('X5', 'SAMSUNG', 7, 1000),
('X6', 'SAMSUNG', 9, 1200),
('W2', 'HUAWEY', 7, 900),
('W8', 'HUAWEY', 2, 1000),
('A3', 'BLACKBERRY', 3, 450.35);

## Select from table
## 2.
SELECT product_name, manufacturer, price FROM test1 WHERE product_count > 2;
## 3.
SELECT * FROM test1 WHERE manufacturer = 'SAMSUNG';
## 4.1.
SELECT * FROM test1 WHERE product_name LIKE '%iphone%' or manufacturer LIKE '%iphone%';
## 4.2.
SELECT * FROM test1 WHERE product_name LIKE '%SAMSUNG%' or manufacturer LIKE '%SAMSUNG%';
## 4.3.
SELECT * FROM test1 WHERE product_name REGEXP '[0-9]';
## 4.4.
SELECT * FROM test1 WHERE product_name REGEXP '[8]';

