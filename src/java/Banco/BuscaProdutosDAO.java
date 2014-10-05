/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Produto;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Caah
 */
public class BuscaProdutosDAO {

    private Connection bdConn;

    public BuscaProdutosDAO() throws BdDAOException, SQLException {

        this.bdConn = ConnectionBanco.getConnection();
    }

    public ArrayList<Produto> BuscaTodosProdutos() throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();
        ResultSet rs;
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        Produto aux;

        rs = stat.executeQuery("SELECT codProd, nomeProd, descProd, ramo, diasLim_validade, valorUnitario FROM Produto;");

        while (rs.next()) {

            aux = new Produto();
            aux.setCodProd(rs.getInt(1));
            aux.setNome(rs.getString(2));
            aux.setDescricao(rs.getString(3));
            aux.setRamo(rs.getString(4));
            aux.setDiasLim_venda(rs.getInt(5));
            aux.setValorUnitario(rs.getFloat(6));

            produtos.add(aux);
        }

        ConnectionBanco.close(bdConn, stat, rs);
        return produtos;
    }

    public ArrayList<Produto> buscaProdutosRamo(String ramo) throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();
        ResultSet rs;
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        Produto aux;

        rs = stat.executeQuery("SELECT codProd, nomeProd, descProd, ramo, diasLim_validade, valorUnitario "
                + "FROM Produto WHERE ramo like '" + ramo + "';");

        while (rs.next()) {

            aux = new Produto();
            aux.setCodProd(rs.getInt(1));
            aux.setNome(rs.getString(2));
            aux.setDescricao(rs.getString(3));
            aux.setRamo(rs.getString(4));
            aux.setDiasLim_venda(rs.getInt(5));
            aux.setValorUnitario(rs.getFloat(6));

            produtos.add(aux);
        }

        ConnectionBanco.close(bdConn, stat, rs);
        return produtos;
    }
}