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

    public Usuario BuscaUsuario(Usuario user) throws SQLException, BdDAOException {
        try{
            Statement stat = bdConn.createStatement();
        ResultSet rs = null;

        Usuario aux = null;

        rs = stat.executeQuery("SELECT username, senha, tipo FROM usuario WHERE username = '"
                + user.getNome() + "' and senha = '" + user.getSenha() + "';");

        while(rs.next()){
            aux = new Usuario();
            aux.setNome(rs.getString(1));
            aux.setSenha(rs.getString(2));
            aux.setTipo(rs.getString(3));
        }

        ConnectionBanco.close(bdConn, stat, rs);
        return aux;
            
        } finally {
            
        }
        
        

 
    }
}
