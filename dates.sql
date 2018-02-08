-- Create a birthday table
CREATE TABLE friends (
    name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME); 

-- Insert people and their birthdays 
INSERT INTO friends (name, birthdate, birthtime, birthdt)
    VALUES ('Lusi', '1990-11-20', '10:00:00', '1990-11-20 10:00:00');
INSERT INTO friends (name, birthdate, birthtime, birthdt)
    VALUES ('Jimmy', '1991-11-16', '3:07:40', '1991-11-16 3:07:40');
INSERT INTO friends (name, birthdate, birthtime, birthdt)
    VALUES ('Rose', '1994-03-13', '12:34:05', '1994-03-13 12:34:05');
INSERT INTO friends (name, birthdate, birthtime, birthdt)
    VALUES ('Fiona', '1993-12-14', '5:23:41', '1993-12-14 5:23:41');
INSERT INTO friends (name, birthdate, birthtime, birthdt)
    VALUES ('Jennifer', '1990-08-15', '2:40:00', '1990-08-15 2:40:00');
    
-- View the table 
SELECT * FROM friends;

-- Meaningful Info
-- Day of Birth 
SELECT CONCAT (name, ' ', DATE_FORMAT(birthdt, 'was born on a %W.')) as 'Day of Birth?' FROM friends;
-- Day of Year 
SELECT CONCAT (name, ' ', 'was born on the', ' ', DAYOFYEAR(birthdate), ' ', 'day of the year.') as 'Day of Year' FROM friends;
-- Days Alive Since Born
SELECT CONCAT (name, ' ', 'is alive for', ' ', DATEDIFF(NOW(), birthdate), ' ', 'days.') as 'Days Alive Since Born' FROM friends;

-- Interesting Fact
-- 1 month after the date of birth
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM friends;
--  3 quarters after the date of birth
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 3 QUARTER) FROM friends;
-- 5 months before birth
SELECT birthdt, birthdt - INTERVAL 5 MONTH FROM friends;

-- Create a Tweet Table 
CREATE TABLE tweet (
    username VARCHAR(20),
    content VARCHAR(140),
    created_at TIMESTAMP DEFAULT NOW());
    
INSERT INTO tweet (username, content)
    VALUES('kedithecat', 'Hey, I am Kedi!');
        
INSERT INTO tweet (username, content)
    VALUES('kedithecat', 'I have many talents. Meow!');

INSERT INTO tweet (username, content)
    VALUES('jedithecat', 'I love to eat a lot.');

INSERT INTO tweet (username, content)
    VALUES('jedithecat', 'I am very good at sleeping!');
    
 -- Current Time
SELECT CURDATE();
SELECT DATE_FORMAT (NOW(), '%W');
SELECT DATE_FORMAT (NOW(), '%w');
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');
