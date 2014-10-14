/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Venda;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Igor
 */
public class CadastrarVendaDAO {
    
    private Connection bdConn;

    public CadastrarVendaDAO() throws BdDAOException, SQLException {
        this.bdConn = ConnectionBanco.getConnection();
    }
    
    public static void main (String args[]) throws BdDAOException, SQLException {
        
        CadastrarVendaDAO dao = new CadastrarVendaDAO();
        Venda v = new Venda(1, "13/10/2014", 1, 3);
        
        if(dao.CadastrarVenda(v))
            System.out.println("ok");
        
    }
    
    public boolean CadastrarVenda (Venda v) throws SQLException, BdDAOException {
      
        Statement stat = bdConn.createStatement();
        
        String SQL = "SELECT efetuarVenda ('" +
                v.getCodigoCliente()  + "', '" + 
                v.getDataVenda() + "', '" + 
                v.getCodigoProduto() + "', '" + 
                v.getQuantidade()  + "');";
        
        ResultSet rowInserted = stat.executeQuery(SQL);
        boolean success = false;
        
        while(rowInserted.next())
        if(rowInserted.getInt(1) == 1){
            success = true;
        } else {
            success = false;
        }
        
        ConnectionBanco.close(bdConn, stat, null);
        return success;
    }
}
