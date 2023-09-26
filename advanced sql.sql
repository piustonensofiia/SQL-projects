-- 1) Додати в таблицю Customers новий рядок: ('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY' , '11111', 'USA' , NULL, NULL). 
-- Переконатися, що дані додалися.
INSERT INTO customers VALUES ('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY' , '11111', 'USA' , NULL, NULL)

-- 2) Те саме що й в 1, але явно задати імена стовпчиків, в які вставляються дані. 
-- (попередньо видалити рядок, який був створений в п. 1:  DELETE FROM Customers WHERE cust_id = '1000000006';)
DELETE FROM Customers WHERE cust_id = '1000000006';

INSERT INTO customers (cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES ('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY' , '11111', 'USA' , NULL, NULL);

SELECT * INTO custCopy FROM customers;
INSERT INTO customers (cust_id, cust_name) VALUES ('105', 'xxx');
SELECT * FROM customers;
SELECT * FROM custcopy;
DROP TABLE custcopy;

CREATE TABLE custcopy AS SELECT * FROM customers


-- 8) 8	Для покупця з cust_id = '1000000005' змінити e-mail на 'kim@thetoystore.com'
UPDATE customers SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = '1000000005'

-- 9) Для покупця з cust_id = '1000000006' змінити поле cust_contact на Sam Roberts, а поле cust_email на 'sam@toyland.com'
UPDATE customers SET cust_contact = 'Sam Roberts', cust_email = 'sam@toyland.com'
WHERE cust_id = '1000000006'

-- 10) Для покупця з cust_id = '1000000005' змінити поле cust_email на NULL
UPDATE customers SET cust_email = NULL
WHERE cust_id = '1000000005'

SELECT * FROM customers
-- 11) Видалити покупця з cust_id = '1000000006'
DELETE FROM Customers WHERE cust_id = '1000000006';

-- 12) Виконати 5, після чого видалити всі рядки з таблиці CustCopy
DELETE FROM custcopy

-- 13) Видалити таблицю CustCopy
DROP TABLE custcopy

-- 14) Додати в таблицю Vendors поле vend_phone, що має тип char(20). Переконатися, що поле присутнє
SELECT * FROM vendors
ALTER TABLE vendors ADD vend_phone char(20)

-- 15) Видалити з таблиці Vendors поле vend_phone
ALTER TABLE vendors DROP COLUMN vend_phone

-- 16) Додати в таблицю Orders поля cur_date, cur_time
ALTER TABLE orders ADD cur_date DATE, ADD cur_time TIME
SELECT * FROM orders

-- 17) Для всіх рядків таблиці Orders заповнити поле cur_date поточною датою, cur_time - поточним часом
UPDATE orders SET cur_date = CURRENT_DATE, cur_time = CURRENT_TIME

-- 18) Створити VIEW ProductCustomers: (cust_name, cust_contact, prod_id) з інформацією про тих покупців, що купували товари
CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id FROM (customers JOIN orders ON orders.cust_id = customers.cust_id 
											  JOIN orderitems ON orderitems.order_num = orders.order_num);

-- 19) Користуючись VIEW ProductCustomers вивести тих покупців, що купували товар з prod_id = 'RGAN01'
SELECT * FROM productcustomers 
WHERE prod_id = 'RGAN01';

-- 20) Створити VIEW VendorLocations, в якому міститься наступна інформація: vend_name, vend_country. 
-- Вивести всі рядки з VendorLocations
CREATE VIEW VendorLocations AS
SELECT vend_name, vend_country FROM vendors;
SELECT * FROM VendorLocations;

-- 21) Створити VIEW OrderItemsExpanded, в якому міститься наступна інформація: order_num, …, expanded_price. 
-- Вивести всі рядки з OrderItemExpanded
CREATE VIEW OrderItemsExpanded AS
SELECT order_num, order_item, prod_id, quantity, item_price, (quantity*item_price) AS expanded_price FROM orderitems;
SELECT * FROM OrderItemsExpanded;
					