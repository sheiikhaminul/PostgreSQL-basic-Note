# 📘 PostgreSQL Basics — Complete Study Notes

> **Dataset:** Pixar Studio database  
> **Tables:** `movies`, `north_american_cities`, `boxoffice`, `buildings`, `employees`

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 📋 Table of Contents

1. [Introduction to SQL & PostgreSQL](#1-introduction-to-sql--postgresql)
2. [Tables Used in This Guide](#2-tables-used-in-this-guide)
3. [SELECT — Basic Queries](#3-select--basic-queries)
4. [WHERE — Filtering Data](#4-where--filtering-data)
5. [LIKE — Pattern Matching](#5-like--pattern-matching)
6. [ORDER BY · DISTINCT · LIMIT · OFFSET](#6-order-by--distinct--limit--offset)
7. [JOINs — Combining Tables](#7-joins--combining-tables)
8. [NULL Values](#8-null-values)
9. [Expressions & Aliases](#9-expressions--aliases)
10. [Aggregate Functions](#10-aggregate-functions)
11. [GROUP BY](#11-group-by)
12. [HAVING](#12-having)
13. [WHERE vs HAVING vs GROUP BY — Key Differences](#13-where-vs-having-vs-group-by)
14. [INSERT INTO — Adding Rows](#14-insert-into--adding-rows)
15. [UPDATE — Modifying Rows](#15-update--modifying-rows)
16. [DELETE — Removing Rows](#16-delete--removing-rows)
17. [CREATE TABLE](#17-create-table)
18. [ALTER TABLE](#18-alter-table)
19. [DROP TABLE](#19-drop-table)
20. [Quick Reference Cheat Sheet](#20-quick-reference-cheat-sheet)

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 1. Introduction to SQL & PostgreSQL

**SQL** (Structured Query Language) is the standard language for interacting with relational databases — reading, inserting, updating, and deleting data.

**PostgreSQL** (often called *Postgres*) is a powerful open-source relational database that follows the SQL standard closely and adds extra enterprise-grade features.

### How a Relational Database Works

Data lives in **tables** (think spreadsheets). Tables have:
- **Rows** (records) — each row is one entry
- **Columns** (fields) — each column is one attribute of that entry

Tables **relate** to each other through keys:
- **Primary Key** — uniquely identifies each row (e.g., `id`)
- **Foreign Key** — a column in one table that references the primary key of another

### General SQL Query Structure

```sql
SELECT  column1, column2       -- 1. What columns to show
FROM    table_name             -- 2. Which table to look in
WHERE   condition              -- 3. Filter rows (optional)
ORDER BY column ASC|DESC       -- 4. Sort results (optional)
LIMIT   n                      -- 5. Max rows to return (optional)
OFFSET  m;                     -- 6. Skip first m rows (optional)
```

> ⚠️ **PostgreSQL string quotes:** String values must use **single quotes** `'value'`, not double quotes.  
> Double quotes `"column"` are reserved for column/table names (identifiers).  
> The exercises in this guide were originally written for a SQLite-based tool that accepts double quotes — in PostgreSQL, always use single quotes for string values.

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 2. Tables Used in This Guide

### Table 1 & 3 — `movies`

> Used in Exercises 1–4, 6, 9, 12–18

| id | title | director | year | length_minutes |
|----|-------|----------|------|----------------|
| 1  | Toy Story | John Lasseter | 1995 | 81 |
| 2  | A Bug's Life | John Lasseter | 1998 | 95 |
| 3  | Toy Story 2 | John Lasseter | 1999 | 93 |
| 4  | Monsters, Inc. | Pete Docter | 2001 | 92 |
| 5  | Finding Nemo | Andrew Stanton | 2003 | 107 |
| 6  | The Incredibles | Brad Bird | 2004 | 116 |
| 7  | Cars | John Lasseter | 2006 | 117 |
| 8  | Ratatouille | Brad Bird | 2007 | 115 |
| 9  | WALL-E | Andrew Stanton | 2008 | 104 |
| 10 | Up | Pete Docter | 2009 | 101 |
| 11 | Toy Story 3 | Lee Unkrich | 2010 | 103 |
| 12 | Cars 2 | John Lasseter | 2011 | 120 |
| 13 | Brave | Brenda Chapman | 2012 | 102 |
| 14 | Monsters University | Dan Scanlon | 2013 | 110 |

### Table 2 — `north_american_cities`

> Used in Review 1

| city | country | population | latitude | longitude |
|------|---------|------------|----------|-----------|
| Guadalajara | Mexico | 1,500,800 | 20.66 | -103.35 |
| Toronto | Canada | 2,795,060 | 43.65 | -79.38 |
| Houston | United States | 2,195,914 | 29.76 | -95.37 |
| New York | United States | 8,405,837 | 40.71 | -74.01 |
| Philadelphia | United States | 1,553,165 | 39.95 | -75.17 |
| Havana | Cuba | 2,106,146 | 23.05 | -82.35 |
| Mexico City | Mexico | 8,555,500 | 19.43 | -99.13 |
| Phoenix | United States | 1,513,367 | 33.45 | -112.07 |
| Los Angeles | United States | 3,884,307 | 34.05 | -118.24 |
| Ecatepec de Morelos | Mexico | 1,742,000 | 19.60 | -99.05 |
| Montreal | Canada | 1,717,767 | 45.50 | -73.57 |
| Chicago | United States | 2,718,782 | 41.88 | -87.63 |

> 🌍 **Geography tip:**  
> - **Latitude** = North/South. Higher value → further North. North to South = `ORDER BY latitude DESC`  
> - **Longitude** = East/West. More negative → further West (in the Americas). West to East = `ORDER BY longitude ASC`

### Table 4 — `boxoffice`

> Used in Exercises 6, 9, 12

| movie_id | rating | domestic_sales | international_sales |
|----------|--------|----------------|---------------------|
| 1  | 8.3 | 191,796,233 | 170,162,503 |
| 2  | 7.2 | 162,798,565 | 200,600,000 |
| 3  | 7.9 | 245,852,179 | 239,163,000 |
| 4  | 8.1 | 289,916,256 | 272,900,000 |
| 5  | 8.2 | 380,843,261 | 555,900,000 |
| 6  | 8.0 | 261,441,092 | 370,001,000 |
| 7  | 7.2 | 244,082,982 | 217,900,167 |
| 8  | 8.0 | 206,445,654 | 417,277,164 |
| 9  | 8.5 | 223,808,164 | 297,503,696 |
| 10 | 8.3 | 293,004,164 | 438,338,580 |
| 11 | 8.4 | 415,004,880 | 648,167,031 |
| 12 | 6.4 | 191,452,396 | 368,400,000 |
| 13 | 7.2 | 237,283,207 | 301,700,000 |
| 14 | 7.4 | 268,492,764 | 475,066,843 |

### Table 5 — `buildings`

> Used in Exercises 7, 8

| building_name | capacity |
|---------------|----------|
| 1e | 24 |
| 1w | 32 |
| 2e | 16 |
| 2w | 20 |

### Table 6 — `employees`

> Used in Exercises 7, 8, 10, 11

| role | name | building | years_employed |
|------|------|----------|----------------|
| Engineer | Becky A. | 1e | 4 |
| Engineer | Dan B. | 1e | 2 |
| Engineer | Sharon F. | 1e | 6 |
| Engineer | Dan M. | 1e | 4 |
| Engineer | Malcolm S. | 1e | 1 |
| Artist | Taylar S. | 2w | 2 |
| Artist | Sherman D. | 2w | 8 |
| Artist | Jakob J. | 2w | 6 |
| Artist | Lilia A. | 2w | 7 |
| Artist | Brandon J. | 2w | 7 |
| Manager | Scott K. | 1e | 9 |
| Manager | Shirlee M. | 1e | 3 |
| Manager | Daria O. | 2w | 6 |
| Engineer | Yancy I. | *(none)* | 0 |
| Artist | Oliver P. | *(none)* | 0 |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 3. SELECT — Basic Queries

### Theory

`SELECT` retrieves data from a table. You specify which columns to return, or use `*` for all.

```sql
-- Select specific columns
SELECT column1, column2 FROM table_name;

-- Select all columns
SELECT * FROM table_name;
```

> 💡 **Best practice:** Avoid `SELECT *` in production — always name the columns you need.  
> It's clearer, faster, and won't break if the table structure changes later.

---

### Exercise 1

**Q1: Find the title of each film**

```sql
SELECT title FROM movies;
```

**Result:**

| title |
|-------|
| Toy Story |
| A Bug's Life |
| Toy Story 2 |
| Monsters, Inc. |
| Finding Nemo |
| The Incredibles |
| Cars |
| Ratatouille |
| WALL-E |
| Up |
| Toy Story 3 |
| Cars 2 |
| Brave |
| Monsters University |

---

**Q2: Find the director of each film**

```sql
SELECT director FROM movies;
```

**Result:**

| director |
|----------|
| John Lasseter |
| John Lasseter |
| John Lasseter |
| Pete Docter |
| Andrew Stanton |
| Brad Bird |
| John Lasseter |
| Brad Bird |
| Andrew Stanton |
| Pete Docter |
| Lee Unkrich |
| John Lasseter |
| Brenda Chapman |
| Dan Scanlon |

---

**Q3: Find the title and director of each film**

```sql
SELECT title, director FROM movies;
```

*(14 rows — both columns side by side)*

---

**Q4: Find the title and year of each film**

```sql
SELECT title, year FROM movies;
```

*(14 rows — title + year)*

---

**Q5: Find all the information about each film**

```sql
-- * means all columns
SELECT * FROM movies;
```

*(All 14 rows, all 5 columns: id, title, director, year, length_minutes)*

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 4. WHERE — Filtering Data

### Theory

`WHERE` filters rows **before** returning results. Only rows where the condition is `TRUE` are returned.

```sql
SELECT column FROM table WHERE condition;
```

#### Comparison Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal | `year = 2008` |
| `!=` or `<>` | Not equal | `director != 'Brad Bird'` |
| `<` | Less than | `year < 2000` |
| `>` | Greater than | `year > 2010` |
| `<=` | Less than or equal | `year <= 2003` |
| `>=` | Greater than or equal | `rating >= 8.0` |
| `BETWEEN a AND b` | Inclusive range | `year BETWEEN 2000 AND 2010` |
| `IN (...)` | Matches any value in list | `year IN (2001, 2003, 2008)` |
| `NOT BETWEEN a AND b` | Outside a range | `year NOT BETWEEN 2000 AND 2010` |
| `NOT IN (...)` | Does not match any value in list | `year NOT IN (2001, 2003)` |
| `NOT LIKE 'pattern'` | Does not match pattern | `title NOT LIKE 'Toy%'` |

#### Logical Operators

| Operator | Meaning |
|----------|---------|
| `AND` | Both conditions must be true |
| `OR` | At least one condition must be true |
| `NOT` | Negates the condition |

---

### Exercise 2

**Q1: Find the movie with a row id of 6**

```sql
SELECT id, title 
FROM movies 
WHERE id = 6;
```

**Result:**

| id | title |
|----|-------|
| 6 | The Incredibles |

---

**Q2: Find the movies released between 2000 and 2010**

```sql
-- BETWEEN is inclusive — includes both 2000 and 2010
SELECT title, year 
FROM movies
WHERE year BETWEEN 2000 AND 2010;
```

**Result:**

| title | year |
|-------|------|
| Monsters, Inc. | 2001 |
| Finding Nemo | 2003 |
| The Incredibles | 2004 |
| Cars | 2006 |
| Ratatouille | 2007 |
| WALL-E | 2008 |
| Up | 2009 |
| Toy Story 3 | 2010 |

---

**Q3: Find the movies NOT released between 2000 and 2010**

```sql
-- OR: either condition being true excludes from the 2000-2010 range
SELECT title, year 
FROM movies
WHERE year < 2000 OR year > 2010;
```

**Result:**

| title | year |
|-------|------|
| Toy Story | 1995 |
| A Bug's Life | 1998 |
| Toy Story 2 | 1999 |
| Cars 2 | 2011 |
| Brave | 2012 |
| Monsters University | 2013 |

---

**Q4: Find the first 5 Pixar movies and their release year**

```sql
-- "First 5" = released up to year 2003 (there happen to be exactly 5)
SELECT title, year 
FROM movies
WHERE year <= 2003;
```

**Result:**

| title | year |
|-------|------|
| Toy Story | 1995 |
| A Bug's Life | 1998 |
| Toy Story 2 | 1999 |
| Monsters, Inc. | 2001 |
| Finding Nemo | 2003 |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 5. LIKE — Pattern Matching

### Theory

`LIKE` searches for a text **pattern** in a column. Used inside `WHERE`.

| Wildcard | Meaning | Example pattern | Matches |
|----------|---------|-----------------|---------|
| `%` | Zero or more characters | `'Toy%'` | Toy, Toy Story, Toy Story 2 |
| `_` | Exactly one character | `'WALL-_'` | WALL-E, WALL-1, WALL-X |

```sql
-- PostgreSQL: LIKE is case-sensitive
WHERE title LIKE 'Toy%'

-- ILIKE is case-insensitive (PostgreSQL-specific)
WHERE title ILIKE 'toy%'    -- matches Toy Story, toy story, TOY STORY
```

---

### Exercise 3

**Q1: Find all the Toy Story movies**

```sql
-- % matches anything after "Toy Story" (including nothing)
SELECT title, director 
FROM movies 
WHERE title LIKE 'Toy Story%';
```

**Result:**

| title | director |
|-------|----------|
| Toy Story | John Lasseter |
| Toy Story 2 | John Lasseter |
| Toy Story 3 | Lee Unkrich |

---

**Q2: Find all the movies directed by John Lasseter**

```sql
-- Exact match on a string — no wildcards needed
SELECT title, director 
FROM movies 
WHERE director = 'John Lasseter';
```

**Result:**

| title | director |
|-------|----------|
| Toy Story | John Lasseter |
| A Bug's Life | John Lasseter |
| Toy Story 2 | John Lasseter |
| Cars | John Lasseter |
| Cars 2 | John Lasseter |

---

**Q3: Find all movies NOT directed by John Lasseter**

```sql
SELECT title, director 
FROM movies 
WHERE director != 'John Lasseter';
```

**Result:**

| title | director |
|-------|----------|
| Monsters, Inc. | Pete Docter |
| Finding Nemo | Andrew Stanton |
| The Incredibles | Brad Bird |
| Ratatouille | Brad Bird |
| WALL-E | Andrew Stanton |
| Up | Pete Docter |
| Toy Story 3 | Lee Unkrich |
| Brave | Brenda Chapman |
| Monsters University | Dan Scanlon |

---

**Q4: Find all the WALL-* movies**

```sql
-- _ matches exactly ONE character — so only "WALL-E" matches WALL-_
SELECT * 
FROM movies 
WHERE title LIKE 'WALL-_';
```

**Result:**

| id | title | director | year | length_minutes |
|----|-------|----------|------|----------------|
| 9 | WALL-E | Andrew Stanton | 2008 | 104 |

---

### 5b. Common String Functions

Since `LIKE` works on text, these string functions are natural companions when querying and transforming text data.

| Function | What it does | Example | Result |
|----------|-------------|---------|--------|
| `UPPER(str)` | Convert to uppercase | `UPPER('wall-e')` | `WALL-E` |
| `LOWER(str)` | Convert to lowercase | `LOWER('WALL-E')` | `wall-e` |
| `LENGTH(str)` | Number of characters | `LENGTH('Brave')` | `5` |
| `CONCAT(a, b)` | Join strings together | `CONCAT('Toy', ' Story')` | `Toy Story` |
| `TRIM(str)` | Remove leading/trailing spaces | `TRIM('  hello  ')` | `hello` |
| `SUBSTRING(str, start, len)` | Extract part of a string | `SUBSTRING('Ratatouille', 1, 4)` | `Rata` |

```sql
-- Find movies with a title longer than 10 characters
SELECT title, LENGTH(title) AS title_length
FROM movies
WHERE LENGTH(title) > 10;
```

**Result:**

| title | title_length |
|-------|-------------|
| Monsters, Inc. | 15 |
| Finding Nemo | 12 |
| The Incredibles | 15 |
| Monsters University | 19 |

```sql
-- Case-insensitive search using LOWER (alternative to ILIKE)
SELECT title FROM movies
WHERE LOWER(title) LIKE '%story%';
-- Matches: Toy Story, Toy Story 2, Toy Story 3

-- Build a readable label by concatenating columns
SELECT CONCAT(title, ' (', year, ')') AS movie_label FROM movies;
-- Result rows: 'Toy Story (1995)', 'A Bug''s Life (1998)', etc.
```


> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 6. ORDER BY · DISTINCT · LIMIT · OFFSET

### Theory

#### ORDER BY

Sorts the result by one or more columns.

```sql
ORDER BY column ASC   -- Ascending: A→Z, 1→9, -180→+180 (default)
ORDER BY column DESC  -- Descending: Z→A, 9→1, +180→-180

-- Sort by multiple columns
ORDER BY year DESC, title ASC
```

**Geographic sorting:**
- **North to South** → `ORDER BY latitude DESC` (North = higher positive value)
- **South to North** → `ORDER BY latitude ASC`
- **East to West** → `ORDER BY longitude DESC` (East = higher/less negative value)
- **West to East** → `ORDER BY longitude ASC`

#### DISTINCT

Removes duplicate values from the result.

```sql
SELECT DISTINCT director FROM movies;
-- Returns each director name only once
```

#### LIMIT and OFFSET

```sql
LIMIT 5             -- Return at most 5 rows
LIMIT 5 OFFSET 5    -- Skip first 5 rows, then return next 5
LIMIT 5 OFFSET 10   -- Skip first 10 rows, then return next 5
```

> 💡 **Pagination analogy:**  
> Page 1 → `LIMIT 5 OFFSET 0`  
> Page 2 → `LIMIT 5 OFFSET 5`  
> Page 3 → `LIMIT 5 OFFSET 10`

---

### Exercise 4

**Q1: List all directors alphabetically, without duplicates**

```sql
-- DISTINCT removes repeated director names from the result
SELECT DISTINCT director 
FROM movies
ORDER BY director ASC;
```

**Result:**

| director |
|----------|
| Andrew Stanton |
| Brad Bird |
| Brenda Chapman |
| Dan Scanlon |
| John Lasseter |
| Lee Unkrich |
| Pete Docter |

---

**Q2: List the last four Pixar movies released (most recent first)**

```sql
-- DESC = newest first, then LIMIT 4 cuts to top 4
SELECT title, year 
FROM movies
ORDER BY year DESC
LIMIT 4;
```

**Result:**

| title | year |
|-------|------|
| Monsters University | 2013 |
| Brave | 2012 |
| Cars 2 | 2011 |
| Toy Story 3 | 2010 |

---

**Q3: List the first five Pixar movies sorted alphabetically**

```sql
SELECT title 
FROM movies
ORDER BY title ASC
LIMIT 5;
```

**Result:**

| title |
|-------|
| A Bug's Life |
| Brave |
| Cars |
| Cars 2 |
| Finding Nemo |

---

**Q4: List the next five Pixar movies sorted alphabetically**

```sql
-- OFFSET 5 skips the first 5 alphabetical results
SELECT title 
FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;
```

**Result:**

| title |
|-------|
| Monsters University |
| Monsters, Inc. |
| Ratatouille |
| Toy Story |
| Toy Story 2 |

---

### Review 1 — `north_american_cities`

**Q1: List all Canadian cities and their populations**

```sql
SELECT city, population 
FROM north_american_cities
WHERE country = 'Canada';
```

**Result:**

| city | population |
|------|------------|
| Toronto | 2,795,060 |
| Montreal | 1,717,767 |

---

**Q2: Order all US cities by latitude from north to south**

```sql
-- North to South = higher latitude first = DESC
SELECT city, latitude 
FROM north_american_cities
WHERE country = 'United States'
ORDER BY latitude DESC;
```

**Result:**

| city | latitude |
|------|----------|
| Chicago | 41.88 |
| New York | 40.71 |
| Philadelphia | 39.95 |
| Los Angeles | 34.05 |
| Phoenix | 33.45 |
| Houston | 29.76 |

---

**Q3: List all cities west of Chicago, ordered from west to east**

> ⚠️ **Bug in the original query:** The original query uses `ORDER BY latitude DESC`, which is North-to-South ordering — that's incorrect here. West/East is determined by **longitude**, not latitude.  
> Cities with a **more negative** longitude are further West. Chicago's longitude is `-87.63`.

```sql
-- Correct query: filter by longitude less than Chicago's, then sort west to east
SELECT city, longitude 
FROM north_american_cities
WHERE longitude < -87.629798    -- west of Chicago (more negative = further west)
ORDER BY longitude ASC;         -- west to east = increasing (less negative) longitude
```

**Result:**

| city | longitude |
|------|-----------|
| Los Angeles | -118.24 |
| Phoenix | -112.07 |
| Houston | -95.37 |

---

**Q4: List the two largest cities in Mexico by population**

```sql
SELECT city, population 
FROM north_american_cities
WHERE country = 'Mexico'
ORDER BY population DESC
LIMIT 2;
```

**Result:**

| city | population |
|------|------------|
| Mexico City | 8,555,500 |
| Ecatepec de Morelos | 1,742,000 |

---

**Q5: List the 3rd and 4th largest US cities by population**

```sql
-- Skip the top 2 (OFFSET 2), then return the next 2 (LIMIT 2)
SELECT city, population 
FROM north_american_cities
WHERE country = 'United States'
ORDER BY population DESC
LIMIT 2 OFFSET 2;
```

**Result:**

| city | population |
|------|------------|
| Chicago | 2,718,782 |
| Houston | 2,195,914 |

> *Full US ranking: #1 New York (8,405,837) → #2 Los Angeles (3,884,307) → #3 Chicago → #4 Houston*

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 7. JOINs — Combining Tables

### Theory

A `JOIN` combines rows from two tables based on a matching column (usually a foreign key).

```
movies table             boxoffice table
id | title               movie_id | rating
1  | Toy Story    ──►    1        | 8.3
2  | A Bug's Life ──►    2        | 7.2
```

#### Types of JOINs

```sql
-- INNER JOIN — only rows that match in BOTH tables
SELECT * 
FROM movies 
  INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;

-- LEFT JOIN — ALL rows from left table + matching rows from right
--             Non-matching right-side columns show as NULL
SELECT * 
FROM buildings 
  LEFT JOIN employees ON building_name = building;

-- RIGHT JOIN — ALL rows from right table + matching rows from left
SELECT * 
FROM employees 
  RIGHT JOIN buildings ON building_name = building;
```

> 💡 **When to use which JOIN:**
> - `INNER JOIN` → you only want rows with a match in both tables (e.g., movies that have sales data)
> - `LEFT JOIN` → you want all rows from the first (left) table, even with no match (e.g., all buildings, including empty ones)

---

### Exercise 6 — `movies` JOIN `boxoffice`

**Q1: Find the domestic and international sales for each movie**

```sql
-- JOIN = INNER JOIN by default
SELECT title, domestic_sales, international_sales 
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
```

**Result:**

| title | domestic_sales | international_sales |
|-------|----------------|---------------------|
| Toy Story | 191,796,233 | 170,162,503 |
| A Bug's Life | 162,798,565 | 200,600,000 |
| Toy Story 2 | 245,852,179 | 239,163,000 |
| Monsters, Inc. | 289,916,256 | 272,900,000 |
| Finding Nemo | 380,843,261 | 555,900,000 |
| The Incredibles | 261,441,092 | 370,001,000 |
| Cars | 244,082,982 | 217,900,167 |
| Ratatouille | 206,445,654 | 417,277,164 |
| WALL-E | 223,808,164 | 297,503,696 |
| Up | 293,004,164 | 438,338,580 |
| Toy Story 3 | 415,004,880 | 648,167,031 |
| Cars 2 | 191,452,396 | 368,400,000 |
| Brave | 237,283,207 | 301,700,000 |
| Monsters University | 268,492,764 | 475,066,843 |

---

**Q2: Show movies that did better internationally than domestically**

```sql
SELECT title, domestic_sales, international_sales
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
WHERE international_sales > domestic_sales;  -- filter after JOIN
```

**Result:**

| title | domestic_sales | international_sales |
|-------|----------------|---------------------|
| A Bug's Life | 162,798,565 | 200,600,000 |
| The Incredibles | 261,441,092 | 370,001,000 |
| Ratatouille | 206,445,654 | 417,277,164 |
| WALL-E | 223,808,164 | 297,503,696 |
| Up | 293,004,164 | 438,338,580 |
| Toy Story 3 | 415,004,880 | 648,167,031 |
| Cars 2 | 191,452,396 | 368,400,000 |
| Brave | 237,283,207 | 301,700,000 |
| Monsters University | 268,492,764 | 475,066,843 |
| Finding Nemo | 380,843,261 | 555,900,000 |

> *(Toy Story, Toy Story 2, Monsters Inc., and Cars did better domestically)*

---

**Q3: List all movies by rating in descending order**

```sql
SELECT title, rating
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
ORDER BY rating DESC;
```

**Result:**

| title | rating |
|-------|--------|
| WALL-E | 8.5 |
| Toy Story 3 | 8.4 |
| Toy Story | 8.3 |
| Up | 8.3 |
| Finding Nemo | 8.2 |
| Monsters, Inc. | 8.1 |
| Ratatouille | 8.0 |
| The Incredibles | 8.0 |
| Toy Story 2 | 7.9 |
| Monsters University | 7.4 |
| A Bug's Life | 7.2 |
| Cars | 7.2 |
| Brave | 7.2 |
| Cars 2 | 6.4 |

---

### Exercise 7 — `buildings` + `employees`

**Q1: Find all buildings that have employees**

```sql
-- DISTINCT removes duplicate building names
SELECT DISTINCT building FROM employees;
```

**Result:**

| building |
|----------|
| 1e |
| 2w |

---

**Q2: Find all buildings and their capacity**

```sql
SELECT building_name, capacity FROM buildings;
```

**Result:**

| building_name | capacity |
|---------------|----------|
| 1e | 24 |
| 1w | 32 |
| 2e | 16 |
| 2w | 20 |

---

**Q3: List all buildings and distinct employee roles (including empty buildings)**

```sql
-- LEFT JOIN: buildings is the left table — all 4 buildings are returned
-- Empty buildings (1w, 2e) have no match in employees, so role = NULL
SELECT DISTINCT building_name, role 
FROM buildings 
  LEFT JOIN employees
    ON building_name = building;
```

**Result:**

| building_name | role |
|---------------|------|
| 1e | Engineer |
| 1e | Manager |
| 1w | *(NULL)* |
| 2e | *(NULL)* |
| 2w | Artist |
| 2w | Manager |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 8. NULL Values

### Theory

`NULL` means **no value / unknown / missing data**. It is NOT the same as `0` or an empty string `''`.

```sql
-- ❌ This does NOT work — NULL comparisons with = always return NULL (not TRUE/FALSE)
WHERE building = NULL

-- ✅ Correct way to check for NULL
WHERE building IS NULL
WHERE building IS NOT NULL
```

> ⚠️ `NULL` is special — any arithmetic or comparison with NULL produces NULL.  
> `NULL + 5 = NULL`, `NULL = NULL` is not true. Always use `IS NULL` / `IS NOT NULL`.

### COALESCE — Replacing NULL with a Default

`COALESCE` returns the **first non-NULL value** from a list of arguments. It is the most practical tool for replacing NULLs with a meaningful fallback.

```sql
COALESCE(value, fallback_if_null)
COALESCE(val1, val2, val3)   -- returns the first non-NULL in the list
```

**Example: show `'Unassigned'` instead of NULL for employees with no building**

```sql
SELECT name, COALESCE(building, 'Unassigned') AS building
FROM employees;
```

**Result:**

| name | building |
|------|----------|
| Becky A. | 1e |
| Dan B. | 1e |
| Sharon F. | 1e |
| Dan M. | 1e |
| Malcolm S. | 1e |
| Taylar S. | 2w |
| Sherman D. | 2w |
| Jakob J. | 2w |
| Lilia A. | 2w |
| Brandon J. | 2w |
| Scott K. | 1e |
| Shirlee M. | 1e |
| Daria O. | 2w |
| Yancy I. | Unassigned |
| Oliver P. | Unassigned |

```sql
-- COALESCE also protects arithmetic — NULL in math always returns NULL
SELECT name, COALESCE(years_employed, 0) AS years
FROM employees;
-- Without COALESCE, NULLs in years_employed could skew SUM/AVG results
```

---

### Exercise 8

**Q1: Find employees not assigned to a building**

```sql
SELECT name, role 
FROM employees
WHERE building IS NULL;
```

**Result:**

| name | role |
|------|------|
| Yancy I. | Engineer |
| Oliver P. | Artist |

---

**Q2: Find buildings that hold no employees**

```sql
-- LEFT JOIN includes buildings with no employees (their role = NULL)
-- WHERE role IS NULL then filters to only those empty buildings
SELECT DISTINCT building_name
FROM buildings 
  LEFT JOIN employees
    ON building_name = building
WHERE role IS NULL;
```

**Result:**

| building_name |
|---------------|
| 1w |
| 2e |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 9. Expressions & Aliases

### Theory

SQL can compute **expressions** directly in the `SELECT` clause.

```sql
-- Arithmetic
SELECT domestic_sales + international_sales AS total_sales FROM boxoffice;
SELECT year % 2 AS remainder FROM movies;   -- % = modulo (remainder)

-- Rename output column with AS
SELECT rating * 10 AS rating_percent FROM boxoffice;
```

> 💡 `AS` creates a column **alias** — a readable name for the result column.  
> Without it, the column header shows the raw expression (e.g., `domestic_sales + international_sales`).

> ⚠️ **Integer division in PostgreSQL:** `361958736 / 1000000` returns `361` (truncated).  
> Use `/ 1000000.0` to get decimal results.

---

### Exercise 9

**Q1: List all movies and their combined sales in millions**

```sql
SELECT title, 
       (domestic_sales + international_sales) / 1000000 AS gross_sales_millions
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
```

**Result:**

| title | gross_sales_millions |
|-------|---------------------|
| Toy Story | 361 |
| A Bug's Life | 363 |
| Toy Story 2 | 485 |
| Monsters, Inc. | 562 |
| Finding Nemo | 936 |
| The Incredibles | 631 |
| Cars | 461 |
| Ratatouille | 623 |
| WALL-E | 521 |
| Up | 731 |
| Toy Story 3 | 1,063 |
| Cars 2 | 559 |
| Brave | 538 |
| Monsters University | 743 |

---

**Q2: List all movies and their ratings in percent**

```sql
-- Multiply rating by 10 to convert to a percent (e.g., 8.5 → 85%)
SELECT title, rating * 10 AS rating_percent
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
```

**Result:**

| title | rating_percent |
|-------|----------------|
| Toy Story | 83 |
| A Bug's Life | 72 |
| Toy Story 2 | 79 |
| Monsters, Inc. | 81 |
| Finding Nemo | 82 |
| The Incredibles | 80 |
| Cars | 72 |
| Ratatouille | 80 |
| WALL-E | 85 |
| Up | 83 |
| Toy Story 3 | 84 |
| Cars 2 | 64 |
| Brave | 72 |
| Monsters University | 74 |

---

**Q3: List all movies released in even-numbered years**

```sql
-- year % 2 = 0 means the year is evenly divisible by 2 (even)
SELECT title, year
FROM movies
WHERE year % 2 = 0;
```

**Result:**

| title | year |
|-------|------|
| A Bug's Life | 1998 |
| The Incredibles | 2004 |
| Cars | 2006 |
| WALL-E | 2008 |
| Toy Story 3 | 2010 |
| Brave | 2012 |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 10. Aggregate Functions

### Theory

Aggregate functions compute a **single summary value** from multiple rows.

| Function | What it does | Example result |
|----------|-------------|----------------|
| `COUNT(*)` | Count all rows | `15` |
| `COUNT(col)` | Count non-NULL values in column | `13` (skips NULLs) |
| `SUM(col)` | Total sum | `340000` |
| `AVG(col)` | Average | `4.6` |
| `MAX(col)` | Largest value | `9` |
| `MIN(col)` | Smallest value | `0` |
| `COUNT(DISTINCT col)` | Count unique non-NULL values | `COUNT(DISTINCT director)` → `7` |

```sql
-- Without GROUP BY — aggregates the entire table
SELECT COUNT(*) FROM employees;           -- 15
SELECT MAX(years_employed) FROM employees; -- 9
SELECT AVG(years_employed) FROM employees; -- 4.6
```

> ⚠️ Aggregate functions **collapse** all rows into one result.  
> Use them with `GROUP BY` when you want results per group (per role, per building, etc.).

```sql
-- COUNT(*) vs COUNT(col) vs COUNT(DISTINCT col)
SELECT COUNT(*)               FROM movies;  -- 14  (all rows)
SELECT COUNT(director)        FROM movies;  -- 14  (non-NULL directors)
SELECT COUNT(DISTINCT director) FROM movies; -- 7  (unique directors only)

-- Useful when you want to know how many unique values exist in a column
SELECT COUNT(DISTINCT building) FROM employees; -- 2  (1e and 2w — NULLs ignored)
```

---

### Exercise 10

**Q1: Find the longest time an employee has been at the studio**

```sql
SELECT MAX(years_employed) AS Max_years_employed
FROM employees;
```

**Result:**

| max_years_employed |
|--------------------|
| 9 |

> *(Scott K. — Manager, Building 1e)*

---

**Q2: Average years employed per role**

```sql
SELECT role, AVG(years_employed) AS Average_years_employed
FROM employees
GROUP BY role;
```

**Result:**

| role | average_years_employed |
|------|------------------------|
| Engineer | 2.83 |
| Artist | 5.00 |
| Manager | 6.00 |

> Engineer: (4+2+6+4+1+0)/6 = 17/6 ≈ 2.83  
> Artist: (2+8+6+7+7+0)/6 = 30/6 = 5.00  
> Manager: (9+3+6)/3 = 18/3 = 6.00

---

**Q3: Total years employed per building**

```sql
SELECT building, SUM(years_employed) AS Total_years_employed
FROM employees
GROUP BY building;
```

**Result:**

| building | total_years_employed |
|----------|---------------------|
| 1e | 29 |
| 2w | 36 |
| *(NULL)* | 0 |

> 1e: 4+2+6+4+1+9+3 = 29  
> 2w: 2+8+6+7+7+6 = 36  
> NULL: 0+0 = 0

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 11. GROUP BY

### Theory

`GROUP BY` organizes rows into groups by the values of a column, so you can apply aggregate functions **per group** instead of across the whole table.

```sql
SELECT role, COUNT(*) 
FROM employees
GROUP BY role;
```

**Without GROUP BY:**
```
COUNT(*) → 15   (total employee count — one number for the whole table)
```

**With GROUP BY role:**
```
Engineer → 6
Artist   → 6
Manager  → 3
```

> 📌 **Golden Rule of GROUP BY:**  
> Every column in your `SELECT` that is **not inside an aggregate function** must appear in the `GROUP BY` clause.

```sql
-- ✅ Correct — role is in both SELECT and GROUP BY
SELECT role, COUNT(*) FROM employees GROUP BY role;

-- ❌ Wrong — name is in SELECT but not in GROUP BY (and not aggregated)
SELECT role, name, COUNT(*) FROM employees GROUP BY role;
```

---

### Exercise 11

**Q1: Find the number of Artists (without HAVING)**

```sql
-- WHERE filters rows first, then COUNT gives the total
SELECT role, COUNT(*) AS Number_of_artists
FROM employees
WHERE role = 'Artist';  -- filter before aggregating
```

**Result:**

| role | number_of_artists |
|------|------------------|
| Artist | 6 |

---

**Q2: Find the number of employees per role**

```sql
SELECT role, COUNT(*)
FROM employees
GROUP BY role;
```

**Result:**

| role | count |
|------|-------|
| Engineer | 6 |
| Artist | 6 |
| Manager | 3 |

---

**Q3: Find the total years employed by all Engineers**

```sql
-- GROUP BY groups by role, then HAVING filters to only the Engineer group
SELECT role, SUM(years_employed)
FROM employees
GROUP BY role
HAVING role = 'Engineer';
```

**Result:**

| role | sum |
|------|-----|
| Engineer | 17 |

> *4 + 2 + 6 + 4 + 1 + 0 = 17 total years*

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 12. HAVING

### Theory

`HAVING` filters **groups** after `GROUP BY` — the same way `WHERE` filters individual rows before grouping.

```sql
-- Keep only roles that have more than 3 employees
SELECT role, COUNT(*) 
FROM employees
GROUP BY role
HAVING COUNT(*) > 3;
```

`HAVING` lets you use aggregate functions (COUNT, SUM, AVG, etc.) in the filter condition — something `WHERE` cannot do.

---

### Exercise 12

**Q1: Find the number of movies each director has directed**

```sql
SELECT director, COUNT(id) AS Num_movies_directed
FROM movies
GROUP BY director;
```

**Result:**

| director | num_movies_directed |
|----------|---------------------|
| John Lasseter | 5 |
| Pete Docter | 2 |
| Andrew Stanton | 2 |
| Brad Bird | 2 |
| Lee Unkrich | 1 |
| Brenda Chapman | 1 |
| Dan Scanlon | 1 |

---

**Q2: Find total domestic + international sales per director**

```sql
SELECT director, 
       SUM(domestic_sales + international_sales) AS Cumulative_sales_from_all_movies
FROM movies
    INNER JOIN boxoffice
        ON movies.id = boxoffice.movie_id
GROUP BY director;
```

**Result:**

| director | cumulative_sales_from_all_movies |
|----------|----------------------------------|
| John Lasseter | 2,232,208,025 |
| Andrew Stanton | 1,458,055,121 |
| Pete Docter | 1,294,159,000 |
| Brad Bird | 1,255,164,910 |
| Lee Unkrich | 1,063,171,911 |
| Dan Scanlon | 743,559,607 |
| Brenda Chapman | 538,983,207 |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 13. WHERE vs HAVING vs GROUP BY

This is one of the most important and commonly confused areas in SQL.

### SQL Execution Order

SQL does **NOT** execute in the order you write it. The actual processing order is:

```
1. FROM        → Choose the table(s)
2. JOIN        → Combine tables
3. WHERE       → Filter individual rows  ← runs BEFORE grouping
4. GROUP BY    → Organize rows into groups
5. HAVING      → Filter groups           ← runs AFTER grouping
6. SELECT      → Compute expressions, pick columns
7. DISTINCT    → Remove duplicates
8. ORDER BY    → Sort the result
9. LIMIT/OFFSET→ Trim the final output
```

### Comparison at a Glance

| | `WHERE` | `GROUP BY` | `HAVING` |
|---|---------|------------|---------|
| **Purpose** | Filter rows | Group rows | Filter groups |
| **Runs** | Before grouping | After WHERE | After GROUP BY |
| **Can use aggregates?** | ❌ No | — | ✅ Yes |
| **Operates on** | Individual rows | Column values | Grouped/aggregated data |

---

### When to Use Each — Decision Guide

**Use `WHERE` when:**
- The condition is on a raw column value (not a computed aggregate)
- You want to reduce rows before grouping to improve performance

```sql
-- Only count employees IN building 1e (filter rows before grouping)
SELECT role, COUNT(*) 
FROM employees
WHERE building = '1e'      -- ✅ filter on raw column
GROUP BY role;
```

**Use `GROUP BY` when:**
- You want one result row per unique value in a column
- You're using aggregate functions (COUNT, SUM, AVG, MIN, MAX)

```sql
-- One row per building, with total years for each
SELECT building, SUM(years_employed)
FROM employees
GROUP BY building;          -- ✅ one row per building
```

**Use `HAVING` when:**
- The filter condition involves an aggregate result
- You want to filter after grouping based on COUNT, SUM, AVG, etc.

```sql
-- Only show roles with 5 or more employees
SELECT role, COUNT(*) 
FROM employees
GROUP BY role
HAVING COUNT(*) >= 5;       -- ✅ filter on aggregate
```

---

### Common Mistake

```sql
-- ❌ WRONG: Cannot use an aggregate function inside WHERE
SELECT role, COUNT(*)
FROM employees
WHERE COUNT(*) > 3          -- ERROR: aggregate not allowed in WHERE
GROUP BY role;

-- ✅ CORRECT: Use HAVING for aggregate conditions
SELECT role, COUNT(*)
FROM employees
GROUP BY role
HAVING COUNT(*) > 3;        -- filters groups, not rows
```

---

### Combined Example (WHERE + GROUP BY + HAVING together)

```sql
-- Question: Among buildings that have Engineers,
-- find buildings where Engineers have worked more than 10 years total

SELECT building, SUM(years_employed) AS total_years
FROM employees
WHERE role = 'Engineer'           -- Step 1: keep only Engineers (WHERE)
GROUP BY building                 -- Step 2: group by building
HAVING SUM(years_employed) > 10;  -- Step 3: keep groups where total > 10
```

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 14. INSERT INTO — Adding Rows

### Theory

`INSERT INTO` adds new rows to a table.

```sql
-- With column names (recommended — safe and readable)
INSERT INTO table_name (col1, col2, col3)
VALUES ('value1', 42, 3.14);

-- Without column names (must match exact column order in table)
INSERT INTO table_name
VALUES ('value1', 42, 3.14, 'value4');
```

> 💡 Always specify column names. Your query won't break if someone adds a new column to the table later.

---

### Exercise 13

**Q1: Add Toy Story 4 to the movies table**

```sql
-- Values in order: id, title, director, year, length_minutes
INSERT INTO movies VALUES (4, 'Toy Story 4', 'El Directore', 2015, 90);
```

**Q2: Add Toy Story 4's box office record**

```sql
-- Values in order: movie_id, rating, domestic_sales, international_sales
INSERT INTO boxoffice VALUES (4, 8.7, 340000000, 270000000);
```

**New row added to movies:**

| id | title | director | year | length_minutes |
|----|-------|----------|------|----------------|
| 4 | Toy Story 4 | El Directore | 2015 | 90 |

**New row added to boxoffice:**

| movie_id | rating | domestic_sales | international_sales |
|----------|--------|----------------|---------------------|
| 4 | 8.7 | 340,000,000 | 270,000,000 |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 15. UPDATE — Modifying Rows

### Theory

`UPDATE` changes existing data in a table.

```sql
UPDATE table_name
SET column1 = 'new_value', column2 = 99
WHERE condition;
```

> ⚠️ **Always use WHERE with UPDATE.**  
> `UPDATE movies SET director = 'John';` (without WHERE) changes **every row** in the table.  
> This is almost never what you want and is very hard to undo.

---

### Exercise 14

**Q1: Fix the director for A Bug's Life (id = 2)**

```sql
UPDATE movies
SET director = 'John Lasseter'
WHERE id = 2;
```

| | Before | After |
|-|--------|-------|
| director | *(wrong value)* | John Lasseter |

---

**Q2: Fix the release year for Toy Story 2 (id = 3)**

```sql
UPDATE movies
SET year = 1999
WHERE id = 3;
```

| | Before | After |
|-|--------|-------|
| year | *(wrong year)* | 1999 |

---

**Q3: Fix both title and director for id = 11**

```sql
-- Multiple columns can be updated in a single SET clause (comma-separated)
UPDATE movies
SET title = 'Toy Story 3', director = 'Lee Unkrich'
WHERE id = 11;
```

| | Before | After |
|-|--------|-------|
| title | Toy Story 8 | Toy Story 3 |
| director | *(wrong)* | Lee Unkrich |

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 16. DELETE — Removing Rows

### Theory

`DELETE` permanently removes rows from a table.

```sql
DELETE FROM table_name WHERE condition;
```

> ⚠️ **Always use WHERE with DELETE.**  
> `DELETE FROM movies;` (without WHERE) deletes **every single row** permanently.  
> In most databases, there is no undo.

---

### Exercise 15

**Q1: Remove all movies released before 2005**

```sql
DELETE FROM movies
WHERE year < 2005;
```

**Rows removed:** Toy Story (1995), A Bug's Life (1998), Toy Story 2 (1999), Monsters, Inc. (2001), Finding Nemo (2003), The Incredibles (2004)

---

**Q2: Remove all movies directed by Andrew Stanton**

```sql
DELETE FROM movies
WHERE director = 'Andrew Stanton';
```

**Rows removed:** Finding Nemo, WALL-E

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 17. CREATE TABLE

### Theory

`CREATE TABLE` defines a brand new table with its columns, data types, and constraints.

#### Common PostgreSQL Data Types

| Type | Description | Example |
|------|-------------|---------|
| `INTEGER` / `INT` | Whole numbers | `42`, `-7` |
| `FLOAT` / `REAL` | Decimal numbers | `8.7`, `3.14` |
| `TEXT` | Unlimited-length string | `'John Lasseter'` |
| `VARCHAR(n)` | String with max length n | `VARCHAR(100)` |
| `BOOLEAN` | True or false | `TRUE`, `FALSE` |
| `DATE` | Date value | `'2024-01-15'` |
| `SERIAL` | Auto-incrementing integer (for IDs) | `1, 2, 3, ...` |

#### Constraints

| Constraint | Meaning |
|------------|---------|
| `NOT NULL` | Column must always have a value |
| `DEFAULT value` | Used when no value is provided on INSERT |
| `PRIMARY KEY` | Unique, non-null identifier for each row |
| `UNIQUE` | No two rows can have the same value |

```sql
CREATE TABLE table_name (
    column_name  DATATYPE  CONSTRAINT,
    ...
);
```

---

### Exercise 16

**Q: Create a table named Database with three columns**

```sql
CREATE TABLE Database (
    Name           TEXT,
    Version        FLOAT,
    Download_count INTEGER
);
```

**Result:** A new empty table `Database` is created with 3 columns and no rows.

> 📝 **My Notes**  
Create Table - with constraint

```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary NUMERIC(10,2),
    hire_date DATE,
    department_id INT
);
```


---

## 18. ALTER TABLE

### Theory

`ALTER TABLE` modifies the **structure** of an existing table — add/remove/rename columns, change data types.

```sql
-- Add a new column (existing rows get the DEFAULT value)
ALTER TABLE table_name
  ADD COLUMN column_name DATATYPE DEFAULT default_value;

-- Rename a column
ALTER TABLE table_name
  RENAME COLUMN old_name TO new_name;

-- Remove a column
ALTER TABLE table_name
  DROP COLUMN column_name;

-- Change a column's data type
ALTER TABLE table_name
  ALTER COLUMN column_name TYPE new_datatype;
```

---

### Exercise 17

**Q1: Add an Aspect_ratio column to the movies table**

```sql
ALTER TABLE Movies
  ADD COLUMN Aspect_ratio FLOAT DEFAULT 2.39;
```

**Effect:** All existing rows get `Aspect_ratio = 2.39`. New rows default to 2.39 unless a value is provided.

---

**Q2: Add a Language column that defaults to English**

```sql
ALTER TABLE Movies
  ADD COLUMN Language TEXT DEFAULT 'English';
```

**Effect:** All existing rows get `Language = 'English'`.

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 19. DROP TABLE

### Theory

`DROP TABLE` permanently deletes a table and **all of its data**.

```sql
-- Drop a table
DROP TABLE table_name;

-- Safe version — won't throw an error if table doesn't exist
DROP TABLE IF EXISTS table_name;
```

> ⚠️ `DROP TABLE` is **irreversible** without a backup. The table structure and all its rows are gone permanently. Use with extreme caution in production.

---

### Exercise 18

**Q1: Remove the Movies table**

```sql
DROP TABLE Movies;
```

**Q2: Remove the BoxOffice table**

```sql
DROP TABLE BoxOffice;
```

> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*


---

## 20. Quick Reference Cheat Sheet

### Full Query Template (with execution order annotated)

```sql
SELECT  DISTINCT column1, expression AS alias   -- 6. pick columns
FROM    table1                                  -- 1. source table
  JOIN  table2 ON table1.key = table2.key       -- 2. combine tables
WHERE   row_condition                           -- 3. filter rows
GROUP BY column1                               -- 4. group rows
HAVING  aggregate_condition                    -- 5. filter groups
ORDER BY column1 ASC, column2 DESC             -- 7. sort
LIMIT   n OFFSET m;                            -- 8. paginate
```

---

### Operators Quick Reference

```sql
-- Comparison
=     !=    <>    <     >     <=    >=
BETWEEN a AND b          -- inclusive range
IN (val1, val2, val3)    -- match any of these values
NOT IN (...)

-- Pattern matching
LIKE 'Toy%'     -- % = zero or more characters
LIKE 'WALL-_'   -- _ = exactly one character
ILIKE 'toy%'    -- case-insensitive (PostgreSQL only)

-- NULL checks (NEVER use = for NULL)
IS NULL
IS NOT NULL

-- Logic
AND     OR      NOT
```

---

### Aggregate Functions Summary

```sql
COUNT(*)          -- Count all rows (including NULLs)
COUNT(column)     -- Count non-NULL values only
SUM(column)       -- Add all values
AVG(column)       -- Average of all values
MAX(column)       -- Highest value
MIN(column)       -- Lowest value
```

---

### JOIN Types Summary

```sql
INNER JOIN  -- rows with a match in BOTH tables
LEFT JOIN   -- ALL rows from left + matching from right (NULL if no match)
RIGHT JOIN  -- ALL rows from right + matching from left (NULL if no match)
FULL OUTER JOIN -- ALL rows from both tables (NULL where no match on either side)
```

---

### WHERE vs HAVING — One-Line Rule

> **`WHERE`** filters **rows** (before grouping) — cannot use aggregate functions  
> **`HAVING`** filters **groups** (after grouping) — can use aggregate functions

---

### DML — Data Manipulation Commands

```sql
-- Insert
INSERT INTO table (col1, col2) VALUES ('val1', 42);

-- Update (always use WHERE)
UPDATE table SET col1 = 'new', col2 = 99 WHERE condition;

-- Delete (always use WHERE)
DELETE FROM table WHERE condition;
```

---

### DDL — Data Definition Commands

```sql
-- Create
CREATE TABLE name (
    id      SERIAL PRIMARY KEY,
    col1    TEXT NOT NULL,
    col2    FLOAT DEFAULT 0.0
);

-- Modify structure
ALTER TABLE name ADD COLUMN col TEXT DEFAULT 'value';
ALTER TABLE name RENAME COLUMN old_name TO new_name;
ALTER TABLE name DROP COLUMN col_name;

-- Remove table permanently
DROP TABLE name;
DROP TABLE IF EXISTS name;   -- safe version
```

---

*End of PostgreSQL Basics Notes*


> 📝 **My Notes**  
> *(Add your notes, examples, or observations here)*
