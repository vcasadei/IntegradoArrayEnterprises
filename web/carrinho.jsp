
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>

        <meta http-equiv="Content-type" content="text/html;charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <script src="js/jquery-1.11.1.js"></script>
        <script src="datepicker/js/bootstrap-datepicker.js"></script>

        <script src="js/example.js"></script>
        <link href="css/bootstrap-dialog.css" rel="stylesheet" type="text/css" />
        <script src="js/bootstrap-dialog.js"></script>

        <script type="text/javascript" src="js/jsPDF/FileSaver.js"></script> 


        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <script  src="js/bootstrapValidator.js"></script>

        <script src="js/jsPDF/jspdf.min.js"></script>


        <script src="js/generatePDF.js"></script>

        <script src="js/jsGeral.js"></script>


        <link rel="stylesheet" href="css/jasny-bootstrap.css">

        <script src="js/jasny-bootstrap.js"></script>
        <script type="text/javascript" src="js/jspdf.plugin.autoprint.js"></script> 
        <script src="js/printPDF.js"></script>

        <!-- Pesquisa produto/Cliente -->
        <script src="js/PesquisaCNPJProduto.js"></script>

        <script src="js/salvarVenda.js"></script>
        <script src="js/jscarrinho.js"></script>

        <title>Resumo da venda - ArrayEnterprises</title>

        <!-- Bootstrap Core CSS -->
        <link href="datepicker/css/datepicker.css" rel="stylesheet">

        <!-- Bootstrap Core CSS -->


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
                                    <a class="" href="BuscaClientesProdutos"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Efetuar Venda</a>
                                </li>
                                <li>
                                    <a class="active" href="carrinho.jsp"><i class="glyphicon glyphicon-list-alt fa-fw"></i> Resumo da Venda</a>
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
                <h1 class="page-header">Resumo da venda</h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="glyphicon glyphicon-home"></i>  <a href="index.html">Painel de Controle</a>
                    </li>
                    <li>
                        <i class="glyphicon glyphicon-shopping-cart"></i> Vendas
                    </li>
                    <li class="active">
                        <i class="glyphicon glyphicon-list-alt"></i> Resumo da Venda
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
                        
                    </div>
                    <div class="panel-body">
                        <!-- Form de Venda -->
                        

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
                                                    <input class="noInput" id="nomeCliente" name="nomeCliente"  readonly>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 yes" >
                                                <div class="form-group">
                                                    <label>CNPJ do cliente</label>
                                                    <input class="noInput" id="cnpjCliente" name="cnpjCliente"  data-mask="99.999.999/9999-99" readonly>
                                                    <input id="codigoCliente" class="hidden" value="0">
                                                    <input id="ramoCliente" class="hidden" value="0">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="col-lg-16">

                                <table id="table-methods-table"  >
                                    <thead>
                                        <tr >

                                            <th data-field="id" data-halign="center" data-align="center" >Item</th>
                                            <th data-field="codigoProduto" data-halign="center" data-align="center" >Código</th>
                                            <th data-field="produto" data-halign="center" data-align="center">Produto</th>
                                            <th data-field="tipo" data-halign="center" data-align="center">Tipo</th>
                                            <th data-field="quantidade" data-halign="center" data-align="center">Quantidade</th>
                                            <th data-field="preco" data-halign="center" data-align="center">Preço (R$)</th>
                                            <th data-field="subtotal" data-halign="center" data-align="center">SubTotal (R$)</th>
                                            <th data-field="operate" data-formatter="operateFormatter" data-events="operateEvents" data-halign="center" data-align="center">Ação</th>
                                        </tr>
                                    </thead>
                                </table>

                            </div>




                            <div class="row">
                                <div class="col-lg-3">
                                </div>
                                <div class="col-lg-5">
                                </div>
                                <div class="col-lg-4">
                                    <h3><b>Total:</b>
                                        <div class="form-group input-group">
                                            <span style="display: table-cell">R$</span>
                                            <b><input type="text" class="noInput input-lg" id="total" name="total" placeholder="0,0" readonly></b>
                                        </div>
                                     </h3>
                                </div>
                            </div>
                            <!-- /.panel-body -->


                            

                            <div class="row" style="margin-top: 10px;">
                                <div class="col-lg-2">
                                </div>
                                <div class="col-lg-3">
                                </div>
                                <div class="col-lg-7">
                                    <button type="button" class="btn btn-danger" id="cancelarVenda">
                                        <span class="glyphicon glyphicon-remove-sign"></span> Cancelar Venda
                                    </button>

                                    <button type="button" class="btn btn-primary" id="newProduct">
                                        <span class="glyphicon glyphicon-plus-sign"></span> Adicionar Produto
                                    </button>

                                    <button type="button" class="btn btn-success" id="terminarCompra">
                                        <span class="glyphicon glyphicon-shopping-cart"></span> Finalizar Compra
                                    </button>
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

    <!-- start: Delete Coupon Modal -->
    <div class="modal fade bs-example-modal-sm " id="modalExcuirProduto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm vertical-centered ">
            <div class="modal-content">
                <div class="modal-header" style="background-color:#f0ad4e;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                    <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Excluir Produto</h4>

                </div>
                <div class="modal-body">
                    <h4>Você deseja excluir o produto?</h4>

                </div>
                <!--/modal-body-collapse -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Não</button>
                    <button type="button" class="btn btn-primary" id="btnDelteYes" href="#">Sim</button>
                </div>
                <!--/modal-footer-collapse -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

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
