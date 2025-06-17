
-- CREATE TABLE rangers(
--   ranger_id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   region TEXT NOT NULL
-- );

-- INSERT INTO rangers (name, region) VALUES
-- ('Alice Green', 'Northern Hills'),
-- ('Bob White', 'River Delta'),
-- ('Carol King', 'Mountain Range');


-- CREATE TABLE species (
--     species_id SERIAL PRIMARY KEY,
--     common_name VARCHAR(100) NOT NULL,
--     scientific_name VARCHAR(150) NOT NULL,
--     discovery_date DATE NOT NULL,
--     conservation_status TEXT NOT NULL
-- );


-- INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
-- ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
-- ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
-- ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
-- ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



-- CREATE TABLE sightings(
--   sighting_id SERIAL PRIMARY KEY,
--   ranger_id INT,
--   FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
--   species_id INT,
--   FOREIGN KEY (species_id) REFERENCES species(species_id),
--   sighting_time TIMESTAMP NOT NULL,
--   location TEXT NOT NULL,
--   notes TEXT
-- );


-- INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
-- (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
-- (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
-- (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
-- (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers (name, region)
 VALUES 
('Derek Fox','Coastal Plains')

-- Problem 2
SELECT  count(DISTINCT species_id) as unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%'

-- problem 4
SELECT name,count('species_id') as total_sightings FROM rangers r INNER JOIN sightings s ON r.ranger_id = s.ranger_id  GROUP BY name ORDER BY name ASC


-- Problem 5
SELECT common_name from species where species_id NOT IN ( SELECT species_id FROM sightings )


-- problem 6
SELECT common_name,sighting_time,name  FROM sightings LEFT JOIN rangers ON sightings.ranger_id = rangers.ranger_id RIGHT JOIN species ON sightings.species_id = species.species_id WHERE sighting_time NOTNULL ORDER BY sighting_time DESC LIMIT 2


-- Problem 7
UPDATE species set conservation_status = 'Historic' WHERE extract(year FROM discovery_date) < 1800;


-- problem 8 
SELECT sighting_id, case WHEN CAST(sighting_time AS time) < CAST('12:00:00' as time) THEN 'Morning' WHEN CAST(sighting_time AS time) > CAST('17:00:00' as time) THEN 'Evening' Else 'Afternoon' End as time_of_day FROM sightings;


-- problem 9
DELETE FROM rangers WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings)

