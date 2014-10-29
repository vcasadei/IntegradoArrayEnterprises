
package Banco;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Caah
 */
public class ConnectionBanco {
    
    public static Connection getConnection() throws BdDAOException, SQLException {

        try {
            String nomeDriver = "org.postgresql.Driver";
            Class.forName(nomeDriver);
            return DriverManager.getConnection("jdbc:postgresql://localhost:5432/ERP?user=postgres&password=1234");
            
        } catch (SQLException e) {
            throw new SQLException("", "", e.getErrorCode());
        } catch (Exception e) {
            throw new BdDAOException(e.getMessage());
        }
    }
    
     public static void close(Connection conn, Statement ps, ResultSet rs) throws BdDAOException {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            throw new BdDAOException(e.getMessage());
        }
    }
}