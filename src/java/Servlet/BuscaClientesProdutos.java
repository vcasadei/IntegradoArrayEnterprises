/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.BuscaClientesDAO;
import Banco.ProdutosDAO;
import Bean.Cliente;
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
 * @author Caah
 */
public class BuscaClientesProdutos extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
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
            out.println("<title>Servlet BuscaTodosClientes</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuscaTodosClientes at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
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

        /*Variáveis para buscar e armazenar os clientes*/
        ArrayList<Cliente> clientes = new ArrayList<Cliente>();
        BuscaClientesDAO clientesDAO;
        
        /*Variáveis para buscar e armazenar os produtos*/
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        ProdutosDAO produtosDAO;

        try {
            
            /*Faz a busca dos clientes*/
            clientesDAO = new BuscaClientesDAO();
            clientes = clientesDAO.BuscaTodosClientes();
            
            /*Faz a busca dos produtos*/
            produtosDAO = new ProdutosDAO();
            produtos = produtosDAO.BuscaTodosProdutos();

            /*Seta os atributos no request*/
            request.setAttribute("listaClientes", clientes);
            request.setAttribute("listaProdutos", produtos);
            
            RequestDispatcher rd = null;
            rd = request.getRequestDispatcher("/venda.jsp");
            rd.forward(request, response);

        } catch (BdDAOException ex) {
            Logger.getLogger(BuscaClientesProdutos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaClientesProdutos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
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

        String cliente = "";
        ArrayList<Cliente> clientes = new ArrayList<Cliente>();
        BuscaClientesDAO clientesDAO;

        try {

            System.out.println("Aqui");
            
            clientesDAO = new BuscaClientesDAO();
            clientes = clientesDAO.BuscaTodosClientes();
            
            request.setAttribute("listaClientes", clientes);
            
            RequestDispatcher rd = null;
            rd = request.getRequestDispatcher("/SelecionaCliente.jsp");
            rd.forward(request, response);

            /*for (Cliente cl : clientes) {
                cliente += "<tr>\n<td>" + cl.getNome() + "</td>\n<td>" + cl.getCNPJ() + "</td>\n</tr>\n";
            }

            PrintWriter writer = response.getWriter();
            writer.print(cliente);
            writer.close();*/

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
