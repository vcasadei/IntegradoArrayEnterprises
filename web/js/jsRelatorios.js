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
                
        if ($('#loadVenda tbody tr').hasClass('selected')) {
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

    //Para a produção do Relatório
   $('#loadVenda tbody').on( 'click', 'button', function () {
        var data = table.row( $(this).parents('tr') ).data();
        var codVenda = data[0];
        var dataVenda = data[1];
        var clienteNome = data[2];
        var totalvenda = data[3];
        //Implementar chamada AJAX
        console.log("clicou!");
    } );

    //Inicia dataTable para clientes
    var table = $('#loadVenda').DataTable( {
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