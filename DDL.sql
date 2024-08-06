CREATE DATABASE IF NOT EXISTS SonicStream;

USE SonicStream;

CREATE TABLE IF NOT EXISTS Listeners
(
    ID integer AUTO_INCREMENT PRIMARY KEY ,
    Username varchar(255) UNIQUE NOT NULL,
    Password varchar(255),
    DateOfBirth DATE,
    Location varchar(255)
);

CREATE TABLE IF NOT EXISTS Playlists
(
    PlaylistNumber integer AUTO_INCREMENT PRIMARY KEY,
    PlaylistName varchar(255),
    Description varchar(255),
    UserID integer NOT NULL,
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt datetime DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) references Listeners (ID)
);

CREATE TABLE IF NOT EXISTS Followers
(
    follower_id integer NOT NULL,
    followee_id integer NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES Listeners (ID)
        ON UPDATE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES Artists (ID)
        ON UPDATE CASCADE,
    PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE IF NOT EXISTS Friends
(
    friender_id integer NOT NULL,
    friended_id integer NOT NULL,
    FOREIGN KEY (friended_id) REFERENCES Listeners (ID)
        ON UPDATE CASCADE,
    FOREIGN KEY (friender_id) REFERENCES Listeners (ID)
        ON UPDATE CASCADE,
    PRIMARY KEY (friended_id, friender_id)
);