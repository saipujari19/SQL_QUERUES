
# creating the table called director which has primary key in it.
CREATE TABLE Director (
director_id int PRIMARY KEY,
director_fn varchar(50),
director_ln varchar(50)
);

# inserting data into the table director.
INSERT INTO Director VALUES
(1, "David", "Fincher"),
(2, "James", "Cameron"),
(3, "Jane", "Doe"),
(4, "John", "Smith"),
(5, "Tim", "Burton"),
(6, "Steven", "Spielberg"),
(7, "Martin", "Scorsese");

# creating the table called genre and also has primary key in it.
CREATE TABLE genre (
genre_id int PRIMARY KEY,
genre_desc varchar(20)
);

# inserting data into the table genre.
INSERT INTO genre VALUES
(1, "Biography"),
(2, "Drama"),
(3, "Family"),
(4, "Romance"),
(5, "True Crime"),
(6, "Mystery")
;

# creating the table called studio and also has primary key in it.
CREATE TABLE studio (
studio_id int PRIMARY KEY,
studio_name varchar(50)
);

# inserting data into the table studio.
INSERT INTO studio VALUES
(1, "Disney Pixar"),
(2, "Sony Pictures"),
(3, "Universal Pictures"),
(4, "Warner Bros")
;

# creating the table called actor and also has primary key in it.
CREATE TABLE actor (
actor_id int PRIMARY KEY,
actor_fn varchar(50),
actor_ln varchar(50)
);

# inserting data into the table actor.
INSERT INTO actor VALUES 
(1, "Brad", "Pitt"),
(2, "Cate", "Blanchett"),
(3, "Emma", "Stone"),
(4, "Helena", "Bonham Carter"),
(5, "Johnny", "Depp"),
(6, "Kate", "Winslet"),
(7, "Leonardo", "DiCaprio"),
(8, "Margot", "Robbie"),
(9, "Matt", "Damon"),
(10, "Ryan", "Gosling"),
(11, "Tom", "Cruise")
;



# creating the table called matRating and also has primary key in it.
CREATE TABLE matRating (
mat_code varchar(4) PRIMARY KEY
);

# inserting data into the table matRating.
INSERT INTO matRating VALUES 
("G"),("PG"),("PG13"),("R");



# creating the table called movie which has the foreign key in it and references to the primary key of the other table .
CREATE TABLE Movie (
movie_id int,
movie_title varchar(50),
director_id int,
length int,
genre_id int,
rating decimal(5,2),
release_date date,
studio_id int,
lead_male_id int,
lead_fmale_id int,
mat_code varchar(4),
FOREIGN KEY (director_id) REFERENCES director(director_id),
FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
FOREIGN KEY (studio_id) REFERENCES studio(studio_id),
FOREIGN KEY (lead_male_id) REFERENCES actor(actor_id),
FOREIGN KEY (lead_fmale_id) REFERENCES actor(actor_id),
FOREIGN KEY (mat_code) REFERENCES matRating(mat_code)
);

# inserting the data into the movie table.
INSERT INTO Movie VALUES 
(1, "The Curious Case of Benjamin Button", 1, 166, 4, 7.8, "2008-12-25", 3, 1, 2, "PG13"),
(2, "Once Upon a Time in Hollywood", 4, 161, 2, 7.6, "2019-07-26", 3, 7, 8, "R");
INSERT INTO Movie VALUES 
(3, "The Wolf of Wall Street", 3, 180, 1, 8.2, "2013-12-25", 3, 7, 8, "R"),
(4, "La La Land", 4, 128, 4, 8, "2016-12-09", 4, 10, 3, "PG13");
INSERT INTO Movie VALUES 
(5, "Charlie and the Chocolate Factory", 5, 115, 3, 6.6, "2005-07-15", 4, 5, 4, "PG"),
(6, "Fight Club", 1, 139, 2, 8.8, "1999-10-15", 4, 1, 4, "R");
INSERT INTO Movie VALUES 
(7, "Revolutionary Road", 3, 119, 2, 7.3, "2009-01-15", 2, 7, 6, "R"),
(8, "Crazy, Stupid, Love", 3, 118, 4, 7.4, "2011-07-29", 3, 10, 3, "PG13");
INSERT INTO Movie VALUES 
(9, "Titanic", 2, 195, 4, 7.8, "1997-12-19", 3, 7, 6, "PG13"),
(10, "Deep Sea", 4, 40, 3, 7.6, "2006-01-19", 2, 5, 6, "G");
INSERT INTO Movie VALUES 
(11, "Alice in Wonderland", 5, 108, 3, 6.4, "2010-03-05", 4, 5, 4, "PG"),
(12, "Dark Shadows", 5, 113, 2, 6.2, "2012-05-11", 3, 5, 4, "PG13");
INSERT INTO Movie VALUES 
(13, "Corpse Bride", 5, 77, 3, 7.3, "2005-09-23", 2, 5, 4, "PG"),
(14, "Finding Neverland", 3, 106, 1, 7.7, "2004-11-17", 2, 5, 6, "PG"),
(15, "Babel", 4, 143, 2, 7.4, "2006-11-10", 3, 1, 2, "R")
;

# using inner join query to join the 2 tables and display data.

SELECT
    m.movie_id,
    m.movie_title,
    d.director_fn || ' ' || d.director_ln AS director_name, # this will concatinate with the space and alias to director name.
    m.length,
    g.genre_desc,
    m.rating,
    m.release_date,
    s.studio_name,
    a1.actor_fn || ' ' || a1.actor_ln AS lead_male_name,
    a2.actor_fn || ' ' || a2.actor_ln AS lead_female_name,
    m.mat_code
FROM
    Movie m
INNER JOIN Director d ON m.director_id = d.director_id
INNER JOIN genre g ON m.genre_id = g.genre_id
INNER JOIN studio s ON m.studio_id = s.studio_id
INNER JOIN actor a1 ON m.lead_male_id = a1.actor_id
INNER JOIN actor a2 ON m.lead_fmale_id = a2.actor_id
INNER JOIN matRating mr ON m.mat_code = mr.mat_code;

# SELECT all studios, joining to the movies, so that you display a list of the number of movies that each studio has produced. 
SELECT
    s.studio_name,
    COUNT(m.movie_id) AS movie_count
FROM
    studio s
LEFT JOIN Movie m ON s.studio_id = m.studio_id
GROUP BY
    s.studio_name;
    
# SELECT all movies where the director is the director for two or more movies in the table.

SELECT 
    m.movie_title, 
    d.director_fn, 
    d.director_ln
FROM 
    Movie m
JOIN 
    Director d ON m.director_id = d.director_id
GROUP BY 
    m.movie_title, d.director_fn, d.director_ln, d.director_id 
HAVING 
    COUNT(*) > 1;
    
# creating the output as desired using group by and order by.
SELECT 
    g.genre_desc AS genre,
    COUNT(m.movie_id) AS movie_count,
    GROUP_CONCAT(m.movie_title ORDER BY m.movie_title SEPARATOR ', ') AS movies_list
FROM 
    genre g
LEFT JOIN 
    Movie m ON g.genre_id = m.genre_id
GROUP BY 
    g.genre_desc
ORDER BY 
    movie_count DESC;
    
# Finding movies with higher than average length

SELECT 
    movie_title, 
    length 
FROM 
    Movie 
WHERE 
    length > (SELECT AVG(length) FROM Movie);
    
# Finding directors who directed more than one movie.

SELECT 
    director_fn, 
    director_ln 
FROM 
    Director d
WHERE 
    d.director_id IN (
        SELECT 
            director_id 
        FROM 
            Movie 
        GROUP BY 
            director_id 
        HAVING 
            COUNT(*) > 1
    );
    
# using left join.

SELECT 
    s.studio_name, 
    m.movie_title 
FROM 
    Studio s
LEFT JOIN 
    Movie m ON s.studio_id = m.studio_id;
    
# using right join.

SELECT 
    m.movie_title, 
    s.studio_name 
FROM 
    Movie m
RIGHT JOIN 
    Studio s ON m.studio_id = s.studio_id;
    
# using inner join, used concat to concat 2 strings.

SELECT 
    m.movie_title, 
    CONCAT(a1.actor_fn, ' ', a1.actor_ln) AS lead_male_name, 
    CONCAT(a2.actor_fn, ' ', a2.actor_ln) AS lead_female_name 
FROM 
    Movie m
INNER JOIN 
    Actor a1 ON m.lead_male_id = a1.actor_id
INNER JOIN 
    Actor a2 ON m.lead_fmale_id = a2.actor_id;
    
# using full join and connected using the union operator.

SELECT 
    s.studio_name, 
    m.movie_title 
FROM 
    Studio s
LEFT JOIN 
    Movie m ON s.studio_id = m.studio_id

UNION

SELECT 
    s.studio_name, 
    m.movie_title 
FROM 
    Movie m
RIGHT JOIN 
    Studio s ON m.studio_id = s.studio_id;
    
# union operator.

SELECT 
    movie_title 
FROM 
    Movie m
JOIN 
    Director d ON m.director_id = d.director_id
WHERE 
    d.director_fn = 'David' AND d.director_ln = 'Fincher'

UNION

SELECT 
    movie_title 
FROM 
    Movie m
JOIN 
    Director d ON m.director_id = d.director_id
WHERE 
    d.director_fn = 'Tim' AND d.director_ln = 'Burton';
    
