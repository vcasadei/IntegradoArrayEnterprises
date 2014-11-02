/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.ProdutosDAO;
import Banco.VendaDAO;
import Bean.Cliente;
import Bean.Lote;
import Bean.Produto;
import Bean.Venda;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author casadei
 */
public class EfetuarVenda extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EfetuarVenda</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EfetuarVenda at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");

        String dataVenda = "";
        int clienteCod;
        String auxQtdeProdutos = "";
        int qtdeProdutos = 0;
        String codigosProdutos = "";
        String quantidadesProdutos = "";
        String auxQtdeLotes = "";
        int qtdeLotes = 0;
        String codProdutoDoLote = "";
        String codigosLotes = "";
        String quantidadeLotes = "";
        String auxTotalVenda = "";
        float totalVenda = 0;

        Lote lote;
        Cliente cliente = new Cliente();
        Venda venda = new Venda();
        Produto produto;
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        ArrayList<Lote> lotes = new ArrayList<Lote>();

        /*Seta a data da venda*/
        dataVenda = request.getParameter("dataVenda");
        venda.setDataVenda(dataVenda);

        /*Seta o cliente e coloca ele na venda*/
        clienteCod = Integer.parseInt(request.getParameter("clienteCod"));
        cliente.setCodCliente(clienteCod);
        venda.setCliente(cliente);

        /*Pega a quantidade de produtos*/
        auxQtdeProdutos = request.getParameter("quantosProdutos");
        if (!auxQtdeProdutos.equals("")) {
            qtdeProdutos = Integer.parseInt(auxQtdeProdutos);
        }

        /*Pega a lista de produtos e suas respectivas quantidades*/
        codigosProdutos = request.getParameter("listaProdCod");
        quantidadesProdutos = request.getParameter("listaProdQuant");

        /*Pega a quantidade de lotes*/
        auxQtdeLotes = request.getParameter("quantosLotes");
        if (!auxQtdeLotes.equals("")) {
            qtdeLotes = Integer.parseInt(auxQtdeLotes);
        }

        /*Pega as listas com os códigos dos lotes, seus respectivos cod de produto e a quantidade 
         que será tirada de cada um desses lotes*/
        codProdutoDoLote = request.getParameter("listaLoteProdCod");
        codigosLotes = request.getParameter("listaLoteCod");
        quantidadeLotes = request.getParameter("listaLoteQuant");

        /*Pega o valor total da venda e adiciona na venda*/
        auxTotalVenda = request.getParameter("totalVenda");
        if (!auxTotalVenda.equals("")) {
            totalVenda = Float.parseFloat(auxTotalVenda);
        }
        venda.setValorTotal(totalVenda);

        /*Coloca as informações dos lotes em vetores*/
        String[] auxLoteCodProd = codProdutoDoLote.split(";");
        String[] auxCodigosLotes = codigosLotes.split(";");
        String[] auxQuantidadeLotes = quantidadeLotes.split(";");
        /*Faz um vetor com os códigos dos produtos e outro com suas respctivas quantidades*/
        String[] auxCodProd = codigosProdutos.split(";");
        String[] qntdProdutos = quantidadesProdutos.split(";");

        /*Monta os lotes*/
        for (int i = 0; i < qtdeLotes; i++) {
            lote = new Lote();
            lote.setCodigoProduto(Integer.parseInt(auxLoteCodProd[i]));
            lote.setCodigoLote(auxCodigosLotes[i]);
            lote.setQntdRetirar(Integer.parseInt(auxQuantidadeLotes[i]));
            lotes.add(lote);
        }

        /*Monta os produtos com seus respctivos lotes*/
        for (int i = 0; i < qtdeProdutos; i++) {
            produto = new Produto();
            produto.setCodProd(Integer.parseInt(auxCodProd[i]));
            produto.setQntd(Integer.parseInt(qntdProdutos[i]));
            System.out.println(produto.getQntd());
            for (int j = 0; j < qtdeLotes; j++) {
                if (lotes.get(j).getCodigoProduto() == produto.getCodProd()) {
                    produto.addLoteVenda(lotes.get(j));
                }
            }

            produtos.add(produto);
        }

        /*coloca os produtos na venda*/
        venda.setProdutos(produtos);

        /*Cadastra a venda no banco*/
        try {
            VendaDAO daoVenda = new VendaDAO();



            if (daoVenda.CadastrarVenda(venda)) {
                response.getWriter().write("sucesso");
            } else {
                response.getWriter().write("erro");
            }

            response.getWriter().close();

        } catch (BdDAOException ex) {
            Logger.getLogger(CadastrarUsuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CadastrarUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
