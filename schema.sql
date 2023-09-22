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

/*create vets table*/

CREATE TABLE
    vets(
        id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(255) NOT NULL,
        age INT NOT NULL,
        date_of_graduation DATE NOT NULL
    );

/*create specialization table*/

CREATE TABLE
    specializations(
        species_id INT REFERENCES species(id),
        vet_id INT REFERENCES vets(id),
        PRIMARY KEY (species_id, vet_id)
    );

/*create visits table*/

CREATE TABLE
    visits(
        animal_id INT REFERENCES animals(id),
        vet_id INT REFERENCES vets(id),
        PRIMARY KEY (animal_id, vet_id)
    );

/*Add visit_date column to visits table*/

ALTER TABLE visits ADD COLUMN visit_date date;

/*Drop primary key constraint in visits table*/

ALTER TABLE visits DROP CONSTRAINT visits_pkey;