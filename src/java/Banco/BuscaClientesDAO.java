/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import java.sql.Connection;
import java.sql.SQLException;
import Bean.Cliente;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Caah
 */
public class BuscaClientesDAO {
    
    private Connection bdConn;
    
    public BuscaClientesDAO() throws BdDAOException, SQLException {

        this.bdConn = ConnectionBanco.getConnection();
    }
    
    public ArrayList<Cliente> BuscaTodosClientes() throws SQLException, BdDAOException{
        
        Statement stat = bdConn.createStatement();
        ResultSet rs;
        ArrayList<Cliente> clientes = new ArrayList<Cliente>();
        Cliente aux;
        String CNPJ;
        
        rs = stat.executeQuery("SELECT codCliente, nome, CNPJ, ramo FROM Cliente;");
        
       while (rs.next()){
           aux = new Cliente();
           aux.setCodCliente(rs.getInt(1));
           aux.setNome(rs.getString(2));
           aux.setRamo(rs.getString(4));
           
           /*Coloca os pontos e traços do CNPJ*/
           CNPJ = rs.getString(3);
           aux.setCNPJ(CNPJ.substring(0, 2) + "." + CNPJ.substring(2, 5) + "." + CNPJ.substring(5, 8) +
                   "/" + CNPJ.substring(8, 12) + "-" + CNPJ.substring(12));
           
           clientes.add(aux);
       }
        
        ConnectionBanco.close(bdConn, stat, rs);
        return clientes;
    }
    
    public Cliente BuscaClienteCNPJ(String cnpj) throws SQLException, BdDAOException{

        Statement stat = bdConn.createStatement();
        ResultSet rs;
        Cliente retorno;
        
        rs = stat.executeQuery("SELECT nome, codcliente FROM Cliente WHERE CNPJ = '" + cnpj + "';");
        
        while (rs.next()){
            retorno = new Cliente();
            retorno.setNome(rs.getString(1));
            retorno.setCodCliente(Integer.parseInt(rs.getString(2)));
            retorno.setCNPJ(cnpj);
            return retorno;
        }
        
        return null;
    }
    
}
