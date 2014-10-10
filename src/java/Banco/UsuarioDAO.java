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

        Statement stat = bdConn.createStatement();
        ResultSet rs;

        rs = stat.executeQuery("SELECT username, senha FROM usuario WHERE username = '"
                + user.getNome() + "' and senha = '" + user.getSenha() + "';");

        ConnectionBanco.close(bdConn, stat, rs);
        return rs.next();
        

 
    }
}
