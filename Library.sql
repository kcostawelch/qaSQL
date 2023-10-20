CREATE DATABASE `library`;

USE library;

CREATE TABLE `catalog` (
`book_id` int NOT NULL AUTO_INCREMENT,
`title` varchar(45) NOT NULL,
`author_id` int NOT NULL,
`genre` varchar(45),
`publisher` varchar(45) NOT NULL,
`ISBN` varchar(17) NOT NULL,
`price` decimal(5,2) NOT NULL,
`pub_date` date NOT NULL,
`availability` varchar(10) NOT NULL,
PRIMARY KEY (`book_id`),
UNIQUE KEY `book_id_UNIQUE` (`book_id`)

) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `library_user` (
`user_id` int NOT NULL AUTO_INCREMENT,
`firstname` varchar(45) NOT NULL,
`lastname` varchar(45) NOT NULL,
`address` varchar(45) NOT NULL,
`postcode` varchar(45) NOT NULL,
`email` varchar(17) NOT NULL,
`dob` date NOT NULL,
`date_joined` date NOT NULL,
PRIMARY KEY (`user_id`),
UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `authors` (
`author_id` int NOT NULL AUTO_INCREMENT,
`firstname` varchar(45) NOT NULL,
`lastname` varchar(45) NOT NULL,
PRIMARY KEY (`author_id`),
UNIQUE KEY `author_id_UNIQUE` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transactions` (
`transaction_id` int NOT NULL AUTO_INCREMENT,
`book_id` int NOT NULL,
`user_id` int NOT NULL,
`date_borrowed` date NOT NULL,
`due_date` date NOT NULL,
`date_returned` date,
`book_condition` varchar(17),
PRIMARY KEY (`transaction_id`),
UNIQUE KEY `transaction_id_UNIQUE` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Ensure that auto-incrementing starts from 1;
ALTER TABLE catalog AUTO_INCREMENT=1;
ALTER TABLE authors AUTO_INCREMENT=1;
ALTER TABLE library_user AUTO_INCREMENT=1;
ALTER TABLE transactions AUTO_INCREMENT=1;

INSERT into catalog (title, author_id, genre, publisher, ISBN, price, pub_date, availability)
values ('Extremely Loud and Incredibly Close', 1, 'drama', 'Mariner Books', '978-0547735023', 5.00, "2005-01-01", "Borrowed"),
('Fantastic Mr Fox', 2, 'adventure', 'Puffin', '978-0141346441', 3.20, "2013-02-13", "Available");

INSERT into library_user (firstname, lastname, address, postcode, email, dob, date_joined)
values ('Katie', 'Costa Welch', '64 Zoo Lane', 'ZL3 6BU', 'katie@zoolane.com', '2000-06-24', '2023-10-19'),
 ('Chloe', 'Vu', '10 Downing Street', 'DW17 5PA', 'chloe@mp.com', '2016-10-01', '2023-10-19');
 
 INSERT into authors (firstname, lastname)
 values ('Jonathan', 'Foer'), ('Roald', 'Dahl');
 
 INSERT into transactions (book_id, user_id, date_borrowed, due_date)
 values (1, 1, '2023-10-10', '2023-10-24');
 
 INSERT into transactions (book_id, user_id, date_borrowed, due_date, date_returned, book_condition)
 values (2, 2, '2023-10-06', '2023-10-20', '2023-10-15', 'Damaged');

ALTER TABLE catalog
ADD CONSTRAINT authorid
FOREIGN KEY (author_id) REFERENCES authors(author_id);

ALTER TABLE transactions
ADD CONSTRAINT bookid
FOREIGN KEY (book_id) REFERENCES catalog(book_id);

ALTER TABLE transactions
ADD CONSTRAINT userid
FOREIGN KEY (user_id) REFERENCES library_user(user_id);

-- Query books with author details
SELECT catalog.book_id, catalog.title, catalog.author_id, authors.firstname, authors.lastname, catalog.genre, catalog.publisher, catalog.ISBN, catalog.price, catalog.pub_date, catalog.availability
FROM catalog
INNER JOIN authors ON catalog.author_id=authors.author_id;

-- Query book transactions with additional details
SELECT transactions.transaction_id, transactions.book_id, catalog.title, catalog.author_id, authors.firstname, authors.lastname, transactions.user_id, library_user.firstname, library_user.lastname, 
transactions.date_borrowed, transactions.due_date, transactions.date_returned, transactions.book_condition
FROM transactions
INNER JOIN catalog ON transactions.book_id=catalog.author_id
INNER JOIN authors ON catalog.author_id=authors.author_id
INNER JOIN library_user ON transactions.user_id=library_user.user_id;