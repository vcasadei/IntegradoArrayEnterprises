<%@page import="java.util.List"%>
<%@page import="Bean.Cliente"%>
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

        <script src="js/jsCliente.js"></script>
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
            List<Cliente> clientes = (List<Cliente>) request.getAttribute("listaClientes");
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
                        <i class="glyphicon glyphicon-shopping-cart"></i> Selecionar Cliente
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
                                    <label>Data da Venda <span class="glyphicon glyphicon-asterisk "></span></label>
                                    <div class="form-group input-group"  data-date-format="dd-mm-yyyy" >
                                        <input class="form-control" id="dataVenda" name="dataVenda" data-date-format="dd/mm/yyyy" placeholder="Clique e selecione" readonly="readonly" style="cursor:pointer;">
                                    </div>

                                </div>
                                <div class="col-lg-4    yes">
                                </div>
                                <div class="col-lg-4 yes">

                                </div>
                            </div>

                            <div class="col-lg-16" >


                                <div class="panel panel-info" id="clientePanel" style="opacity:0.5;">
                                    <div class="panel-heading">
                                        <div class="row"  >
                                            <div class="col-lg-9" >
                                                <div class="form-group input-group" >
                                                    <input type="text" class="form-control" id="pesquisaCNPJCliente" name="pesquisaCNPJCliente" data-mask="99.999.999/9999-99" placeholder="Pesquise pelo CNPJ do Cliente (apenas números)" disabled>
                                                    <span class="input-group-btn" >
                                                        <button class="btn btn-default" id="buttonpesquisaCNPJCliente" type="button" disabled><i class="fa fa-search" ></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-lg-1" style="margin-top: 8px; ">
                                                <span><b style="color:black;"> OU </b>
                                            </div>
                                            <div class="col-lg-2" style="margin-left: -10px; ">
                                                <button type="button" id="buttonSelectCliente" class="btn btn-primary" disabled>Ver Clientes</button>
                                            </div>
                                        </div>


                                    </div>
                                    <!-- Erro se não houver clientes cadastrados com o cnpj -->
                                    <div class="alert alert-danger" id="erroPesquisaCNPJ" style="display:none;">
                                        <button type="button" id="closeErroPesquisaCNPJ" class="close" >&times;</button>
                                        <span><b>Erro:</b> Não existem clientes cadastrados com esse CNPJ.</span>
                                    </div>
                                    <div class="panel-body">

                                        <div id="nomeClienteHidden" class="hidden row">
                                            <div class="col-lg-6 yes">
                                                <div class="form-group" >
                                                    <label>Nome do Cliente</label>
                                                    <input class="form-control" id="nomeCliente" name="nomeCliente" placeholder="Insira o nome do cliente" readonly>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 yes" >
                                                <div class="form-group">
                                                    <label>CNPJ do cliente</label>
                                                    <input class="form-control" id="cnpjCliente" name="cnpjCliente" placeholder="Insira o CNPJ do cliente" data-mask="99.999.999/9999-99" readonly>
                                                    <input id="codigoCliente" class="hidden" value="0">
                                                    <input id="ramoCliente" class="hidden" value="0">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            

                            <div class="row">
                                <div class="col-lg-3">
                                </div>
                                <div class="col-lg-4">
                                </div>
                                <div class="col-lg-5">
                                    <!-- Button Limp3r Campos -->
                                    <button type="reset" id="resetVenda" class="btn btn-danger"><span class="glyphicon glyphicon-repeat" style="color:white;"></span>&nbsp; Limpar Campos</button>

                                    <button id="toProducts" type="button" class="btn btn-primary"  disabled><span class="glyphicon glyphicon-plus-sign" style="color:white;"></span>&nbsp; Adicionar Produtos</button>
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
    

    <!-- Modal Selecionar Cliente -->
    <div class="modal fade" id="selecionarCliente" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Selecionar Cliente</h4>
                </div>
                <div class="modal-body">
                    <table id="loadCliente" class="display table-bordered" cellspacing="0" width="100%" style="cursor:pointer;">
                        <thead>
                            <tr>
                                <th>Nome do Cliente</th>
                                <th>CNPJ</th>
                                <th class="hidden">cod</th>
                                <th class="hidden">ramo</th>


                            </tr>
                        </thead>

                        <tfoot>
                            <tr>
                                <th>Nome do Cliente</th>
                                <th>CNPJ</th>
                                <th class="hidden">cod</th>
                                <th class="hidden">ramo</th>


                            </tr>
                        </tfoot>

                        <tbody>
                            <% for (int i = 0; i < clientes.size(); i++) {
                            %>
                            <tr>
                                <td> <%=clientes.get(i).getNome()%> </td>
                                <td> <%=clientes.get(i).getCNPJ()%> </td>
                                <td class="hidden"> <%=clientes.get(i).getCodCliente()%> </td>
                                <td class="hidden"> <%=clientes.get(i).getRamo()%> </td>

                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="selectClient" class="btn btn-primary" >Selecionar Cliente</button>
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