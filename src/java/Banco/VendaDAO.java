/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Banco;

import Bean.Cliente;
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

        Statement stat = bdConn.createStatement();

        for (Produto p : v.getProdutos()) {

            String SQL = "SELECT efetuarVenda ('"
                    + v.getCliente().getCodCliente() + "', '"
                    + v.getDataVenda() + "', '"
                    + p.getCodProd() + "', '"
                    + v.getQuantidade() + "');";

            ResultSet rowInserted = stat.executeQuery(SQL);
            
            while (rowInserted.next()) {
                if (rowInserted.getInt(1) != 1) {
                    return false;
                }
            }
        }

        ConnectionBanco.close(bdConn, stat, null);
        return true;
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
            venda.setDataVenda(auxData.substring(8,10) + "/" + auxData.substring(5,7) + "/" + auxData.substring(0,4));
            venda.setValorTotal(rs.getFloat("valorTotal"));

            vendas.add(venda);
        }

        return vendas;
    }

    public Venda buscaDadosVenda() {
        return null;
    }
}
