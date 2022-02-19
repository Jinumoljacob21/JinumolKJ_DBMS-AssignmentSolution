Create Database if not exists `travel_on_the_go`;
use `travel_on_the_go`;


create table IF NOT EXISTS PASSENGER(
Passenger_name varchar(30), 
Category       varchar(30),
Gender          varchar(10),
Boarding_City   varchar(30),
Destination_City varchar(30),
Distance         int,
Bus_Type         varchar(20)
);


create table IF NOT EXISTS PRICE(
Bus_Type  varchar(20),
Distance  int,
Price     int
 );

insert into passenger values('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
insert into passenger values('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
insert into passenger values('Pallavi','AC','F','panaji','Bengaluru',600,'Sleeper');
insert into passenger values('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
insert into passenger values('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
insert into passenger values('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
insert into passenger values('Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper');
insert into passenger values('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
insert into passenger values('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

select * from passenger;


insert into price values('Sleeper',350,770);
insert into price values('Sleeper',500,1100);
insert into price values('Sleeper',600,1320);
insert into price values('Sleeper',700,1540);
insert into price values('Sleeper',1000,2200);
insert into price values('Sleeper',1200,2640);
insert into price values('Sleeper',1500,2700);
insert into price values('Sitting',500,620);
insert into price values('Sitting',600,744);
insert into price values('Sitting',700,868);
insert into price values('Sitting',1000,1240);
insert into price values('Sitting',1200,1488);
insert into price values('Sitting',1500,1860);

select * from price;

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?


select GENDER,count(GENDER) AS COUNT 
  FROM PASSENGER 
 WHERE DISTANCE>=600 
 GROUP BY GENDER;


-- 4) Find the minimum ticket price for Sleeper Bus.

SELECT MIN(PRICE) AS MINIMUM_PRICE 
  FROM PRICE 
 WHERE BUS_TYPE='sleeper';


-- 5) Select passenger names whose names start with character 'S'


SELECT PASSENGER.*
  FROM PASSENGER 
 WHERE PASSENGER_NAME LIKE 'S%';


-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output


SELECT P.PASSENGER_NAME,P.BOARDING_CITY,P.DESTINATION_CITY,P.BUS_TYPE,PR.PRICE 
  FROM PASSENGER AS P,PRICE AS PR 
 WHERE P.DISTANCE=PR.DISTANCE 
   AND P.BUS_TYPE=PR.BUS_TYPE;


-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s

SELECT P.PASSENGER_NAME ,PR.PRICE 
  FROM PASSENGER AS P,PRICE AS PR  
 WHERE P.BUS_TYPE=PR.BUS_TYPE
   AND P.DISTANCE=PR.DISTANCE 
   AND P.BUS_TYPE='Sitting'  
   AND P.DISTANCE=1000;
 

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT DISTINCT P.PASSENGER_NAME,P.DESTINATION_CITY AS BOARDING_CITY,P.BOARDING_CITY AS DESTINATION_CITY,P.DISTANCE,PR.BUS_TYPE,PR.PRICE 
  FROM PASSENGER P,PRICE PR 
 WHERE P.DISTANCE = PR.DISTANCE
   AND P.BOARDING_CITY='panaji'
   AND P.DESTINATION_CITY ='Bengaluru'
   AND P.PASSENGER_NAME = 'Pallavi';

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.

SELECT  DISTINCT DISTANCE 
  FROM PASSENGER 
 ORDER BY DISTANCE DESC;

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables


SELECT PASSENGER_NAME,DISTANCE,TOTAL_DISTANCE,truncate( DISTANCE *100 /TOTAL_DISTANCE,2)AS PERCENTAGE_OF_DISTANCE  
 FROM(
SELECT PASSENGER_NAME, DISTANCE,(SELECT SUM(DISTANCE)FROM PASSENGER) AS TOTAL_DISTANCE
  FROM PASSENGER)as A;
 
 
-- 11) Display the distance, price in three categories in table Price a) Expensive if the cost is more than 1000 b) Average Cost if the cost is less than 1000 and greater than 500 c) Cheap otherwise

SELECT BUS_TYPE,DISTANCE,PRICE,
CASE
WHEN PRICE>1000 THEN "EXPENSIVE"
WHEN PRICE<1000 AND PRICE>500 THEN "AVERAGE COST"
ELSE "CHEAP"
END AS VERDICT FROM PRICE
ORDER BY VERDICT; 
