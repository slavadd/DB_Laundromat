DROP DATABASE IF EXISTS laundry;
CREATE DATABASE laundry;
USE laundry;

CREATE TABLE customer (
id INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(255), 
last_name VARCHAR(255), 
phone_number VARCHAR(15));


create table laundry_type (
id INT AUTO_INCREMENT PRIMARY KEY, 
programs ENUM('Бяло','Цветно','Вълна','Деликатно','Памук'),
clothes ENUM('тениски','блузи','панталони','рокли','връхни дрехи','официално облекло','бельо','чаршафи'), 
display_temperature ENUM('20 C','30 C','40 C', '60 C', '90 C'));


create table laundry_duration (
id INT AUTO_INCREMENT PRIMARY KEY, 
duration ENUM('15','30','45','60','90','120'),
details VARCHAR(255), 
display_name VARCHAR(255));

create table laundry_order (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	laundry_type_id INT NOT NULL,
	laundry_duration_id INT NOT NULL,
    customer_id INT NOT NULL,
	price DECIMAL(4,2),
	hours_to_complete TINYINT,
    discount_coupon VARCHAR(15) NULL,
	created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
	CONSTRAINT FOREIGN KEY (laundry_type_id) REFERENCES laundry_type(id),
	CONSTRAINT FOREIGN KEY (laundry_duration_id) REFERENCES laundry_duration(id),
	CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(id));

	
	INSERT INTO `customer` (`first_name`, `last_name`, `phone_number`)
	VALUES ('Петър','Петров','0885102030'),
	('Григор','Атанасов','089852159'),
    ('Вяра','Костадинов','0887145879'),
    ('Георги','Димитров','0789856214'),
    ('Симона','Янакиева','0899921548'),
    ('Надежда','Стаменова','0981472563'),
    ('Александър','Георгиев','088159357'),
    ('Владислав','Владимиров','0877412365'),
    ('Кристиян','Тодоров','088698325'),
    ('Йоана','Евгениева','087965632');
	

	INSERT INTO `laundry_type` (`programs`, `clothes`, `display_temperature`)
	VALUES 
    (1,7,4),
    (2,3,3),
    (4,4,3),
    (2,5,3),
	(1,8,4),
	(3,2,2),
    (4,6,1),
    (5,1,3);
	
	INSERT INTO `laundry_duration` (`duration` ,`details` , `display_name`)
	VALUES
    (1, 'Експерсно','express'),
	(2, 'Късо','short'),
	(3,'Ежедневно','daily'),
    (4,'Средно','medium'),
    (5,'Нормално','normal'),
    (6,'Дълго','long');
	
	INSERT INTO `laundry_order` (`laundry_type_id`,	`laundry_duration_id`,
    `customer_id`, `price`, `hours_to_complete`, `discount_coupon` )
	VALUES
    (1,1,1,4.5,48,null),
	(4,2,4,8,24,'GHJ898876545'),
	(2,3,5,10.6,24,'IHJ498876545'),
    (7,6,6,50.5,72,null),
    (8,2,7,7.9,8,'STV1258895'),
    (3,5,2,16.7,12,'BDF74265023'),
    (5,4,3,20.9,3,'CDE65322320'),
    (6,1,5,19.9,24,'MNO23659870'),
    (2,4,9,8.9,8,null),
    (5,6,4,22.9,72,'HIJ0025698'),
    (6,5,10,35.9,12,'DEF0985332');
    
    SELECT * FROM customer;
    SELECT * FROM laundry_type;
    SELECT * FROM laundry_duration;
    SELECT * FROM laundry_order;
	
    SELECT customer_id as customer, discount_coupon as coupon
    FROM laundry_order
    WHERE  price>=30;
    
	SELECT customer.first_name as name,
    customer.last_name as surname,
    COUNT(laundry_order.id)
    FROM laundry_order JOIN customer
    ON customer_id=customer.id
    GROUP BY customer_id
    HAVING COUNT(customer_id)>1;
    
    SELECT customer.first_name as name,
    customer.last_name as surname,
    laundry_order.price,
    laundry_order.discount_coupon as coupon
    FROM laundry_order JOIN customer
    ON customer_id=customer.id;
    
    SELECT DISTINCT customer.first_name, customer.last_name,laundry_type.programs, laundry_type.clothes,laundry_type.display_temperature
    FROM customer JOIN laundry_order
    ON customer_id=customer.id
    JOIN laundry_type
    ON laundry_order.laundry_type_id=laundry_type.id
    WHERE laundry_order.discount_coupon='IHJ498876545';
    
    
	SELECT customer.first_name as name,
    customer.last_name as surname,
    laundry_order.price,
    laundry_order.discount_coupon as coupon,
    laundry_order.created_date as date
    FROM laundry_order RIGHT OUTER JOIN customer
    ON customer_id=customer.id;
    
    SELECT laundry_order.customer_id as customer,
    laundry_order.price,
    laundry_type.programs,
    laundry_type.clothes,
    laundry_type.display_temperature, 
    laundry_order.hours_to_complete
    FROM laundry_order JOIN laundry_type
    ON laundry_type_id= laundry_type.id
    ORDER BY display_temperature;
    
	
    
	SELECT customer.first_name as name,
    customer.last_name as surname,
    laundry_type.programs,
    SUM(price) sumPrice 
	FROM laundry_order 
	JOIN laundry_type ON laundry_type.id = laundry_order.laundry_type_id
	RIGHT JOIN customer ON laundry_order.customer_id = customer.id
	GROUP BY customer.first_name, customer.last_name, laundry_type.programs;
    

    
  
  #2 
  
	SELECT MAX(price) as maxPrice, 
    DATE(created_date) as orderDay
	FROM laundry_order 
	GROUP BY DATE(created_date);
     
    SELECT customer_id as customer,
    AVG(price) as averagePrice
    FROM laundry_order
    GROUP BY customer_id;
    
    SELECT customer_id as customer,
    AVG(hours_to_complete) as averageHours
    FROM laundry_order
     GROUP BY customer_id;
    
    SELECT customer_id,
    MIN(price) as minPrice
    FROM laundry_order
    GROUP BY customer_id;
    
  #3
      
	SELECT customer.first_name as name,
    customer.last_name as surname,
    laundry_type.programs,
    laundry_order.price
    FROM laundry_order
    JOIN laundry_type ON laundry_type.id=laundry_order.laundry_type_id
    RIGHT JOIN customer ON laundry_order.customer_id=customer.id;
    
    
    SELECT CONCAT(customer.first_name,' ' ,customer.last_name)fullName,
    laundry_duration.duration, 
    laundry_duration.details,
    laundry_duration.display_name as durationName,
    laundry_order.hours_to_complete as hours,
    laundry_order.discount_coupon as coupon
    FROM laundry_order 
    JOIN laundry_duration ON laundry_duration_id=laundry_duration.id
    RIGHT JOIN customer ON laundry_order.customer_id=customer.id;	

#4    
   
    SELECT customer_id as customer,
    customer.first_name as name,
    customer.last_name as surname,
    SUM(price) as price
    FROM laundry_order JOIN customer
     ON customer_id=customer.id
    GROUP BY customer_id;
   

	SELECT customer_id as customer,
    laundry_duration.duration, 
    laundry_duration.details,
    laundry_duration.display_name as durationName,
    SUM(hours_to_complete) as totalHours
    FROM laundry_order JOIN laundry_duration
	ON laundry_duration_id=laundry_duration.id
    GROUP BY customer_id;
    
    
    
USE laundry;

SELECT customer.last_name, 
laundry_order.price,
laundry_type.programs,
laundry_type.clothes
FROM customer JOIN laundry_order
ON customer_id=customer.id
JOIN laundry_type
ON laundry_order.laundry_type_id=laundry_type.id
JOIN laundry_duration
ON laundry_order.laundry_duration_id=laundry_duration.id
WHERE programs="Деликатно" AND clothes="официално облекло";
        
		 
