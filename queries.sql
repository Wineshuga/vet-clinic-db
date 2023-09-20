/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';

SELECT *
FROM animals
WHERE
    date_of_birth >= '2016-01-01'
    AND date_of_birth <= '2019-12-31';

SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE
    name in ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3 

/*First transaction */

BEGIN TRANSACTION;

UPDATE animals set species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

/*Second transaction */

BEGIN;

UPDATE animals set species = 'digimon' WHERE name like '%mon';

UPDATE animals set species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

/*Third transaction */

BEGIN;

DELETE FROM animals;

ROLLBACK;

SELECT * FROM animals 

/*Fourth transaction */

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO SP;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

/*Queries*/

SELECT COUNT(id) AS num_of_animals FROM animals;

SELECT
    COUNT(id) AS num_of_no_escape_animals
FROM animals
GROUP BY escape_attempts
HAVING escape_attempts = 0;

SELECT avg(weight_kg) AS average_weight FROM animals;

SELECT neutered
FROM animals
GROUP BY neutered
HAVING SUM(escape_attempts) = (
        SELECT
            MAX(total_escape_attempts)
        FROM (
                SELECT
                    SUM(escape_attempts) AS total_escape_attempts
                FROM animals
                GROUP BY neutered
            )
    );

SELECT
    species,
    min(weight_kg) AS min_weight,
    max(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT avg(escape_attempts)
FROM animals
WHERE
    date_of_birth > '1990-01-01'
    AND date_of_birth < '2000-12-31'
GROUP BY species;