/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY NOT NULL, 
    name VARCHAR(100) NOT NULL, 
    date_of_birth DATE NOT NULL, 
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
  );

ALTER TABLE animals 
    ADD species VARCHAR(255);

-- Owners table 
CREATE TABLE owners (
    id SERIAL PRIMARY KEY NOT NULL,
    full_name varchar(100),
    age INT
);

-- Species table 
CREATE TABLE species (
    id SERIAL PRIMARY KEY NOT NULL,
    name varchar(100)
);

-- Remove column species
ALTER TABLE animals DROP species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
  ADD species_id INT,
  ADD CONSTRAINT fk_species
  FOREIGN KEY (species_id)
  REFERENCES species (id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
  ADD owner_id INT,
  ADD CONSTRAINT fk_owner
  FOREIGN KEY (owner_id)
  REFERENCES owners (id);

-- Creating new table vets
CREATE TABLE vets (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(100) NOT NULL, 
  age INT,
  date_of_graduation DATE NOT NULL 
);

--Specialization table
CREATE TABLE specializations (
    species_id INT,
    vet_id INT,
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);

--Visit table
CREATE TABLE visits (
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE,
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- optimize queries performance 
CREATE INDEX visits_animals_id ON visits(animal_id);
CREATE INDEX visits_vets_id ON visits(vet_id);
CREATE INDEX visits_owners_id ON owners(email);
