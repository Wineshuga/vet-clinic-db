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
                GROUP BY
                    neutered
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

/*Queries with JOIN*/

SELECT
    name AS animal_name,
    full_name AS owner
FROM animals as a
    INNER JOIN owners as o ON a.owner_id = o.id
WHERE o.id = 4;

SELECT
    a.name AS name_of_animals,
    s.name AS TYPE
FROM animals AS a
    INNER JOIN species AS s ON a.species_id = s.id
WHERE s.id = 1;

SELECT
    full_name AS owners,
    name AS animal_name
FROM owners AS o FULL
    JOIN animals AS a ON o.id = a.owner_id;

SELECT
    s.name AS species,
    COUNT(a.id) AS num_animals
FROM animals AS a
    INNER JOIN species AS s ON a.species_id = s.id
GROUP BY s.name
ORDER BY num_animals DESC;

SELECT
    full_name AS owner,
    a.name AS animal_names,
    s.name AS species
FROM animals As a
    INNER JOIN owners AS o ON a.owner_id = o.id
    INNER JOIN species AS s ON a.species_id = s.id
WHERE
    full_name = 'Jennifer Orwell'
    AND s.id = 2;

SELECT
    full_name AS owner,
    name AS animal_name,
    escape_attempts
FROM animals AS a
    INNER JOIN owners AS o ON a.owner_id = o.id
WHERE
    escape_attempts = 0
    AND full_name = 'Dean Winchester';

SELECT
    full_name,
    COUNT(a.id) AS num_of_animals
FROM animals AS a
    INNER JOIN owners AS o ON a.owner_id = o.id
GROUP BY full_name
HAVING COUNT(a.id) = (
        SELECT MAX(animal_count)
        FROM (
                SELECT
                    COUNT(id) AS animal_count
                FROM animals
                GROUP BY
                    owner_id
            ) AS subquery
    );