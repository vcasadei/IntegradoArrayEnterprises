<%-- 
    Document   : produto
    Created on : Oct 23, 2014, 2:31:25 PM
    Author     : casadei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Bean.Produto"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <script src="js/jquery-1.11.1.js"></script>
        <script src="datepicker/js/bootstrap-datepicker.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script src="js/example.js"></script>
        <link href="css/bootstrap-dialog.css" rel="stylesheet" type="text/css" />
        <script src="js/bootstrap-dialog.js"></script>

        <script type="text/javascript" src="js/jsPDF/FileSaver.js"></script> 


        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <script  src="js/bootstrapValidator.js"></script>

        <script src="js/jsPDF/jspdf.min.js"></script>


        <script src="js/generatePDF.js"></script>


        <link rel="stylesheet" href="css/jasny-bootstrap.css">
        <script src="js/jasny-bootstrap.js"></script>
        <script type="text/javascript" src="js/jspdf.plugin.autoprint.js"></script> 
        <script src="js/printPDF.js"></script>

        <!-- Pesquisa produto/Cliente -->
        <!-- <script src="js/PesquisaCNPJProduto.js"></script> -->


        <script src="js/jsProduto.js"></script>
        <script src="js/jsGeral.js"></script>


        <title>Efetuar Venda - ArrayEnterprises</title>

        <!-- Bootstrap Core CSS -->
        <link href="datepicker/css/datepicker.css" rel="stylesheet">

        <!-- Bootstrap Core CSS -->
        <link href="css/jquery.dataTables.css" rel="stylesheet">

        <!-- Bootstrap Core CSS -->
        <link href="css/meucss.css" rel="stylesheet">


        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">

        <!-- Timeline CSS -->
        <link href="css/plugins/timeline.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/sb-admin-2.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="css/plugins/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/bootstrap-table.css">
        <script src="js/bootstrap-table.js"></script>
        <script src="js/bootstrap-table-pt-BR.min.js"></script>



        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
            <![endif]-->

    </head>

    <body>

        <!-- Pega o que veio do request-->
        <%
            List<Produto> produtos = (List<Produto>) request.getAttribute("listaProdutos");
        %>


        <div id="wrapper">
            <!-- Chamada para Menu topo -->
            <div id="header2"></div> 
            <!-- Fim de Menu topo -->

            <!--Início Menu lateral -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="index.html"><i class="glyphicon glyphicon-home fa-fw"></i> Painel de Controle</a>
                        </li>

                        <li class="somenteAdm">
                            <a href="novousuario.jsp"><i class="glyphicon glyphicon-edit fa-fw"></i> Cadastro de Usuário</a>
                        </li>
                        <li class="somenteAdm">
                            <a  href="BuscaProdutosEstoque"><i class="glyphicon glyphicon-calendar fa-fw"></i> Alterar Limite de Validade</a>
                        </li>

                        <li>
                            <a href="#"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Vendas<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level collapse in">
                                <li>
                                    <a class="active" href="BuscaClientesProdutos"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Efetuar Venda</a>
                                </li>
                                <li>
                                    <a class="" href="carrinho.jsp"><i class="glyphicon glyphicon-list-alt fa-fw"></i> Resumo da Venda</a>
                                </li>
                                <li>
                                    <a class="" href="BuscaTodasVendas"><i class="glyphicon glyphicon-file fa-fw"></i> Relatórios de Vendas</a>
                                </li>

                            </ul>
                            <!-- /.nav-second-level -->
                        </li>

                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
    </div>
    <!-- Fim do menu lateral -->


    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Efetuar Venda</h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="glyphicon glyphicon-home"></i>  <a href="index.html">Painel de Controle</a>
                    </li>
                    <li>
                        <i class="glyphicon glyphicon-shopping-cart"></i> Vendas
                    </li>
                    <li class="">
                        <i class="glyphicon glyphicon-shopping-cart"></i> <a href="BuscaClientesProdutos">Efetuar Venda</a>
                    </li>
                    <li class="active">
                        <i class="glyphicon glyphicon-shopping-cart"> </i> <a href="BuscaClientesProdutos"> Selecionar Cliente</a>
                    </li>
                    <li class="active">
                        <i class="glyphicon glyphicon-shopping-cart"></i> Selecionar Produto
                    </li>

                </ol>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <!-- Conteúdo do Form -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <b>Itens obrigatórios estão marcados com </b><span class="glyphicon glyphicon-asterisk "></span>
                    </div>
                    <div class="panel-body">
                        <!-- Form de Venda -->
                        <form id="formVenda" >

                            <div class="row">
                                <div class="col-lg-8 yes">
                                    <label>Data da Venda </label>
                                    <div class="form-group input-group"  data-date-format="dd-mm-yyyy" >
                                        <input class="noInput" id="fixDataVenda" name="fixDataVenda" data-date-format="dd/mm/yyyy" readonly="readonly" >
                                    </div>

                                </div>
                                <div class="col-lg-4    yes">
                                </div>
                                <div class="col-lg-4 yes">

                                </div>
                            </div>

                            <div class="col-lg-16" >


                                <div class="panel panel-info" id="clientePanel" style="">
                                    <div class="panel-heading">
                                        <div class="row"  >
                                            <h4 style="margin-left:20px;">Cliente</h4>
                                        </div>


                                    </div>
                                    <!-- Erro se não houver clientes cadastrados com o cnpj -->
                                    <div class="alert alert-danger" id="erroPesquisaCNPJ" style="display:none;">
                                        <button type="button" id="closeErroPesquisaCNPJ" class="close" >&times;</button>
                                        <span><b>Erro:</b> Não existem clientes cadastrados com esse CNPJ.</span>
                                    </div>
                                    <div class="panel-body">

                                        <div id="nomeClienteHidden" class=" row">
                                            <div class="col-lg-6 yes">
                                                <div class="form-group" >
                                                    <label>Nome do Cliente</label>
                                                    <input class="noInput" id="nomeCliente" name="nomeCliente" placeholder="Insira o nome do cliente" readonly>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 yes" >
                                                <div class="form-group">
                                                    <label>CNPJ do cliente</label>
                                                    <input class="noInput" id="cnpjCliente" name="cnpjCliente" placeholder="Insira o CNPJ do cliente" data-mask="99.999.999/9999-99" readonly >
                                                    <input id="codigoCliente" class="hidden" value="0">
                                                    <input id="ramoCliente" class="hidden" value="0">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-16">
                                <div class="panel panel-warning" id="produtoPanel" style="">
                                    <div class="panel-heading">


                                        <div class="row" >
                                            <div class="col-lg-9" >
                                                <div class="form-group input-group">
                                                    <input type="text" class="form-control" id="pesquisaNomeProduto" name="pesquisaNomeProduto" placeholder="Digite o código do Produto e clique na lupa para inseri-lo (apenas números)" >
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" id="buttonPesquisaNomeProduto" type="button" ><i class="fa fa-search"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-lg-1" style="margin-top: 8px; ">
                                                <span><b style="color:black;"> OU </b>
                                            </div>
                                            <div class="col-lg-2" style="margin-left: -10px; ">
                                                <button type="button" id="buttonSelectProduto" class="btn btn-primary"  >Ver Produtos</button>
                                            </div>
                                        </div>


                                    </div>
                                    <!-- Erro se não houver produtos cadastrados com o código -->
                                    <div class="alert alert-danger" id="erroPesquisaCodigo" style="display:none;">
                                        <button type="button" id="closeErroPesquisaCodigo" class="close">&times;</button>
                                        <span><b>Erro:</b> Não existem produtos cadastrados com esse código ou o item já foi adicionado à venda.</span>

                                    </div>

                                    <div class="panel-body">
                                        <div id="hid" class="hidden">

                                            <div id="produtoHidden" class=" row">

                                                <div class="col-lg-6 yes">
                                                    <div class="form-group">
                                                        <label>Nome do Produto</label>
                                                        <input class="noInput" id="nomeProduto" placeholder="Insira o Nome do Produto" readonly>
                                                    </div>

                                                    <div class="form-group" >
                                                        <label>Tipo de Produto: </label><br>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="tipoProduto" id="optionsAlimento" value="alimento"  disabled>Alimentício
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="tipoProduto" id="optionsMedicamento" value="medicamento"  disabled>Farmacêutico
                                                        </label>
                                                    </div>



                                                    <label>Quantidade</label>&nbsp;<span class="glyphicon glyphicon-asterisk "></span>
                                                    <div class="form-group" id="formGroupQuantidadeProduto">

                                                        <input class="form-control" id="quantidadeProduto" class="quantidadeProduto" name="quantidadeProduto" placeholder="Insira a quantidade do produto" >
                                                    </div>
                                                    <input class="hidden" id="hidQtdeFaltando">

                                                    <div class="form-group input-group" style="margin-top: 6%;">

                                                        <div class="col-lg-6 yes">
                                                            <button type="button" id="loteAutomatico" class="btn btn-primary">Lote Automático</button>
                                                        </div>
                                                        <div class="col-lg-4 yes">
                                                            <button type="button" id="loteManual" class="btn btn-primary" >Lote Manual</button>
                                                        </div>
                                                    </div>

                                                    <div class="form-group input-group" id="formGroupQuantidadeProduto2" style="display: none;">
                                                        <small class="help-block"  >Por favor, insira a quantidade do produto</small>
                                                    </div>

                                                </div>

                                                <div class="col-lg-6 yes">
                                                    <div class="form-group">
                                                        <label>Código do Produto</label>
                                                        <input class="noInput" id="codigoProduto" name="codigoProduto" placeholder="Insira o código do produto" readonly>
                                                    </div>
                                                    <label>Valor Unitário</label>
                                                    <div class="form-group input-group">
                                                        <span style="display: table-cell">R$</span>
                                                        <input  class="noInput" id="valorUnitario" name="valorUnitario" placeholder="Insira o valor unitário do produto" readonly>
                                                    </div>

                                                    <label>Quantidade em Estoque</label>
                                                    <div class="form-group input-group">
                                                        
                                                        <input  class="noInput" id="qtdeEstoque" name="qtdeEstoque" placeholder="" readonly>
                                                    </div>

                                                    
                                                </div>


                                            </div>

                                            <div class="col-lg-16">

                                                <table class="hidden" id="table-methods-table"  >
                                                    <thead>
                                                        <tr >
                                                            <th class="status" data-field="state" data-checkbox="true" data-events="operateEvents"></th>
                                                            <th data-field="codigoLote" data-halign="center" data-align="center" >Código</th>
                                                            <th data-field="qtdeEstoque" data-halign="center" data-align="center">Quantidade em Estoque</th>
                                                            <th data-field="validade" data-halign="center" data-align="center">Validade</th>
                                                            
                                                        </tr>
                                                    </thead>
                                                </table>

                                                <div class="col-lg-2">

                                                </div>
                                                <div class="col-lg-5">

                                                </div>
                                                <div class="col-lg-5" style="margin-top: 10px;">
                                                    <div class="form-group input-group" id="groupUnidadesFalta" style="display:none;">
                                                        <label >Unidades Faltantes</label>
                                                        <input class="noInput" id="unidadesFalta" name="unidadesFalta" placeholder="" readonly>
                                                        <div class="alert alert-danger" id="erroLotesManual" style="display:none;">
                                                            
                                                            <span><b>Erro:</b> Você selecionou muitos lotes.</span>
                                                        </div>


                                                    </div>

                                                </div>
                                                

                                            </div>
                                            

                                            <div class="panel-group" id="accordion">
                                                <div class="hidden panel panel-default template" >
                                                    <div class="panel-heading">
                                                        <h4 class="panel-title">
                                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">

                                                            </a> 
                                                        </h4>
                                                    </div>
                                                    <div id="collapseOne" class="panel-collapse collapse">
                                                        <div class="panel-body">

                                                            <div class="col-lg-6 yes">
                                                                <!-- Campos do Formulário -->

                                                                <div class="form-group">
                                                                    <label>Código do Lote</label>
                                                                    <input class="noInput" id="codigoLote" name="codigoLote" placeholder="Insira o código do lote" readonly>

                                                                </div>



                                                                <div class="form-group " >
                                                                    <label>Data de Validade</label>
                                                                    <input class="noInput" id="validade" name="validade" style="width: 130px;" readonly>
                                                                </div>


                                                            </div>
                                                            <!-- /.col-lg-6 (nested) -->
                                                            <div class="col-lg-6">
                                                                <label>Unidades a Retirar</label>
                                                                <div class="form-group input-group">

                                                                    <input class="noInput" id="quantidadeProduto" name="quantidadeProduto"  readonly>
                                                                </div>

                                                            </div>

                                                            <div class="col-lg-3">

                                                            </div>
                                                            <div class="col-lg-9">

                                                            </div>
                                                            <div class="col-lg-2">
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <br />
                                            <button  type="button" class=" hidden btn btn btn-primary btn-add-panel">
                                                <i class="glyphicon glyphicon-plus white" style="color:white"></i> Adicionar novo lote
                                            </button>
                                        </div>



                                        </div>

                                    </div>

                                </div>


                            </div>




                            <div class="row">
                                <div class="col-lg-4 yes">
                                </div>
                                <div class="col-lg-3 yes">
                                </div>
                                <div class="col-lg-4 yes">
                                    <label>Valor Total</label>

                                    <div class="form-group input-group">
                                        <span style="display: table-cell">R$</span>
                                        <input type="text"  class="noInput" id="valorTotal" name="valorTotal" placeholder="0,0" readonly>
                                    </div>

                                </div>

                                <hr width="85%">
                            </div>
                            <!-- /.panel-body -->


                            

                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-2">
                                    <button id="alterarCliente" type="button" class="btn btn-primary" style="margin-left: 15px;"><span class="glyphicon glyphicon-arrow-left" style="color:white; "></span>&nbsp; Alterar Cliente</button>
                                </div>
                                <div class="col-lg-3">
                                </div>
                                <div class="col-lg-7">
                                    <!-- Button Limp3r Campos -->
                                    <button type="button" class="btn btn-danger" id="cancelarVenda">
                                        <span class="glyphicon glyphicon-remove-sign"></span> Cancelar Venda
                                    </button>

                                    <button id="verResumo" type="button" class="btn btn-primary" ><span class="glyphicon glyphicon-shopping-cart" style="color:white;"></span>&nbsp; Resumo da Venda</button>                                                                

                                    <button id="addToCart" type="button" class="btn btn-primary"  disabled><span class="glyphicon glyphicon-plus-sign" style="color:white;"></span>&nbsp; Adicionar à venda</button>
                                </div>
                            </div>

                        </form>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>

    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="alertaCancelarVenda"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#f0ad4e;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Cancelar Venda</h4>
                </div>
                <div class="modal-body">
                    <p>Tem certeza que deseja cancelar a venda?</p>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="btn btn-default" data-dismiss="modal">Não</button>
                    <button type="button" id="simCancelarVenda" class="btn btn-primary" data-dismiss="modal">Sim</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
   

    <!-- Modal -->

    <div class="modal fade" id="selecionarProduto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Selecionar Produto</h4>
                </div>
                <div class="modal-body">
                    <table id="loadProduto" class="display table-bordered" cellspacing="0" width="100%" style="cursor: pointer;">


                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nome do Produto</th>
                                <th>Tipo</th>
                                <th hidden="">Valor Unitário</th>

                            </tr>
                        </thead>

                        <tbody>
                            <%
                                for (int i = 0; i < produtos.size(); i++) {
                            %>
                            <tr>
                                <td class="code"><%= produtos.get(i).getCodProd()%></td>
                                <td><%= produtos.get(i).getNome()%></td>
                                <td class="ramo"><%= produtos.get(i).getRamo()%></td>
                                <td hidden=""><%= produtos.get(i).getValorUnitario()%></td>

                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="selectProduct"  >Selecionar Produto</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- Modal Selecionar Lote -->
    <div class="modal fade" id="modalSelecionarLote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Selecionar Lote</h4>
                </div>
                <div class="modal-body">
                    <table id="loadLote" class="display table-bordered" cellspacing="0" width="100%" style="cursor: pointer;">

                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Quantidade Estoque</th>
                                <th>Data de Validade</th>

                            </tr>
                        </thead>

                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button"  class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="selectLote" class="btn btn-primary" data-dismiss="modal">Selecionar Lote</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->


    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="modalErroDeSelecao"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Erro de Seleção</h4>
                </div>
                <div class="modal-body">
                    <p>Você deve selecionar um item.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>

                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="modalQuantidade0"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Quantidade Inválida</h4>
                </div>
                <div class="modal-body">
                    <p>A quantidade deve ser maior que 0.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>

                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="modalSemQuantidade"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Insira a Quantidade</h4>
                </div>
                <div class="modal-body">
                    <p>Você deve inserir uma quantidade para selecionar o lote.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>

                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <!-- Modal confirmação de salvamento -->
    <div class="modal fade bs-example-modal-sm2" id="sucessoVenda"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel2" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#5cb85c;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-ok" style="color:white;"></span>&nbsp;&nbsp;Venda Efetuada com Sucesso</h4>
                </div>
                <div class="modal-body">
                    <span>A venda foi efetuada com sucesso!</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
                    <button type="button" class="btn btn-primary" id="gerarRelatorio" ><span class="glyphicon glyphicon-book" style="color:white;"></span>&nbsp;Gerar Relatório</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->



    <div class="modal fade" id="relatorioVenda" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="relatorioTitle">Relatório de Vendas</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-4 yes">
                            <div class="input-group">
                                <span class="input-group-addon"><b>Data da venda</b></span>
                                <input type="text" id="dataVendaModal" class="form-control" value="" readonly>
                            </div>
                        </div>
                    </div>
                    <hr width="90%">

                    <span><b>Cliente</b></span>

                    <div class="row">
                        <div class="col-lg-6 yes">
                            <div class="input-group">
                                <span class="input-group-addon"><b>Nome</b></span>
                                <input type="text" id="nomeClienteModal" class="form-control" value="" readonly>
                            </div>
                        </div>

                        <div class="col-lg-1 yes">

                        </div>

                        <div class="col-lg-6 yes">
                            <div class="input-group">
                                <span class="input-group-addon"><b>CNPJ</b></span>
                                <input type="text" id="cnpjClienteModal" class="form-control" value="" readonly>
                            </div>
                        </div>
                    </div>

                    <hr width="60%">

                    <span><b>Produto</b></span>
                    <div class="row">
                        <div class="col-lg-6 yes">
                            <div class="form-group input-group">
                                <span class="input-group-addon"><b>Produto</b></span>
                                <input type="text" id="nomeProdutoModal" class="form-control" value="" readonly>
                            </div>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><b>Tipo do produto</b></span>
                                <input type="text" id="tipoProdutoModal" class="form-control" value="" readonly>
                            </div>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><b>Valor unitátio</b></span>
                                <input type="text" id="valorUnitarioModal" class="form-control" value="" readonly>
                            </div>
                        </div>

                        <div class="col-lg-1 yes">

                        </div>

                        <div class="col-lg-6 yes">
                            <div class="form-group input-group">
                                <span class="input-group-addon"><b>Código do produto</b></span>
                                <input type="text" id="codProdutoModal" class="form-control" value="" readonly>
                            </div>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><b>Quantidade unitária</b></span>
                                <input type="text" id="quantidadeModal" class="form-control" value="" readonly>
                            </div>
                        </div>
                    </div>


                    <div id="loteRelatorio">
                        <hr width="60%">


                        <span><b>Lote</b></span>
                        <div class="hidden row relatorioGerado">
                            <div class="col-lg-6 yes">
                                <div class="form-group input-group">
                                    <span class="input-group-addon"><b>Código</b></span>
                                    <input type="text" id="codigoLoteModal" class="form-control" value="" readonly>
                                </div>
                                <div class="form-group input-group">
                                    <span class="input-group-addon"><b>Validade</b></span>
                                    <input type="text" id="dataValidadeModal" class="form-control" value="" readonly>
                                </div>

                            </div>

                            <div class="col-lg-1 yes">

                            </div>

                            <div class="col-lg-6 yes">
                                <div class="form-group input-group">
                                    <span class="input-group-addon"><b>Quantidade</b></span>
                                    <input type="text" id="quantidadeProdutoModal" class="form-control" value="" readonly>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- <hr width="60%"> -->

                    <div class="row">
                        <div class="col-lg-6 yes">
                        </div>
                        <div class="col-lg-1 yes">
                        </div>
                        <div class="col-lg-5 yes">
                            <div class="form-group input-group">
                                <span class="input-group-addon"><b>Valor total da venda</b></span>
                                <input type="text" id="valorTotalModal" class="form-control" value="" readonly>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
                    <button type="button" class="btn btn-primary" id="salvarRelatorio" ><span class="glyphicon glyphicon-floppy-disk" style="color:white;"></span>&nbsp;Salvar Relatório</button>

                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- Modal confirmação de salvamento -->
    <div class="modal fade bs-example-modal-sm2" id="salvarRelatorioComo"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel2" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#428bca;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-exclamation-sign" style="color:white;"></span>&nbsp;&nbsp;Salvar Relatório</h4>
                </div>
                <div class="modal-body">

                    <div class="alert alert-danger" id="erroNomeVazio" style="display:none;">
                        <button type="button" class="close" id="closeErroNomeVazio" >&times;</button>
                        <span><b>Erro:</b> Insira o nome do arquivo</span>
                    </div>
                    <label>Salvar como: *</label>
                    <div class="form-group input-group " id="nomeRelatorioInputGroup">

                        <input class="form-control" id="nomeRelatorio" class="nomeRelatorio" name="nomeRelatorio" placeholder="Insira o nome do arquivo" >
                        <span class="input-group-addon" id="unidadeAddon">.pdf</span>



                    </div>
                    <div class="form-group input-group"  >
                        <small class="help-block" >*Somente letras, números e hífen (-)</small>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
                    <button type="button" class="btn btn-primary" id="salvarRelatorioNome"><span class="glyphicon glyphicon-floppy-disk" style="color:white;"></span>&nbsp;Salvar Relatório</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="erroLoteInsuficiente"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Falta de Produto em Estoque</h4>
                </div>
                <div class="modal-body">
                    <p>Não existem produtos suficientes em estoque para essa venda.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="erroVenda"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Erro do Cadastro da venda</h4>
                </div>
                <div class="modal-body">
                    <p>Não foi possível inserir a venda na base de dados. Aparentemente já existe uma venda cadastrada com os mesmos parâmetros ou a base de dados pode estar com problemas de comunicação.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="hidden" id="auxiliarParaRelatorio"></div>



    <!-- /#wrapper -->
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>


</body>
</html>
