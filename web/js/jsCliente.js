$(document).ready(function() {

    $('#header2').load('header.html');


    sessionStorage.clear();
    

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
    });

    //Quando um cliente é selecionado no modal
    $('#selectClient').click(function() {
                
        if ($('#loadCliente tbody tr').hasClass('selected')) {
            $('#load tbody tr').removeClass('selected');
        }

        if (auxSplit === "none") {
            console.log("Nada foi Selecionado");
            $('#modalErroDeSelecao').modal('show');


        } else {
            console.log("ALGO FOI SELECIONADO");
            var auxNomeCliente = auxSplit[1];
            var auxCNPJ = auxSplit[2];
            var auxCodigo = auxSplit[3];
            // var ramo = auxsplit[4];
            $('#nomeClienteHidden').removeClass('hidden');
            console.log(auxNomeCliente);
            console.log(auxCNPJ);
            console.log("Codigo: " + auxCodigo);
            $('#nomeCliente').val(auxNomeCliente);
            $('#cnpjCliente').val(auxCNPJ);
            $('#codigoCliente').val(auxCodigo);
            // $('#ramoCliente').val(ramo);
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

    //Inicia dataTable para clientes
    var table = $('#loadCliente').DataTable( {
        language: {
            url: 'localisation/Portuguese-Brasil.json'
        }
    } );


    var aux2 = "";
    var auxSplit = "none";

    //Tratamento de seleção na dataTable de cliente
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

    $("#resetVenda").click(function() {
        limparFormulario();
    });

    function limparFormulario(){
        $('#dataVenda').val('');
        $('#buttonSelectCliente').prop("disabled",true);
        $('#buttonpesquisaCNPJCliente').prop("disabled",true);
        $('#pesquisaCNPJCliente').prop("disabled",true);
        $('#clientePanel').fadeTo( "slow", 0.5 );
        


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

        var venda = [{
            dataVenda: dataVenda,
            codCliente: codCliente,
            ramoCliente: ramoCliente,
            nomeCliente: nomeCliente,
            cnpjCliente:cnpjCliente
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
        sessionStorage.clear();
        window.location.href = "/ArrayEnterprises/index.html";
    });



});