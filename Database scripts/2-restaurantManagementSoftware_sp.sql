  SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=1;
  SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;
  SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
  SET TIME_ZONE = "+00:00";

  /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
  /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
  /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
  /*!40101 SET NAMES utf8 */;

  -- ---------------------------------------------------------------------------
  -- Creation database
  -- ---------------------------------------------------------------------------
  DROP DATABASE IF EXISTS `restaurantManagementSoftware`;
  CREATE DATABASE IF NOT EXISTS `restaurantManagementSoftware`;
  USE `restaurantManagementSoftware`;

  DELIMITER GO

  ALTER DATABASE  `restaurantManagementSoftware` DEFAULT CHARACTER SET latin2 COLLATE latin2_general_ci;
  GO 

  -- ---------------------------------------------------------------------------
  -- Drop tables
  -- ---------------------------------------------------------------------------
  DROP TABLE IF EXISTS `supplier`
  GO
  DROP TABLE IF EXISTS `product_category`
  GO
  DROP TABLE IF EXISTS `users_restaurants`
  GO
  DROP TABLE IF EXISTS `login_attempts`
  GO
  DROP TABLE IF EXISTS `users`
  GO
  DROP TABLE IF EXISTS `restaurant`
  GO
  DROP TABLE IF EXISTS `product`
  GO
  DROP TABLE IF EXISTS `supplier_product`
  GO
  DROP TABLE IF EXISTS `order_list`
  GO
  DROP TABLE IF EXISTS `purchase_orders`
  GO
  DROP TABLE IF EXISTS `PO_item`
  GO


  -- ---------------------------------------------------------------------------
  -- Table supplier
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `supplier` (
    `id_supplier` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `contact_name` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(14) NOT NULL,
    `fax_number` VARCHAR(14),
    PRIMARY KEY (`id_supplier`)
  ) ENGINE=InnoDB  DEFAULT CHARSET=latin2 AUTO_INCREMENT=5;
  GO

  -- ---------------------------------------------------------------------------
  -- Table product_category
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `product_category` (
    `id_category` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `parent` INT(11), 
    `orderof` INT(11) NOT NULL,
    UNIQUE (`orderof`),
    PRIMARY KEY (`id_category`),
    CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `product_category` (`id_category`) ON DELETE SET NULL
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table restaurant
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `restaurant` (
    `id_restaurant` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `address` VARCHAR(250),
    PRIMARY KEY (`id_restaurant`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table users
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `users` (
    `id_user` INT(11) NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL UNIQUE,
    `name` VARCHAR(75) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `password` CHAR(128) NOT NULL,
    `salt` CHAR(128) NOT NULL,
    `session_id` CHAR(128),
    `session_expiry_time` INT(25),
    `location_selected` INT(11),
    PRIMARY KEY (`id_user`),
    CONSTRAINT `location_selected_users_ibfk_1` FOREIGN KEY (`location_selected`) REFERENCES `restaurant` (`id_restaurant`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table login_attempts
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `login_attempts` (
    `id_user` INT(11) NOT NULL,
    `time_of_attempt` VARCHAR(30) NOT NULL,
    `ip_address` VARCHAR(30) DEFAULT 'n/a',
    KEY `id_user` (`id_user`),
    CONSTRAINT `login_attempts_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table users_restaurants
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `users_restaurants` (
    `id_restaurant` INT(11) NOT NULL,
    `id_user` INT(11) NOT NULL,
    PRIMARY KEY (`id_restaurant`, `id_user`),
    CONSTRAINT `users_restaurants_ibfk_1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id_restaurant`),
    CONSTRAINT `users_restaurants_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table product
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `product` (
    `id_product` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `id_category` INT(11) NOT NULL,
    `unitOfMeasurement` VARCHAR(30) NOT NULL,
   PRIMARY KEY (`id_product`),
   CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `product_category` (`id_category`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO
  
  -- ---------------------------------------------------------------------------
  -- Table supplier_product
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `supplier_product` (
    `id_product` INT(11) NOT NULL,
    `id_supplier` INT(11) NOT NULL,
    `price` REAL NOT NULL,
    `unitOfMeasurement` VARCHAR(30) NOT NULL,
   PRIMARY KEY (`id_product`, `id_supplier`),
   CONSTRAINT `supplier_product_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
   CONSTRAINT `supplier_supplier_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table order_list
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `order_list` (
    `id_order` INT(11) NOT NULL AUTO_INCREMENT,
    `id_restaurant` INT(11) NOT NULL,
    `dateCreated` DATETIME NOT NULL,

    `subtotal` INT(11), -- sum of of subtotal of each PO
    `taxes` INT(11), -- sum of all taxes of each PO
    `totalCost` INT(11), -- sum of of total of each PO
    `shippingCost` INT(11), -- sum of of shipping of each PO

    `state` INT(3), -- 0: saved, 1: ordered
   PRIMARY KEY (`id_order`),
   CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id_restaurant`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table purchase_orders
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `purchase_orders` (
    `po_Number` VARCHAR(20) NOT NULL UNIQUE,
    `id_order` INT(11) NOT NULL,
    `id_supplier` INT(11) NOT NULL,

    `dateOrdered` DATETIME NOT NULL,
    `dateDelivered` DATETIME NOT NULL,
    `subtotal` INT(11),
    `taxes` INT(11),
    `shippingCost` INT(11),
    `totalCost` INT(11),
    `state` INT(3), -- 0: order, 1: shipped, 2: received

    PRIMARY KEY (`po_Number`),
    CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `order_list` (`id_order`),
    CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO

  -- ---------------------------------------------------------------------------
  -- Table PO_item
  -- ---------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `PO_item` (
    `id_product` INT(11) NOT NULL,
    `po_Number` VARCHAR(20) NOT NULL,
    `qty` INT(11) NOT NULL,
    `costPerUnit` DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (`id_product`, `po_Number`),
    CONSTRAINT `PO_item_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
    CONSTRAINT `PO_item_ibfk_2` FOREIGN KEY (`po_Number`) REFERENCES `purchase_orders` (`po_Number`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin2;
  GO
  DELIMITER ;

  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
  /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;










































USE `restaurantManagementSoftware`;

DELIMITER GO

-- ---------------------------------------------------------------------------------------
-- Views
-- ---------------------------------------------------------------------------------------
-- -----------------------------------------------------
-- View `v_getSuppliers`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getSuppliers`
GO
CREATE VIEW v_getSuppliers
AS
	SELECT id_supplier, name, contact_name, phone_number, fax_number
	FROM supplier;
GO

-- -----------------------------------------------------
-- View `v_getProductCategories`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getProductCategories`
GO
CREATE VIEW v_getProductCategories
AS
	SELECT P.id_category, P.name, P.parent, PA.name AS parent_name, P.orderof
	FROM product_category P LEFT JOIN product_category PA
	ON P.parent = PA.id_category;
GO

-- -----------------------------------------------------
-- View `v_getProducts`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getProducts`
GO
CREATE VIEW v_getProducts
AS
	SELECT p.id_product, p.name AS p_name, p.id_category, pc.name AS pc_name, p.unitOfMeasurement
	FROM product p LEFT JOIN product_category pc ON p.id_category = pc.id_category;
GO

-- -----------------------------------------------------
-- View `v_getSuppliersProducts`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getSuppliersProducts`
GO
CREATE VIEW v_getSuppliersProducts
AS
	SELECT sp.id_product, p.name AS pname, sp.id_supplier, s.name AS sname, sp.unitOfMeasurement, sp.price
	FROM supplier_product sp LEFT JOIN product p ON sp.id_product = p.id_product
							LEFT JOIN supplier s ON sp.id_supplier = s.id_supplier;
GO

-- -----------------------------------------------------
-- View `v_getRestaurants`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getRestaurants`
GO
CREATE VIEW v_getRestaurants
AS
	SELECT R.id_restaurant, R.name, R.address
	FROM restaurant R;
GO

-- -----------------------------------------------------
-- View `v_getRestaurantsUsers`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getRestaurantsUsers`
GO
CREATE VIEW v_getRestaurantsUsers
AS
	SELECT R.id_restaurant, R.name AS name_restaurant, U.id_user, U.name AS name_user, NULL AS is_check
	FROM restaurant R 
		LEFT JOIN users_restaurants UR ON R.id_restaurant = UR.id_restaurant
		LEFT JOIN users U ON U.id_user = UR.id_user
	ORDER BY R.id_restaurant;
GO

-- -----------------------------------------------------
-- View `v_getOrderList`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getOrderList`
GO
CREATE VIEW v_getOrderList
AS
	SELECT OL.id_order, OL.id_restaurant, R.name as nameRestaurant,
	 OL.dateCreated, OL.subtotal, OL.shippingCost, OL.taxes, OL.totalCost, OL.state
	FROM order_list OL
		LEFT JOIN restaurant R ON OL.id_restaurant = R.id_restaurant
GO

-- -----------------------------------------------------
-- View `v_getRestaurantOrderList`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getRestaurantOrderList`
GO
CREATE VIEW v_getRestaurantOrderList
AS
	SELECT OL.id_order, OL.id_restaurant, R.name as restaurantName, OL.dateCreated,
	OL.subtotal, OL.shippingCost, OL.taxes, OL.totalCost
	FROM order_list OL
		LEFT JOIN restaurant R ON OL.id_restaurant = R.id_restaurant
GO

-- -----------------------------------------------------
-- View `v_getPurchaseOrders`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getPurchaseOrders`
GO
CREATE VIEW v_getPurchaseOrders
AS
	SELECT PO.po_Number, PO.id_order, PO.id_supplier, S.name as supplierName
	FROM purchase_orders PO
		LEFT JOIN supplier S ON PO.id_supplier = S.id_supplier
GO

-- -----------------------------------------------------
-- View `v_getPOItems`
-- -----------------------------------------------------	
DROP VIEW IF EXISTS `v_getPOItems`
GO
CREATE VIEW v_getPOItems
AS
	SELECT PO.id_product, PO.po_Number, PO.qty, PO.costPerUnit
	FROM PO_item PO
GO


-- ---------------------------------------------------------------------------------------
-- Stored Procedures
-- ---------------------------------------------------------------------------------------
-- -----------------------------------------------------
-- Stored Procedure `sp_getSupplier`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getSupplier`
GO
CREATE PROCEDURE sp_getSupplier(
    IN s_supplier_id INT
)
BEGIN
 	SELECT id_supplier, name, contact_name, phone_number, fax_number
 	FROM supplier
 	WHERE id_supplier = s_supplier_id;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_deleteSupplier`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteSupplier`
GO
CREATE PROCEDURE sp_deleteSupplier(
	IN s_supplier_id INT(11)
)
BEGIN
	IF EXISTS (SELECT * FROM supplier WHERE id_supplier = s_supplier_id) THEN
		DELETE FROM supplier 
		WHERE id_supplier = s_supplier_id;
	ELSE
		CALL raise_error;
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveSupplier`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveSupplier`
GO
CREATE PROCEDURE sp_saveSupplier(
	IN s_id_supplier INT(11),
	IN s_name VARCHAR(100),
	IN s_contact_name VARCHAR(100),
	IN s_phone_number VARCHAR(14),
	IN s_fax_number VARCHAR(14)
)
BEGIN
	IF EXISTS (SELECT * FROM supplier WHERE id_supplier = s_id_supplier) THEN
		UPDATE supplier SET	
			name = s_name,
			contact_name = s_contact_name,
			phone_number = s_phone_number,
			fax_number = s_fax_number
		WHERE id_supplier = s_id_supplier;
	ELSE
		INSERT INTO `supplier` (`name`, `contact_name`, `phone_number`, `fax_number`) 
		VALUES (s_name, s_contact_name, s_phone_number, s_fax_number);
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getUser`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getUser`
GO
CREATE PROCEDURE sp_getUser(
    IN u_username VARCHAR(30)
)
BEGIN
 	SELECT DISTINCT *
 	FROM users
 	WHERE u_username COLLATE latin2_general_ci = username COLLATE latin2_general_ci;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getSalt`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getSalt`
GO
CREATE PROCEDURE sp_getSalt(
    IN u_username VARCHAR(30)
)
BEGIN
 	SELECT salt
 	FROM users
 	WHERE username = u_username;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getPassword`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getPassword`
GO
CREATE PROCEDURE sp_getPassword(
    IN u_username VARCHAR(30)
)
BEGIN
 	SELECT password
 	FROM users
 	WHERE username = u_username;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_deleteUser`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteUser`
GO
CREATE PROCEDURE sp_deleteUser(
	IN u_user_id INT
)
BEGIN
	DELETE FROM users 
	WHERE id_user = u_user_id;
	DELETE FROM login_attempts 
	WHERE id_user = u_user_id;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveUser`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveUser`
GO
CREATE PROCEDURE sp_saveUser(
	IN u_id_user INT(11),
	IN u_username VARCHAR(30),
	IN u_name VARCHAR(75),
	IN u_email VARCHAR(50),
	IN u_password VARCHAR(128),
	IN u_salt VARCHAR(128)
)
BEGIN
	IF EXISTS (SELECT * FROM users WHERE id_user = u_id_user) THEN
		UPDATE users SET
			username = u_username,
			name = u_name,
			email = u_email,
			password = u_password,
			salt = u_salt
		WHERE id_user = u_id_user;
	ELSE
		INSERT INTO `users` (`username`, `name`, `email`, `password`, `salt`) 
		VALUES (u_username, u_name, u_email, u_password, u_salt);
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_updateUserSession`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_updateUserSession`
GO
CREATE PROCEDURE sp_updateUserSession(
	IN current_userid INT(11),
	IN new_sessionId CHAR(128),
	IN new_sessionExpiryTime INT(25)
)
BEGIN
	IF EXISTS (SELECT * FROM users WHERE id_user = current_userid) THEN
		UPDATE users SET
			session_id = new_sessionId,
			session_expiry_time = new_sessionExpiryTime
		WHERE id_user = current_userid;
	END IF;
END
GO


-- -----------------------------------------------------
-- Stored Procedure `sp_getUserBySessionID`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getUserBySessionID`
GO
CREATE PROCEDURE sp_getUserBySessionID(
	IN sessionId CHAR(128)
)
BEGIN
	SELECT * 
	FROM users 
	WHERE session_id COLLATE latin2_general_ci = sessionId COLLATE latin2_general_ci;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getProductCategory`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getProductCategory`
GO
CREATE PROCEDURE sp_getProductCategory(
    IN c_id_category INT
)
BEGIN
 	SELECT P.id_category, P.name, P.parent, PA.name AS parent_name, P.orderof
	FROM product_category P LEFT JOIN product_category PA
	ON P.parent = PA.id_category
 	WHERE P.id_category = c_id_category;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getProductCategoryParents`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getProductCategoryParents`
GO
CREATE PROCEDURE sp_getProductCategoryParents(
    IN c_id_category INT
)
BEGIN
 	SELECT P.id_category, P.name, P.parent, PA.name AS parent_name, P.orderof
	FROM product_category P LEFT JOIN product_category PA
	ON P.parent = PA.id_category
 	WHERE P.id_category <> c_id_category;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_deleteProductCategory`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteProductCategory`
GO
CREATE PROCEDURE sp_deleteProductCategory(
	IN c_id_category INT(11)
)
BEGIN
	IF EXISTS (SELECT * FROM product_category WHERE id_category = c_id_category) THEN
	BEGIN
		DECLARE orderOfItemToDelete INT;
		
		SELECT orderof INTO orderOfItemToDelete
		FROM product_category
		WHERE id_category = c_id_category;
	
		DELETE FROM product_category 
		WHERE id_category = c_id_category;
	
		UPDATE product_category SET orderof = orderof - 1 WHERE orderof > orderOfItemToDelete;
	END;
	ELSE
		CALL raise_error;
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveProductCategory`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveProductCategory`
GO
CREATE PROCEDURE sp_saveProductCategory(
	IN c_id_category INT(11),
	IN c_name VARCHAR(100),
	IN c_parent INT(22),
	IN c_orderof INT(11)
)
BEGIN
	IF EXISTS (SELECT * FROM product_category WHERE id_category = c_id_category) THEN
	BEGIN
		IF (fct_isNotChildOf(c_id_category, c_parent)) THEN
		BEGIN
			UPDATE product_category SET	
				name = c_name,
				parent = c_parent,
				orderof = c_orderof
			WHERE id_category = c_id_category;
		END;
		ELSE
			CALL raise_error;
		END IF;
	END;
	ELSE
	BEGIN
		DECLARE nextOrder INT;
		SET @nextOrder = 1;
		IF ((SELECT COUNT(*) FROM product_category) > 0) THEN		
			SELECT @nextOrder := MAX(`orderof`) + 1 FROM `product_category`;
		END IF;
		INSERT INTO `product_category` (`name`, `parent`, `orderof`) 
		VALUES (c_name, c_parent, @nextOrder);
	END;
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getProduct`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getProduct`
GO
CREATE PROCEDURE sp_getProduct(
    IN a_product_id INT
)
BEGIN
 	SELECT p.id_product, pc.name AS pc_name, p.id_category, p.name AS p_name, p.unitOfMeasurement
	FROM product p LEFT JOIN product_category pc ON p.id_category = pc.id_category
 	WHERE p.id_product= a_product_id;
END
GO
-- -----------------------------------------------------
-- Stored Procedure `sp_deleteProduct` 
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteProduct`
GO
CREATE PROCEDURE sp_deleteProduct(
	IN a_product_id INT(11)
)
BEGIN
	IF EXISTS (SELECT * FROM product WHERE id_product= a_product_id) THEN
	BEGIN
		DELETE FROM product
		WHERE id_product = a_product_id;
	END;
	ELSE
		CALL raise_error;
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveProduct'
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveProduct`
GO
CREATE PROCEDURE sp_saveProduct(
	IN product_id INT(11),
	IN product_name VARCHAR(100),
	IN product_category_id INT(11),
	IN unit_of_measurement VARCHAR(30)
)
BEGIN
	IF EXISTS (SELECT * FROM product WHERE id_product = product_id) THEN
		UPDATE product SET
			name = product_name,
			id_category = product_category_id,
			unitOfMeasurement = unit_of_measurement 
		WHERE id_product = product_id;
	ELSE
		INSERT INTO `product` (`name`, `id_category`, `unitOfMeasurement`) 
		VALUES (product_name, product_category_id, unit_of_measurement);
	END IF;
END;
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getSupplierProduct`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getSupplierProduct`
GO
CREATE PROCEDURE sp_getSupplierProduct(
    IN a_supplier_id INT(11),
    IN a_product_id INT(11)
)
BEGIN
 	SELECT sp.id_product, p.name AS pname, sp.id_supplier, s.name AS sname, sp.unitOfMeasurement, sp.price
	FROM supplier_product sp LEFT JOIN product p ON sp.id_product = p.id_product
							LEFT JOIN supplier s ON sp.id_supplier = s.id_supplier
 	WHERE sp.id_product= a_product_id AND sp.id_supplier = a_supplier_id;
END
GO
-- -----------------------------------------------------
-- Stored Procedure `sp_deleteSupplierProduct` 
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteSupplierProduct`
GO
CREATE PROCEDURE sp_deleteSupplierProduct(
	IN a_supplier_id INT(11),
	IN a_product_id INT(11)
)
BEGIN
	IF EXISTS (SELECT * FROM supplier_product WHERE id_product = a_product_id AND id_supplier = a_supplier_id) THEN
	BEGIN
		DELETE FROM supplier_product
		WHERE id_product= a_product_id AND id_supplier = a_supplier_id;
	END;
	ELSE
		CALL raise_error;
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveSupplierProduct'
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveSupplierProduct`
GO
CREATE PROCEDURE sp_saveSupplierProduct(
	IN a_supplier_id INT(11),
	IN a_product_id INT(11),
	IN p_price REAL,
	IN unit_of_measurement VARCHAR(30)
)
BEGIN
	IF EXISTS (SELECT * FROM supplier_product WHERE id_product = a_product_id AND id_supplier = a_supplier_id) THEN
		UPDATE supplier_product SET
			price = p_price,
			unitOfMeasurement = unit_of_measurement 
		WHERE id_product = a_product_id AND id_supplier = a_supplier_id;
	ELSE
		INSERT INTO `supplier_product` (`id_product`, `id_supplier`, `price`, `unitOfMeasurement`) 
		VALUES (a_product_id, a_supplier_id, p_price, unit_of_measurement);
	END IF;
END;
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getRestaurant`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getRestaurant`
GO
CREATE PROCEDURE sp_getRestaurant(
    IN r_id_restaurant INT
)
BEGIN
 	SELECT id_restaurant, name, address
 	FROM restaurant
 	WHERE id_restaurant = r_id_restaurant;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_deleteRestaurant`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteRestaurant`
GO
CREATE PROCEDURE sp_deleteRestaurant(
	IN r_id_restaurant INT(11)
)
BEGIN
	IF EXISTS (SELECT * FROM restaurant WHERE id_restaurant = r_id_restaurant) THEN
		DELETE FROM restaurant 
		WHERE id_restaurant = r_id_restaurant;
	ELSE
		CALL raise_error;
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveRestaurant`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveRestaurant`
GO
CREATE PROCEDURE sp_saveRestaurant(
	IN r_id_restaurant INT(11),
	IN r_name VARCHAR(100),
	IN r_address VARCHAR(250)
)
BEGIN
	IF EXISTS (SELECT * FROM restaurant WHERE id_restaurant = r_id_restaurant) THEN
		UPDATE restaurant SET	
			name = r_name,
			address = r_address
		WHERE id_restaurant = r_id_restaurant;
	ELSE
		INSERT INTO `restaurant` (`name`, `address`) 
		VALUES (r_name, r_address);
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getRestaurantUsers`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getRestaurantUsers`
GO
CREATE PROCEDURE sp_getRestaurantUsers(
    IN ru_id_restaurant INT
)
BEGIN
 	SELECT U.id_user, U.name AS name_user, (IF (id_user_check = U.id_user, 1, 0)) AS is_check, NULL AS id_restaurant, NULL AS name_restaurant
	FROM users U LEFT JOIN (SELECT U1.id_user as id_user_check
 							FROM users U1 
 							WHERE EXISTS (SELECT UR.id_user
 					  						FROM users_restaurants UR
 					  						WHERE UR.id_user = U1.id_user AND UR.id_restaurant = ru_id_restaurant)) AS U
 	ON U.id_user = id_user_check;				 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_subscribOrUnSubscribUsersToRestaurant`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_subscribOrUnSubscribUsersToRestaurant`
GO
CREATE PROCEDURE sp_subscribOrUnSubscribUsersToRestaurant(
	IN r_id_restaurant INT(11),
	IN r_users VARCHAR(1000)
)
BEGIN
	DECLARE pos INT DEFAULT 0;
	DECLARE cur_user VARCHAR(1000);
	DECLARE cur_op INT;

	-- LOOP
	manip_loop: LOOP
		-- Get the current user
		SET pos = pos + 1;
    	SET cur_user = fct_split(r_users, ",", pos);
    	-- Get the operation related (1-add, 0-delete)
    	SET pos = pos + 1;
    	SET cur_op = fct_split(r_users, ",", pos);
	
		-- Loop exit
		/****************************/
		IF cur_user = '' THEN
			LEAVE manip_loop;
		END IF;
		/****************************/
		
		-- Loop manipulation
		
		-- Check if subscribe or unsubscribe operation
		-- Subscribe
		IF (cur_op = 1) THEN
		BEGIN
			IF NOT EXISTS (SELECT * FROM users_restaurants WHERE id_restaurant = r_id_restaurant AND id_user = cur_user) THEN
			BEGIN
				INSERT INTO users_restaurants (`id_restaurant`, `id_user`)  
				VALUES (r_id_restaurant, cur_user);
			END;
			END IF;
		END;
		-- Unsubscribe
		ELSEIF (cur_op = 0) THEN
		BEGIN
			IF EXISTS (SELECT * FROM users_restaurants WHERE id_restaurant = r_id_restaurant AND id_user = cur_user) THEN
			BEGIN
				DELETE FROM users_restaurants 
				WHERE id_restaurant = r_id_restaurant AND id_user = cur_user;			
			END;
			END IF;
		END;
		-- Invalid operation
		ELSE
			CALL raise_error;
		END IF;
	END LOOP manip_loop;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getUserLocations`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getUserLocations`
GO
CREATE PROCEDURE sp_getUserLocations(
    IN ur_id_user INT
)
BEGIN
	DECLARE selectedLocation INT;
	DECLARE defaultSelectedLocation INT;
	DECLARE locationExists INT;
	
	SET selectedLocation = -1;
	
	-- Get the selected location for the current user
	SELECT location_selected INTO selectedLocation
	FROM users
	WHERE id_user = ur_id_user;
	
	-- Determine if the user has access to the selected location
	SELECT COUNT(*) INTO locationExists
 	FROM users_restaurants RU
 	WHERE RU.id_restaurant = selectedLocation AND RU.id_user = ur_id_user;
	
	-- If the user selected location is null or if he does not 
	-- have access to the selected location we update his selected location
	-- for the first location in his locations list.
	IF (selectedLocation IS NULL OR locationExists = 0) THEN
	BEGIN
		SELECT R.id_restaurant INTO defaultSelectedLocation
 		FROM restaurant R, users_restaurants RU
 	 	WHERE R.id_restaurant = RU.id_restaurant AND RU.id_user = ur_id_user
 	 	LIMIT 0,1;
	
	 	UPDATE users SET location_selected = defaultSelectedLocation
	 	WHERE id_user = ur_id_user;
	END;
	END IF;
	
	-- Get all the locations of a user
	SELECT R.id_restaurant, R.name, NULL AS address
 	FROM restaurant R, users_restaurants RU
 	WHERE R.id_restaurant = RU.id_restaurant AND RU.id_user = ur_id_user;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_selectLocation`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_selectLocation`
GO
CREATE PROCEDURE sp_selectLocation(
	IN u_id_user INT,
    IN u_id_location INT
)
BEGIN
	UPDATE users SET	
		location_selected = u_id_location
	WHERE id_user = u_id_user;
END
GO

-- ---------------------------------------------------------------------------------------
-- Functions
-- ---------------------------------------------------------------------------------------
-- -----------------------------------------------------
-- Function `fct_isNotChildOf`
-- Validate that there is no child->parent->child loop
-- for 1 or 2 or 3 level of indentations
-- *** This solution is temporary until we find a better solution ***
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `fct_isNotChildOf`
GO
CREATE FUNCTION fct_isNotChildOf(
	c_id_category INT(11),
	c_parent INT(11)
)
RETURNS INT
BEGIN
	DECLARE cpt INT;
	SET cpt = 0;
	
	SELECT cpt + COUNT(P1.id_category) INTO cpt
	FROM product_category P1		
	WHERE P1.id_category = c_parent AND P1.parent = c_id_category;
	
	SELECT cpt + COUNT(P1.id_category) INTO cpt
	FROM product_category P1, 
		product_category P2
	WHERE P1.id_category = c_parent AND P1.parent = P2.id_category AND P2.parent = c_id_category;

	SELECT cpt + COUNT(P1.id_category) INTO cpt
	FROM product_category P1, 
		product_category P2,
		product_category P3
	WHERE P1.id_category = c_parent AND P1.parent = P2.id_category AND P2.parent = P3.id_category AND P3.parent = c_id_category;

	RETURN cpt = 0;
END
GO

-- -----------------------------------------------------
-- Function `fct_split`
-- source : http://stackoverflow.com/questions/11835155/mysql-split-comma-seperated-string-into-temp-table
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS `fct_split`
GO
CREATE FUNCTION fct_split(
  x VARCHAR(1000),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(25)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
GO

DELIMITER ;