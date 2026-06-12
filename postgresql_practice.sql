-- ============================================================
-- PostgreSQL Basics — Full Practice Script (Pixar Database)
-- ============================================================
-- A runnable PostgreSQL script covering: SELECT, WHERE, LIKE,
-- ORDER BY, DISTINCT, LIMIT/OFFSET, JOINs, NULL handling,
-- expressions/aliases, aggregates, GROUP BY, HAVING,
-- INSERT, UPDATE, DELETE, CREATE TABLE, ALTER TABLE, DROP TABLE.
--
-- Companion notes: postgresql_basics.md
-- ============================================================


-- ============================================================
-- PART 1: SCHEMA SETUP (DDL — Data Definition Language)
-- ============================================================
-- Run these once to create the tables used throughout this file.

DROP TABLE IF EXISTS boxoffice;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS north_american_cities;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS buildings;

-- Table 1 / 3: movies
CREATE TABLE movies (
    id              INTEGER PRIMARY KEY,
    title           TEXT,
    director        TEXT,
    year            INTEGER,
    length_minutes  INTEGER
);

-- Table 2: north_american_cities
CREATE TABLE north_american_cities (
    city        TEXT,
    country     TEXT,
    population  INTEGER,
    latitude    NUMERIC,
    longitude   NUMERIC
);

-- Table 4: boxoffice
-- movie_id is a FOREIGN KEY referencing movies.id (relational link)
CREATE TABLE boxoffice (
    movie_id              INTEGER REFERENCES movies(id),
    rating                NUMERIC,
    domestic_sales        BIGINT,
    international_sales   BIGINT
);

-- Table 5: buildings
CREATE TABLE buildings (
    building_name  TEXT PRIMARY KEY,
    capacity       INTEGER
);

-- Table 6: employees
-- building is a FOREIGN KEY referencing buildings.building_name
-- (allows NULL — some employees are not assigned to a building)
CREATE TABLE employees (
    role            TEXT,
    name            TEXT,
    building        TEXT REFERENCES buildings(building_name),
    years_employed  INTEGER
);


-- ============================================================
-- PART 2: SAMPLE DATA (DML — Inserting Records)
-- ============================================================

-- movies: 14 Pixar films
INSERT INTO movies (id, title, director, year, length_minutes) VALUES
(1,  'Toy Story',            'John Lasseter',   1995, 81),
(2,  'A Bug''s Life',        'John Lasseter',   1998, 95),
(3,  'Toy Story 2',          'John Lasseter',   1999, 93),
(4,  'Monsters, Inc.',       'Pete Docter',     2001, 92),
(5,  'Finding Nemo',         'Andrew Stanton',  2003, 107),
(6,  'The Incredibles',      'Brad Bird',       2004, 116),
(7,  'Cars',                 'John Lasseter',   2006, 117),
(8,  'Ratatouille',          'Brad Bird',       2007, 115),
(9,  'WALL-E',                'Andrew Stanton',  2008, 104),
(10, 'Up',                   'Pete Docter',     2009, 101),
(11, 'Toy Story 3',          'Lee Unkrich',     2010, 103),
(12, 'Cars 2',               'John Lasseter',   2011, 120),
(13, 'Brave',                'Brenda Chapman',  2012, 102),
(14, 'Monsters University',  'Dan Scanlon',     2013, 110);

-- north_american_cities: 12 cities across Canada, US, Mexico, Cuba
INSERT INTO north_american_cities (city, country, population, latitude, longitude) VALUES
('Guadalajara',          'Mexico',         1500800, 20.659699,  -103.349609),
('Toronto',               'Canada',         2795060, 43.653226, -79.383184),
('Houston',                'United States',  2195914, 29.760427, -95.369804),
('New York',              'United States',  8405837, 40.712784, -74.005941),
('Philadelphia',          'United States',  1553165, 39.952584, -75.165222),
('Havana',                 'Cuba',           2106146, 23.05407,  -82.345189),
('Mexico City',           'Mexico',         8555500, 19.432608, -99.133209),
('Phoenix',                'United States',  1513367, 33.448377, -112.074037),
('Los Angeles',           'United States',  3884307, 34.052234, -118.243685),
('Ecatepec de Morelos',   'Mexico',         1742000, 19.601841, -99.050674),
('Montreal',               'Canada',         1717767, 45.501689, -73.567256),
('Chicago',                'United States',  2718782, 41.878114, -87.629798);

-- boxoffice: ratings + sales linked to movies.id via movie_id
INSERT INTO boxoffice (movie_id, rating, domestic_sales, international_sales) VALUES
(1,  8.3, 191796233, 170162503),
(2,  7.2, 162798565, 200600000),
(3,  7.9, 245852179, 239163000),
(4,  8.1, 289916256, 272900000),
(5,  8.2, 380843261, 555900000),
(6,  8.0, 261441092, 370001000),
(7,  7.2, 244082982, 217900167),
(8,  8.0, 206445654, 417277164),
(9,  8.5, 223808164, 297503696),
(10, 8.3, 293004164, 438338580),
(11, 8.4, 415004880, 648167031),
(12, 6.4, 191452396, 368400000),
(13, 7.2, 237283207, 301700000),
(14, 7.4, 268492764, 475066843);

-- buildings: 4 office buildings with seat capacity
INSERT INTO buildings (building_name, capacity) VALUES
('1e', 24),
('1w', 32),
('2e', 16),
('2w', 20);

-- employees: 15 staff — some unassigned (building = NULL)
INSERT INTO employees (role, name, building, years_employed) VALUES
('Engineer', 'Becky A.',  '1e',  4),
('Engineer', 'Dan B.',    '1e',  2),
('Engineer', 'Sharon F.', '1e',  6),
('Engineer', 'Dan M.',    '1e',  4),
('Engineer', 'Malcolm S.','1e',  1),
('Artist',   'Taylar S.', '2w',  2),
('Artist',   'Sherman D.','2w',  8),
('Artist',   'Jakob J.',  '2w',  6),
('Artist',   'Lilia A.',  '2w',  7),
('Artist',   'Brandon J.','2w',  7),
('Manager',  'Scott K.',  '1e',  9),
('Manager',  'Shirlee M.','1e',  3),
('Manager',  'Daria O.',  '2w',  6),
('Engineer', 'Yancy I.',  NULL,  0),
('Artist',   'Oliver P.', NULL,  0);


-- ============================================================
-- PART 3: PRACTICE QUERIES (SELECT) — Exercises 1–12
-- ============================================================


-- ─────────────────────────────────────────────
-- Exercise 1: Basic SELECT
-- THEORY: SELECT col1, col2 FROM table; retrieves specific columns.
--         SELECT * FROM table; retrieves ALL columns.
-- ─────────────────────────────────────────────

-- Find the title of each film
SELECT title FROM movies;

-- Find the director of each film
SELECT director FROM movies;

-- Find the title and director of each film
SELECT title, director FROM movies;

-- Find the title and year of each film
SELECT title, year FROM movies;

-- Find all the information about each film
SELECT * FROM movies;


-- ─────────────────────────────────────────────
-- Exercise 2: WHERE — filtering rows
-- THEORY: WHERE filters rows BEFORE they're returned.
--         Operators: = != < > <= >= BETWEEN...AND  AND / OR / NOT
-- ─────────────────────────────────────────────

-- Find the movie with a row id of 6
SELECT id, title
FROM movies
WHERE id = 6;

-- Find the movies released between 2000 and 2010 (inclusive)
SELECT title, year
FROM movies
WHERE year BETWEEN 2000 AND 2010;

-- Find the movies NOT released between 2000 and 2010
SELECT title, year
FROM movies
WHERE year < 2000 OR year > 2010;

-- Find the first 5 Pixar movies and their release year
SELECT title, year
FROM movies
WHERE year <= 2003;


-- ─────────────────────────────────────────────
-- Exercise 3: LIKE — pattern matching
-- THEORY: % = zero or more characters, _ = exactly one character.
--         PostgreSQL LIKE is case-sensitive; use ILIKE for case-insensitive.
--         NOTE: PostgreSQL requires single quotes for string literals.
-- ─────────────────────────────────────────────

-- Find all the Toy Story movies
SELECT title, director FROM movies
WHERE title LIKE 'Toy Story%';

-- Find all the movies directed by John Lasseter
SELECT title, director FROM movies
WHERE director = 'John Lasseter';

-- Find all the movies (and director) NOT directed by John Lasseter
SELECT title, director FROM movies
WHERE director != 'John Lasseter';

-- Find all the WALL-* movies (single-character wildcard with _)
SELECT * FROM movies
WHERE title LIKE 'WALL-_';


-- ─────────────────────────────────────────────
-- Exercise 4: ORDER BY, DISTINCT, LIMIT, OFFSET
-- THEORY: ORDER BY sorts (ASC default / DESC).
--         DISTINCT removes duplicate rows.
--         LIMIT n returns max n rows. OFFSET m skips first m rows.
-- ─────────────────────────────────────────────

-- List all directors alphabetically, without duplicates
SELECT DISTINCT director FROM movies
ORDER BY director ASC;

-- List the last four Pixar movies released (most recent first)
SELECT title, year FROM movies
ORDER BY year DESC
LIMIT 4;

-- List the first five Pixar movies sorted alphabetically
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5;

-- List the next five Pixar movies sorted alphabetically (pagination: page 2)
SELECT title FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;


-- ─────────────────────────────────────────────
-- Review 1: north_american_cities — sorting by geography
-- THEORY: Latitude → North/South (higher = further North → DESC for N→S).
--         Longitude → East/West (more negative = further West).
-- ─────────────────────────────────────────────

-- List all Canadian cities and their populations
SELECT city, population FROM north_american_cities
WHERE country = 'Canada';

-- Order all US cities by latitude, north to south
SELECT city, latitude FROM north_american_cities
WHERE country = 'United States'
ORDER BY latitude DESC;

-- List cities west of Chicago, ordered west to east
-- (Correct version — uses longitude, not latitude, for E/W ordering)
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;

-- List the two largest cities in Mexico by population
SELECT city, population FROM north_american_cities
WHERE country = 'Mexico'
ORDER BY population DESC
LIMIT 2;

-- List the 3rd and 4th largest US cities by population
SELECT city, population FROM north_american_cities
WHERE country = 'United States'
ORDER BY population DESC
LIMIT 2 OFFSET 2;


-- ─────────────────────────────────────────────
-- Exercise 6: JOIN — combining movies + boxoffice
-- THEORY: JOIN (= INNER JOIN) returns only rows that match in BOTH tables.
--         Match movies.id with boxoffice.movie_id (foreign key relationship).
-- ─────────────────────────────────────────────

-- Find the domestic and international sales for each movie
SELECT title, domestic_sales, international_sales
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

-- Show movies that did better internationally than domestically
SELECT title, domestic_sales, international_sales
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
WHERE international_sales > domestic_sales;

-- List all movies by their rating, descending
SELECT title, rating
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
ORDER BY rating DESC;


-- ─────────────────────────────────────────────
-- Exercise 7: LEFT JOIN — buildings + employees
-- THEORY: LEFT JOIN keeps ALL rows from the left table (buildings),
--         even if there's no match in the right table (employees).
--         Unmatched columns from the right table become NULL.
-- ─────────────────────────────────────────────

-- Find the list of all buildings that HAVE employees
SELECT DISTINCT building FROM employees;

-- Find the list of all buildings and their capacity
SELECT building_name, capacity FROM buildings;

-- List all buildings and the distinct employee roles in each
-- (including empty buildings, via LEFT JOIN)
SELECT DISTINCT building_name, role
FROM buildings
  LEFT JOIN employees
    ON building_name = building;


-- ─────────────────────────────────────────────
-- Exercise 8: NULL handling
-- THEORY: NULL = "unknown/missing". Never use "= NULL" — always use
--         IS NULL / IS NOT NULL. Any arithmetic with NULL returns NULL.
-- ─────────────────────────────────────────────

-- Find the name and role of employees not assigned to a building
SELECT name, role FROM employees
WHERE building IS NULL;

-- Find the names of buildings that hold NO employees
SELECT DISTINCT building_name
FROM buildings
  LEFT JOIN employees
    ON building_name = building
WHERE role IS NULL;

-- BONUS: COALESCE — replace NULL with a fallback value
SELECT name, COALESCE(building, 'Unassigned') AS building
FROM employees;


-- ─────────────────────────────────────────────
-- Exercise 9: Expressions & Aliases (AS)
-- THEORY: SQL can compute expressions in SELECT (arithmetic, %, etc.)
--         AS gives the computed/result column a readable name.
--         NOTE: integer division truncates — use a decimal divisor
--         (e.g. / 1000000.0) if you need fractional results.
-- ─────────────────────────────────────────────

-- List all movies and their combined sales in millions of dollars
SELECT title,
       (domestic_sales + international_sales) / 1000000 AS gross_sales_millions
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

-- List all movies and their ratings in percent
SELECT title, rating * 10 AS rating_percent
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

-- List all movies released in even-numbered years (% = modulo)
SELECT title, year
FROM movies
WHERE year % 2 = 0;

-- BONUS: String functions — readable label via CONCAT
SELECT CONCAT(title, ' (', year, ')') AS movie_label
FROM movies;


-- ─────────────────────────────────────────────
-- Exercise 10: Aggregate Functions
-- THEORY: COUNT, SUM, AVG, MAX, MIN summarize multiple rows into one value.
--         Without GROUP BY, they aggregate the ENTIRE table into one row.
-- ─────────────────────────────────────────────

-- Find the longest time an employee has been at the studio
SELECT MAX(years_employed) AS max_years_employed
FROM employees;

-- For each role, find the average years employed
SELECT role, AVG(years_employed) AS average_years_employed
FROM employees
GROUP BY role;

-- Find the total employee-years worked in each building
SELECT building, SUM(years_employed) AS total_years_employed
FROM employees
GROUP BY building;

-- BONUS: COUNT(*) vs COUNT(col) vs COUNT(DISTINCT col)
SELECT
    COUNT(*)                  AS total_rows,
    COUNT(director)           AS non_null_directors,
    COUNT(DISTINCT director)  AS unique_directors
FROM movies;


-- ─────────────────────────────────────────────
-- Exercise 11: GROUP BY + HAVING
-- THEORY: GROUP BY groups rows by a column's value so aggregates run
--         PER GROUP. HAVING filters those groups AFTER aggregation
--         (unlike WHERE, which filters rows BEFORE grouping).
--         RULE: Every non-aggregated SELECT column must be in GROUP BY.
-- ─────────────────────────────────────────────

-- Find the number of Artists (without HAVING — filter rows first)
SELECT role, COUNT(*) AS number_of_artists
FROM employees
WHERE role = 'Artist'
GROUP BY role;

-- Find the number of employees of each role
SELECT role, COUNT(*)
FROM employees
GROUP BY role;

-- Find the total years employed by all Engineers (HAVING filters the group)
SELECT role, SUM(years_employed)
FROM employees
GROUP BY role
HAVING role = 'Engineer';

-- BONUS: HAVING with an aggregate condition (only roles with 5+ employees)
SELECT role, COUNT(*) AS employee_count
FROM employees
GROUP BY role
HAVING COUNT(*) >= 5;


-- ─────────────────────────────────────────────
-- Exercise 12: GROUP BY with JOIN
-- THEORY: You can JOIN tables first, then GROUP BY a column from
--         either table to aggregate combined data per group.
-- ─────────────────────────────────────────────

-- Find the number of movies each director has directed
SELECT director, COUNT(id) AS num_movies_directed
FROM movies
GROUP BY director;

-- Find total domestic + international sales attributed to each director
SELECT director,
       SUM(domestic_sales + international_sales) AS cumulative_sales_from_all_movies
FROM movies
    INNER JOIN boxoffice
        ON movies.id = boxoffice.movie_id
GROUP BY director;


-- ============================================================
-- PART 4: DML EXERCISES — INSERT / UPDATE / DELETE
-- ============================================================
-- ⚠️ WARNING: These statements MODIFY the data inserted in Part 2.
-- Running them will change the result of earlier SELECT queries.
-- If you want to re-run Part 3 with the original dataset afterward,
-- re-run Part 1 + Part 2 first to reset the tables.
--
-- NOTE: The id = 4 used below was from the original exercise's
-- smaller starter dataset. In THIS dataset, id 4 is already used by
-- "Monsters, Inc." To run this safely without a primary key conflict,
-- use a new unused id (e.g. 15) as shown below.
-- ============================================================


-- ─────────────────────────────────────────────
-- Exercise 13: INSERT INTO — adding rows
-- THEORY: INSERT INTO table (columns) VALUES (...) adds a new row.
--         Always specify column names for clarity and safety.
-- ─────────────────────────────────────────────

-- Add the studio's new production, Toy Story 4, to the movies table
INSERT INTO movies (id, title, director, year, length_minutes)
VALUES (15, 'Toy Story 4', 'El Directore', 2015, 90);

-- Toy Story 4 had a rating of 8.7, made 340M domestically and 270M
-- internationally. Add the record to the boxoffice table.
INSERT INTO boxoffice (movie_id, rating, domestic_sales, international_sales)
VALUES (15, 8.7, 340000000, 270000000);


-- ─────────────────────────────────────────────
-- Exercise 14: UPDATE — modifying existing rows
-- THEORY: UPDATE table SET col = value WHERE condition.
--         ⚠️ ALWAYS include a WHERE clause — without it, EVERY row
--         in the table gets updated.
-- ─────────────────────────────────────────────

-- The director for A Bug's Life is incorrect — fix it to John Lasseter
UPDATE movies
SET director = 'John Lasseter'
WHERE id = 2;

-- The year for Toy Story 2 is incorrect — it was released in 1999
UPDATE movies
SET year = 1999
WHERE id = 3;

-- Multiple columns can be updated in one SET clause (comma-separated)
-- Example: fix both title and director for a misnamed record
UPDATE movies
SET title = 'Toy Story 3', director = 'Lee Unkrich'
WHERE id = 11;


-- ─────────────────────────────────────────────
-- Exercise 15: DELETE — removing rows
-- THEORY: DELETE FROM table WHERE condition.
--         ⚠️ ALWAYS include a WHERE clause — without it, ALL rows
--         in the table are permanently removed.
-- ─────────────────────────────────────────────

-- Remove all movies released before 2005
DELETE FROM movies
WHERE year < 2005;

-- Remove all movies directed by Andrew Stanton
DELETE FROM movies
WHERE director = 'Andrew Stanton';


-- ============================================================
-- PART 5: DDL EXERCISES — CREATE TABLE / ALTER TABLE / DROP TABLE
-- ============================================================
-- ⚠️ WARNING: DROP TABLE permanently deletes a table and ALL its data.
-- The DROP statements at the end of this section are commented out
-- by default — uncomment only if you intend to remove those tables.
-- ============================================================


-- ─────────────────────────────────────────────
-- Exercise 16: CREATE TABLE
-- THEORY: CREATE TABLE name (column DATATYPE, ...) defines a new,
--         empty table. Common types: TEXT, INTEGER, FLOAT/NUMERIC,
--         BOOLEAN, DATE, SERIAL (auto-incrementing).
-- ─────────────────────────────────────────────

-- Create a table named "database" with: Name (text), Version (float),
-- Download_count (integer)
-- NOTE: lowercase used for the table name — "database" is a reserved
-- keyword in some contexts; quoting avoids ambiguity if needed.
CREATE TABLE database_info (
    name            TEXT,
    version         FLOAT,
    download_count  INTEGER
);


-- ─────────────────────────────────────────────
-- Exercise 17: ALTER TABLE — modifying table structure
-- THEORY: ALTER TABLE adds/removes/renames columns or changes types
--         on an EXISTING table. ADD COLUMN ... DEFAULT applies that
--         default value to all existing rows.
-- ─────────────────────────────────────────────

-- Add an Aspect_ratio column (FLOAT, default 2.39) to movies
ALTER TABLE movies
  ADD COLUMN aspect_ratio FLOAT DEFAULT 2.39;

-- Add a Language column (TEXT, default 'English') to movies
ALTER TABLE movies
  ADD COLUMN language TEXT DEFAULT 'English';


-- ─────────────────────────────────────────────
-- Exercise 18: DROP TABLE — removing tables permanently
-- THEORY: DROP TABLE name; deletes the table AND all its data.
--         DROP TABLE IF EXISTS name; avoids an error if the table
--         doesn't exist. This is IRREVERSIBLE without a backup.
-- ─────────────────────────────────────────────

-- Remove the movies table
-- DROP TABLE movies;

-- Remove the boxoffice table
-- DROP TABLE boxoffice;


-- ============================================================
-- 📝 NOTES / EXTRA QUERIES
-- (Add your own practice queries below this line)
-- ============================================================

