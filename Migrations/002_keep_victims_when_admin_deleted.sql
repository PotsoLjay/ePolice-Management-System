-- Run once on an existing database.
-- Before: deleting an administrator also deleted every victim record that administrator captured (ON DELETE CASCADE).
-- After:  the victim records are kept and only their Admin_ID is cleared, matching how case, suspect and evidence already behave.
USE mydb;

ALTER TABLE victim DROP FOREIGN KEY FK4;

ALTER TABLE victim
  ADD CONSTRAINT FK4 FOREIGN KEY (Admin_ID) REFERENCES administrator (Admin_ID)
  ON DELETE SET NULL ON UPDATE CASCADE;
