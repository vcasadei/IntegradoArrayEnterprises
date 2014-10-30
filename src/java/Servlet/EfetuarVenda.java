/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.ProdutosDAO;
import Bean.Cliente;
import Bean.Lote;
import Bean.Produto;
import Bean.Venda;
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
        
        String dataVenda = "";
        String clienteNome = "";
        String auxQtdeProdutos = "";
        int qtdeProdutos = 0;
        String codigosProdutos = "";
        String quantidadesProdutos = "";
        String auxQtdeLotes = "";
        int qtdeLotes = 0;
        String codProdutoDoLote = "";
        String codigosLotes = "";
        String quantidadeLotes = "";
        String auxTotalVenda= "";
        float totalVenda = 0;
        
        Lote lote;
        Cliente cliente = new Cliente();
        Venda venda;
        Produto produto;
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        ArrayList<Lote> lotes = new ArrayList<Lote>();
        
        String codigo;
        codigo = "1";

        dataVenda = request.getParameter("dataVenda");
        clienteNome = request.getParameter("clienteNome");
        auxQtdeProdutos = request.getParameter("quantosProdutos");
        if(!auxQtdeProdutos.equals("")){
            qtdeProdutos = Integer.parseInt(auxQtdeProdutos);
        }
        codigosProdutos = request.getParameter("listaProdCod");
        quantidadesProdutos = request.getParameter("listaProdQuant");
        auxQtdeLotes = request.getParameter("quantosLotes");
        if(!auxQtdeLotes.equals("")){
            qtdeLotes = Integer.parseInt(auxQtdeLotes);
        }
        codProdutoDoLote = request.getParameter("listaLoteProdCod");
        codigosLotes = request.getParameter("listaLoteCod");
        quantidadeLotes = request.getParameter("listaLoteQuant");
        auxTotalVenda = request.getParameter("totalVenda");
        if(!auxTotalVenda.equals("")){
            totalVenda = Float.parseFloat(auxTotalVenda);
        }
        cliente.setNome(clienteNome);
        String[] auxLoteCodProd = codProdutoDoLote.split(";");
        String[] auxCodigosLotes = codigosLotes.split(";");
        String[] auxQuantidadeLotes = quantidadeLotes.split(";");
        for(int i = 0; i < qtdeLotes; i++){
            lote = new Lote();
            lote.setCodigoProduto(Integer.parseInt(auxLoteCodProd[i]));
            lote.setCodigoLote(auxCodigosLotes[i]);
            //auxQuantidadeLotes[i] --> Quantidade que deverá tirar de cada lote
            lotes.add(lote);
        }
        String[] auxCodProd = codigosProdutos.split(";");
        for(int i = 0; i < qtdeProdutos; i++){
            produto = new Produto();
            produto.setCodProd(Integer.parseInt(auxCodProd[i]));
            produto.setLotesVenda(lotes);
            produtos.add(produto);
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
