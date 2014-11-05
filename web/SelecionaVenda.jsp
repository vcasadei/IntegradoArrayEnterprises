<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Bean.Cliente"%>
<%@page import="Bean.Venda"%>
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


       


        <link rel="stylesheet" href="css/jasny-bootstrap.css">
        <script src="js/jasny-bootstrap.js"></script>
        <script type="text/javascript" src="js/jspdf.plugin.autoprint.js"></script> 
        

        <!-- Pesquisa produto/Cliente -->

        <script src="js/jsSelecionarVenda.js"></script>
        <script src="js/openRelatorio.js"></script>
        <script src="js/jsGeral.js"></script>



        <title>Relatórios de Vendas - ArrayEnterprises</title>

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
            
            List<Venda> vendas = (List<Venda>) request.getAttribute("listaVendas");
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
                            <a href="index.html"><i class=" fa-fw"></i> Painel de Controle</a>
                        </li>

                        <li class="somenteAdm">
                            <a href="novousuario.jsp"><i class=" fa-fw"></i> Cadastro de Usuário</a>
                        </li>
                        <li class="somenteAdm">
                            <a  href="BuscaProdutosEstoque"><i class=" fa-fw"></i> Alterar Limite de Validade</a>
                        </li>

                        <li>
                            <a href="#"><i class=" fa-fw"></i> Vendas<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level collapse in">
                                <li>
                                    <a class="" href="BuscaClientesProdutos"><i class=" fa-fw"></i> Efetuar Venda</a>
                                </li>
                                <li>
                                    <a class="" href="carrinho.jsp"><i class=" fa-fw"></i> Resumo da Venda</a>
                                </li>
                                <li>
                                    <a class="active" href="BuscaTodasVendas"><i class=" fa-fw"></i> Relatórios de Vendas</a>
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
                <h1 class="page-header">Relatórios de Vendas</h1>
                <ol class="breadcrumb">
                    <li>
                        <i class=""></i>  <a href="index.html">Painel de Controle</a>
                    </li>
                    <li>
                        <i class=""></i> Vendas
                    </li>
                    <li class="active">
                        <i class=""></i> Relatórios de Vendas
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
                        <b>As vendas efetuadas estão listadas abaixo: </b>
                    </div>
                    <div class="panel-body">

                            <div class="col-lg-16" >
                                <table id="loadVenda" class="display table-bordered" cellspacing="0" width="100%" style="">
                                    <thead >
                                        <tr >
                                            <th style="text-align: center;" class="hidden">codVenda</th>
                                            <th style="text-align: center;" >Data da Venda</th>
                                            <th style="text-align: center;">Cliente</th>
                                            <th class="hidden" style="text-align: center;">Código Produtos</th>
                                            <th style="text-align: center;">Produtos</th>
                                            <th style="text-align: center;" class="hidden">Valor Total (R$)</th>
                                            <th style="text-align: center;">Relatório</th>
                                        </tr>
                                    </thead >

                                    <tfoot >
                                        <tr>
                                            <th class="hidden">codVenda</th>
                                            <th style="text-align: center;">Data da Venda</th>
                                            <th style="text-align: center;">Cliente</th>
                                            <th  class="hidden" style="text-align: center;">Código Produtos</th>
                                            <th style="text-align: center;">Produtos</th>
                                            <th style="text-align: center;" class="hidden">Valor Total (R$)</th>
                                            <th style="text-align: center;">Relatório</th>
                                        </tr>
                                    </tfoot>

                                    <tbody style="text-align: center;">
                                        <% for (int i = 0; i < vendas.size(); i++) {
                                        %>
                                        <tr>
                                            <td class="hidden"> <%=vendas.get(i).getCodVenda()%> </td>
                                            <td> <%=vendas.get(i).getDataVenda()%> </td>
                                            <td> <%=vendas.get(i).getCliente().getNome()%> </td> 
                                            <td class="hidden" > <%=vendas.get(i).getProduto().getCodProds()%> </td>
                                            <td> <%=vendas.get(i).getProduto().getNome()%> </td> 
                                            <td class="hidden"> <%=vendas.get(i).getValorTotal()%> </td>
                                            <td> <button class="btn btn-primary"><span class="glyphicon glyphicon-file"> Gerar Relatório</button></td>

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
    <div class="modal fade bs-example-modal-sm " id="erroRelatorio"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog vertical-centered " >
            <div class="modal-content">
                <div class="modal-header" style="background-color:#d9534f;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Erro na geração de relatório</h4>
                </div>
                <div class="modal-body">
                    <p>Não foi possível gerar o relatório de vendas por conta de um erro de comunicação com o servidor. Contate o suporte.</p>
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