CREATE TABLE Astrologers (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE UserTypes (
    id INT PRIMARY KEY,
    type_name VARCHAR(255)
);

CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    user_type_id INT,
    FOREIGN KEY (user_type_id) REFERENCES UserTypes(id)
);

CREATE TABLE Pings (
    id INT PRIMARY KEY,
    astrologer_id INT,
    user_id INT,
    ping_time DATETIME,
    FOREIGN KEY (astrologer_id) REFERENCES Astrologers(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Chats (
    id INT PRIMARY KEY,
    session_start DATETIME,
    session_length INT,
    revenue DECIMAL(10, 2)
);

CREATE TABLE PingChatLinks (
    id INT PRIMARY KEY,
    ping_id INT,
    chat_id INT,
    FOREIGN KEY (ping_id) REFERENCES Pings(id),
    FOREIGN KEY (chat_id) REFERENCES Chats(id)
);
