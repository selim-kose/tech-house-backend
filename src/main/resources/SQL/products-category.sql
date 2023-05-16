

-- -----------------------------------------------------
-- Schema tech_house
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tech-house`;

CREATE SCHEMA `tech-house`;
USE `tech-house` ;

-- -----------------------------------------------------
-- Table tech_house.product_category
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_category` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `category_name` VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (id))
    ENGINE=InnoDB
    AUTO_INCREMENT = 1;

-- -----------------------------------------------------
-- Table tech_house.product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) DEFAULT NULL,
    `description` VARCHAR(255) DEFAULT NULL,
    `price` DECIMAL(13,2) DEFAULT NULL,
    `image_url` VARCHAR(255) DEFAULT NULL,
    `category_id` BIGINT(20) NOT NULL,
    PRIMARY KEY (id),
    KEY fk_category (category_id),
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES product_category (id)
    )
    ENGINE=InnoDB
    AUTO_INCREMENT = 1;



-- --------------------------------------------------
-- Table structure for table `country`
-- -------------------------------------------------
SET foreign_key_checks = 0;

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
                           `id` smallint unsigned NOT NULL,
                           `code` varchar(2) DEFAULT NULL,
                           `name` varchar(255) DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB;



DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
                         `id` smallint unsigned NOT NULL AUTO_INCREMENT,
                         `name` varchar(255) DEFAULT NULL,
                         `country_id` smallint unsigned NOT NULL,
                         PRIMARY KEY (`id`),
                         KEY `fk_country` (`country_id`),
                         CONSTRAINT `fk_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;




-- -----------------------------------------------------
-- Data for table `country`
-- -----------------------------------------------------

INSERT INTO `country` VALUES
                          (1,'BR','Brazil'),
                          (2,'CA','Canada'),
                          (3,'DE','Germany'),
                          (4,'IN','India'),
                          (5,'TR','Turkey'),
                          (6,'US','United States');




--
-- Prep work
--
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `order_item`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `address`;
SET FOREIGN_KEY_CHECKS=1;

--
-- Table structure for table `address`
--
CREATE TABLE `address` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `city` varchar(255) DEFAULT NULL,
                           `country` varchar(255) DEFAULT NULL,
                           `street` varchar(255) DEFAULT NULL,
                           `zip_code` varchar(255) DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `customer`
--
CREATE TABLE `customer` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `first_name` varchar(255) DEFAULT NULL,
                            `last_name` varchar(255) DEFAULT NULL,
                            `email` varchar(255) DEFAULT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `orders`
--
CREATE TABLE `orders` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `order_tracking_number` varchar(255) DEFAULT NULL,
                          `total_price` decimal(19,2) DEFAULT NULL,
                          `total_quantity` int DEFAULT NULL,
                          `billing_address_id` bigint DEFAULT NULL,
                          `customer_id` bigint DEFAULT NULL,
                          `shipping_address_id` bigint DEFAULT NULL,
                          `status` varchar(128) DEFAULT NULL,
                          `date_created` datetime(6) DEFAULT NULL,
                          `last_updated` datetime(6) DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `UK_billing_address_id` (`billing_address_id`),
                          UNIQUE KEY `UK_shipping_address_id` (`shipping_address_id`),
                          KEY `K_customer_id` (`customer_id`),
                          CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
                          CONSTRAINT `FK_billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`),
                          CONSTRAINT `FK_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `order_items`
--
CREATE TABLE `order_item` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `image_url` varchar(255) DEFAULT NULL,
                              `quantity` int DEFAULT NULL,
                              `price` decimal(19,2) DEFAULT NULL,
                              `order_id` bigint DEFAULT NULL,
                              `product_id` bigint DEFAULT NULL,
                              PRIMARY KEY (`id`),
                              KEY `K_order_id` (`order_id`),
                              CONSTRAINT `FK_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
                              CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Categories
-- -----------------------------------------------------
INSERT INTO product_category(category_name) VALUES ('Computers');
INSERT INTO product_category(category_name) VALUES ('Monitors');
INSERT INTO product_category(category_name) VALUES ('PS5 Games');
INSERT INTO product_category(category_name) VALUES ('TVs');
INSERT INTO product_category(category_name) VALUES ('Phones');


-- -----------------------------------------------------
-- Computers
-- -----------------------------------------------------

INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'Lenovo 14" IdeaPad 1i Laptop', 'Intel Core i3 Processor - 8GB RAM - 256GB SSD Storage - Windows 11 Home in S Mode - Gray (82QC004BUS)', 844.99, 'assets/img/products/computer/1.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP 15.6" FHD Laptop', 'AMD Ryzen 5 Processor - 8GB RAM - 512GB SSD Flash Storage - Windows 11 Home in S Mode - Silver (15-ef2040tg)', 499.99, 'assets/img/products/computer/2.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'Acer 14" Touchscreen Convertible Laptop', 'Intel Core i3 Processor - 8GB RAM - 256GB SSD storage – Windows - Silver (SP314-55-34UR)', 499.99, 'assets/img/products/computer/3.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'MSI Pulse GL66 15.6"', '144Hz FHD Gaming Laptop - Intel Core i7 - NVIDIA GeForce RTX 3050 - 16GB RAM - 1TBNVMe SSD - Gray', 899.99, 'assets/img/products/computer/4.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'Acer 512 Chromebook', ' 12" Intel Celeron N4020 1.1GHz 4GB RAM 32GB Flash ChromeOS - Manufacturer Refurbished', 99.99, 'assets/img/products/computer/5.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'Acer Predator Triton 500', '15.6" Intel i7-10750H 2.6GHz 32GB Ram 1TB SSD Win10H - Manufacturer Refurbished', 199.99, 'assets/img/products/computer/6.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP 14" Stream Touchscreen Laptop', 'AMD Processor - 4GB RAM Memory - 64GB Flash Storage - Windows 11 - Indigo Blue (14-fq0037nr)', 299.99, 'assets/img/products/computer/7.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'ASUS 15.6" Laptop', 'Intel Pentium Processor - 4GB RAM 128GB Flash Storage - Windows 11 Home in S Mode - Black - L510MA-TH21', 239.99, 'assets/img/products/computer/8.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP Victus 15.6" 144Hz FHD Gaming Laptop', 'Intel Core i5-12450H, 16GB RAM, 512GB SSD, Nvidia RTX 3050 – Silver (15-fa0012tg)', 799.99, 'assets/img/products/computer/9.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP 14 Series 14" ', 'Touchscreen Laptop Intel Celeron N4020 4GB RAM 64GB eMMC Snow White', 299.99, 'assets/img/products/computer/10.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP Inc. Pavilion Laptop ', '15.6" FHD AMD Ryzen 7 16 GB memory; 512 GB SSD', 844.99, 'assets/img/products/computer/11.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP 14 Series 14"', 'Intel Celeron N4020 4GB RAM 64GB eMMC Pale Rose Gold - Intel Celeron N4020 Dual-core - Integrated Intel UHD Graphics', 1110.99, 'assets/img/products/computer/12.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP Pavilion 15.6"', '60Hz Gaming Laptop - Intel Core i5 - Nvidia GTX 1650 - 8GB RAM, 256GB SSD - Backlit KB - Black (15-dk1045tg)', 749.99, 'assets/img/products/computer/13.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP Victus 15.6"', 'NVIDIA GeForce RTX 3050 8GB RAM 512GB SSD Mica Silver - Intel Core i5 i5-12500H Dodeca-core', 1069.99 , 'assets/img/products/computer/14.webp', 1);
INSERT INTO product (name, description, price, image_url, category_id) VALUES ( 'HP Elitebook X360 1040 G6 14"', 'Intel Core i5 1.60 GHz 8 GB 256 GB SSD W10P', 329.99, 'assets/img/products/computer/15.webp', 1);

-- -----------------------------------------------------
-- Displays
-- -----------------------------------------------------
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Acer 27"', 'Full HD IPS Computer Monitor, AMD FreeSync, 75hz Refresh Rate (HDMI,VGA)- KB272', 'assets/img/products/display/1.webp', 119.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 24"', 'FHD IPS Computer Monitor, AMD FreeSync, HDMI & VGA (T350 Series) - Dark Blue/Gray', 'assets/img/products/display/2.webp', 109.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Acer 23.8"', 'Full HD Computer Monitor, AMD FreeSync, 75hz Refresh Rate (HDMI,VGA) - KB242Y', 'assets/img/products/display/3.webp', 99.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 27"', 'Full HD IPS Computer Monitor, AMD FreeSync, 3-Side Virtually Borderless Design - Black', 'assets/img/products/display/4.webp', 189.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 27GP700-B.AUS 27"', 'UltraGear Nano IPS 3-Side Virtually Borderless FHD (1920 x 1080) IPS 1ms 240Hz NVIDIA G', 'assets/img/products/display/5.webp', 299.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'HP 27"', 'Full HD IPS Computer Monitor, AMD FreeSync, (2 x HDMI, VGA) - M27fe', 'assets/img/products/display/6.webp', 269.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 24GQ50FB 24"', 'UltraGear Gaming Monitor', 'assets/img/products/display/7.webp', 169.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 24"', 'Full HD IPS Computer Monitor with AMD FreeSync - Black - 24MP60G', 'assets/img/products/display/8.webp', 127.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Acer KA2 - 23.8"', 'Monitor FullHD 1920 x 1080 75Hz VA 1 ms VRB 250Nit HDMI - Manufacturer Refurbished', 'assets/img/products/display/9.webp', 69.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Acer SB1- 23.8"', 'Monitor FullHD 1920 x 1080 VA 75Hz 1ms VRB 250Nit HDMI - Manufacturer Refurbished', 'assets/img/products/display/10.webp', 69.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Acer EB1 - 31.5"', 'Monitor Display Full HD 1920x1080 60Hz 16:9 4ms IPS 300Nit - Manufacturer Refurbished', 'assets/img/products/display/11.webp', 159.99 , 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'HP Inc. U32"', '4K HDR Monitor 31.5" 4K UHD (3840 x 2160) 30-60 Hz', 'assets/img/products/display/12.webp', 409.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'ViewSonic VA1655 15.6"', '1080p Portable IPS Monitor with Mobile Ergonomics, USB-C and Mini HDMI for Home and Office', 'assets/img/products/display/13.webp', 139.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 32"', 'LC32R500FHNXZA-RB 32" FHD Curved BezelLess Monitor Certified Refurbished', 'assets/img/products/display/14.webp', 189.99, 2);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 32BN67U-B 31.5"', '4K UHD LED Gaming LCD Monitor - 16:9 - Textured Black - 32" Class - In-plane Switching (IPS) Technology - 3840 x 2160', 'assets/img/products/display/15.webp', 485.99 , 2);



-- -----------------------------------------------------
-- PS5 Games
-- -----------------------------------------------------
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'God of War Ragnarök', 'Those Who Break Fate: Atreus hungers for knowledge to help him understand the prophecy of “Loki” and the role he is to play in Ragnarök.', 'assets/img/products/ps5/1.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Call of Duty: Modern Warfare II', 'Drops players into an unprecedented global conflict', 'assets/img/products/ps5/2.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Dead Island 2', 'Horror, dark humor and over the top zombie-slaying', 'assets/img/products/ps5/3.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Star Wars Jedi: Survivor', 'The “Rebel Hero” Cosmetic - Evoke the heroism of Luke Skywalker™ with this outfit modeled after his iconic yellow jacket worn in STAR WARS: A New Hope.', 'assets/img/products/ps5/4.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Hogwarts Legacy', 'YOUR LEGACY IS WHAT YOU MAKE OF IT - For the first time, experience Hogwarts in the 1800s. Your character is a student who holds the key to an ancient secret that threatens to tear the wizarding world apart.', 'assets/img/products/ps5/5.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Grand Theft Auto V', 'Includes Grand Theft Auto V: Story Mode and Grand Theft Auto Online.', 'assets/img/products/ps5/6.webp', 39.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'FIFA 23', 'Matchday Experience - From augmented reality broadcast replays to hyper-realistic', 'assets/img/products/ps5/7.webp', 29.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Marvels Spider-Man', 'Extra Skill Points – Learn new powers and combat abilities more quickly with extra skill points to spend.', 'assets/img/products/ps5/8.webp', 49.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LEGO Star Wars', 'Explore the Saga in Any Order – Players can dive into the Skywalker saga and access any of the nine saga films right away in any order they choose. They can direct where to go and how to play.', 'assets/img/products/ps5/9.webp', 39.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Ratchet & Clank', 'The intergalactic adventurers are back with a bang. Help them stop a robotic emperor intent on conquering cross-dimensional worlds, with their own universe next in the firing line.', 'assets/img/products/ps5/10.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Gran Turismo 7', 'Fast loading: The PS5 console’s ultra-high-speed SSD lets you quickly start race events, gather in lobbies, browse your garage and seamlessly navigate GT7’s modes and menus.', 'assets/img/products/ps5/11.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Final Fantasy XVI', 'Titanic Clashes - When rival Dominants come head to head, epic battles between their Eikons ensue!', 'assets/img/products/ps5/12.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Resident Evil 4', 'Fan favorite characters and gameplay, Reawaken a Classic Resident Evil 4 ', 'assets/img/products/ps5/13.webp', 59.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'The Last of Us Part 1', 'Fast loading: Initial loading times are near instant, and seamless after the first instance thanks to the PS5 console’s SSD – so you can pick up where you left off in the story and load specific encounters and chapters more quickly.', 'assets/img/products/ps5/14.webp', 69.99, 3);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'NHL 23', 'CROSS-PLATFORM MATCHMAKING with stumble actions, loose puck plays, and Enhanced goalie AI', 'assets/img/products/ps5/15.webp', 59.99, 3);

-- -----------------------------------------------------
-- TV
-- -----------------------------------------------------
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'VIZIO D-Series 32"', 'Class 720p Full-Array LED HD Smart TV - D32h-J09', 'assets/img/products/TV/1.webp', 199.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'VIZIO V-Series 50"', 'Class 4K HDR Smart TV - V505-J09', 'assets/img/products/TV/2.webp', 269.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 55"', 'Class 4K UHD Smart LED TV - 55UQ7570PUJ', 'assets/img/products/TV/3.webp', 399.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 32"', '720p Smart HD LED TV - Black (UN32M4500)', 'assets/img/products/TV/4.webp', 199.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Hisense 50"', '4K UHD Smart Google TV - 50A6H', 'assets/img/products/TV/5.webp', 249.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 65"', 'The Frame Smart 4K UHD TV - Charcoal Black (QN65LS03B)', 'assets/img/products/TV/6.webp', 1799.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Westinghouse 50"', '4K UHD LED Roku Smart TV', 'assets/img/products/TV/7.webp', 279.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Element 70"', '4K UHD Roku Smart TV', 'assets/img/products/TV/8.webp', 529.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 43"', 'Class 4K UHD Smart LED TV - 43UQ9000PUD', 'assets/img/products/TV/9.webp', 399.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 50"', 'Crystal UHD 4K Smart TV - (UN50TU690T)', 'assets/img/products/TV/10.webp', 349.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 55"', 'Smart QLED 4K UHD TV - Titan Gray (QN55Q60B)', 'assets/img/products/TV/11.webp', 699.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'LG 65"', 'NanoCell 4K UHD Smart LED HDR TV - 65NANO75', 'assets/img/products/TV/12.webp', 899.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 65"', 'class CU8000 UHD 4K Smart TV - Black (UN65CU8000)', 'assets/img/products/TV/13.webp', 649.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Sony 65"', 'Class X80K Series 4K HDR LED with smart Google TV- KD65X80K', 'assets/img/products/TV/14.webp', 8499.99, 4);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung 85"', 'class Q60C QLED UHD 4K Smart TV - Titan Gray (QN85Q60C)', 'assets/img/products/TV/15.webp', 1999.99, 4);

-- -----------------------------------------------------
-- Phones
-- -----------------------------------------------------
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy S23+', '5G (256GB) Unlocked Smartphone – Phantom Black', 'assets/img/products/phone/1.webp', 999.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy S23 Ultra', '5G (256GB) Unlocked Smartphone – Phantom Black', 'assets/img/products/phone/2.webp', 999.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy S23', '5G Unlocked Smartphone', 'assets/img/products/phone/3.webp', 799.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy A23', '55G (64GB) Unlocked Smartphone - Black', 'assets/img/products/phone/4.webp', 299.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy A14', '5G (64GB) Unlocked - Black', 'assets/img/products/phone/5.webp', 199.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy S21 FE', '5G Unlocked (128GB) Smartphone - Graphite', 'assets/img/products/phone/6.webp', 599.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy S20', '5G 128gb Rom 8gb Ram G981 Unlocked Smartphone - Manufacturer Refurbished', 'assets/img/products/phone/7.webp', 199.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Apple iPhone XR', 'Pre-Owned Unlocked (64GB) - Black', 'assets/img/products/phone/8.webp', 399.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Apple iPhone XS', 'Unlocked XS Max Pre-Owned (256GB) GSM/CDMA Phone - Gold', 'assets/img/products/phone/9.webp', 419.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Google Pixel 7 Pro', '5G Unlocked (128GB) Smartphone', 'assets/img/products/phone/10.webp', 814.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Google Pixel 7', '5G Unlocked (128GB) Smartphone', 'assets/img/products/phone/11.webp', 599.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Nokia 2780 Flip', '(512MB) GSM Verizon Unlocked Phone - Blue', 'assets/img/products/phone/12.webp', 99.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Nokia G100', 'LTE Unlocked (128GB) Smartphone - Blue', 'assets/img/products/phone/13.webp', 199.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'Samsung Galaxy A13', '64GB ROM 4GB RAM A136U GSM Unlocked Smartphone - Black', 'assets/img/products/phone/14.webp', 219.99, 5);
INSERT INTO product (name, description, image_url, price, category_id) VALUES ( 'BLU Studio X5', 'LTE Unlocked (4GB) GSM Smartphone - Black', 'assets/img/products/phone/15.webp', 79.99, 5);



--
-- Dumping data for table `state`
--


INSERT INTO `city` VALUES
                        (1,'Acre',1),
                        (2,'Alagoas',1),
                        (3,'Amapá',1),
                        (4,'Amazonas',1),
                        (5,'Bahia',1),
                        (6,'Ceará',1),
                        (7,'Distrito Federal',1),
                        (8,'Espírito Santo',1),
                        (9,'Goiás',1),
                        (10,'Maranhão',1),
                        (11,'Mato Grosso do Sul',1),
                        (12,'Mato Grosso',1),
                        (13,'Minas Gerais',1),
                        (14,'Paraná',1),
                        (15,'Paraíba',1),
                        (16,'Pará',1),
                        (17,'Pernambuco',1),
                        (18,'Piaui',1),
                        (19,'Rio de Janeiro',1),
                        (20,'Rio Grande do Norte',1),
                        (21,'Rio Grande do Sul',1),
                        (22,'Rondônia',1),
                        (23,'Roraima',1),
                        (24,'Santa Catarina',1),
                        (25,'Sergipe',1),
                        (26,'São Paulo',1),
                        (27,'Tocantins',1),
                        (28,'Alberta',2),
                        (29,'British Columbia',2),
                        (30,'Manitoba',2),
                        (31,'New Brunswick',2),
                        (32,'Newfoundland and Labrador',2),
                        (33,'Northwest Territories',2),
                        (34,'Nova Scotia',2),
                        (35,'Nunavut',2),
                        (36,'Ontario',2),
                        (37,'Prince Edward Island',2),
                        (38,'Quebec',2),
                        (39,'Saskatchewan',2),
                        (40,'Yukon',2),
                        (41,'Baden-Württemberg',3),
                        (42,'Bavaria',3),
                        (43,'Berlin',3),
                        (44,'Brandenburg',3),
                        (45,'Bremen',3),
                        (46,'Hamburg',3),
                        (47,'Hesse',3),
                        (48,'Lower Saxony',3),
                        (49,'Mecklenburg-Vorpommern',3),
                        (50,'North Rhine-Westphalia',3),
                        (51,'Rhineland-Palatinate',3),
                        (52,'Saarland',3),
                        (53,'Saxony',3),
                        (54,'Saxony-Anhalt',3),
                        (55,'Schleswig-Holstein',3),
                        (56,'Thuringia',3),
                        (57,'Andhra Pradesh',4),
                        (58,'Arunachal Pradesh',4),
                        (59,'Assam',4),
                        (60,'Bihar',4),
                        (61,'Chhattisgarh',4),
                        (62,'Goa',4),
                        (63,'Gujarat',4),
                        (64,'Haryana',4),
                        (65,'Himachal Pradesh',4),
                        (66,'Jammu & Kashmir',4),
                        (67,'Jharkhand',4),
                        (68,'Karnataka',4),
                        (69,'Kerala',4),
                        (70,'Madhya Pradesh',4),
                        (71,'Maharashtra',4),
                        (72,'Manipur',4),
                        (73,'Meghalaya',4),
                        (74,'Mizoram',4),
                        (75,'Nagaland',4),
                        (76,'Odisha',4),
                        (77,'Punjab',4),
                        (78,'Rajasthan',4),
                        (79,'Sikkim',4),
                        (80,'Tamil Nadu',4),
                        (81,'Telangana',4),
                        (82,'Tripura',4),
                        (83,'Uttar Pradesh',4),
                        (84,'Uttarakhand',4),
                        (85,'West Bengal',4),
                        (86,'Andaman and Nicobar Islands',4),
                        (87,'Chandigarh',4),
                        (88,'Dadra and Nagar Haveli',4),
                        (89,'Daman & Diu',4),
                        (90,'Lakshadweep',4),
                        (91,'Puducherry',4),
                        (92,'The Government of NCT of Delhi',4),
                        (93,'Alabama',6),
                        (94,'Alaska',6),
                        (95,'Arizona',6),
                        (96,'Arkansas',6),
                        (97,'California',6),
                        (98,'Colorado',6),
                        (99,'Connecticut',6),
                        (100,'Delaware',6),
                        (101,'District Of Columbia',6),
                        (102,'Florida',6),
                        (103,'Georgia',6),
                        (104,'Hawaii',6),
                        (105,'Idaho',6),
                        (106,'Illinois',6),
                        (107,'Indiana',6),
                        (108,'Iowa',6),
                        (109,'Kansas',6),
                        (110,'Kentucky',6),
                        (111,'Louisiana',6),
                        (112,'Maine',6),
                        (113,'Maryland',6),
                        (114,'Massachusetts',6),
                        (115,'Michigan',6),
                        (116,'Minnesota',6),
                        (117,'Mississippi',6),
                        (118,'Missouri',6),
                        (119,'Montana',6),
                        (120,'Nebraska',6),
                        (121,'Nevada',6),
                        (122,'New Hampshire',6),
                        (123,'New Jersey',6),
                        (124,'New Mexico',6),
                        (125,'New York',6),
                        (126,'North Carolina',6),
                        (127,'North Dakota',6),
                        (128,'Ohio',6),
                        (129,'Oklahoma',6),
                        (130,'Oregon',6),
                        (131,'Pennsylvania',6),
                        (132,'Rhode Island',6),
                        (133,'South Carolina',6),
                        (134,'South Dakota',6),
                        (135,'Tennessee',6),
                        (136,'Texas',6),
                        (137,'Utah',6),
                        (138,'Vermont',6),
                        (139,'Virginia',6),
                        (140,'Washington',6),
                        (141,'West Virginia',6),
                        (142,'Wisconsin',6),
                        (143,'Wyoming',6),
                        (144,'Adıyaman',5),
                        (145,'Afyonkarahisar',5),
                        (146,'Ağrı',5),
                        (147,'Aksaray',5),
                        (148,'Amasya',5),
                        (149,'Ankara',5),
                        (150,'Antalya',5),
                        (151,'Ardahan',5),
                        (152,'Artvin',5),
                        (153,'Aydın',5),
                        (154,'Balıkesir',5),
                        (155,'Bartın',5),
                        (156,'Batman',5),
                        (157,'Bayburt',5),
                        (158,'Bilecik',5),
                        (159,'Bingöl',5),
                        (160,'Bitlis',5),
                        (161,'Bolu',5),
                        (162,'Burdur',5),
                        (163,'Bursa',5),
                        (164,'Çanakkale',5),
                        (165,'Çankırı',5),
                        (166,'Çorum',5),
                        (167,'Denizli',5),
                        (168,'Diyarbakır',5),
                        (169,'Düzce',5),
                        (170,'Edirne',5),
                        (171,'Elazığ',5),
                        (172,'Erzincan',5),
                        (173,'Erzurum',5),
                        (174,'Eskişehir',5),
                        (175,'Gaziantep',5),
                        (176,'Giresun',5),
                        (177,'Gümüşhane',5),
                        (178,'Hakkâri',5),
                        (179,'Hatay',5),
                        (180,'Iğdır',5),
                        (181,'Isparta',5),
                        (182,'İstanbul',5),
                        (183,'İzmir',5),
                        (184,'Kahramanmaraş',5),
                        (185,'Karabük',5),
                        (186,'Karaman',5),
                        (187,'Kars',5),
                        (188,'Kastamonu',5),
                        (189,'Kayseri',5),
                        (190,'Kırıkkale',5),
                        (191,'Kırklareli',5),
                        (192,'Kırşehir',5),
                        (193,'Kilis',5),
                        (194,'Kocaeli',5),
                        (195,'Konya',5),
                        (196,'Kütahya',5),
                        (197,'Malatya',5),
                        (198,'Manisa',5),
                        (199,'Mardin',5),
                        (200,'Mersin',5),
                        (201,'Muğla',5),
                        (202,'Muş',5),
                        (203,'Nevşehir',5),
                        (204,'Niğde',5),
                        (205,'Ordu',5),
                        (206,'Osmaniye',5),
                        (207,'Rize',5),
                        (208,'Sakarya',5),
                        (209,'Samsun',5),
                        (210,'Siirt',5),
                        (211,'Sinop',5),
                        (212,'Sivas',5),
                        (213,'Şanlıurfa',5),
                        (214,'Şırnak',5),
                        (215,'Tekirdağ',5),
                        (216,'Tokat',5),
                        (217,'Trabzon',5),
                        (218,'Tunceli',5),
                        (219,'Uşak',5),
                        (220,'Van',5),
                        (221,'Yalova',5),
                        (222,'Yozgat',5),
                        (223,'Zonguldak',5);

SET foreign_key_checks = 1;