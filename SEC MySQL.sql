-- Create the database
CREATE DATABASE music_streaming;
USE music_streaming;

-- Table for storing user information
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing song information
CREATE TABLE songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    album VARCHAR(100),
    genre VARCHAR(50),
    release_date DATE,
    duration INT NOT NULL,  -- duration in seconds
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing playlists
CREATE TABLE playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table for storing songs within playlists
CREATE TABLE playlist_songs (
    playlist_song_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_id INT,
    song_id INT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- Table for storing user listening history
CREATE TABLE listening_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    song_id INT,
    listened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- Insert user
INSERT INTO users (username, password_hash, email)
VALUES ('Himanshu', 'hashed_password_here', 'himanshu@example.com');

-- Get user_id of Himanshu
SET @user_id = (SELECT user_id FROM users WHERE username = 'Himanshu');

-- Insert songs (Hindi songs sample)
INSERT INTO songs (title, artist, album, genre, release_date, duration)
VALUES 
('Daayre', 'Arijit Singh', 'Dilwale', 'Romantic', '2015-12-18', 290),
('Tum Hi Ho', 'Arijit Singh', 'Aashiqui 2', 'Romantic', '2013-04-08', 260),
('Channa Mereya', 'Arijit Singh', 'Ae Dil Hai Mushkil', 'Romantic', '2016-10-28', 300),
('Tera Ban Jaunga', 'Akhil Sachdeva', 'Kabir Singh', 'Romantic', '2019-06-21', 230),
('Kal Ho Naa Ho', 'Sonu Nigam', 'Kal Ho Naa Ho', 'Drama', '2003-11-28', 320),
('Zindagi Do Pal Ki', 'KK', 'Kites', 'Pop', '2010-05-21', 210),
('Ae Mere Humsafar', 'Abhijeet Bhattacharya', 'Baazigar', 'Romantic', '1993-11-12', 250),
('Tum Mile', 'Javed Ali', 'Tum Mile', 'Romantic', '2009-11-13', 270),
('Khairiyat', 'Arijit Singh', 'Chhichhore', 'Drama', '2019-09-06', 275),
('Jeene Laga Hoon', 'Atif Aslam', 'Ramaiya Vastavaiya', 'Romantic', '2013-07-19', 240);

-- Insert a playlist for Himanshu
INSERT INTO playlists (user_id, name)
VALUES (@user_id, 'Himanshu\'s Favorites');

-- Get playlist_id
SET @playlist_id = (SELECT playlist_id FROM playlists WHERE user_id = @user_id);

-- Insert songs into Himanshu's playlist
INSERT INTO playlist_songs (playlist_id, song_id)
SELECT @playlist_id, song_id FROM songs;

-- Insert listening history for Himanshu (listening to a few songs)
INSERT INTO listening_history (user_id, song_id, listened_at)
VALUES 
(@user_id, (SELECT song_id FROM songs WHERE title = 'Daayre'), '2024-11-18 09:00:00'),
(@user_id, (SELECT song_id FROM songs WHERE title = 'Tum Hi Ho'), '2024-11-18 11:00:00'),
(@user_id, (SELECT song_id FROM songs WHERE title = 'Channa Mereya'), '2024-11-18 14:00:00');

-- Display structure of each table
SHOW CREATE TABLE users;
SHOW CREATE TABLE songs;
SHOW CREATE TABLE playlists;
SHOW CREATE TABLE playlist_songs;
SHOW CREATE TABLE listening_history;

-- Display all data from each table
SELECT * FROM users;
SELECT * FROM songs;
SELECT * FROM playlists;
SELECT * FROM playlist_songs;
SELECT * FROM listening_history;
