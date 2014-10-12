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

            $('#usuarioForm').bind("keyup keypress", function(e) {
                  var code = e.keyCode || e.which; 
                  if (code  == 13) {               
                    e.preventDefault();
                    return false;
                  }
                });

            $( "#resetCliente" ).click(function() {
                limparCampos();
            });

            function limparCampos(){
                $('#usuarioForm').each (function(){
                  this.reset();
                });
                $('#usuarioForm').bootstrapValidator('resetForm', true);
            }

        $("#enviarUser").click(function(e){
            $('#usuarioForm').bootstrapValidator('validate');
            
            
        });



            $('#usuarioForm').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    nomeUsuario: {
                        message: 'O nome do usuário Não válido',
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira o nome do usuário'
                            },
                            stringLength: {
                                min: 6,
                                max: 20,
                                message: 'O nome do usuário deve ter entre 6 e 20 caracteres'
                            },
                            regexp: {
                                regexp: /[a-zA-Z]+$/,
                                message: 'O nome do usuário deve conter apenas letras'
                            }
                        }
                    },
                    senhaUser: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira a senha do usuário'
                            },
                            different: {
                                field: 'nomeUsuario',
                                message: 'A senha e o nome de usuário não podem ser iguais'
                            },
                            stringLength: {
                                min: 6,
                                max: 15,
                                message: 'A senha deve ter entre 6 e 15 caracteres'
                            },
                            regexp: {
                                regexp: /[\S]+$/,
                                message: 'A senha não deve conter espaços'
                            }
                        }
                    },
                    emailUser: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira o email do usuário'
                            },
                            emailUser: {
                                message: 'O email inserido não válido'
                            },
                            emailAddress: {
                                message: 'O email inserido não válido'
                            }
                        }
                    },
                    tipoUsuario: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, selecione o tipo do usuário'
                            }
                        }
                    }
                },
                submitHandler: function(validator, form, submitButton) {
                    
                }
            }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();

                var varUsername =  $('#nomeUsuario').val();
                var varPassword = $('#senhaUser').val();
                var varEmail = $('#emailUser').val();
                var varTipoUser = $('input[name=tipoUsuario]:checked', '#usuarioForm').val();

                    var dataString;
                    dataString = "nomeUsuario=" + varUsername + "&senhaUser=" + varPassword + "&emailUser=" + varEmail + "&tipoUsuario=" + varTipoUser;
                    $.ajax({
                        type: "POST",
                        url: "CadastrarUsuario",
                        dataType: "json",
                        data: dataString,
                        //if received a response from the server
                        success: function( data) {
                             if(data.success){
                                $('#userInserted').val(varUsername);
                                $('#sucessoInserção').modal('show');
                                limparCampos();
                                 


                             } 
                             else {
                                    limparCampos();
                                    $('#erroInserção').modal('show');
                                        
                             }
                        },
                        
                        //If there was no resonse from the server
                        error: function(){
                            limparCampos();
                            $('#erroInserção').modal('show');
                              
                        }
                            });
        });
});
</script>


<!-- Funcao para validaÃ§ao e captaÃ§Ã£o de dados de form -->
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

            <!--InÃ­cio Menu lateral -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a  href="index.html"><i class="fa fa-dashboard fa-fw"></i> Painel de Controle</a>
                        </li>

                        <li>
                            <a href="novousuario.jsp" class="active"><i class="fa fa-edit fa-fw"></i> Cadastro de usuário</a>
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
            <h1 class="page-header">Cadastro de novo usuário</h1>
            <ol class="breadcrumb">
                <li>
                    <i class="fa fa-dashboard"></i>  <a href="index.html">Painel de Controle</a>
                </li>
                <li class="active">
                    <i class="fa fa-edit"></i> Cadastro de novo usuário
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
                    <b>Items obrigatórios estão marcados com </b><span class="glyphicon glyphicon-asterisk req"></span>
                </div>
                <div class="panel-body">
                    <!-- Form de Cliente -->
                    <form id="usuarioForm" >
                        <div class="row">
                            <div class="col-lg-6 yes">
                                <!-- Campos do Formulário -->
                                <div class="form-group">
                                    <label>Nome do usuário <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <input type="text" class="form-control" id="nomeUsuario" name="nomeUsuario" placeholder="Insira o nome do usuário"  />
                                    
                                </div>

                                <div class="form-group">
                                    <label>Senha do usuário <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <input type="password" class="form-control" id="senhaUser" name="senhaUser" placeholder="Insira a senha do usuário" />
                                </div>


                            </div>
                            <!-- /.col-lg-6 (nested) -->
                            <div class="col-lg-6">

                                <div class="form-group">
                                    <label>Email do usuário <span class="glyphicon glyphicon-asterisk req"></span></label>
                                    <input type="email" class="form-control" id="emailUser" name="emailUser" placeholder="Insira o email do usuário" />
                                    
                                </div>

                                <div class="form-group" >
                                    <label>Tipo de usuário: <span class="glyphicon glyphicon-asterisk req"></span></label>
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
                        <hr width="85%">
                        <!-- /.row (nested) -->
                        

                            <!-- Button Submit -->
                        <div class="row">
                            <div class="col-lg-4">
                            </div>
                            <div class="col-lg-4">
                            </div>
                            <div class="col-lg-4">
                            <!-- Button Limpar Campos -->
                                <button type="reset" id="resetCliente" class="btn btn-danger"><span class="glyphicon glyphicon-repeat" style="color:white;"></span>&nbsp; Limpar Campos</button>

                                <button  type="button" id="enviarUser" name="enviarUser" class="btn btn-primary"><span class="glyphicon glyphicon-check" style="color:white;"></span>&nbsp; Cadastrar</button>
                            </div>
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

     <!-- Modal confirmação de salvamento -->
        <div class="modal fade bs-example-modal-sm2" id="sucessoInserção"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel2" aria-hidden="true">
          <div class="modal-dialog modal-sm vertical-centered " >
            <div class="modal-content">
              <div class="modal-header" style="background-color:#5cb85c;">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-ok" style="color:white;"></span>&nbsp;&nbsp;Usuário Inserido com Sucesso</h4>
              </div>
              <div class="modal-body">
                    <span>Usuário <b id="userInserted"></b> foi inserido com sucesso!</span>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <!-- Modal confirmação de salvamento -->
        <div class="modal fade bs-example-modal-sm2" id="erroInserção"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel2" aria-hidden="true">
          <div class="modal-dialog vertical-centered " >
            <div class="modal-content">
              <div class="modal-header" style="background-color:#d9534f;">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
                <h4 class="modal-title " style="color:white;"><span class="glyphicon glyphicon-warning-sign" style="color:white;"></span>&nbsp;&nbsp;Erro no cadastro de usuário</h4>
              </div>
              <div class="modal-body" id="cadastroMensagemErro">
                    <span>Algum erro ocorreu no cadastro de usuário. Possíveis causas:</span>
                    <ul>
                        <li><b>O usuário já existe na base de dados.</b></li>
                        <li><b>Houve falha na comunicação com a base de dados.</b> Contate o suportes</li>
                    </ul>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
</div>
<!-- /#page-wrapper -->


</body>

</html>
