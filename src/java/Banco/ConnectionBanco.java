
package Banco;

import java.sql.*;
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
            Class.forName("org.postgresql.Driver").newInstance();
            String conexao = "jdbc:postgresql://localhost:5432/ERP";
            String usuario = "postgres";
            String senha = "postgres";
            Connection conn = DriverManager.getConnection(conexao, usuario, senha);
            return conn;
            
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
     
          public static void close(Connection conn, Statement ps) throws BdDAOException {
        try {
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