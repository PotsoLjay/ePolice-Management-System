-- ePolice demo data. Everything here is fictional.
-- Run AFTER Project.sql on an empty database:  mysql -u root -p mydb < Seed.sql
--
-- Demo logins (change or delete these before using the system for anything real):
--   Master administrator   Admin ID: 0      Password: Master@123
--   Administrator          Admin ID: 1001   Password: Admin@123
-- Passwords are stored as PBKDF2 hashes, never as plain text.

USE mydb;

INSERT INTO administrator (Admin_ID, Admin_First_Name, Admin_Last_Name, Phone_Num, Email, Admin_Password) VALUES
(0,    'Master', 'Admin',   '0120000000', 'master@epolice.example', 'pbkdf2$100000$le+npeHmP/KMs32c12ljxQ==$dwQalxSfwOBaAqSZR4+zMPJjTl/uCYMehdHZbOzVQFc='),
(1001, 'Thandi', 'Mokoena', '0821234567', 'thandi.mokoena@epolice.example', 'pbkdf2$100000$I8426+gyoDpZmjFFAKhAGA==$8dj6nUfObFJaEwDadk+rIhTPxKXgm4b5HVRUTmdZbrg=');

INSERT INTO `case` (Case_ID, Admin_ID, Location, `Date`, Crime_Committed) VALUES
(10001, 1001, 'Pretoria Central',   '2026-03-04', 'Theft'),
(10002, 1001, 'Soshanguve Block F', '2026-03-11', 'Assault'),
(10003, 1001, 'Mamelodi East',      '2026-03-19', 'Fraud'),
(10004, 1001, 'Hatfield',           '2026-04-02', 'Theft'),
(10005, 1001, 'Centurion',          '2026-04-15', 'Domestic Violence'),
(10006, 1001, 'Pretoria Central',   '2026-05-08', 'Kidnapping'),
(10007, 1001, 'Soshanguve Block F', '2026-05-21', 'Theft'),
(10008, 1001, 'Mamelodi East',      '2026-06-03', 'Assault');

INSERT INTO victim (Victim_ID, Victim_First_Name, Victim_Last_Name, Victim_Phone_Number, Address, Admin_ID, Case_ID) VALUES
(20001, 'Lerato', 'Dlamini', '0839876543', '12 Church St, Pretoria', 1001, 10001),
(20002, 'Sipho',  'Nkosi',   '0724561890', '4 Ntuli Rd, Soshanguve',  1001, 10002),
(20003, 'Anele',  'Khumalo', '0611122334', '88 Orchid Ave, Mamelodi', 1001, 10003),
(20004, 'Pieter', 'Botha',   '0795550101', '5 Duxbury Rd, Hatfield',  1001, 10004),
(20005, 'Naledi', 'Sithole', '0847778899', '21 Rooihuiskraal, Centurion', 1001, 10005);

INSERT INTO suspect (Suspect_ID, Suspect_First_Name, Suspect_Last_Name, Suspect_Address, Admin_ID, Case_ID) VALUES
(30001, 'Tebogo', 'Maseko',  'Unknown, last seen near Pretoria Central taxi rank', 1001, 10001),
(30002, 'Jabu',   'Mahlangu', '17 Mabena St, Soshanguve', 1001, 10002),
(30003, 'Riaan',  'Pretorius', '9 Kerk St, Mamelodi', 1001, 10003),
(30004, 'Unknown','Suspect',  'No fixed address', 1001, 10004);

INSERT INTO evidence (Evidence_ID, Case_ID, Description_Of_Evidence, Admin_ID) VALUES
(40001, 10001, 'CCTV footage from the taxi rank, 14:05 to 14:20', 1001),
(40002, 10002, 'Photographs of injuries and the scene', 1001),
(40003, 10003, 'Bank statements showing three unauthorised transfers', 1001),
(40004, 10004, 'Broken car window glass and fingerprints lifted from the door', 1001);

INSERT INTO documents (Document_ID, Document_Type, Date_of_Upload, Description_of_Doc, Admin_ID) VALUES
(50001, 'PDF',   '2026-03-05', 'Sworn statement from the complainant (Case 10001)', 1001),
(50002, 'WORD',  '2026-03-12', 'Medical report for Case 10002', 1001),
(50003, 'EXCEL', '2026-03-20', 'Spreadsheet of disputed transactions (Case 10003)', 1001);
