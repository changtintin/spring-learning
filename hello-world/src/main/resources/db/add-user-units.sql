ALTER TABLE users
    ADD COLUMN weight_unit VARCHAR(10) NOT NULL DEFAULT 'kg' AFTER weight_kg,
    ADD COLUMN height_unit VARCHAR(10) NOT NULL DEFAULT 'cm' AFTER height_cm;
