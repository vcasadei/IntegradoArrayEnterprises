/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import java.util.ArrayList;

/**
 *
 * @author Caah
 */
public class Produto {
    
    private int codProd;
    private String nome;
    private String descricao;
    private String ramo;
    private int diasLim_venda;
    private int qntd;
    private float valorUnitario;
    private ArrayList<Lote> lotesVenda;
    private String codProds;

    public String getCodProds() {
        return codProds;
    }

    public void setCodProds(String codProds) {
        this.codProds = codProds;
    }

    public Produto(){
        lotesVenda = new ArrayList<Lote>();
    }

    public int getQntd() {
        return qntd;
    }

    public void setQntd(int qntd) {
        this.qntd = qntd;
    }

    public ArrayList<Lote> getLotesVenda() {
        return lotesVenda;
    }

    public void setLotesVenda(ArrayList<Lote> lotesVenda) {
        this.lotesVenda = lotesVenda;
    }
    
    public void addLoteVenda(Lote lote){
        this.lotesVenda.add(lote);
    }
    
    public int getCodProd() {
        return codProd;
    }

    public void setCodProd(int codProd) {
        this.codProd = codProd;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getRamo() {
        return ramo;
    }

    public void setRamo(String ramo) {
        this.ramo = ramo;
    }

    public int getDiasLim_venda() {
        return diasLim_venda;
    }

    public void setDiasLim_venda(int diasLim_venda) {
        this.diasLim_venda = diasLim_venda;
    }

    public float getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(float valorUnitario) {
        this.valorUnitario = valorUnitario;
    }
}