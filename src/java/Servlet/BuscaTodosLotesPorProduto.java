/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.BuscarLotesDAO;
import Banco.ProdutosDAO;
import Bean.Lote;
import Bean.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author casadei
 */
public class BuscaTodosLotesPorProduto extends HttpServlet {

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
            out.println("<title>Servlet BuscaTodosLotesPorProduto</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuscaTodosLotesPorProduto at " + request.getContextPath() + "</h1>");
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
        
        /*Variáveis para buscar e armazenar os produtos*/
        ArrayList<Lote> lotes = new ArrayList<Lote>();
        BuscarLotesDAO lotesDAO;
        String auxCodProd = "";
        String dataVenda = "";
        int codProd = 0;

        try {
           
            auxCodProd = request.getParameter("codigoProduto");
            if(!auxCodProd.equals("")){
                codProd = Integer.parseInt(auxCodProd);
            }
            dataVenda = request.getParameter("dataVenda");
            /*Faz a busca dos produtos*/
            lotesDAO = new BuscarLotesDAO();
            lotes = lotesDAO.BuscaTodosLotes(codProd, dataVenda);
            response.getWriter().write(lotes.size() + ""); 
            response.getWriter().write(";");
            for (int i = 0; i < lotes.size(); i++) {
                System.out.println(lotes.get(i).getCodigoLote());
                response.getWriter().write(lotes.get(i).getCodigoLote() + ""); 
                response.getWriter().write(";"); 
                response.getWriter().write(Integer.toString(lotes.get(i).getCodigoProduto()));
                response.getWriter().write(";"); 
                response.getWriter().write(Integer.toString(lotes.get(i).getQntdInicial())); 
                response.getWriter().write(";"); 
                response.getWriter().write(Integer.toString(lotes.get(i).getQntdAtual())); 
                response.getWriter().write(";"); 
                response.getWriter().write(lotes.get(i).getValidade());
                response.getWriter().write(";"); 
            }

        } catch (BdDAOException ex) {
            Logger.getLogger(BuscaClientesProdutos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaClientesProdutos.class.getName()).log(Level.SEVERE, null, ex);
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
