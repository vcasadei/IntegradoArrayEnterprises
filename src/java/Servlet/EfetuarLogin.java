/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Servlet;

import Banco.BdDAOException;
import Banco.UsuarioDAO;
import Bean.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Bruna
 */

public class EfetuarLogin extends HttpServlet {

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
            out.println("<title>Servlet VerificarLogin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerificarLogin at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/plain");  
        response.setCharacterEncoding("UTF-8");
       
        try { 
            String username = request.getParameter("username");
            String senha = request.getParameter("password");

            Usuario user = new Usuario();
            user.setNome(username);
            user.setSenha(senha);
            
            Usuario userReturn = null;
        
            UsuarioDAO usuario = new UsuarioDAO();
//            usuario.BuscaUsuario(user);
            userReturn = usuario.BuscaUsuario(user);
            
            if(userReturn != null){
                response.getWriter().write("ok;"); 
                response.getWriter().write(userReturn.getNome()); 
                response.getWriter().write(";"); 
                response.getWriter().write(userReturn.getSenha());
                response.getWriter().write(";"); 
                response.getWriter().write(userReturn.getTipo()); 
                
            } else {
                response.getWriter().write("erro");
            }
        } catch (SQLException ex) {
            Logger.getLogger(EfetuarLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (BdDAOException ex) {
            Logger.getLogger(EfetuarLogin.class.getName()).log(Level.SEVERE, null, ex);
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
