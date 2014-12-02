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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Caah
 */
public class ProdutosDAO {

    private Connection bdConn;

    public ProdutosDAO() throws BdDAOException, SQLException {

        this.bdConn = ConnectionBanco.getConnection();
    }

    public ArrayList<Produto> BuscaTodosProdutos(String dataVenda) throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();
        ResultSet rs;
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        Produto aux;

//        rs = stat.executeQuery("SELECT codProd, nomeProd, descProd, ramo, diasLim_validade, valorUnitario FROM Produto;");
        rs = stat.executeQuery("SELECT SUM(qntdatual) as qtdeEstoque, p.codProd, p.nomeProd, p.descProd, "
                + "p.ramo, p.diasLim_validade, p.valorUnitario FROM Produto p, lote l WHERE l.codprod = "
                + "p.codProd AND qntdatual > 0 AND ((to_date('" + dataVenda + "','DD/MM/YYYY') <= "
                + "(l.validade - p.diaslim_validade))) GROUP BY p.codProd;");

        
        while (rs.next()) {

            aux = new Produto();
            aux.setCodProd(rs.getInt(2));
            aux.setNome(rs.getString(3));
            aux.setDescricao(rs.getString(4));
            aux.setRamo(rs.getString(5));
            aux.setDiasLim_venda(rs.getInt(6));
            aux.setValorUnitario(rs.getFloat(7));

            produtos.add(aux);
        }

        ConnectionBanco.close(bdConn, stat, rs);
        return produtos;
    }
    
    public ArrayList<Produto> BuscaTodosProdutosEstoque() throws SQLException, BdDAOException {

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

    /*Busca um produto através do seu código*/
    public Produto BuscaProdutoCod(int cod, String data) throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();
        ResultSet rs;
        Produto retorno = null;

//        rs = stat.executeQuery("SELECT nomeProd, ramo, valorUnitario FROM Produto WHERE codProd = " + cod + ";");
        rs = stat.executeQuery("SELECT SUM(qntdatual) as qtdeEstoque, p.nomeProd, p.ramo, p.valorUnitario "
                + "FROM Produto p, lote l WHERE l.codprod = p.codProd AND qntdatual > 0 "
                + "AND p.codProd = " + cod + " AND "
                + "((to_date('" + data + "','DD/MM/YYYY') <= (l.validade - p.diaslim_validade))) "
                + "GROUP BY p.codProd;");
        while (rs.next()) {
            retorno = new Produto();
            retorno.setCodProd(cod);
            retorno.setNome(rs.getString(2));
            retorno.setRamo(rs.getString(3));
            retorno.setValorUnitario(rs.getFloat(4));
        }

        /*Fecha a conexão com o banco*/
        ConnectionBanco.close(bdConn, stat, rs);

        return retorno;
    }

    /*Altera a quantidade de dias limite pra venda de um produto no banco*/
    public boolean alteraLimiteDias(int limite, int codProd) throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();

        try {
            stat.executeUpdate("UPDATE Produto SET diasLim_validade = " + limite + "WHERE codProd = " + codProd + ";");

            ConnectionBanco.close(bdConn, stat, null);

            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    /*Busca a quantidade de dias limite de venda de um produto*/
    public int buscaDiasLimite(int codProd) throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();
        int diasLimite = -1;

        ResultSet rs = stat.executeQuery("SELECT diasLim_validade FROM Produto WHERE codProd = " + codProd);

        if (rs.next()){
            diasLimite = rs.getInt("diasLim_validade");
        }
        
        ConnectionBanco.close(bdConn, stat, null);
        
        return diasLimite;
    }
    
    /* Busca a quantidade de produtos QUE RESPEITAM O LIMITE DE DIAS */
    public int buscaQuantidadeProd(int codProd, String dataVenda) throws SQLException, BdDAOException, ParseException { 
        
        Statement stat = bdConn.createStatement();
       
 
	
        
        ResultSet rs = stat.executeQuery("SELECT SUM(qntdatual) as qtdeEstoque FROM lote l, produto p WHERE (l.codprod = " + codProd + ") AND (l.codprod = p.codprod)" +
                                            "AND ((to_date('" + dataVenda + "','DD/MM/YYYY') <= (l.validade - p.diaslim_validade)))");
        int qtde = 0;
        if (rs.next()){
            qtde = rs.getInt("qtdeestoque");
        }

       
        return qtde;
    }
}
