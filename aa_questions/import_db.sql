PRAGMA foreign_keys = ON;

CREATE TABLE users (
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
    id INTEGER PRIMARY KEY

);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY 
    title TEXT NOT NULL 
    body TEXT NOT NULL  
    author_id TEXT NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY 
    user_id INTEGER NOT NULL
    question_id INTEGER NOT NULL 

    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY
    body TEXT NOT NULL 
    question_id INTEGER NOT NULL 
    user_id INTEGER NOT NULL 
    reply_id INTEGER 

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY 
    user_id INTEGER NOT NULL
    question_id INTEGER NOT NULL 

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

