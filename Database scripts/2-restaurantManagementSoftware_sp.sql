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
-- View `v_getUsers`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getUsers`
GO
CREATE VIEW v_getUsers
AS
	SELECT *
	FROM users U;
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
	SELECT R.id_restaurant, R.name AS name_restaurant, U.id_user, U.name AS name_user
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
	SELECT PO.id_po, PO.po_NumberSupplier, PO.id_order, PO.id_supplier, S.name as supplierName, 
			PO.dateOrdered, PO.dateDelivered, PO.subtotal, PO.taxes, PO.shippingCost, PO.totalCost,
			PO.state
	FROM purchase_orders PO
		LEFT JOIN supplier S ON PO.id_supplier = S.id_supplier
GO

-- -----------------------------------------------------
-- View `v_getRestaurantsInventory`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_getRestaurantsInventory`
GO
CREATE VIEW v_getRestaurantsInventory
AS
	SELECT I.id_inventory, I.id_restaurant, R.name AS restaurantName
	FROM inventory I LEFT JOIN restaurant R ON I.id_restaurant = R.id_restaurant
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
		CALL raise_error; /* ERREUR */
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
		CALL raise_error; /* ERREUR */
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
			CALL raise_error; /* ERREUR */
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
		CALL raise_error; /* ERREUR */
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
		CALL raise_error; /* ERREUR */
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
	IN p_price DECIMAL(10,2),
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
		CALL raise_error; /* ERREUR */
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
	SELECT U.id_user, U.name AS name_user, (IF (id_user_check = U.id_user, 1, 0)) AS is_check
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
   			CALL raise_error; /* ERREUR */
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
	SELECT R.id_restaurant, R.name
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

-- -----------------------------------------------------
-- Stored Procedure `sp_getRestaurantOrders`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getRestaurantOrders`
GO
CREATE PROCEDURE sp_getRestaurantOrders(
  IN ro_id_restaurant INT
)
BEGIN
	SELECT O.id_order, O.id_restaurant, R.name as nameRestaurant, O.dateCreated, O.subtotal,
		O.shippingCost, O.taxes, O.totalCost, O.state
	FROM order_list O LEFT JOIN restaurant R ON O.id_restaurant = R.id_restaurant
	WHERE O.id_restaurant = ro_id_restaurant;			 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveOrder`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveOrder`
GO
CREATE PROCEDURE sp_saveOrder(
  IN id_order_in INT(11),
  IN id_restaurant_in INT(11),
  IN dateCreated_in DATETIME,
  IN subtotal_in DECIMAL(10,2),
  IN taxes_in DECIMAL(10,2),
  IN totalCost_in DECIMAL(10,2),
  IN shippingCost_in DECIMAL(10,2),
  IN state_in INT(3)
  )
BEGIN
	DECLARE id INT(11);
	SET id = -1;
	IF EXISTS (SELECT * FROM order_list WHERE id_order = id_order_in) THEN
	BEGIN
		UPDATE order_list SET 
  			id_restaurant = id_restaurant_in,
  			dateCreated = dateCreated_in,
  			subtotal = subtotal_in,
  			taxes = taxes_in,
  			totalCost = totalCost_in,
  			shippingCost = shippingCost_in,
  			state = state_in
		WHERE id_order = id_order_in;
		-- Get the id of the order if the update was successful
		SET id = id_order_in;
	END;
	ELSE
	BEGIN
		INSERT INTO `order_list` (`id_restaurant`, `dateCreated`, `subtotal`,
  					`taxes`, `totalCost`, `shippingCost`, `state`) 
		VALUES (id_restaurant_in, dateCreated_in, subtotal_in, taxes_in, totalCost_in, shippingCost_in, state_in);
		SET id = LAST_INSERT_ID();
	END;
	END IF;
	SELECT id;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_deleteOrder`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteOrder`
GO
CREATE PROCEDURE sp_deleteOrder(
	IN o_id_order INT(11)
)
BEGIN
	/* Delete only if the order is in progress otherwise the order cannot be delete */
	IF EXISTS (SELECT * FROM order_list WHERE id_order = o_id_order AND state = 0 /*In Progress*/) THEN
		DELETE FROM order_list 
		WHERE id_order = o_id_order;
	ELSE
		CALL raise_error; /* ERREUR */
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getOrder`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getOrder`
GO
CREATE PROCEDURE sp_getOrder(
  IN o_id_order INT
)
BEGIN
	SELECT OL.id_order, OL.id_restaurant, R.name as nameRestaurant,
			OL.dateCreated, OL.subtotal, OL.shippingCost, OL.taxes, OL.totalCost, OL.state
	FROM order_list OL
		LEFT JOIN restaurant R ON OL.id_restaurant = R.id_restaurant     		 
	WHERE OL.id_order = o_id_order;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_addPurchaseOrder`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_addPurchaseOrder`
GO
CREATE PROCEDURE sp_addPurchaseOrder(
	IN po_po_number VARCHAR(20),
	IN po_id_order INT(11),
	IN po_id_supplier INT(11),
	IN po_date_ordered DATETIME,
	IN po_date_delivered DATETIME,
	IN po_subtotal DECIMAL(10,2),
  	IN po_taxes DECIMAL(10,2),
  	IN po_totalCost DECIMAL(10,2),
 	IN po_shippingCost DECIMAL(10,2),
 	IN po_state INT(3)
)
BEGIN
	INSERT INTO `purchase_orders` (`po_NumberSupplier`, `id_order`, `id_supplier`,
    							`dateOrdered`, `dateDelivered`, `subtotal`, `taxes`, 
    							`shippingCost`, `totalCost`, `state`) 
	VALUES (po_po_number, po_id_order, po_id_supplier, po_date_ordered, po_date_delivered, 
			po_subtotal, po_taxes, po_shippingCost, po_totalCost, po_state);
	SELECT LAST_INSERT_ID() AS id;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_updatePurchaseOrderState`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_updatePurchaseOrderState`
GO
CREATE PROCEDURE sp_updatePurchaseOrderState(
	IN po_id INT(11),
	IN po_state INT(3)
)
BEGIN
	IF EXISTS (SELECT * FROM purchase_orders WHERE id_po = po_id) THEN
	BEGIN
		UPDATE purchase_orders SET 
  			state = po_state
		WHERE id_po = po_id;
	END;
	ELSE
		CALL raise_error; /* ERREUR */
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_addPurchaseOrderItem`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_addPurchaseOrderItem`
GO
CREATE PROCEDURE sp_addPurchaseOrderItem(
	IN poi_id_po INT(11),
	IN poi_id_product INT(11),
	IN poi_qty INT(11),
	IN poi_cost_per_unit DECIMAL(10,2),
	IN poi_unit_of_measurement VARCHAR(30)
)
BEGIN
	INSERT INTO `PO_item` (`id_product`, `id_po`, `qty`, `costPerUnit`, `unitOfMeasurement`) 
	VALUES (poi_id_product, poi_id_po, poi_qty, poi_cost_per_unit, poi_unit_of_measurement);
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_deleteAllPurcaseOrdersOfOrder`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_deleteAllPurcaseOrdersOfOrder`
GO
CREATE PROCEDURE sp_deleteAllPurcaseOrdersOfOrder(
	IN po_id_order INT(11)
)
BEGIN
	DELETE FROM purchase_orders 
	WHERE id_order = po_id_order;
END
GO      

-- -----------------------------------------------------
-- Stored Procedure `sp_isSupplierPONumberUnique`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_isSupplierPONumberUnique`
GO
CREATE PROCEDURE sp_isSupplierPONumberUnique (
	IN po_order_id INT,
	IN po_supplier_id INT,
	IN po_supplierPONumber VARCHAR(20)
)
BEGIN
	IF ((SELECT COUNT(*) FROM purchase_orders WHERE po_NumberSupplier = po_supplierPONumber) = 1) THEN
	BEGIN
		IF NOT EXISTS (SELECT * FROM purchase_orders WHERE id_order = po_order_id AND id_supplier = po_supplier_id AND po_NumberSupplier = po_supplierPONumber) THEN
			CALL raise_error; -- ERREUR
		END IF;
	END;
	ELSEIF ((SELECT COUNT(*) FROM purchase_orders WHERE po_NumberSupplier = po_supplierPONumber) > 1) THEN
		CALL raise_error; -- ERREUR
	END IF;
END
GO     
         
-- -----------------------------------------------------
-- Stored Procedure `sp_getPurchaseOrderItems`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getPurchaseOrderItems`
GO
CREATE PROCEDURE sp_getPurchaseOrderItems(
  IN poi_po_id INT
)
BEGIN
	SELECT POI.id_product, POI.id_po, POI.qty, POI.costPerUnit, P.name AS productName, POI.unitOfMeasurement
	FROM PO_item POI LEFT JOIN purchase_orders PO ON POI.id_po = PO.id_po
					LEFT JOIN supplier_product SP ON PO.id_supplier = SP.id_supplier AND POI.id_product = SP.id_product
					LEFT JOIN product P ON SP.id_product = P.id_product
	WHERE POI.id_po = poi_po_id;     		 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getPurchaseOrdersByOrderId`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getPurchaseOrdersByOrderId`
GO
CREATE PROCEDURE sp_getPurchaseOrdersByOrderId(
  IN po_order_id INT
)
BEGIN
	SELECT PO.id_po, PO.po_NumberSupplier, PO.id_order, PO.id_supplier, S.name as supplierName, 
			PO.dateOrdered, PO.dateDelivered, PO.subtotal, PO.taxes, PO.shippingCost, PO.totalCost,
			PO.state
	FROM purchase_orders PO
		LEFT JOIN supplier S ON PO.id_supplier = S.id_supplier
	WHERE PO.id_order = po_order_id;     		 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getPurchaseOrderItemsByOrderId`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getPurchaseOrderItemsByOrderId`
GO
CREATE PROCEDURE sp_getPurchaseOrderItemsByOrderId(
  IN po_order_id INT
)
BEGIN
	SELECT POI.id_product, POI.id_po, POI.qty, POI.costPerUnit, P.name AS productName, POI.unitOfMeasurement, PO.id_supplier, S.name as supplierName
	FROM PO_item POI LEFT JOIN purchase_orders PO ON POI.id_po = PO.id_po
					LEFT JOIN supplier_product SP ON PO.id_supplier = SP.id_supplier AND POI.id_product = SP.id_product
					LEFT JOIN product P ON SP.id_product = P.id_product
					LEFT JOIN supplier S ON SP.id_supplier = S.id_supplier
	WHERE PO.id_order = po_order_id; 	 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getRestaurantInventory`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getRestaurantInventory`
GO
CREATE PROCEDURE sp_getRestaurantInventory(
  IN i_restaurant_id INT
)
BEGIN
	SELECT I.id_inventory, I.id_restaurant, R.name AS restaurantName
	FROM inventory I LEFT JOIN restaurant R ON I.id_restaurant = R.id_restaurant
	WHERE I.id_restaurant = i_restaurant_id;     		 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_addInventory`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_addInventory`
GO
CREATE PROCEDURE sp_addInventory(
	IN i_restaurant_id INT(11)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM inventory WHERE id_restaurant = i_restaurant_id) THEN
	BEGIN
		INSERT INTO `inventory` (`id_restaurant`) 
		VALUES (i_restaurant_id);
		SELECT LAST_INSERT_ID() AS id;
	END;
	ELSE
		SELECT id_inventory AS id FROM inventory WHERE id_restaurant = i_restaurant_id; 
	END IF;
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_getInventoryItems`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_getInventoryItems`
GO
CREATE PROCEDURE sp_getInventoryItems(
  IN i_id INT
)
BEGIN
	SELECT II.id_inventory_item as id_item, II.id_inventory, II.id_product, II.costPerUnit, II.qty, II.unitOfMeasurement, II.id_supplier, P.name AS productName, S.name AS supplierName
	FROM inventory_item II LEFT JOIN product P ON II.id_product = P.id_product
							LEFT JOIN supplier S ON II.id_supplier = S.id_supplier
	WHERE II.id_inventory = i_id;	 		 
END
GO

-- -----------------------------------------------------
-- Stored Procedure `sp_saveInventoryItem`
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sp_saveInventoryItem`
GO
CREATE PROCEDURE sp_saveInventoryItem(
	IN ii_item_id INT(11),
	IN ii_inventory_id INT(11),
	IN ii_product_id INT(11),
	IN ii_supplier_id INT(11),
	IN ii_qty INT(11),
	IN ii_cost_per_unit DECIMAL(10,2),
	IN ii_unit_of_measurement VARCHAR(30)
)
BEGIN
	DECLARE id INT;
	DECLARE oldQty INT;
	IF EXISTS (SELECT * FROM inventory_item WHERE id_inventory_item = ii_item_id) THEN
		UPDATE inventory_item SET	
			qty = ii_qty
		WHERE id_inventory_item = ii_item_id;
	ELSE
	BEGIN
		IF EXISTS (SELECT * FROM inventory_item WHERE id_inventory = ii_inventory_id AND id_product = ii_product_id AND id_supplier = ii_supplier_id AND abs(costPerUnit - ii_cost_per_unit) <= 1e-6 AND unitOfMeasurement LIKE ii_unit_of_measurement) THEN
		BEGIN
			SELECT @id := id_inventory_item, @oldQty := qty FROM inventory_item WHERE id_inventory = ii_inventory_id AND id_product = ii_product_id AND id_supplier = ii_supplier_id AND abs(costPerUnit - ii_cost_per_unit) <= 1e-6 AND unitOfMeasurement LIKE ii_unit_of_measurement;
			UPDATE inventory_item SET	
				qty = ii_qty + @oldQty
			WHERE id_inventory_item = @id;
			SELECT @id, @oldQty;
		END;
		ELSE		
			INSERT INTO `inventory_item` (`id_inventory`, `id_product`, `id_supplier`, `qty`, `costPerUnit`, `unitOfMeasurement`) 
			VALUES (ii_inventory_id, ii_product_id, ii_supplier_id, ii_qty, ii_cost_per_unit, ii_unit_of_measurement);
		END IF;
	END;
	END IF;
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
	FROM product_category P1, product_category P2
	WHERE P1.id_category = c_parent AND P1.parent = P2.id_category AND P2.parent = c_id_category;

	SELECT cpt + COUNT(P1.id_category) INTO cpt
	FROM product_category P1, product_category P2, product_category P3
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