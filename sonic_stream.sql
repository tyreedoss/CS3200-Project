DROP DATABASE sonic_stream;

CREATE DATABASE sonic_stream;
USE sonic_stream;

CREATE TABLE IF NOT EXISTS listener
(
    id integer AUTO_INCREMENT PRIMARY KEY ,
    username varchar(255) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    dob DATE,
    location varchar(255)
);

INSERT INTO listener (username, password, dob, location) VALUES
    ('hpotter', 'asdf1234', DATE('2000-01-01'), 'hogwarts');
INSERT INTO listener (username, password, dob, location) VALUES
    ('jraiden', 'jacktheripper', DATE('2000-01-06'), 'america');
INSERT INTO listener (username, password, dob, location) VALUES
    ('wsartorio', 'myrealpassword1234', DATE('2005-02-02'), 'boston');

-- i figured that order of who friended who does not matter (unlike follows)
CREATE TABLE IF NOT EXISTS friend(
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    friend_1 INT,
    friend_2 INT,
    PRIMARY KEY (friend_1, friend_2),
    CONSTRAINT fk_01 FOREIGN KEY (friend_1) REFERENCES listener(id)
        ON UPDATE cascade,
    CONSTRAINT fk_02 FOREIGN KEY (friend_2) REFERENCES listener(id)
        ON UPDATE cascade
);

INSERT INTO friend (friend_1, friend_2) VALUES (1, 2);
INSERT INTO friend (friend_1, friend_2) VALUES (2, 3);

CREATE TABLE IF NOT EXISTS concert(
    id INT AUTO_INCREMENT PRIMARY KEY,
    venue VARCHAR(60),
    event_date DATE
);

INSERT INTO concert (venue, event_date) VALUES
    ('fenway', DATE('2024-06-07'));
INSERT INTO concert (venue, event_date) VALUES
    ('international space station', DATE('2034-08-11'));

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
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    bio VARCHAR(2500)
);

INSERT INTO artist(name, bio) VALUES
    ('michael jackson', 'HEE HEE');
INSERT INTO artist(name, bio) VALUES
    ('bon jovi', 'WOOOOAH LIVING ON A PRAYER');

CREATE TABLE IF NOT EXISTS artist_concert(
    artist_id INT,
    concert_id INT,
    PRIMARY KEY (artist_id, concert_id),
    CONSTRAINT fk_05 FOREIGN KEY (artist_id) REFERENCES artist(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_06 FOREIGN KEY (concert_id) REFERENCES concert(id)
        ON UPDATE cascade ON DELETE cascade
);

INSERT INTO artist_concert(artist_id, concert_id) VALUES (1, 1);
INSERT INTO artist_concert(artist_id, concert_id) VALUES (2, 2);

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

INSERT INTO listener_artist(listener_id, artist_id, playcount) VALUES
    (1, 1, 2049);
INSERT INTO listener_artist(listener_id, artist_id, playcount) VALUES
    (2, 2, 65038);

CREATE TABLE IF NOT EXISTS playlist(
    listener_id INT,
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(500),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (listener_id) REFERENCES listener(id)
);

INSERT INTO playlist(listener_id, name, description) VALUES
    (1, 'spell training', 'for defense against the dark arts');
INSERT INTO playlist(listener_id, name, description) VALUES
    (2, 'destroying metal gears', 'RULES OF NATURE');

CREATE TABLE IF NOT EXISTS revenue(
    id INT AUTO_INCREMENT PRIMARY KEY,
    song_payout DOUBLE,
    company_revenue DOUBLE,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO revenue(song_payout, company_revenue) VALUES
    (10, 100.46);
INSERT INTO revenue(song_payout, company_revenue) VALUES
    (20, 100.46);

CREATE TABLE IF NOT EXISTS song(
    id INT AUTO_INCREMENT PRIMARY KEY,
    album VARCHAR(70),
    title VARCHAR(50),
    genre VARCHAR(50),
    duration TIME,
    release_date DATE,
    revenue_id INT,
    FOREIGN KEY (revenue_id) REFERENCES revenue(id)
);

INSERT INTO song(album, title, genre, duration, release_date, revenue_id) VALUES
    ('asdf', 'asd', 'post-apocalyptic egyptian punk rock', TIME('00:03:36'),
     DATE('2049-03-29'), 1);
INSERT INTO song(album, title, genre, duration, release_date, revenue_id) VALUES
    ('it has to be this way', 'MGR OST', 'heavy metal', TIME('00:02:56'),
     DATE('2013-02-20'), 1);

CREATE TABLE IF NOT EXISTS playlist_song(
    playlist_id INT,
    song_id INT,
    PRIMARY KEY (playlist_id, song_id),
    CONSTRAINT fk_10 FOREIGN KEY (playlist_id) REFERENCES playlist(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_11 FOREIGN KEY (song_id) REFERENCES song(id)
        ON UPDATE cascade ON DELETE cascade
);

INSERT INTO playlist_song(playlist_id, song_id) VALUES (1, 1);
INSERT INTO playlist_song(playlist_id, song_id) VALUES (2, 2);

CREATE TABLE IF NOT EXISTS review(
    id INTEGER AUTO_INCREMENT,
    song_id INTEGER,
    listener_id INTEGER,
    text VARCHAR(2500),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id, song_id),
    CONSTRAINT fk_12 FOREIGN KEY (song_ID) REFERENCES song(id)
        ON UPDATE cascade ON DELETE cascade,
    foreign key (listener_id) REFERENCES listener(id)
);

INSERT INTO review(song_id, listener_id, text) VALUES
    (1, 3, 'absolute masterpiece');
INSERT INTO review(song_id, listener_id, text) VALUES
    (1, 2, 'id get married with this in the background');

CREATE TABLE IF NOT EXISTS artist_revenue(
    artist_id INT,
    revenue_id INT,
    PRIMARY KEY (artist_id, revenue_id),
    CONSTRAINT fk_13 FOREIGN KEY (artist_id) REFERENCES artist(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_14 FOREIGN KEY (revenue_id) REFERENCES revenue(id)
        ON UPDATE cascade ON DELETE cascade
);

INSERT INTO artist_revenue(artist_id, revenue_id) VALUES(1, 1);
INSERT INTO artist_revenue(artist_id, revenue_id) VALUES(2, 2);

CREATE TABLE IF NOT EXISTS artist_song(
    artist_id INT,
    song_id INT,
    PRIMARY KEY (artist_id, song_id),
    CONSTRAINT fk_15 FOREIGN KEY (artist_id) REFERENCES artist(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_16 FOREIGN KEY (song_id) REFERENCES song(id)
        ON UPDATE cascade ON DELETE cascade
);

INSERT INTO artist_song(artist_id, song_id) VALUES (1, 1);
INSERT INTO artist_song(artist_id, song_id) VALUES (1, 2);

CREATE TABLE IF NOT EXISTS advertisement(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60),
    company VARCHAR(60),
    target_location VARCHAR(100),
    target_age VARCHAR(50),
    status VARCHAR(60), -- not sure if we want this as a boolean
    revenue_id INT,
    FOREIGN KEY (revenue_id) REFERENCES revenue(id)
);

INSERT INTO advertisement(name, company, target_location, target_age, status, revenue_id)
    VALUES('acquire money', 'umbrella corp', 'mars', '95-102', 'indefinite hiatus', 1);
INSERT INTO advertisement(name, company, target_location, target_age, status, revenue_id)
    VALUES('project zebra', 'vought', 'hell', '12-16', 'complete', 2);

CREATE TABLE IF NOT EXISTS listener_song(
    listener_id INT,
    song_id INT,
    playcount INT,
    liked_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (listener_id, song_id),
    CONSTRAINT fk_17 FOREIGN KEY (listener_id) REFERENCES listener(id)
        ON UPDATE cascade ON DELETE CASCADE,
    CONSTRAINT fk_18 FOREIGN KEY (song_id) REFERENCES song(id)
        ON UPDATE cascade ON DELETE cascade
);

INSERT INTO listener_song(listener_id, song_id, playcount) VALUES
    (1, 2, 2039485);
INSERT INTO listener_song(listener_id, song_id, playcount) VALUES
    (3, 1, 3948504);

