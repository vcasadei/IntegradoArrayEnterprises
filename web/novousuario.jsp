<!DOCTYPE html>
<html lang="pt-br">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Chamadas de Scripts -->
    <script src="js/jquery-1.11.1.js"></script>
    <!-- /#wrapper -->
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <script src="js/jasny-bootstrap.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js"></script>



    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>

    <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
    <script  src="js/bootstrapValidator.js"></script>
    
    <style type="text/css">

    </style>

    <!-- Chamada para menu topo -->
    <script>
        $( document ).ready(function() {
            $('#header2').load('header.html');
        });

    </script>

    <script>
        $(document).ready(function() {
            $('#usuarioForm').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    nomeUsuario: {
                        message: 'O nome do usu�rio N�o v�lido',
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira o nome do usu�rio'
                            },
                            stringLength: {
                                min: 6,
                                max: 10,
                                message: 'O nome do usu�rio deve ter entre 6 e 30 caracteres'
                            },
                            regexp: {
                                regexp: /[a-zA-Z]+$/,
                                message: 'O nome do usu�rio deve conter apenas letras'
                            }
                        }
                    },
                    senhaUser: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira a senha do usu�rio'
                            },
                            different: {
                                field: 'nomeUsuario',
                                message: 'A senha e o nome de usu�rio n�o podem ser iguais'
                            },
                            stringLength: {
                                min: 6,
                                max: 10,
                                message: 'A senha deve ter entre 6 e 16 caracteres'
                            },
                            regexp: {
                                regexp: /[\S]+$/,
                                message: 'A senha n�o deve conter espa�os'
                            }
                        }
                    },
                    emailUser: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira o email do usu�rio'
                            },
                            emailUser: {
                                message: 'O email inserido n�o v�lido'
                            },
                            emailAddress: {
                                message: 'O email inserido n�o v�lido'
                            }
                        }
                    },
                    tipoUsuario: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, selecione o tipo do usu�rio'
                            }
                        }
                    }
                },
                submitHandler: function(validator, form, submitButton) {
                    var fullName = validator.getFieldElements('nomeUsuario').val();
                    alert('Hello ' + fullName);
                }
            });
});
</script>


<!-- Funcao para validaçao e captação de dados de form -->
<script>
$( document ).ready(function() {
        // $( "#enviarUser" ).click(function() {
        //     var nomeCliente, cnpjCliente, ruaCliente, numeroRua, telefoneCliente;

        //     nomeCliente = $('#nomeCliente').val();
        //     cnpjCliente = $('#cnpjCliente').val();
        //     ruaCliente = $('#ruaCliente').val();
        //     numeroRua = $('#numeroRua').val();
        //     telefoneCliente = $('#telefoneCliente').val();

        //         // Array com dados do form
        //         var auxArray = [nomeCliente, cnpjCliente, ruaCliente, numeroRua, telefoneCliente];
        //         alert(auxArray);
        //     });
});
</script>

<!-- Funcao para limpar campos de form -->
<script>
$( document ).ready(function() {
    $( "#resetCliente" ).click(function() {

        $('#usuarioForm').each (function(){
          this.reset();
        });
        $('#usuarioForm').bootstrapValidator('resetForm', true);
    });
});
</script>

<!-- Input somente de numeros -->
<script>
$(document).ready(function () {
            //called when key is pressed in textbox
            $("#numeroRua").keypress(function (e) {
                //if the letter is not digit then display error and don't type anything
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    //display error message
                    //$("#errmsg").html("Digits Only").show().fadeOut("slow");
                    return false;
                }
            });
        });
</script>


<title>Cadastro de Cliente - ArrayEnterprises</title>

<!-- Bootstrap Core CSS -->
<link href="css/meucss.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/jasny-bootstrap.css" rel="stylesheet">

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


        <div id="wrapper">
            <!-- Chamada para Menu topo -->
            <div id="header2"></div> 
            <!-- Fim de Menu topo -->

            <!--Início Menu lateral -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <!-- Barra de Pesquisa -->
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" name="pesquisaLateral" placeholder="Pesquisar...">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                        </li>
                        <li>
                            <a  href="index.html"><i class="fa fa-dashboard fa-fw"></i> Painel de Controle</a>
                        </li>

                        <li>
                            <a href="novousuario.jsp" class="active"><i class="fa fa-edit fa-fw"></i> Cadastro de usu�rio</a>
                        </li>

                        <li>
                            <a href="#"><i class="glyphicon glyphicon-shopping-cart fa-fw"></i> Vendas<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a class="acrtive" href="BuscaClientesProdutos">Efetuar Venda</a>
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

    <!--Fim Menu lateral -->


    <div id="page-wrapper">

     <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Cadastro de novo usu�rio</h1>
            <ol class="breadcrumb">
                <li>
                    <i class="fa fa-dashboard"></i>  <a href="index.html">Painel de Controle</a>
                </li>
                <li class="active">
                    <i class="fa fa-edit"></i> Cadastro de novo usu�rio
                </li>
            </ol>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <!-- Conte�do do Form -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <b>Items obrigat�rios est�o marcados com </b><span class="glyphicon glyphicon-asterisk req"></span>
                </div>
                <div class="panel-body">
                    <!-- Form de Cliente -->
                    <form id="usuarioForm" action="CadastrarUsuario" method="POST">
                        <div class="row">
                            <div class="col-lg-6 yes">
                                <!-- Campos do Formul�rio -->
                                <div class="form-group">
                                    <label>Nome do usu�rio <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <input type="text" class="form-control" id="nomeUsuario" name="nomeUsuario" placeholder="Insira o nome do usu�rio"  />
                                    
                                </div>

                                <div class="form-group">
                                    <label>Senha do usu�rio <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <input type="password" class="form-control" id="senhaUser" name="senhaUser" placeholder="Insira a senha do usu�rio" />
                                </div>


                            </div>
                            <!-- /.col-lg-6 (nested) -->
                            <div class="col-lg-6">

                                <div class="form-group">
                                    <label>Email do usu�rio <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <input type="email" class="form-control" id="emailUser" name="emailUser" placeholder="Insira o email do usu�rio" />
                                    
                                </div>

                                <div class="form-group" >
                                    <label>Tipo de usu�rio: <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <div class="radio">
                                        <label class="radio">
                                            <input type="radio" name="tipoUsuario" id="userAdmin" value="Administrador"    />Administrador
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label class="radio">
                                            <input type="radio" name="tipoUsuario" id="userNormal" value="Normal"  />Normal
                                        </label>
                                    </div>
                                </div>




                            </div>
                            <!-- /.col-lg-6 (nested) -->

                        </div>
                        <!-- /.row (nested) -->

                        <div class="form-group text-center">
                            <!-- Button Submit -->
                            <button  type="submit" id="enviarUser" name="enviarUser" class="btn btn-success">Enviar</button>

                            <!-- Button Limpar Campos -->
                            <button type="reset" id="resetCliente" class="btn btn-danger">Limpar Campos</button>
                        </div>
                    </form>

                </div>
                <!-- /.panel-body -->

                <!-- Show the messages in #errors -->

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


</body>

</html>
