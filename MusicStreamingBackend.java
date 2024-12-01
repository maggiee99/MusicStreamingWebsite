import java.sql.*;

public class MusicStreamingBackend {

    // Database URL, username, and password
    private static final String DB_URL = "jdbc:mysql://localhost:3306/music_streaming";
    private static final String DB_USER = "root"; // Change to your DB username
    private static final String DB_PASSWORD = "password"; // Change to your DB password

    // Establish database connection
    private static Connection connect() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Insert a new user
    public static void insertUser(String username, String passwordHash, String email) {
        String query = "INSERT INTO users (username, password_hash, email) VALUES (?, ?, ?)";
        try (Connection conn = connect();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, passwordHash);
            pstmt.setString(3, email);
            pstmt.executeUpdate();
            System.out.println("User added successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Add a song to a playlist
    public static void addSongToPlaylist(int playlistId, int songId) {
        String query = "INSERT INTO playlist_songs (playlist_id, song_id) VALUES (?, ?)";
        try (Connection conn = connect();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, playlistId);
            pstmt.setInt(2, songId);
            pstmt.executeUpdate();
            System.out.println("Song added to playlist successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Log listening history
    public static void logListeningHistory(int userId, int songId, Timestamp listenedAt) {
        String query = "INSERT INTO listening_history (user_id, song_id, listened_at) VALUES (?, ?, ?)";
        try (Connection conn = connect();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, songId);
            pstmt.setTimestamp(3, listenedAt);
            pstmt.executeUpdate();
            System.out.println("Listening history logged successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Retrieve and display all songs
    public static void displayAllSongs() {
        String query = "SELECT * FROM songs";
        try (Connection conn = connect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.println("Song ID: " + rs.getInt("song_id") +
                                   ", Title: " + rs.getString("title") +
                                   ", Artist: " + rs.getString("artist") +
                                   ", Album: " + rs.getString("album") +
                                   ", Genre: " + rs.getString("genre") +
                                   ", Release Date: " + rs.getDate("release_date") +
                                   ", Duration: " + rs.getInt("duration") + " seconds");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Main method for testing
    public static void main(String[] args) {
        try {
            // Add a new user
            insertUser("Himanshu", "hashed_password_here", "himanshu@example.com");

            // Display all songs
            System.out.println("Songs in the database:");
            displayAllSongs();

            // Add a song to a playlist
            addSongToPlaylist(1, 1); // Example: Add song ID 1 to playlist ID 1

            // Log a song to listening history
            logListeningHistory(1, 1, Timestamp.valueOf("2024-11-18 09:00:00"));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
