/* Database schema to keep the structure of entire database. */

CREATE TABLE
    animals(
        id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50) NOT NULL,
        date_of_birth DATE NOT NULL,
        escape_attempts int NOT NULL,
        neutered BOOLEAN NOT NULL,
        weight_kg DECIMAL(5, 2) NOT NULL
    );

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE
    owners(
        id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        full_name VARCHAR(255) NOT NULL,
        age INT
    );

CREATE TABLE
    species(
        id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(50)
    );

/*Modify animal table*/

BEGIN;

ALTER TABLE
    animals DROP COLUMN species,
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT;

COMMIT;

/*Make columns FOREIGN keys*/

BEGIN;

ALTER TABLE animals
ADD
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

SAVEPOINT sp1;

ALTER TABLE animals
ADD
    CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

COMMIT;