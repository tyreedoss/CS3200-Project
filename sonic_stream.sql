DROP DATABASE sonic_stream;

CREATE DATABASE sonic_stream;
USE sonic_stream;

CREATE TABLE IF NOT EXISTS listener
(
    id integer AUTO_INCREMENT PRIMARY KEY ,
    username varchar(255) UNIQUE NOT NULL,
    password varchar(255),
    dob DATE,
    location varchar(255)
);

-- i figured that order of who friended who does not matter (unlike follows)
CREATE TABLE IF NOT EXISTS friend(
    created_at DATETIME,
    friend_1 INT,
    friend_2 INT,
    PRIMARY KEY (friend_1, friend_2),
    CONSTRAINT fk_01 FOREIGN KEY (friend_1) REFERENCES listener(id)
        ON UPDATE cascade,
    CONSTRAINT fk_02 FOREIGN KEY (friend_2) REFERENCES listener(id)
        ON UPDATE cascade
);

CREATE TABLE IF NOT EXISTS concert(
    id INT UNIQUE PRIMARY KEY,
    venue VARCHAR(60),
    event_date DATE
);

CREATE TABLE IF NOT EXISTS listener_concert(
    listener_id INT,
    concert_id INT,
    PRIMARY KEY (listener_id, concert_id),
    CONSTRAINT fk_03 FOREIGN KEY (listener_id) REFERENCES listener(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_04 FOREIGN KEY (concert_id) REFERENCES concert(id)
        ON UPDATE cascade ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS artist(
    id INT UNIQUE PRIMARY KEY,
    name VARCHAR(50),
    bio VARCHAR(2500)
);

CREATE TABLE IF NOT EXISTS artist_concert(
    artist_id INT,
    concert_id INT,
    PRIMARY KEY (artist_id, concert_id),
    CONSTRAINT fk_05 FOREIGN KEY (artist_id) REFERENCES artist(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_06 FOREIGN KEY (concert_id) REFERENCES concert(id)
        ON UPDATE cascade ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS listener_artist(
    listener_id INT,
    artist_id INT,
    playcount INT,
    PRIMARY KEY (listener_id, artist_id),
    CONSTRAINT fk_07 FOREIGN KEY (listener_id) REFERENCES listener(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_08 FOREIGN KEY (artist_id) REFERENCES artist(id)
        ON UPDATE cascade ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS playlist(
    id INT,
    playlist_number INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(500),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES listener(id)
);

CREATE TABLE IF NOT EXISTS revenue(
    id INT UNIQUE PRIMARY KEY,
    artist_revenue DOUBLE,
    company_revenue DOUBLE,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS song(
    id INT UNIQUE PRIMARY KEY,
    album VARCHAR(70),
    title VARCHAR(50),
    genre VARCHAR(50),
    duration DATE,
    release_date DATE,
    revenue_id INT,
    FOREIGN KEY (revenue_id) REFERENCES revenue(id)
);

CREATE TABLE IF NOT EXISTS playlist_song(
    playlist_id INT,
    song INT,
    PRIMARY KEY (playlist_id, song),
    CONSTRAINT fk_10 FOREIGN KEY (playlist_id) REFERENCES
        playlist(id, playlist_number)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_11 FOREIGN KEY (song) REFERENCES song(id)
        ON UPDATE cascade ON DELETE cascade
);