/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Usuario;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Igor
 */
public class CadastrarUsuarioDAO {
    
    private Connection bdConn;

    public CadastrarUsuarioDAO() throws BdDAOException, SQLException {
        this.bdConn = ConnectionBanco.getConnection();
    }
    
    public boolean CadastrarUsuario (Usuario u) throws SQLException, BdDAOException {
        
        Statement stat = bdConn.createStatement();
        String SQL = "INSERT INTO usuario VALUES ('" +
                u.getNome()  + "', '" + 
                u.getSenha() + "', '" + 
                u.getEmail() + "', '" + 
                u.getTipo()  + "');";
       
        int rowInserted = stat.executeUpdate(SQL);
        boolean success = false;
        if(rowInserted > 0){
            success = true;
        } else {
            success = false;
        }
        
        ConnectionBanco.close(bdConn, stat, null);
        return success;
    }
}
