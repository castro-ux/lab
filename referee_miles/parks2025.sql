/* Calculating Distance using POSTGIS */

-- Enable the PostGIS spatial extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- DROP TABLE IF IT EXISTS
DROP TABLE IF EXISTS parks2025 CASCADE;

-- CREATE TABLE
CREATE TABLE parks2025 (
    game        VARCHAR(15) NOT NULL,
    date        DATE,
    park        TEXT,
    longitude   DOUBLE PRECISION,
    latitude    DOUBLE PRECISION, 
    geom        GEOMETRY(Point, 4326)
    );
   
-- IMPORT DATA TO TABLE
COPY parks2025 (game, date, park, latitude, longitude)
FROM '/tmp/imports/df_sorted.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- TURN COORDINATES TO A SPATIAL POINT. LONGITUDE THEN LATITUDE
UPDATE parks2025
SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);

-- CALCULATE THE DISTANCE
-- PENN STATION:-73.993899 40.750638) 
CREATE OR REPLACE VIEW penn_station_analysis AS 
SELECT *,
    ST_Distance(
        geom::geography,
        ST_GeographyFromText('SRID=4326;POINT(-73.993899 40.750638)')
    ) * 0.000621371 AS one_way_miles,

    (ST_Distance(
        geom::geography,
        ST_GeographyFromText('SRID=4326;POINT(-73.993899 40.750638)')
    ) * 0.000621371) * 2 AS round_trip_miles
FROM parks2025;

-- VIEW RESULTS
SELECT date, game, park, one_way_miles, round_trip_miles
FROM penn_station_analysis
ORDER BY date; 

-- Calculate 2025 Total Miles 
SELECT 
    SUM(round_trip_miles) AS total_season_mileage
FROM penn_station_analysis;

-- EXPORT DATA
\copy (SELECT * FROM penn_station_analysis) TO '/tmp/imports/final_results.csv' WITH (FORMAT CSV, HEADER);
