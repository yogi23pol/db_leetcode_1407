# NOTE :- In this context, it's important to note that the table names used in the examples include underscores and numbers, 
# which differ from the naming conventions used in the LeetCode problem.

Create Table If Not Exists Users_30 
(
id int, 
name varchar(30)
);

Create Table If Not Exists Rides_30 
(
id int, 
user_id int, 
distance int
);

Truncate table Users_30;
insert into Users_30 (id, name) values ('1', 'Alice');
insert into Users_30 (id, name) values ('2', 'Bob');
insert into Users_30 (id, name) values ('3', 'Alex');
insert into Users_30 (id, name) values ('4', 'Donald');
insert into Users_30 (id, name) values ('7', 'Lee');
insert into Users_30 (id, name) values ('13', 'Jonathan');
insert into Users_30 (id, name) values ('19', 'Elvis');

Truncate table Rides_30;
insert into Rides_30 (id, user_id, distance) values ('1', '1', '120');
insert into Rides_30 (id, user_id, distance) values ('2', '2', '317');
insert into Rides_30 (id, user_id, distance) values ('3', '3', '222');
insert into Rides_30 (id, user_id, distance) values ('4', '7', '100');
insert into Rides_30 (id, user_id, distance) values ('5', '13', '312');
insert into Rides_30 (id, user_id, distance) values ('6', '19', '50');
insert into Rides_30 (id, user_id, distance) values ('7', '7', '120');
insert into Rides_30 (id, user_id, distance) values ('8', '19', '400');
insert into Rides_30 (id, user_id, distance) values ('9', '7', '230');

/*
Q. Write an SQL query to report the distance traveled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users traveled the same distance, order them by their name in ascending order.
The query result format is in the following example.

Input: 
Users table:
+------+-----------+
| id   | name      |
+------+-----------+
| 1    | Alice     |
| 2    | Bob       |
| 3    | Alex      |
| 4    | Donald    |
| 7    | Lee       |
| 13   | Jonathan  |
| 19   | Elvis     |
+------+-----------+
Rides table:
+------+----------+----------+
| id   | user_id  | distance |
+------+----------+----------+
| 1    | 1        | 120      |
| 2    | 2        | 317      |
| 3    | 3        | 222      |
| 4    | 7        | 100      |
| 5    | 13       | 312      |
| 6    | 19       | 50       |
| 7    | 7        | 120      |
| 8    | 19       | 400      |
| 9    | 7        | 230      |
+------+----------+----------+
Output: 
+----------+--------------------+
| name     | travelled_distance |
+----------+--------------------+
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |
+----------+--------------------+
Explanation: 
Elvis and Lee traveled 450 miles, Elvis is the top traveler as his name is alphabetically smaller than Lee.
Bob, Jonathan, Alex, and Alice have only one ride and we just order them by the total distances of the ride.
Donald did not have any rides, the distance traveled by him is 0.
*/

SELECT * FROM Users_30;
SELECT * FROM Rides_30;

# TYPE 1: IFNULL
SELECT u.name, IFNULL(SUM(r.distance),0) AS travelled_distance
FROM Users_30 AS u
LEFT JOIN Rides_30 AS r 
ON u.id = r.user_id
GROUP BY u.name
ORDER BY travelled_distance DESC, u.name;

# TYPE 2: COALESCE
SELECT u.name, COALESCE(SUM(r.distance),0) AS travelled_distance
FROM Users_30 AS u
LEFT JOIN Rides_30 AS r 
ON u.id = r.user_id
GROUP BY u.name
ORDER BY travelled_distance DESC, u.name;