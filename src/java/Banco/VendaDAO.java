/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Cliente;
import Bean.Lote;
import Bean.Produto;
import Bean.Venda;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Igor
 */
public class VendaDAO {

    private Connection bdConn;

    public VendaDAO() throws BdDAOException, SQLException {
        this.bdConn = ConnectionBanco.getConnection();
    }

    public boolean CadastrarVenda(Venda v) throws SQLException, BdDAOException {

        System.out.println("Entrou");

        Statement stat = bdConn.createStatement();

        String codProdutos;
        String qntdProdutos;
        int codVenda;

        /*Monta a String com o código dos produtos da venda e aquela com suas respctivas quantidades*/
        codProdutos = "{";
        qntdProdutos = "{";
        for (Produto p : v.getProdutos()) {
            codProdutos += p.getCodProd();
            qntdProdutos += p.getQntd();
            if (p.getCodProd() != v.getProdutos().get((v.getProdutos().size() - 1)).getCodProd()) {
                codProdutos += ", ";
                qntdProdutos += ", ";
            }
        }
        codProdutos += "}";
        qntdProdutos += "}";
        System.out.println(codProdutos + "\n" + qntdProdutos);

        /*Monta a consulta SQL*/
        String SQL = "SELECT insereVenda( " + v.getCliente().getCodCliente() + ", '" + v.getDataVenda() + "', "
                + v.getValorTotal() + ", '" + codProdutos + "', '" + qntdProdutos + "', " + v.getProdutos().size()
                + ");";

        /*Verifica se foi inserido*/
        ResultSet rowInserted = stat.executeQuery(SQL);
        if (rowInserted.next()) {
            if (rowInserted.getInt(1) != 1) {
                return false;
            }
        } else {
            return false;
        }

        /*Fecha o resultSet*/
        ConnectionBanco.close(null, null, rowInserted);

        /*Seleciona o código da venda que foi inserida*/
        codVenda = getCodUltimaVenda();
        if (codVenda == -1) {
            return false;
        }

        /*Faz as inserções na tabela ProdVendaLote*/
        String codLotes;
        String qntdRetirarLotes;

        /*Monta a string que contém os códigos dos lotes, e aquela que contém as respectivas quantidades
         a serem retiradas*/
        int tamanho;
        for (Produto p : v.getProdutos()) {

            codLotes = "{";
            qntdRetirarLotes = "{";

            tamanho = p.getLotesVenda().size();
            for (Lote l : p.getLotesVenda()) {
                codLotes += "\"" + l.getCodigoLote() + "\"";
                qntdRetirarLotes += l.getQntdRetirar();
                if (!l.getCodigoLote().equals(p.getLotesVenda().get((tamanho - 1)).getCodigoLote())) {
                    codLotes += ", ";
                    qntdRetirarLotes += ", ";
                }
            }

            codLotes += "}";
            qntdRetirarLotes += "}";

            System.out.println(codLotes);
            System.out.println(qntdRetirarLotes);

            /*Monta a consulta SQL*/
            SQL = "SELECT insereLote(" + p.getCodProd() + ", " + codVenda + ", '" + codLotes + "', '"
                    + qntdRetirarLotes + "', " + tamanho + ");";

            /*Faz a inserção*/
            rowInserted = stat.executeQuery(SQL);
            if (rowInserted.next()) {
                if (rowInserted.getInt(1) != 1) {
                    return false;
                }
            } else {
                return false;
            }

            /*Fecha o resultSet*/
            ConnectionBanco.close(null, null, rowInserted);

        }

        ConnectionBanco.close(bdConn, stat, null);
        return true;
    }

    private int getCodUltimaVenda() throws SQLException, BdDAOException {

        Statement stat = bdConn.createStatement();

        ResultSet rs = stat.executeQuery("SELECT max(codVenda) FROM Venda;");

        while (rs.next()) {
            return rs.getInt(1);
        }

        /*Fecha o resultSet e o statement*/
        ConnectionBanco.close(null, stat, rs);

        return -1;
    }

    public ArrayList<Venda> getAllVendaRelatorio() throws SQLException, BdDAOException {

        ArrayList<Venda> vendas = new ArrayList<Venda>();
        Statement stat = bdConn.createStatement();

        ResultSet rs = stat.executeQuery("SELECT codVenda, nome, dataVenda, valorTotal FROM Venda as v, "
                + "Cliente as c WHERE v.codCliente = c.codCliente;");

        Cliente cliente;
        Venda venda;

        while (rs.next()) {
            cliente = new Cliente();
            cliente.setNome(rs.getString("nome"));

            venda = new Venda();
            venda.setCliente(cliente);
            venda.setCodVenda(rs.getInt("codVenda"));
            String auxData = rs.getString("dataVenda");
            venda.setDataVenda(auxData.substring(8, 10) + "/" + auxData.substring(5, 7) + "/" + auxData.substring(0, 4));
            venda.setValorTotal(rs.getFloat("valorTotal"));

            vendas.add(venda);
        }

        return vendas;
    }

    public Venda buscaDadosVenda() {
        return null;
    }
}
