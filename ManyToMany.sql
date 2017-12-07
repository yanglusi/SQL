-- Many to Many Relationship
-- Create a Database for TV Series
CREATE DATABASE series;
USE series;

-- Create a Table
CREATE TABLE reviewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE series (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

-- Insert the Data 
INSERT INTO series (title, released_year, genre) VALUES
    ('American Horror Movie', 2011, 'Horror'),
    ('CSI: Crime Scene Investigation', 2000, 'Mystery'),
    ("Monk", 2002, 'Comedy'),
    ('How I Met Your Mother', 2014, 'Comedy'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Family Guy', 1999, 'Comedy'),
    ("The Hunt", 2015, 'Documentary'),
    ('Orange Is the New Black', 2013, 'Comedy'),
    ('Stranger Things', 2016, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');

INSERT INTO reviewers (first_name, last_name) VALUES
    ('Lusi', 'Yang'),
    ('Jimmy', 'Zhan'),
    ('Rose', 'Garrett'),
    ('Fiona', 'Yan'),
    ('Sabrina', 'Page'),
    ('Peter', 'Parker'),
    ('Bruce', 'Wayne');

INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.2),(1,2,7.7),(1,3,8.5),(1,4,8.4),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

-- Find average rating for each movie
SELECT 
    title,
    AVG(rating) as rating
FROM series
JOIN reviews
    ON series.id = reviews.series_id
GROUP BY title
ORDER BY rating;

-- Find the ratings from each reviewer
SELECT 
    title,
    rating,
    CONCAT(first_name,' ', last_name) AS reviewer
FROM reviewers
JOIN reviews
    ON reviewers.id = reviews.reviewer_id
JOIN series
    ON reviewers.id = reviews.series_id;

-- Unreivewed Series 
SELECT 
    title AS unreviewed_series
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
WHERE rating IS NULL;

-- Avg for Each Genre
SELECT 
    genre,
    IFNULL(ROUND(AVG(rating),2), 0) AS avg_rating
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
GROUP BY genre;

-- Analyze Users
SELECT
    first_name,
    last_name,
    count(rating) AS COUNT,
    IFNULL(min(rating),0) AS MIN,
    IFNULL(max(rating),0) AS MAX,
    IFNULL(ROUND(AVG(rating),2), 0) AS AVG,
    IF(COUNT(rating) >= 1, 'ACITVE', 'INACTIVE') AS STATUS
FROM reviewers
LEFT JOIN reviews
    ON reviewers.id = reviews.reviewer_id
GROUP BY first_name
ORDER BY AVG DESC;
