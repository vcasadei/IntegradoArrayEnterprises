/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Banco.BdDAOException;
import Banco.VendaDAO;
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
 * @author Caah
 */
public class BuscaDadosRelatorio extends HttpServlet {

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
            out.println("<title>Servlet BuscaDadosVenda</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuscaDadosVenda at " + request.getContextPath() + "</h1>");
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
        
        try {
            
            int codVenda;
            codVenda = Integer.parseInt(request.getParameter("codVenda"));
            System.out.println("pegou parametro " + codVenda);
            VendaDAO vendaDAO = new VendaDAO();
            ArrayList<Produto> produtos = new ArrayList<Produto>();
            ArrayList<Lote> lotes = new ArrayList<Lote>();
            Cliente cliente = new Cliente();
            response.getWriter().write("success;");
            Venda dadosVenda = vendaDAO.buscaDadosVenda(codVenda);
            System.out.println("sucesso");
            
            response.getWriter().write(codVenda + "");
            response.getWriter().write(";");
            
            String dataVenda = dadosVenda.getDataVenda();
            response.getWriter().write(dataVenda + "");
            response.getWriter().write(";");
            
            Float valorTotal = dadosVenda.getValorTotal();
            response.getWriter().write(valorTotal + "");
            response.getWriter().write(";");
            
            cliente = dadosVenda.getCliente();
            int codCliente = cliente.getCodCliente();
            response.getWriter().write(codCliente + "");
            response.getWriter().write(";");
            
            //5
            String CNPJ = cliente.getCNPJ();
            response.getWriter().write(CNPJ + "");
            response.getWriter().write(";");
            
            String nomeCliente = cliente.getNome();
            response.getWriter().write(nomeCliente + "");
            response.getWriter().write(";");
            
            String ramoCliente = cliente.getRamo();
            response.getWriter().write(ramoCliente + "");
            response.getWriter().write(";");
            
            //8
            produtos = dadosVenda.getProdutos();
            response.getWriter().write(produtos.size() + "");
            response.getWriter().write(";");
            
            for(int i = 0; i < produtos.size(); i++){
                int codProd = produtos.get(i).getCodProd();
                response.getWriter().write(codProd + "");
                response.getWriter().write(";");
                
                //10
                int qntdProduto = produtos.get(i).getQntd();
                response.getWriter().write(qntdProduto + "");
                response.getWriter().write(";");
                //11
                String nomeProd = produtos.get(i).getNome();
                response.getWriter().write(nomeProd + "");
                response.getWriter().write(";");
                //12
                String ramoProd = produtos.get(i).getRamo();
                response.getWriter().write(ramoProd + "");
                response.getWriter().write(";");
                //13
                Float valorUnitario = produtos.get(i).getValorUnitario();
                response.getWriter().write(valorUnitario + "");
                response.getWriter().write(";");
                //14
                Float totalVal = qntdProduto * valorUnitario;
                response.getWriter().write(totalVal + "");
                response.getWriter().write(";");
                
                //15
                lotes = produtos.get(i).getLotesVenda();
                response.getWriter().write(lotes.size() + "");
                response.getWriter().write(";");
                
                for(int j = 0; j < lotes.size(); j++){
                    //16
                    String codLote = lotes.get(j).getCodigoLote();
                    response.getWriter().write(codLote + "");
                    response.getWriter().write(";");
                    //17
                    int codProduto = lotes.get(j).getCodigoProduto();
                    response.getWriter().write(codProduto + "");
                    response.getWriter().write(";");
                    //18
                    int qtdeInicial = lotes.get(j).getQntdInicial();
                    response.getWriter().write(qtdeInicial + "");
                    response.getWriter().write(";");
                    //19
                    int qtdeRetirar = lotes.get(j).getQntdRetirar();
                    response.getWriter().write(qtdeRetirar + "");
                    response.getWriter().write(";");
                    //20
                    String validade = lotes.get(j).getValidade();
                    response.getWriter().write(validade + "");
                    response.getWriter().write(";");
                }
            }
            
            
            response.getWriter().close();
            
            
        } catch (BdDAOException ex) {
            Logger.getLogger(BuscaDadosRelatorio.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BuscaDadosRelatorio.class.getName()).log(Level.SEVERE, null, ex);
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
