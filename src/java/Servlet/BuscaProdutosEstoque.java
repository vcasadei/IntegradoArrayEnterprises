/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.ProdutosDAO;
import Bean.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
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
public class BuscaProdutosEstoque extends HttpServlet {

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
            out.println("<title>Servlet BuscaProdutosEstoque</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuscaProdutosEstoque at " + request.getContextPath() + "</h1>");
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
        response.setCharacterEncoding("UTF-8");
        
        /*Variáveis para buscar e armazenar os produtos*/
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        ProdutosDAO produtosDAO;

        try {
           
            
            /*Faz a busca dos produtos*/
            produtosDAO = new ProdutosDAO();
            produtos = produtosDAO.BuscaTodosProdutos();

            request.setAttribute("listaProdutos", produtos);
            
            RequestDispatcher rd = null;
            rd = request.getRequestDispatcher("/AlteraLimiteVenda.jsp");
            rd.forward(request, response);

        } catch (BdDAOException ex) {
            Logger.getLogger(BuscaClientesProdutos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaClientesProdutos.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        ProdutosDAO produtosDAO;
        int codProduto, quantidadeEstoque = 0;
        String dataVenda = "";
        
         try {

            produtosDAO = new ProdutosDAO();
            
            /*Pega o código do produto da aplicação*/
            codProduto = Integer.parseInt(request.getParameter("codProd"));
            dataVenda = request.getParameter("dataVenda");
            
            /*Busca a quantidade de dias limite no banco*/
            quantidadeEstoque = produtosDAO.buscaQuantidadeProd(codProduto, dataVenda);

            /*Manda de volta pra aplicação*/
            PrintWriter writer = response.getWriter();
            writer.print(Integer.toString(quantidadeEstoque));
            writer.close();
    }   catch (BdDAOException ex) {
            Logger.getLogger(BuscaProdutosEstoque.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaProdutosEstoque.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(BuscaProdutosEstoque.class.getName()).log(Level.SEVERE, null, ex);
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
