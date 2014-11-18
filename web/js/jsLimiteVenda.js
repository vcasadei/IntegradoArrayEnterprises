$(document).ready(function() {

    

    sessionStorage.removeItem('dataProduto');
        sessionStorage.removeItem('dataLote');
        sessionStorage.removeItem('dataCliente');
    

    //Controle da Seleção da data da venda
    $('#dataVenda').datepicker().on('changeDate', function (ev) {
        $('#buttonSelectCliente').removeAttr("disabled");
        $('#buttonpesquisaCNPJCliente').removeAttr("disabled");
        $('#pesquisaCNPJCliente').removeAttr("disabled");
        $('#clientePanel').fadeTo( "slow", 1 );
        $(this).datepicker('hide');
    });

    //Quando um Cliente é Selecionado
    $('#buttonSelectCliente').click(function() {
        $('#selecionarCliente').modal('show');
        $('#pesquisaCNPJCliente').val("");
        $('#erroPesquisaCNPJ').fadeOut("slow");

        if($('#nomeClienteHidden').hasClass('hidden')){

        } else {
            $('#nomeClienteHidden').addClass('hidden');
        }
        
        $('#nomeCliente').val("");
        $('#cnpjCliente').val("");
        $('#toProducts').attr("disabled", true);
    });

    //Quando um cliente é selecionado no modal
    $('#selectClient').click(function() {
                
        if ($('#loadProduto tbody tr').hasClass('selected')) {
            $('#load tbody tr').removeClass('selected');
        }

        if (auxSplit === "none") {
            console.log("Nada foi Selecionado");
            $('#modalErroDeSelecao').modal('show');


        } else {
            console.log("ALGO FOI SELECIONADO " + auxSplit);
            var auxNomeCliente = auxSplit[1];
            var auxCNPJ = auxSplit[2];
            var auxCodigo = auxSplit[3];
            var ramo = auxSplit[4];
            $('#nomeClienteHidden').removeClass('hidden');
            console.log(auxNomeCliente);
            console.log(auxCNPJ);
            console.log("Codigo: " + auxCodigo);
            $('#nomeCliente').val(auxNomeCliente);
            $('#cnpjCliente').val(auxCNPJ);
            $('#codigoCliente').val(auxCodigo);
            $('#ramoCliente').val(ramo);
            auxSplit === "none";
            aux2 = "";
            auxNomeCliente = "";
            auxCNPJ = "";
            $('#selecionarCliente').modal('hide');
            $('#toProducts').removeAttr("disabled");
        }
        $('#erroPesquisaCNPJ').fadeOut(300);
    });

    //Quando fecha o erro de pesquisa de cliente
    $('#closeErroPesquisaCNPJ').click(function(){
        $('#erroPesquisaCNPJ').fadeOut(300);
    });

    $('#newLimiteDias').keypress(function (e) {
        var allowedChars = new RegExp("^[0-9]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (allowedChars.test(str)) {
            return true;
        }
        e.preventDefault();
        return false;
    }).keyup(function() {
        // the addition, which whill check the value after a keyup (triggered by Ctrl+V)
        // We take the same regex as for allowedChars, but we add ^ after the first bracket : it means "all character BUT these"
        var forbiddenChars = new RegExp("[^0-9]", 'g');
        if (forbiddenChars.test($(this).val())) {
            $(this).val($(this).val().replace(forbiddenChars, ''));
        }
    });

    //Para alterar o limite de vendas, chama MODAL
   $('#loadProduto tbody').on( 'click', 'button', function () {
        var data = table.row( $(this).parents('tr') ).data();
        var codProduto = data[0];
        var prodNome = data[1];
        var diasLimite = data[4];
        $('#modalProdNone').html(prodNome);
        $('#modalProdDias').html(diasLimite);
        $('#hidCodProd').val(codProduto);

        $('#modalAlterarLimite').modal('show');
        setTimeout(
            function ()
            {
                //do something special
                $('#newLimiteDias').prop('autofocus', true);
                $('#newLimiteDias').delay(200).focus();
            },
        500);

        //Implementar chamada AJAX
    });

    function alterarLimiteDias(dias){

        var dataString;
            dataString = "codProd=" + $('#hidCodProd').val().replace(/ /g, '') + "&diasLim=" + dias;
             $.ajax({
                type: "POST",
                url: "AlteraDataLimiteValidade",
                dataType: "text",
                data: dataString
            }).done(function(data) {
                testeData = data;

                if (data === "error" || data == "") {
                    console.log("deu erro " + data)
                    $('#qtdeEstoque').val("0");
                    $('#modalAlterarLimite').fadeTo( "fast", 0.2 );
                    $('#modalErroAlterar').modal('show');
                    
                } else {
                    console.log("parece que funfou: " + data)
                    $('#qtdeEstoque').val(data);
                    $('#modalAlterarLimite').fadeTo( "fast", 0.2 );
                    $('#modalSucessoAlterar').modal('show');
                }

            });
        }

    $('#modalErroAlterar').on('hidden.bs.modal', function () {
        $('#modalAlterarLimite').modal('hide');
    });

    $('#modalSucessoAlterar').on('hidden.bs.modal', function () {
        $('#modalAlterarLimite').modal('hide');
        window.location = "BuscaProdutosEstoque";
    });
    
    $('#alterarSim').click(function(){

        if( $('#newLimiteDias').val() != "" ){
            $('#erroDiasVazio').fadeOut(200);
            $('#nomeRelatorioInputGroup').removeClass('has-error');
            //chamada AJAX

            alterarLimiteDias($('#newLimiteDias').val().replace(/ /g, ''));
            
        } else {
            $('#erroDiasVazio').fadeIn(200);
            $('#nomeRelatorioInputGroup').addClass('has-error');
        }
    });
    
    $('#cancelarLimiteSim').click(function(){
        $('#newLimiteDias').val("");
    });

    //Inicia dataTable para clientes
    var table = $('#loadProduto').DataTable( {
        language: {
            url: 'localisation/Portuguese-Brasil.json'
        }
    } );


    var aux2 = "";
    var auxSplit = "none";


    

    $("#resetVenda").click(function() {
        limparFormulario();
    });

    function pesquisarCNPJ() {

        if($("#pesquisaCNPJCliente").val() != ""){
            $.ajax({
                type: "POST",
                url: "BuscaClienteProdutoCNPJCod",
                dataType: "html",
                data: {CNPJ: $('#pesquisaCNPJCliente').val()}
            }).done(function(data) {

                if (data === "null") {
                    //Criar mensagem que diz que o cliente com esse cnpj não existe

                    $('#pesquisaCNPJCliente').val("");
                    $('#erroPesquisaCNPJ').fadeIn("slow");
                    $('#nomeCliente').val("");
                    $('#cnpjCliente').val("");
                    $('#codigoCliente').val("");
                    $('#ramoCliente').val("");

                    $('#buttonSelectProduto').attr("disabled", true);
                    $('#buttonPesquisaNomeProduto').attr("disabled", true);
                    $('#pesquisaNomeProduto').attr("disabled", true);
                    $('#produtoPanel').fadeTo( "slow", 0.5 );
                    $('#inserirVenda').attr("disabled", "true");
                    $('#toProducts').attr("disabled", true);
                    $('.addedPanel').remove();
                    $('.addedRelatorio').remove();
                    $('.addedPrint').remove();

                    if($('#nomeClienteHidden').hasClass('hidden')){

                    } else {
                        $('#nomeClienteHidden').addClass('hidden');
                    }
                        

                } else {

                    var aux = "";
                    aux = data.split(";");

                    $('#nomeClienteHidden').removeClass('hidden');
                    $('#nomeCliente').val(aux[0]);
                    $('#cnpjCliente').val(aux[1]);
                    console.log("codigo do cliente " + aux[2])
                    $('#codigoCliente').val(aux[2]);
                    $('#ramoCliente').val(aux[3]);
                    $('#pesquisaCNPJCliente').val("");

                    $('#buttonSelectProduto').removeAttr("disabled");
                    $('#buttonPesquisaNomeProduto').removeAttr("disabled");
                    $('#pesquisaNomeProduto').removeAttr("disabled");
                    $('#produtoPanel').fadeTo( "slow", 1 );
                    $('#toProducts').removeAttr("disabled");
                    $('#erroPesquisaCNPJ').fadeOut(300);
                }

            });
        } else {
            $('#selecionarCliente').modal('show');
            $('#erroPesquisaCNPJ').fadeOut("slow");

            if($('#nomeClienteHidden').hasClass('hidden')){

            } else {
                $('#nomeClienteHidden').addClass('hidden');
            }
            
            $('#nomeCliente').val("");
            $('#cnpjCliente').val("");
            $('#toProducts').attr("disabled", true);
        } 
         
    }
    //Pesquisa um cliente pelo CNPJ
    $('#buttonpesquisaCNPJCliente').click(function() {
        if($("#pesquisaCNPJCliente").val() != ""){
            pesquisarCNPJ();
        } else {
            $('#selecionarCliente').modal('show');
            $('#erroPesquisaCNPJ').fadeOut("slow");

            if($('#nomeClienteHidden').hasClass('hidden')){

            } else {
                $('#nomeClienteHidden').addClass('hidden');
            }
            
            $('#nomeCliente').val("");
            $('#cnpjCliente').val("");
            $('#toProducts').attr("disabled", true);
        }
        
    });

    $('#pesquisaCNPJCliente').keypress(function(e) {
        if(e.which == 13) {
            if($("#pesquisaCNPJCliente").val() != "" && $("#pesquisaCNPJCliente").val() != "__.___.___/____-__"){
                console.log($("#pesquisaCNPJCliente").val())
                pesquisarCNPJ();
            } else {
                $('#selecionarCliente').modal('show');
                $('#erroPesquisaCNPJ').fadeOut("slow");

                if($('#nomeClienteHidden').hasClass('hidden')){

                } else {
                    $('#nomeClienteHidden').addClass('hidden');
                }
                
                $('#nomeCliente').val("");
                $('#cnpjCliente').val("");
                $('#toProducts').attr("disabled", true);
            }
        }
    });



    function limparFormulario(){
        $('#dataVenda').val('');
        $('#buttonSelectCliente').prop("disabled",true);
        $('#buttonpesquisaCNPJCliente').prop("disabled",true);
        $('#pesquisaCNPJCliente').prop("disabled",true);
        $('#clientePanel').fadeTo( "slow", 0.5 );


        if($('#nomeClienteHidden').hasClass('hidden')){

        } else {
            $('#nomeClienteHidden').addClass('hidden');
        }


        $('#pesquisaCNPJCliente').val('');
        $('#nomeCliente').val('');
        $('#cnpjCliente').val('');
        $('#codigoCliente').val('');
        $('#ramoCliente').val('');
        $('#toProducts').prop("disabled",true);
        $('#formVenda').bootstrapValidator('resetForm', true);
    }

    $('#toProducts').click(function(){
        var dataVenda = $('#dataVenda').val().replace(/ /g, '');
        var codCliente = $('#codigoCliente').val().replace(/ /g, '');
        var ramoCliente = $('#ramoCliente').val().replace(/ /g, '');
        var nomeCliente = $('#nomeCliente').val();
        var cnpjCliente = $('#cnpjCliente').val().replace(/ /g, '');
        var ramoCliente = $('#ramoCliente').val().replace(/ /g, '');

        var venda = [{
            dataVenda: dataVenda,
            codCliente: codCliente,
            ramoCliente: ramoCliente,
            nomeCliente: nomeCliente,
            cnpjCliente: cnpjCliente,
            ramoCliente: ramoCliente
        }];
        var jsonStr = JSON.stringify( venda );
        console.log(jsonStr);

        sessionStorage.setItem( "dataCliente", jsonStr );
        // now the cart is {"item":"Product 1","price":35.50,"qty":2}
        var dataClienteValue = sessionStorage.getItem( "dataCliente" );
        console.log(dataClienteValue);
        var vendaObj = JSON.parse( dataClienteValue );
        console.log(vendaObj);
        console.log(sessionStorage.getItem( "dataCliente" ) );
        // original object
        window.location.href = "/ArrayEnterprises/BuscaTodosProdutos";
    });

    $('#cancelarVenda').click(function() {
        sessionStorage.removeItem('dataProduto');
        sessionStorage.removeItem('dataLote');
        sessionStorage.removeItem('dataCliente');
        window.location.href = "/ArrayEnterprises/index.html";
    });





});