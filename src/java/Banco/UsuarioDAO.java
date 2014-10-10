/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Usuario;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Bruna
 */
public class UsuarioDAO {

    private Connection bdConn;

    public UsuarioDAO() throws BdDAOException, SQLException {

        this.bdConn = ConnectionBanco.getConnection();
    }

    public boolean BuscaUsuario(Usuario user) throws SQLException, BdDAOException {
        try{
            Statement stat = bdConn.createStatement();
        ResultSet rs = null;
        boolean exist = false;

        rs = stat.executeQuery("SELECT username, senha FROM usuario WHERE username = '"
                + user.getNome() + "' and senha = '" + user.getSenha() + "';");

        
        exist =  rs.next();
        ConnectionBanco.close(bdConn, stat, rs);
        return exist;
            
        } finally {
            
        }
        
        

 
    }
}
