DROP TABLE IF EXISTS QueueSettings;
DROP TABLE IF EXISTS UserSettings;
DROP TABLE IF EXISTS RoomSettings;
DROP TABLE IF EXISTS Announsements;
DROP TABLE IF EXISTS QueueMembers;
DROP TABLE IF EXISTS RoomMember;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Queues;

CREATE TABLE Users(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    vk_id      INTEGER UNIQUE,
    first_name TEXT    NOT NULL,
    last_name  TEXT,
    photo_url  TEXT
);

CREATE TABLE Rooms(
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    title    TEXT    NOT NULL UNIQUE, -- not sure
    password TEXT    NOT NULL -- not sure
);

CREATE TABLE Queues(
    id      INTEGER   PRIMARY KEY AUTOINCREMENT,
    room_id INTEGER   NOT NULL,
    title   TEXT      NOT NULL,
    date    TIMESTAMP NOT NULL,

    FOREIGN KEY id REFERENCES Rooms(id)
        ON DELETE CASCADE
);

CREATE TABLE RoomMembers(
    room_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    role    TEXT    NOT NULL, -- todo: change to enum/bit mask

    FOREIGN KEY room_id REFERENCES Rooms(id)
        ON DELETE CASCADE,

    FOREIGN KEY user_id REFERENCES Users(id)
        ON DELETE CASCADE
);

CREATE TABLE QueueMembers(
    queue_id INTEGER NOT NULL,
    user_id  INTEGER NOT NULL,
    position INTEGER NOT NULL UNIQUE,
    status   TEXT    NOT NULL, -- todo: change to enum

    FOREIGN KEY queue_id REFERENCES Queues(id)
        ON DELETE CASCADE,

    FOREIGN KEY user_id REFERENCES Users(id)
        ON DELETE CASCADE
);

CREATE TABLE Announsements(
    id      INTEGER   PRIMARY KEY AUTOINCREMENT,
    room_id INTEGER   NOT NULL,
    title   TEXT      NOT NULL, -- unique?
    body    TEXT      NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY room_id REFERENCES Rooms(id)
        ON DELETE CASCADE
);

CREATE TABLE UserSettings(
    user_id INTEGER NOT NULL UNIQUE,
    -- some other columns

    FOREIGN KEY user_id REFERENCES Users(id)
        ON DELETE CASCADE
);

CREATE TABLE QueueSettings(
    queue_id INTEGER NOT NULL UNIQUE,
    -- some other columns

    FOREIGN KEY queue_id REFERENCES Queues(id)
        ON DELETE CASCADE
);

CREATE TABLE RoomSettings(
    room_id INTEGER NOT NULL UNIQUE,
    -- some other columns

    FOREIGN KEY room_id REFERENCES Rooms(id)
        ON DELETE CASCADE
);
