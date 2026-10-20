-- Run once on an existing database.
-- Hashed passwords are about 100 characters, so the old VARCHAR(45) column is too small.
-- Existing plain-text passwords keep working: each one is converted to a hash the next time that admin logs in.
USE mydb;

ALTER TABLE administrator
  MODIFY Admin_Password VARCHAR(255) NULL;
