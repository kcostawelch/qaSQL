USE test_schema;

CREATE TABLE `hero` (
  `hero_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `alias` varchar(45) NOT NULL,
  `ability` varchar(45) NOT NULL,
  `team_id` int DEFAULT NULL,
  PRIMARY KEY (`hero_id`),
  UNIQUE KEY `hero_id_UNIQUE` (`hero_id`),
  KEY `teamid_idx` (`team_id`),
  CONSTRAINT `teamid` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team` (
  `team_id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(15) NOT NULL,
  `team_objective` varchar(200) NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `team_id_UNIQUE` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT into team (team_name, team_objective) values ('JLA','Protect the world'), 
('JSA','Defeat the Nazis'), ('Birds of Prey','Fight crime (without men)'), 
('Task Force X', 'Follow Wallers orders or die'), 
('Teen Titans', 'Teavh young superheroes to be their best');

INSERT into hero (firstname,surname,alias,ability,team_id) values ('Bruce', 'Wayne', 'Batman', 'Martial Arts',1),
('Clark','Kent','Superman','Flight',1), ('Jay','Garrick','The Flash','Super-speed',2),
('Alan','Scott','Green Lantern','Ring Creation',2), ('Helena','Bertenelli','The Huntress','Crossbow Archery',3),
('Dr Harleen','Quinzel','Harley Quinn','Hammer-Fighting',3), ('Floyd','Lawton','Deadshot','Marksmanship',4),
('Cecil','Adams','Count Vertigo','Induce dizziness',4), ('Damian','Wayne','Robin','Swordsmanship',5),
('Dick','Grayson','Nightwing','Acrobatics',5);

CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(15) NOT NULL,
  `colour` varchar(15) NOT NULL,
  `std_cost` decimal(5,2) NOT NULL,
  `list_price` decimal(5,2) NOT NULL,
  `date_available` date NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT into product (product_name,colour,std_cost,list_price,date_available) 
values ('Star Widget','Multi',529.50,670.00,'2023-11-01'),
('Rocket Widget','Multi',555.50,605.00,'2023-11-01'), ('Flying Widget','Multi',532.50,623.00,'2023-11-01'),
('Spinning Widget','Multi',320.50,561.00,'2023-11-01'), ('Rainbow Widget','Multi',435.50,463.00,'2023-11-01'),
('Flying Unicorn','Multi',900.50,989.00,'2023-11-01'), ('Rainbow Unicorn','Multi',958.50,960.00,'2023-11-01'),
('Golden Unicorn','Multi',655.50,786.00,'2023-11-01');

ALTER TABLE hero 
ADD COLUMN product_id int;

ALTER TABLE hero
ADD CONSTRAINT prodID
FOREIGN KEY (product_id) REFERENCES product(product_id);

SELECT *
FROM hero
JOIN team ON hero.team_id=team.team_id
JOIN product ON hero.product_id=product.product_id;

SELECT hero.hero_id,hero.firstname,hero.surname,hero.alias,hero.ability,hero.team_id,
team.team_name,team.team_objective,hero.product_id,product.product_name,product.colour,
product.std_cost,product.list_price,product.date_available
FROM hero
JOIN team ON hero.team_id=team.team_id
JOIN product ON hero.product_id=product.product_id;
