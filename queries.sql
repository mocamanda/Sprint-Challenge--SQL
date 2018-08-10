CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME default current_time,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE channel_user (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);

INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);

INSERT INTO message (content, user_id, channel_id) VALUES ('Hi', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Sup', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Ohai', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Yahello', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Howdy do?', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Heyo', 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Greetings', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('See ya', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Salutations', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Ciao', 3, 2);

SELECT name FROM organization;
SELECT name FROM channel;

SELECT content FROM message, user
    WHERE user_id = user.id
    AND user.name = "Kenzie";

SELECT content from message, channel, user
    WHERE user_id = user.id
    AND channel_id = channel.id
    AND channel.name = "#lambda"
    AND user.name = "Kenzie";

SELECT user.name AS "User Name", COUNT(*) AS "Message Count" FROM user, message
    WHERE user_id = user.id
    GROUP BY user.name 
    ORDER BY user.name DESC;

SELECT user.name AS "User", channel.name AS "Channel", COUNT(*) AS "Message Count"
    FROM user, channel, message, channel_user
    WHERE message.user_id = user.id
    AND message.channel_id = channel.id
    AND user.id = channel_user.user_id
    AND channel.id = channel_user.channel_id
    GROUP BY channel.name, user.id;
