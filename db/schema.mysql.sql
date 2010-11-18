CREATE TABLE ulsimag_user
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
  email VARCHAR(128) NOT NULL,
  salt VARCHAR(128) NOT NULL,
  encrypted_password VARCHAR(128) NOT NULL,
  lost_password VARCHAR(128) NOT NULL,
--  image VARCHAR(128),
--  about TEXT,
  admin BOOLEAN
);

CREATE TABLE ulsimag_email_account
(
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id INTEGER NOT NULL,
  email VARCHAR(128) NOT NULL,
  login VARCHAR(128) NOT NULL,
  password VARCHAR(128) NOT NULL,
  CONSTRAINT FK_email_user FOREIGN KEY (user_id)
    REFERENCES ulsimag_user (id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE ulsimag_relationship
(
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  follower_id INTEGER NOT NULL,
  followed_id INTEGER NOT NULL
);

CREATE TABLE ulsimag_parseemail
(
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id INTEGER NOT NULL,
  date INTEGER,
  subject VARCHAR(128),
  body TEXT NOT NULL,
  from VARCHAR(128),
  to VARCHAR(128),
  send BOOLEAN
  share BOOLEAN,
  attachments,
  CONSTRAINT FK_email_user FOREIGN KEY (user_id)
    REFERENCES ulsimag_user (id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE ulsimag_label
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL
);

CREATE TABLE ulsimag_parseemail_label
(
    email_id INTEGER NOT NULL,
    label_id INTEGER NOT NULL,
    PRIMARY KEY (email_id, label_id)
    CONSTRAINT FK_parseemail FOREIGN KEY (email_id),
        REFERENCES ulsimag_parseemail (id) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT FK_label FOREIGN KEY (label_id)
        REFERENCES ulsimag_label (id) ON DELETE CASCADE ON UPDATE RESTRICT
);