<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Bean.Produto"%>
<!DOCTYPE html>
<html lang="pt-br" class="wf-sourcecodepro-n4-active wf-sourcecodepro-n7-active wf-active">

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
        <script src="js/PesquisaCNPJProduto.js"></script>

        <script src="js/salvarVenda.js"></script>

        <script src="js/jsLimiteVenda.js"></script>
        <script src="js/jsGeral.js"></script>



        <title>Alterar Limite de Validade - ArrayEnterprises</title>

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
                            <a class="active" href="BuscaProdutosEstoque"><i class="glyphicon glyphicon-calendar fa-fw"></i> Alterar Limite de Validade</a>
                        </li>

                        <li>
                            <a href="#"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Vendas<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level collapse out">
                                <li>
                                    <a class="" href="BuscaClientesProdutos"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Efetuar Venda</a>
                                </li>
                                <li>
                                    <a class="" href="carrinho.jsp"><i class="glyphicon glyphicon-list-alt fa-fw"></i> Resumo da Venda</a>
                                </li>
                                <li>
                                    <a  href="BuscaTodasVendas"><i class="glyphicon glyphicon-file fa-fw"></i> Relatórios de Vendas</a>
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
                <h1 class="page-header">Alterar Limite de Validade</h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="glyphicon glyphicon-home"></i>  <a href="index.html">Painel de Controle</a>
                    </li>
                    <li class="active">
                        <i class="glyphicon glyphicon-calendar"></i> Alterar Limite de Validade
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
                        <b>Os produtos são Listados abaixo: </b>
                    </div>
                    <div class="panel-body">


                            <div class="col-lg-16" >
                                <table id="loadProduto" class="display table-bordered" cellspacing="0" width="100%" style="">
                                    <thead >
                                        <tr >
                                            <th style="text-align: center;" >Código</th>
                                            <th style="text-align: center;" >Produto</th>
                                            <th style="text-align: center;">Ramo</th>
                                            <th class="hidden" style="text-align: center;">Valor unitário (R$)</th>
                                            <th style="text-align: center;">Limite para venda (dias)</th>
                                            <th style="text-align: center;">Alterar limite</th>
                                        </tr>
                                    </thead >

                                    <tfoot >
                                        <tr>
                                            <th style="text-align: center;" >Código</th>
                                            <th style="text-align: center;" >Produto</th>
                                            <th style="text-align: center;">Ramo</th>
                                            <th class="hidden" style="text-align: center;">Valor unitário (R$)</th>
                                            <th style="text-align: center;">Limite para venda (dias)</th>
                                            <th style="text-align: center;">Alterar limite</th>
                                        </tr>
                                    </tfoot>

                                    <tbody style="text-align: center;">
                                        <% for (int i = 0; i < produtos.size(); i++) {
                                        %>
                                        <tr>
                                            <td > <%=produtos.get(i).getCodProd()%> </td>
                                            <td > <%=produtos.get(i).getNome()%> </td>
                                            <td > <%=produtos.get(i).getRamo()%> </td>
                                            <td class="hidden"> <%=produtos.get(i).getValorUnitario()%> </td>
                                            <td ><b> <%=produtos.get(i).getDiasLim_venda()%> </b></td>
                                            <td> <button class="btn btn-primary"><span class="glyphicon glyphicon-pencil"> Alterar</button></td>

                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>

                                
                            </div>


                            


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
    <div class="modal fade " id="modalAlterarLimite"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#428bca;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Alterar Limite de Venda</h4>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger" id="erroDiasVazio" style="display:none;">
                        <button type="button" class="close" id="closeErroNomeVazio" >&times;</button>
                        <span><b>Erro:</b> Insira um valor válido</span>
                    </div>

                    <input class="hidden" id="hidCodProd">

                    <p>O tempo limite para a venda do produto <b><span id="modalProdNone"></span></b> é de <b><span id="modalProdDias"></span></b> dias.</p>
                    <p>Para alterar, insira o novo limite no campo abaixo e clique em <b>Alterar</b></p>

                    
                    <label>Novo limite de dias: *</label>
                    <div class="form-group input-group " id="nomeRelatorioInputGroup">

                        <input class="form-control" id="newLimiteDias" class="newLimiteDias" name="newLimiteDias" placeholder="Insira o novo limite de dias" maxlength="2">
                        <span class="input-group-addon" id="unidadeAddon">dias</span>

                    </div>
                    <div class="form-group input-group"  >
                        <small class="help-block" >* Somente números positivos</small>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="alterarSim" class="btn btn-primary" >Alterar</button>

                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="modalSucessoAlterar"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#5cb85c;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-ok" style="color:white;"></span>&nbsp;&nbsp;Sucesso na Alteração</h4>
                </div>
                <div class="modal-body">
                    <p>O Limite de dias foi alterado com sucesso!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>

                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

     <!-- Modal erro de não selecionar nenhum item -->
    <div class="modal fade bs-example-modal-sm " id="modalErroAlterar"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-exclamation-sign" style="color:white;"></span>&nbsp;&nbsp;Erro na Alteração</h4>
                </div>
                <div class="modal-body">
                    <p>Um erro ocorreu durante a alteração do limite de dias.</p>
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