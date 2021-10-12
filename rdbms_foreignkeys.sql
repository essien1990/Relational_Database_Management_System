-- create a new table for questions

CREATE TABLE stackoverflow."questions" (
    "id" int4 NOT NULL ,
    "user_id" int4 NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "accepted_answer_id" int4 NULL,
    "score" int4 NOT NULL DEFAULT 0,
    "view_count" int4 NOT NULL DEFAULT 0,
    "comment_count" int4 NOT NULL DEFAULT 0,
    "created_at" timestamp NOT NULL,
    primary key(id)
);



--You get an error: “questions does not exist” because the default schema is still the public schema

SELECT * FROM questions;



-- specify the schema name as a prefix to the table name

SELECT * FROM stackoverflow.questions;



-- change the default schema

SET search_path TO stackoverflow;


-- The command will be executed successfully

SELECT *  FROM questions;


------------------------IMPORT DATA--------------------------------------

-- The COPY command is an efficient way to get CSV files into Postgres
-- -- SQL Error [23502]: ERROR: null value in column "user_id" violates not-null constraint

COPY questions FROM '/Users/.../stackoverflow/questions.csv' WITH (FORMAT
CSV, HEADER, DELIMITER ',', QUOTE '"');


-- ALTER command to make the column NULLABLE
ALTER TABLE questions ALTER COLUMN user_id DROP NOT  NULL ;


-- Repeat the COPY again (224,719 rows)

COPY questions FROM '/Users/.../stackoverflow/questions.csv' WITH (FORMAT
CSV, HEADER, DELIMITER ',', QUOTE '"');


SELECT count(*) FROM questions;


--------------------ADD/REMOVE COLUMNS------------------------------------

-- Add a "question_rank" column
ALTER TABLE questions ADD COLUMN question_rank int4;


-- confirm that the column is present
SELECT * FROM questions LIMIT 10;

-- Let's drop the column
ALTER TABLE questions DROP COLUMN question_rank;


-------------------------CREATE & IMPORT OTHER TABLES-----------------------------


CREATE  TABLE "answers" (
"id" int4,
"user_id" int4 ,
"question_id" int4 NOT NULL,
"body"  TEXT NOT NULL,
"score" int4  NOT NULL DEFAULT 0,
"comment_count" int4  NOT NULL DEFAULT 0,
"created_at" timestamp ,
PRIMARY KEY ( "id" )
);

COPY answers FROM '/home/nana/Desktop/blossom_academy/rdms/answers.csv' WITH (FORMAT CSV,
HEADER);


CREATE TABLE users (
    "id" int,
    "display_name" text NOT NULL,
    "reputation" text NULL,
    "website_url" text NULL,
    "location" text NULL,
    "about_me" text NULL,
    "views" int NULL,
    "up_votes" int NULL,
    "down_votes" int NULL,
    "image_url" text NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    primary key(id)
);


COPY users FROM '/home/nana/Desktop/blossom_academy/rdms/users.csv' WITH (FORMAT CSV,
HEADER);


CREATE  TABLE question_tags (
"question_id" int,
"tag" text,
PRIMARY KEY (question_id, tag)
);

COPY question_tags FROM '/home/nana/Desktop/blossom_academy/rdms/question_tags.csv' WITH (FORMAT CSV, HEADER);



---------------------Create Foregign Keys-----------------------------------------

-- users can not be deleted if their questions are not deleted first
ALTER  TABLE questions ADD FOREIGN  KEY (user_id) REFERENCES  users ON DELETE RESTRICT;

-- users can not be deleted if their answers are not deleted first
ALTER  TABLE answers ADD FOREIGN  KEY (user_id)  REFERENCES  users ON DELETE RESTRICT;

-- when questions are deleted, answers can be remain
ALTER  TABLE answers ADD FOREIGN  KEY (question_id)  REFERENCES questions ON DELETE NO ACTION;

-- when questions are deleted, all tags should be deleted automatically
ALTER  TABLE question_tags ADD FOREIGN  KEY (question_id)  REFERENCES questions ON DELETE CASCADE;


--------------------------------------Consolidate to a single compact script---------------------------------------------

-- CASCADE option drops the schema’s tables and all other objects
drop schema stackoverflow cascade ;


-----------------------command to import the sql file--------------------------------------------

cat import_data.sql | psql --host localhost --username postgres --password