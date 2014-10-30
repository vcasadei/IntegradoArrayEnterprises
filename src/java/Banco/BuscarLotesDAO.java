/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Lote;
import Bean.Produto;
import Servlet.BuscaLotesAutomatico;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Igor
 */
public class BuscarLotesDAO {
    private Connection bdConn;
    
    public BuscarLotesDAO() throws BdDAOException, SQLException {

        this.bdConn = ConnectionBanco.getConnection();
    }
    
    public ArrayList<Lote> BuscaLotesAutomatico(int codigo, int qtde, String data) throws SQLException, BdDAOException
    {
        Statement stat = bdConn.createStatement();
        ResultSet rs;
        ArrayList<Lote> lotes = new ArrayList<Lote>();
        Lote aux;
        try{
            rs = stat.executeQuery("SELECT * FROM RecuperaLotesAutomatico(" + codigo + ", " + qtde 
                    + ", '" + data + "');");
            while (rs.next()){
                aux = new Lote();
                aux.setCodigoLote(rs.getString(1));
                aux.setCodigoProduto(rs.getInt(2));
                aux.setQntdInicial(rs.getInt(3));
                aux.setQntdAtual(rs.getInt(4));
                aux.setValidade(rs.getString(5));

                lotes.add(aux);
             }   

             ConnectionBanco.close(bdConn, stat, rs);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaLotesAutomatico.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lotes;
    }
    
    public ArrayList<Lote> BuscaTodosLotes(int codigoProduto, String data) throws SQLException, BdDAOException
    {
        Statement stat = bdConn.createStatement();
        ResultSet rs;
        ArrayList<Lote> lotes = new ArrayList<Lote>();
        Lote aux;
        try{
            
            rs = stat.executeQuery("SELECT * FROM BuscaTodosLotes(" + codigoProduto + ", " + data + "');");
            while (rs.next()){
                aux = new Lote();
                aux.setCodigoLote(rs.getString(1));
                aux.setCodigoProduto(rs.getInt(2));
                aux.setQntdInicial(rs.getInt(3));
                aux.setQntdAtual(rs.getInt(4));
                aux.setValidade(rs.getString(5));

                lotes.add(aux);
             }

             ConnectionBanco.close(bdConn, stat, rs);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaLotesAutomatico.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lotes;
    }
}