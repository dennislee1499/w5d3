PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_follows; 
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    reply_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL, 

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);



INSERT INTO 
    users (fname, lname)
VALUES
    ('Dennis', 'Lee'),
    ('Klodian', 'Behrami');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Chicken', 'Why did the chicken cross the road', (SELECT id FROM users WHERE fname = 'Dennis' AND lname = 'Lee')),
    ('general', 'Hows the weather', (SELECT id FROM users WHERE fname = 'Klodian' AND lname = 'Behrami'));

INSERT INTO
    question_follows (user_id, question_id)
VALUES 
    ((SELECT id FROM users WHERE fname = 'Klodian' AND lname = 'Behrami'), (SELECT id FROM questions WHERE title = 'Chicken')),
    ((SELECT id FROM users WHERE fname = 'Dennis' AND lname = 'Lee'), (SELECT id FROM questions WHERE title = 'general'));

INSERT INTO 
    replies (body, question_id, user_id, reply_id)
VALUES
    ('good question', (SELECT id FROM questions WHERE title = 'Chicken'), (SELECT id FROM users WHERE fname = 'Klodian' AND lname = 'Behrami'), NULL),
    ('its raining', (SELECT id FROM questions WHERE title = 'general'), (SELECT id FROM users WHERE fname = 'Klodian' AND lname = 'Behrami'), NULL);

INSERT INTO 
    replies (body, question_id, user_id, reply_id)
VALUES 
    ('thanks', (SELECT id FROM questions WHERE title = 'Chicken'), (SELECT id FROM users WHERE fname = 'Dennis' AND lname = 'Lee'), (SELECT id FROM replies WHERE body = 'good question'));

INSERT INTO 
    question_likes(user_id, question_id)
VALUES 
    ((SELECT id FROM users WHERE fname = 'Klodian' AND lname = 'Behrami'), (SELECT id FROM questions WHERE title = 'Chicken')),
    ((SELECT id FROM users WHERE fname = 'Dennis' AND lname = 'Lee'), (SELECT id FROM questions WHERE title = 'general'));


    