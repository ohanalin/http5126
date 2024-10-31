--  LAB 8 CRUD
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
CREATE TABLE customer (
    email VARCHAR(255),
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (email)
);

-- B 
CREATE TABLE supplier (
    supplier_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (supplier_id)
);

-- C 
CREATE TABLE `order` (
    order_id INT AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (email) REFERENCES customer (email)
);

-- D
CREATE TABLE product (
    product_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    brand VARCHAR(255) NOT NULL,
    supplier_id INT,
    PRIMARY KEY (product_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
);

-- E 
CREATE TABLE order_product (
    order_id INT,
    product_id INT,
    PRIMARY KEY (order_id,product_id),
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


--  2 
-- A 
INSERT INTO customer (email, name)
VALUES ('john@gmail.com', 'John'),
('jane@gmail.com', 'Jane'),
('alice@gmail.com', 'Alice');
-- B 
INSERT INTO supplier (name,location)
VALUES ('XYZ Electronics', 'Toronto'),
('ABC Gadgets', 'Montreal'),
('XYZ Furniture', 'Vancouver');

-- C 
INSERT INTO `order` (email)
VALUES ('john@gmail.com'),
('jane@gmail.com'),
('john@gmail.com'),
('alice@gmail.com');
-- D
INSERT INTO product (name, price,brand,supplier_id)
VALUES ('Laptop',800,'Dell',1),
('Smartphone',600,'Apple',2),
('Smartphone',600,'Samsung',2),
('Camera',300,'Canon',1),
('Chair',100,'Herman Miller',3);
-- E 
INSERT INTO order_product (order_id , product_id)
VALUES (1,1),
(2,2),
(2,3),
(3,4),
(4,5);

--  3 
-- A 

-- B 


--  4 
-- A 

-- B 

-- C 

-- D

