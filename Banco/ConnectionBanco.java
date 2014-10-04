
import Banco.PubMedDAOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Caah
 */
public class ConnectionBanco {

    public static Connection getConnection() {

        try {
            Class.forName("org.postgresql.Driver").newInstance();
            
            return DriverManager.getConnection("jdbc:postgresql://localhost:5432/ICSahudy?user=postgres&password=foreveralones");

        } catch (SQLException e) {
            throw new SQLException("", "", e.getErrorCode());
        } catch (Exception e) {
            throw new PubMedDAOException(e.getMessage());
        }
    }
}
