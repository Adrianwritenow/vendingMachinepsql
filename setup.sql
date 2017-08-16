DROP DATABASE IF EXISTS vendingMachine;
CREATE DATABASE vendingMachine;

\c vendingMachine;

CREATE TABLE machine(
  machine_id SERIAL PRIMARY KEY,
  bank FLOAT,
  location TEXT
);

CREATE TABLE item(
  item_id SERIAL PRIMARY KEY,
  cost FLOAT,
  name TEXT,
  amount INTEGER,
  machine_id INTEGER REFERENCES machine
);


CREATE TABLE purchase(
  purchase_id SERIAL PRIMARY KEY,
  purchase_time TIMESTAMP,
  machine_id INTEGER REFERENCES machine,
  item_id INTEGER REFERENCES item,
  money_taken FLOAT,
  change_given FLOAT
);

INSERT INTO machine (bank, location)
VALUES(350.75, 'Break Room'),
      (320.65, 'Hallway'),
      (297.75, 'Garage');

INSERT INTO item (cost, name, amount, machine_id)
VALUES
  (1.25,'Snickers',12,(SELECT machine_id FROM machine WHERE location='Break Room')),
  (6.00,'Jack Daniels',10,(SELECT machine_id FROM machine WHERE location ='Break Room')),
  (3.25,'Beef Jerky',6,(SELECT machine_id FROM machine WHERE location ='Break Room')),
  (1.00,'Doritos',10,(SELECT machine_id FROM machine WHERE location='Hallway')),
  (1.00,'Milkyway',8,(SELECT machine_id FROM machine WHERE location='Hallway')),
  (.75,'Gum',12,(SELECT machine_id FROM machine WHERE location='Hallway')),
  (1.00,'Sprite',7,(SELECT machine_id FROM machine WHERE location='Garage')),
  (1.00,'CocaCola',5,(SELECT machine_id FROM machine WHERE location='Garage')),
  (1.00,'Water',10,(SELECT machine_id FROM machine WHERE location='Garage'));

INSERT INTO purchase 
VALUES('2017-08-12 19:10:25',(SELECT machine_id FROM machine WHERE location='Hallway'),(SELECT item_id FROM item WHERE name='Doritos'), 5.00, 4.00),
('2017-08-12 16:15:45',(SELECT machine_id FROM machine WHERE location='Garage'),(SELECT item_id FROM item WHERE name='CocaCola'),1.00,0),
('2017-08-11 09:10:46',(SELECT machine_id FROM machine WHERE location='Break Room'),(SELECT item_id FROM item WHERE name='Jack Daniels'), 10.00, 4.00);

SELECT * FROM machine;
SELECT * FROM item;
SELECT * FROM purchase;
