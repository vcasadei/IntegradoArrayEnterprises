<%@page import="java.util.List"%>
<%@page import="Bean.Cliente"%>
<%@page import="Bean.Produto"%>
<!DOCTYPE html>
<html lang="pt-br">

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

        <link rel="stylesheet" href="css/jasny-bootstrap.css">
        <script src="js/jasny-bootstrap.js"></script>



        <script>
            $(document).ready(function() {

                var table = $('#loadCliente').DataTable( {
                    language: {
                        url: 'localisation/Portuguese-Brasil.json'
                    }
                } );

                var aux2 = "";
                var auxSplit = "none";



                $('#loadCliente tbody').on('click', 'tr', function() {
                    if ($(this).hasClass('selected')) {
                        $(this).removeClass('selected');
                        auxSplit = "none";
                    }
                    else {
                        table.$('tr.selected').removeClass('selected');
                        $(this).addClass('selected');

                        $(this).find("td").each(function() {
                            aux2 = aux2 + "#/" + $(this).text();
                        });

                        auxSplit = aux2.split("#/");
                    }
                });

                $('#selectClient').click(function() {
                
                    if ($('#loadCliente tbody tr').hasClass('selected')) {
                        $('#load tbody tr').removeClass('selected');
                    }
                
                    if (auxSplit === "none") {
                        console.log("Nada foi Selecionado");
                    } else {
                        console.log("ALGO FOI SELECIONADO");
                        var auxNomeCliente = auxSplit[1];
                        var auxCNPJ = auxSplit[2];
                        $('#nomeClienteHidden').removeClass('hidden');
                        console.log(auxNomeCliente);
                        console.log(auxCNPJ);
                        $('#nomeCliente').val(auxNomeCliente);
                        $('#cnpjCliente').val(auxCNPJ);
                        auxSplit === "none";
                        aux2 = "";
                        auxNomeCliente = "";
                        auxCNPJ = "";
                    }
                });
            });
        </script>

        <script >
            $(document).ready(function() {

                var table = $('#loadProduto').dataTable( {
                    language: {
                        url: 'localisation/Portuguese-Brasil.json'
                    }
                } );
                var aux2 = "";
                var auxSplit = "none";

                $('#loadProduto tbody').on('click', 'tr', function() {
                    if ($(this).hasClass('selected')) {
                        $(this).removeClass('selected');
                        auxSplit = "none";
                    }
                    else {
                        table.$('tr.selected').removeClass('selected');
                        $(this).addClass('selected');

                        $(this).find("td").each(function() {
                            aux2 = aux2 + "#/" + $(this).text();
                        });

                        auxSplit = aux2.split("#/");
                    }
                });

                // Camila - buguei o bang de produtos aqui
                $('#selectProduct').click(function() {

                    if ($('#loadProduto tbody tr').hasClass('selected')) {
                        $('#loadProduto tbody tr').removeClass('selected');

                    }

                    if (auxSplit === "none") {
                        console.log("Nada foi Selecionado");
                    } else {
                        console.log("ALGO FOI SELECIONADO");
                        var auxCodProd = auxSplit[1];
                        var auxNomeProd = auxSplit[2];
                        var auxTipoProd = auxSplit[3];
                        var auxValorUnitario = auxSplit[4];
                        $('#hid').removeClass('hidden');
                        $('#nomeProduto').val(auxNomeProd);
                        $('#codigoProduto').val(auxCodProd);
                        $('#valorUnitario').val(auxValorUnitario);
                        var osRaio = $('input:radio[name=tipoProduto]');
                        if (auxTipoProd === "medicamento") {
                            osRaio.filter('[value=medicamento]').attr('checked', true);
                            console.log("medicamento");
                        } else {
                            osRaio.filter('[value=alimento]').attr('checked', true);
                            console.log("Alimento");
                        }
                        auxSplit === "none";
                        aux2 = "";
                        $('#quantidadeProduto').addClass("focusedInput");
                    }
                });

                $('#loadLote').dataTable();

                $('#selectLote').click(function() {
                    $('#loteHidden').removeClass('hidden');
                });


            });
        </script>

        <script type="text/javascript">
            var $template = $(".template");

            var hash = 2;
            $(".btn-add-panel").on("click", function() {
                var $newPanel = $template.clone();
                $newPanel.find(".collapse").removeClass("in");
                $newPanel.find(".accordion-toggle").attr("href", "#" + (++hash))
                        .text("Dynamic panel #" + hash);
                $newPanel.find(".panel-collapse").attr("id", hash).addClass("collapse").removeClass("in");
                $("#accordion").append($newPanel.fadeIn());
            });


        </script>

        <!-- Input somente de numeros -->
        <script>
            $(document).ready(function() {
                //called when key is pressed in textbox
                $("#quantidadeProduto").keypress(function(e) {
                    //if the letter is not digit then display error and don't type anything
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        //display error message
                        //$("#errmsg").html("Digits Only").show().fadeOut("slow");
                        return false;
                    }
                });

                $("#valorUnitario").keypress(function(e) {
                    //if the letter is not digit then display error and don't type anything
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        //display error message
                        //$("#errmsg").html("Digits Only").show().fadeOut("slow");
                        return false;
                    }
                });


                $("#quantidadeProduto").keyup(function(e) {
                    //if the letter is not digit then display error and don't type anything
                    
                        var value = document.getElementById('quantidadeProduto').value;
                        var valueUnity = document.getElementById('valorUnitario').value;
                        var total = value*valueUnity;
                        document.getElementById('valorTotal').value=total;

                    
                });


                //Pesquisa pelo código do Prod que só aceita números
                $("#pesquisaNomeProduto").keypress(function(e) {
                    //if the letter is not digit then display error and don't type anything
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        //display error message
                        //$("#errmsg").html("Digits Only").show().fadeOut("slow");
                        return false;
                    }
                });

            });
        </script>


        <script>
            $(document).ready(function() {
                $('#dataVenda').datepicker();
            });
        </script>

        <script>
            $(document).ready(function() {
                $('#header2').load('header.html');

            });
        </script>

        <!-- Funcao para limpar campos de form -->
        <script>
            $(document).ready(function() {
                $("#resetVenda").click(function() {
                    $('#nomeProduto').text('');
                    $('#codigoProduto').text('');
                    $('input[name="tipoProduto"]:checked').text('');
                    $('#quantidadeProduto').text('');
                    $('input[name="unidadeProduto"]:checked').text('');
                    $('#descricaoProduto').text('');

                    $('#nomeCliente').text('');
                    $('#cnpjCliente').text('');

                    $('#dataVenda').text('');

                    $('#codigoLote').text('');
                    $('#dataFabricacao').text('');
                    $('#dataValidade').text('');
                    $('#observacoes').text('');
                    $('#quantidadeProduto').text('');

                    if (!($('#nomeClienteHidden').hasClass('hidden'))) {
                        $('#nomeClienteHidden').addClass('hidden');
                    }

                    if (!($('#hid').hasClass('hidden'))) {
                        $('#hid').addClass('hidden');
                    }

                    if (!($('#loteHidden').hasClass('hidden'))) {
                        $('#loteHidden').addClass('hidden');
                    }

                });
            });
        </script>



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
                            <a href="index.html"><i class="fa fa-dashboard fa-fw"></i> Painel de Controle</a>
                        </li>

                        <li>
                            <a href="novousuario.html"><i class="fa fa-edit fa-fw"></i> Cadastro de Usuário</a>
                        </li>

                        <li>
                            <a href="#"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Vendas<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level collapse in">
                                <li>
                                    <a class="active" href="BuscaClientesProdutos">Efetuar Venda</a>
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
                        <i class="fa fa-dashboard"></i>  <a href="index.html">Painel de Controle</a>
                    </li>
                    <li>
                        <i class="glyphicon glyphicon-shopping-cart"></i> Venda
                    </li>
                    <li class="active">
                        <i class="glyphicon glyphicon-shopping-cart"></i> Efetuar Venda
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
                        <b>Itens obrigatórios estão marcados com </b><span class="glyphicon glyphicon-asterisk req"></span>
                    </div>
                    <div class="panel-body">
                        <!-- Form de Venda -->
                        <form role="formVenda" action="CadastrarVenda" method="POST">

                            <div class="row">
                                <div class="col-lg-8 yes">
                                    <label>Data da Venda <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <div class="form-group input-group"  data-date-format="dd-mm-yyyy">
                                        <input class="form-control" id="dataVenda" name="dataVenda" data-date-format="dd/mm/yyyy" placeholder="Clique e selecione">
                                    </div>

                                </div>
                                <div class="col-lg-4    yes">
                                </div>
                                <div class="col-lg-4 yes">

                                </div>
                            </div>

                            <div class="col-lg-16">


                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <div class="row" style="margin-bottom: -16px;">
                                            <div class="col-lg-9" >
                                                <div class="form-group input-group">
                                                    <input type="text" class="form-control" id="pesquisaCNPJCliente" name="pesquisaCNPJCliente" data-mask="99.999.999/9999-99" placeholder="Pesquise pelo CNPJ do Cliente (apenas números)">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" id="buttonpesquisaCNPJCliente" type="button"><i class="fa fa-search"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#selecionarCliente">Selecionar Cliente</button>
                                            </div>
                                        </div>


                                    </div>
                                    <div class="panel-body">

                                        <div id="nomeClienteHidden" class="hidden row">
                                            <div class="col-lg-6 yes">
                                                <div class="form-group" >
                                                    <label>Nome do Cliente</label>
                                                    <input class="form-control" id="nomeCliente" name="nomeCliente" placeholder="Insira o nome do cliente" disabled>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 yes">
                                                <div class="form-group">
                                                    <label>CNPJ do cliente</label>
                                                    <input class="form-control" id="cnpjCliente" name="cnpjCliente" placeholder="Insira o CNPJ do cliente" data-mask="99.999.999/9999-99" disabled>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="col-lg-16">
                                <div class="panel panel-warning">
                                    <div class="panel-heading">


                                        <div class="row" style="margin-bottom: -16px;">
                                            <div class="col-lg-9" >
                                                <div class="form-group input-group">
                                                    <input type="text" class="form-control" id="pesquisaNomeProduto" name="pesquisaNomeProduto" placeholder="Pesquise pelo código do Produto (apenas números)">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" id="buttonPesquisaNomeProduto" type="button"><i class="fa fa-search"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-lg-2">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#selecionarProduto">Selecionar Produto</button>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="panel-body">
                                        <div id="hid" class="hidden">

                                            <div id="produtoHidden" class=" row">
                                                <div class="col-lg-6 yes">
                                                    <div class="form-group">
                                                        <label>Nome do Produto</label>
                                                        <input class="form-control" id="nomeProduto" placeholder="Insira o Nome do Produto" disabled>
                                                    </div>

                                                    <div class="form-group" >
                                                        <label>Tipo de Produto: </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="tipoProduto" id="optionsAlimento" value="alimento"  disabled>Alimentício
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="tipoProduto" id="optionsMedicamento" value="medicamento"  disabled>Farmacêutico
                                                        </label>
                                                    </div>



                                                    <label>Quantidade</label>&nbsp;<span class="glyphicon glyphicon-asterisk req"></span>
                                                    <div class="form-group input-group">

                                                        <input class="form-control" id="quantidadeProduto" class="quantidadeProduto" name="quantidadeProduto" placeholder="Insira a quantidade do produto" >
                                                        <span class="input-group-addon" id="unidadeAddon">unidades</span>
                                                    </div>


                                                </div>

                                                <div class="col-lg-6 yes">
                                                    <div class="form-group">
                                                        <label>Código do Produto</label>
                                                        <input class="form-control" id="codigoProduto" name="codigoProduto" placeholder="Insira o código do produto" disabled>
                                                    </div>
                                                    <label>Valor Unitário</label>
                                                    <div class="form-group input-group">
                                                        <span class="input-group-addon">R$</span>
                                                        <input  class="form-control" id="valorUnitario" name="valorUnitario" placeholder="Insira o valor unitário do produto" disabled></textarea>
                                                    </div>
                                                </div>











                                            </div>







                                            <!-- ACCORDION -->


                                            <div class="hidden panel-group" id="accordion">
                                                <div class="panel panel-default template">
                                                    <div class="panel-heading">
                                                        <h4 class="panel-title">
                                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                                                Lote 1
                                                            </a> 
                                                        </h4>
                                                    </div>
                                                    <div id="collapseOne" class="panel-collapse collapse">
                                                        <div class="panel-body">

                                                            <div class="col-lg-6 yes">
                                                                <!-- Campos do Formulário -->

                                                                <div class="form-group">
                                                                    <label>Código do Lote</label>
                                                                    <input class="form-control" id="codigoLote" name="codigoLote" placeholder="Insira o código do lote" disabled>
                                                                    <p class="help-block">Deixe em branco para auto-gerar código</p>
                                                                </div>

                                                                <div class="col-lg-6 yes">
                                                                    <label>Data de Fabricação</label>
                                                                    <div class="form-group input-group"  data-date-format="dd-mm-yyyy">
                                                                        <input class="form-control" id="dataFabricacao" name="dataFabricacao" data-date-format="dd/mm/yyyy" placeholder="Clique e selecione" disabled>
                                                                    </div>

                                                                </div>
                                                                <div class="col-lg-6    yes">

                                                                    <label>Data de Validade</label>
                                                                    <div class="form-group input-group" data-date-format="dd-mm-yyyy">
                                                                        <input class="form-control" id="dataValidade" name="dataValidade"  data-date-format="dd/mm/yyyy" placeholder="Clique e selecione" disabled>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <!-- /.col-lg-6 (nested) -->
                                                            <div class="col-lg-6">

                                                                <div class="form-group">
                                                                    <label>Unidades de Produto</label>
                                                                    <input class="form-control" id="quantidadeProduto" name="quantidadeProduto" placeholder="Insira a quantidade do produto no lote" disabled>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label>Observações</label>
                                                                    <textarea class="form-control" id="observacoes" name="observacoes" rows="2" disabled></textarea>
                                                                </div>

                                                            </div>

                                                            <div class="col-lg-3">

                                                            </div>
                                                            <div class="col-lg-9">

                                                            </div>
                                                            <div class="col-lg-2">
                                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#selecionarLote">Selecionar Lote</button>
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




                            <div class="row">
                                <div class="col-lg-4 yes">
                                </div>
                                <div class="col-lg-3 yes">
                                </div>
                                <div class="col-lg-4 yes">
                                    <label>Valor Total</label>

                                    <div class="form-group input-group">
                                        <span class="input-group-addon">R$</span>
                                        <input type="text" class="form-control" id="valorTotal" name="valorTotal" placeholder="Valor total da venda" disabled>
                                    </div>

                                </div>
                                <hr width="85%">
                            </div>
                            <!-- /.panel-body -->

                            <div class="row">
                                <div class="col-lg-4">
                                </div>
                                <div class="col-lg-4">
                                </div>
                                <div class="col-lg-4">
                                    <!-- Button Limp3r Campos -->
                                    <button type="reset" id="resetVenda" class="btn btn-danger">Limpar Campos</button>

                                    <button id="inserirVenda" type="submit" class="btn btn-success">Efetuar Venda</button>
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

                            </tr>
                        </thead>

                        <tfoot>
                            <tr>
                                <th>Nome do Cliente</th>
                                <th>CNPJ</th>

                            </tr>
                        </tfoot>

                        <tbody>
                            <% for (int i = 0; i < clientes.size(); i++) {
                            %>
                            <tr>
                                <td> <%=clientes.get(i).getNome()%> </td>
                                <td> <%=clientes.get(i).getCNPJ()%> </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="selectClient" class="btn btn-primary" data-dismiss="modal">Selecionar Cliente</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- Modal -->
    <div class="modal fade" id="selecionarProduto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
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

                        <tfoot>
                            <tr>
                                <th>Código</th>
                                <th>Nome do Produto</th>
                                <th>Tipo</th>
                                <th hidden="">Valor Unitário</th>

                            </tr>
                        </tfoot>

                        <tbody>
                            <%
                                for (int i = 0; i < produtos.size(); i++) {
                            %>
                            <tr>
                                <td><%= produtos.get(i).getCodProd()%></td>
                                <td><%= produtos.get(i).getNome()%></td>
                                <td><%= produtos.get(i).getRamo()%></td>
                                <td hidden=""><%= produtos.get(i).getValorUnitario()%></td>

                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="selectProduct"  data-dismiss="modal">Selecionar Produto</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- Modal Selecionar Lote -->
    <div class="modal fade" id="selecionarLote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Selecionar Lote</h4>
                </div>
                <div class="modal-body">
                    <table id="loadLote" class="hover table table-striped table-bordered" cellspacing="0" width="100%" style="cursor: pointer;">
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Unidades</th>
                                <th>Data de Fabricação</th>
                                <th>Data de Validade</th>

                            </tr>
                        </thead>

                        <tfoot>
                            <tr>
                                <th>Código</th>
                                <th>Unidades</th>
                                <th>Data de Fabricação</th>
                                <th>Data de Validade</th>

                            </tr>
                        </tfoot>

                        <tbody>
                            <tr>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Garrett Winters</td>
                                <td>Accountant</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Ashton Cox</td>
                                <td>Junior Technical Author</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Cedric Kelly</td>
                                <td>Senior Javascript Developer</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Airi Satou</td>
                                <td>Accountant</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Brielle Williamson</td>
                                <td>Integration Specialist</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Herrod Chandler</td>
                                <td>Sales Assistant</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Rhona Davidson</td>
                                <td>Integration Specialist</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Colleen Hurst</td>
                                <td>Javascript Developer</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Sonya Frost</td>
                                <td>Software Engineer</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Jena Gaines</td>
                                <td>Office Manager</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Quinn Flynn</td>
                                <td>Support Lead</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Charde Marshall</td>
                                <td>Regional Director</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Haley Kennedy</td>
                                <td>Senior Marketing Designer</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Tatyana Fitzpatrick</td>
                                <td>Regional Director</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Michael Silva</td>
                                <td>Marketing Designer</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Paul Byrd</td>
                                <td>Chief Financial Officer (CFO)</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Gloria Little</td>
                                <td>Systems Administrator</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Bradley Greer</td>
                                <td>Software Engineer</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Dai Rios</td>
                                <td>Personnel Lead</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Jenette Caldwell</td>
                                <td>Development Lead</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>
                            <tr>
                                <td>Yuri Berry</td>
                                <td>Chief Marketing Officer (CMO)</td>
                                <td>Tiger Nixon</td>
                                <td>System Architect</td>

                            </tr>

                        </tbody>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button"  class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="selectLote" class="btn btn-primary" data-dismiss="modal">Selecionar Lote</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->


    <!-- /#wrapper -->
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>

</body>

</html>