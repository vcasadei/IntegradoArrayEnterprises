/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.BuscaClientesDAO;
import Banco.BuscaProdutosDAO;
import Bean.Cliente;
import Bean.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Caah
 */
public class BuscaClienteProdutoCNPJCod extends HttpServlet {

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
            out.println("<title>Servlet BuscaClienteProdutoCNPJCod</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuscaClienteProdutoCNPJCod at " + request.getContextPath() + "</h1>");
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

        Produto produto;
        BuscaProdutosDAO produtosDAO;
        String codigo;
        codigo = "1";

        try {

            produtosDAO = new BuscaProdutosDAO();
            
            codigo = request.getParameter("cod");
            if(!codigo.equals("")){
                produto = produtosDAO.BuscaProdutoCod(Integer.parseInt(codigo));
                PrintWriter writer = response.getWriter();
            if (produto == null){
                writer.print("null");
            } else {
                writer.print(produto.getNome() + ";" + produto.getCodProd() + ";" + produto.getRamo() + ";"
                        + produto.getValorUnitario());
            }
            writer.close();
            }
            
            

            

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

        Cliente cliente;
        BuscaClientesDAO clientesDAO;
        String cnpj;

        try {

            clientesDAO = new BuscaClientesDAO();
            String auxCNPJ = "";
            
            cnpj = request.getParameter("CNPJ");
            
            /*Tira os pontos e traços do cnpj*/
            for (int i = 0; i < cnpj.length(); i++){
                if (!cnpj.substring(i, i+1).equals(".") && !cnpj.substring(i, i+1).equals("/") &&
                        !cnpj.substring(i, i+1).equals("-")){
                    auxCNPJ += cnpj.substring(i, i+1);
                }
            }
            
            cliente = clientesDAO.BuscaClienteCNPJ(auxCNPJ);

            PrintWriter writer = response.getWriter();
            if (cliente == null){
                writer.print("null");
            } else {
                writer.print(cliente.getNome() + ";" + cnpj + ";" +  cliente.getCodCliente());
            }
            writer.close();

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
