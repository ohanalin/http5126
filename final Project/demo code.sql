1. Update Expiry Date for Soap sql 

UPDATE soap
SET expire_date = DATE_ADD(produce_date, INTERVAL 2 YEAR);

---------------------------------------------------------------

2. Add Foreign Key Constraint Between soap and soap_recipe

ALTER TABLE soap 
ADD CONSTRAINT fk_soap_recipe_id 
FOREIGN KEY (soap_recipe_id) REFERENCES soap_recipe(soap_recipe_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

---------------------------------------------------------------

3. Add Foreign Key Constraint Between sale and soap

ALTER TABLE sale 
ADD CONSTRAINT fk_sale_soap_id 
FOREIGN KEY (soap_id) REFERENCES soap(soap_id) 
ON DELETE CASCADE ON UPDATE CASCADE;


---------------------------------------------------------------

4. Trigger to Reduce Inventory After a Sale

DELIMITER $$
CREATE TRIGGER after_sale_insert 
AFTER INSERT ON sale 
FOR EACH ROW 
BEGIN 
    UPDATE soap 
    SET inventory = inventory - 1 
    WHERE soap_id = NEW.soap_id; 
END$$ 
DELIMITER ;

---------------------------------------------------------------

5. Add Default Timestamp to Alert

ALTER TABLE low_inventory_alert
ADD alert_date DATETIME DEFAULT CURRENT_TIMESTAMP;

---------------------------------------------------------------

6. Add Foreign Key Constraint Between low_inventory_alert and soap

ALTER TABLE low_inventory_alert
ADD CONSTRAINT fk_soap_id 
FOREIGN KEY (soap_id) REFERENCES soap(soap_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

---------------------------------------------------------------

7. Trigger to Insert Low Inventory Alert

DELIMITER $$
CREATE TRIGGER low_inventory_alert 
AFTER UPDATE ON soap 
FOR EACH ROW 
BEGIN 
    -- Check if the inventory is lower than 10 after the update 
    IF NEW.inventory < 10 THEN 
        -- Insert a new record into low_inventory_alert table 
        INSERT INTO low_inventory_alert (soap_id, alert_date) 
        VALUES (NEW.soap_id, NOW()); 
    END IF; 
END$$ 
DELIMITER ;

---------------------------------------------------------------
8. Inserts a new record into the sale table, automatically generating a unique sale_id while associating the user with ID 5 and the soap product with ID 9.

INSERT INTO `sale` (`sale_id`, `user_id`, `soap_id`) VALUES (NULL, '3', '7');