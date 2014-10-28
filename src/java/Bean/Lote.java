/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

/**
 *
 * @author Igor
 */
public class Lote {
    
    private String codigoLote;
    private int codigoProduto;
    private int qntdInicial;
    private int qntdAtual;
    private String validade;
    
    public Lote(){}
    
    public String getCodigoLote() {
        return codigoLote;
    }

    public void setCodigoLote(String codigoLote) {
        this.codigoLote = codigoLote;
    }

    public int getCodigoProduto() {
        return codigoProduto;
    }

    public void setCodigoProduto(int codigoProduto) {
        this.codigoProduto = codigoProduto;
    }

    public int getQntdInicial() {
        return qntdInicial;
    }

    public void setQntdInicial(int qntdInicial) {
        this.qntdInicial = qntdInicial;
    }

    public int getQntdAtual() {
        return qntdAtual;
    }

    public void setQntdAtual(int qntdAtual) {
        this.qntdAtual = qntdAtual;
    }

    public String getValidade() {
        return validade;
    }

    public void setValidade(String validade) {
        this.validade = validade;
    } 
}
