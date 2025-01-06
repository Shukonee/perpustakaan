package db;
import java.sql.*;

public class JDBC {
    Connection con;
    Statement stmt;
    public boolean isConnected;
    public String message; 
    
    public JDBC() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/perpus_pbo_2024","root","admin");  
            stmt = con.createStatement();
            isConnected = true;
            message = "DB connected";
        } catch(Exception e) {
            isConnected = false;
            message = e.getMessage();
        }
    }
    
    public Connection getConnection() {
        return this.con; 
    }
    
    public void disconnect() {
        try {
            stmt.close();
            con.close();
            message = "DB disconnected";
        } catch(Exception e) {
            message = e.getMessage();
        }
    }
    
    public void runUpdate(String query, Object[] params) {
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);  
            }
            int result = pstmt.executeUpdate();
            message = result + " rows affected";  
        } catch (SQLException e) {
            message = "Error: " + e.getMessage(); 
        }
    }
    
    public void runQuery(String query) {
        try {
            int result = stmt.executeUpdate(query);  
            message = result + " rows affected";  
        } catch (SQLException e) {
            message = "Error: " + e.getMessage(); 
        }
    }
    
    public ResultSet getData(String query) {
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery(query);  
        } catch (SQLException e) {
            message = e.getMessage();
        }
        return rs;
    }
    
    public PreparedStatement getPreparedStatement(String query) throws SQLException {
        return con.prepareStatement(query);
    }
}
