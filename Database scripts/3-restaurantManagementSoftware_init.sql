USE `restaurantManagementSoftware`;

DELIMITER GO

-- ---------------------------------------------------------------------------
-- Insert table supplier
-- ---------------------------------------------------------------------------
INSERT INTO `supplier` (`id_supplier`, `name`, `contact_name`, `phone_number`, `fax_number`) VALUES
(1, 'Supplier A', 'David Fortin', '450-450-4500', '450-450-4000'),
(2, 'Supplier B', 'Alexandre Dubé', '450-450-4501', '450-450-4001'),
(3, 'Supplier C', 'Paul Germound', '1-450-450-4502', '1-450-450-4002'),
(4, 'Supplier D', 'Doris Laprade', '450-450-4503', '450-450-4003'),
(5, 'Supplier E', 'Henry Tibault', '1-450-450-4504', '1-450-450-4004');
GO
-- ---------------------------------------------------------------------------
-- Insert table product_category
-- ---------------------------------------------------------------------------
INSERT INTO `product_category` (`id_category`, `name`, `parent`, `orderof`) VALUES
(1, 'Dry', NULL, 1),
(2, 'Herbs and Spices', 1, 2),
(3, 'Green Herbs', 2, 3),
(4, 'Meats', NULL, 4);
GO
-- ---------------------------------------------------------------------------
-- Insert table restaurant
-- ---------------------------------------------------------------------------
INSERT INTO `restaurant` (`id_restaurant`, `name`, `address`)
VALUES
	(5, 'Restaurant 1', '114 rue st-antoine ouest, montreal, qc, J6T 4G7'),
	(6, 'Restaurant 2', '110 rue st-caty, montreal, qc, J9T 3T7');
GO
-- ---------------------------------------------------------------------------
-- Insert table users
-- ---------------------------------------------------------------------------
INSERT INTO `users` (`id_user`, `username`, `name`, `email`, `password`, `salt`, `session_id`, `session_expiry_time`, `location_selected`) VALUES
(1, 'aassaly', 'Andrew Assaly', 'aassaly@gmail.com', '6e6591627c7da94b0b3f31ff57589f82ec535352e0b66db038aa055495eb11edc7649560692b82267dda6eca1977a2f2336266550e9f9b55cfa5cf2e8f37972e', '1059368288c58a44f974d25c81cbf6cf607e15087f8aa0339ad13b635906259b5a31d5f4dd9896a91dd2545d62506a8f9494731dbdf29f803aba345a1b7496ba',
'00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 0, 5),
(2, 'dfortin', 'David Fortin', 'davidfortin8640@gmail.com', '1a40afcd508909a06959536f3e7b1ebc89dce270ba6609ca39699e6eb41fad1aa85761444ac707d5cbf7b34821f70535635cf6e6e6184b6009bb3d880509a509', 'b1901714256032b06f8bfa1ba90c93bdaf138d8f0de3dbaf8e6306c7c1f1bdfc07eea690d02199ce6ef3cdf155ca22f171bc0a6226f0abc25d4a5e93fa21c563',
'00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 0, 5),
(3, 'ohijazi', 'Omar Hijazi', 'ohijazi22@gmail.com', '8f4eca587bfdd8b00300d206ba82961c3c8a8cfe69a66b57449f20fff0a2f8fb4487314a09cd352b1d12ef364798d22625c086f19e1b4ee25403121cd010cff2', '1b8db8b9fb8f1c48dd5e5eca4f75427dee7d3b5b0e9620f8150a8f288117de30c7305992979374a458950289a2b47e31d5ca1475ac432e5eae34d69a7f49091d',
'00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 0, 5),
(4, 'dfachin', 'Daniel Fachin', 'danfachin@gmail.com', 'ba37007093ba6838f62eaacf4b011b7a92f2c42585d2c00b462b54978507c24835f97307f95193c889dff6d39a33477602162c5af6461c5c432a140760895f3d', '533c8e8489b4028836e00f5ecdfb6aa18a11f42e29121f3d862377fd53d2df16c4f93d06d2ed08feb4290aa91f02d5b4fd1e62e4f7dec7da4de3cd1c09b52ff2',
'00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 0, 5);
GO
-- ---------------------------------------------------------------------------
-- Insert table users_restaurants
-- ---------------------------------------------------------------------------
INSERT INTO `users_restaurants` (`id_restaurant`, `id_user`)
VALUES
	(5, 1),
	(5, 2),
	(5, 3),
	(5, 4),
	(6, 1),
	(6, 2),
	(6, 3),
	(6, 4);
GO

-- ---------------------------------------------------------------------------
-- Insert table product
-- ---------------------------------------------------------------------------
INSERT INTO `product` (`id_product`, `name`, `id_category`, `unitOfMeasurement`)
VALUES
	(1, 'Beef', 4, 'Kg'),
	(2, 'Pork', 4, 'Kg'),
	(3, 'Turkey', 4, 'Kg'),
	(4, 'Chive Herbs', 3, 'Kg');
GO

-- ---------------------------------------------------------------------------
-- Insert table supplier_product
-- ---------------------------------------------------------------------------
INSERT INTO `supplier_product` (`id_product`, `id_supplier`, `price`, `unitOfMeasurement`)
VALUES
	(1, 1, 2.50, 'Kg'),
	(1, 2, 2.40, 'Kg'),
	(2, 1, 3.50, 'Kg'),
	(2, 2, 4.50, 'Kg');
GO

-- ---------------------------------------------------------------------------
-- Insert table order_list
-- ---------------------------------------------------------------------------
INSERT INTO `order_list` (`id_order`, `id_restaurant`, `dateCreated`,
	`subtotal`, `taxes`, `totalCost`, `shippingCost`, `state`)
VALUES
	(1, 5, '2014-01-19 18:55:55', 750, 625, 2400, 1025, 0),
	(2, 6, '2014-01-22 12:07:55', 750, 175, 1000, 75, 1);
GO

-- ---------------------------------------------------------------------------
-- Insert table purchase_orders
-- ---------------------------------------------------------------------------
INSERT INTO `purchase_orders` (`id_po`, `po_NumberSupplier`, `id_order`, `id_supplier`, `subtotal`, `taxes`, `shippingCost`, `totalCost`, `state`)
VALUES
	(1, 'ABCC', 1, 1, 500, 25, 1000, 1525, 0),
	(2, 'ABCD', 2, 1, 500, 25, 150, 675, 1),
	(3, 'ABCE', 1, 2, 250, 600, 25, 875, 0),
	(4, 'ABCF', 2, 2, 250, 50, 25, 325, 1);
GO

-- ---------------------------------------------------------------------------
-- Insert table PO_item
-- ---------------------------------------------------------------------------
INSERT INTO `PO_item` (`id_product`, `id_po`,`qty`, `costPerUnit`, `unitOfMeasurement`)
VALUES
	(1, 1, 10, 50, 'kg'),
	(1, 2, 10, 50, 'kg'),
	(2, 3, 10, 25, 'kg'),
	(2, 4, 10, 25, 'kg');
GO

-- ---------------------------------------------------------------------------
-- Insert table inventory
-- ---------------------------------------------------------------------------
INSERT INTO `inventory` (`id_inventory`, `id_restaurant`)
VALUES
	(1, 5),
	(2, 6);
GO

-- ---------------------------------------------------------------------------
-- Insert table inventory_item
-- ---------------------------------------------------------------------------
INSERT INTO `inventory_item` (`id_inventory_item`, `id_inventory`, `id_product`, `id_supplier`,`qty`, `costPerUnit`, `unitOfMeasurement`)
VALUES
	(1, 1, 1, 1, 1, 50, 'kg'),
	(2, 2, 1, 1, 2, 25, 'mg');
GO

DELIMITER ;
