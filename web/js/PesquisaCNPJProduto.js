

$(document).ready(function() {

    function pesquisarCNPJ() {
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

            } else {

                var aux = "";
                aux = data.split(";");

                $('#nomeClienteHidden').removeClass('hidden');
                $('#nomeCliente').val(aux[0]);
                $('#cnpjCliente').val(aux[1]);
                $('#pesquisaCNPJCliente').val("");

                $('#buttonSelectProduto').removeAttr("disabled");
            $('#buttonPesquisaNomeProduto').removeAttr("disabled");
            $('#pesquisaNomeProduto').removeAttr("disabled");
            $('#produtoPanel').fadeTo( "slow", 1 );
            }

        });
    }

    function pesquisarCodigo() {
        $.ajax({
            type: "GET",
            url: "BuscaClienteProdutoCNPJCod",
            dataType: "html",
            data: {cod: $('#pesquisaNomeProduto').val()}
        }).done(function(data) {

            if (data === "null") {
                //Criar mensagem que diz que o o produto com esse código não existe
                $('#erroPesquisaCodigo').fadeIn("slow");
                $('#pesquisaNomeProduto').val("");
                $('#nomeProduto').val("");
                $('#codigoProduto').val("");
                $('#valorUnitario').val("");
                var osRaio = $('input:radio[name=tipoProduto]');
                osRaio.filter('[value=medicamento]').attr('checked', false);
                osRaio.filter('[value=alimento]').attr('checked', false);
                

            } else {


                var aux = data.split(";");

                $('#hid').removeClass('hidden');
                $('#nomeProduto').val(aux[0]);
                $('#codigoProduto').val(aux[1]);
                //Seta o rádio do tipo do produto
                var osRaio = $('input:radio[name=tipoProduto]');
                if (aux[2] === "medicamento") {
                    osRaio.filter('[value=medicamento]').attr('checked', true);
                } else {
                    osRaio.filter('[value=alimento]').attr('checked', true);
                    console.log("Alimento");
                }
                $('#valorUnitario').val(aux[3]);
                $('#pesquisaNomeProduto').val("");

                setTimeout(
                      function() 
                      {
                        //do something special
                        $('#quantidadeProduto').prop('autofocus',true);
                        $('#quantidadeProduto').delay(200).focus();
                        $('#quantidadeProduto').tooltip({title : 'Insira a quantidade e clique em Lote Automático',
            placement : 'left',trigger: 'manual'}).tooltip('show');
                        
                      }, 
                500);


            }
        });
    }

     function pesquisarLotesAutomatico() {
         $.ajax({
            type: "POST",
            url: "BuscarLotesAutomatico",
            dataType: "html",
            data: {codigo:     $('#codigoProduto').val(),
                   quantidade: $('#quantidadeProduto').val() }
        }).done(function(data) {

            if (data === "null") {
                //Criar mensagem que diz que o cliente com esse cnpj não existe
                
            } else {

                var aux = data.split(";");

                
            }

        });
    }


        $('#pesquisaCNPJCliente').keypress(function(e) {
            if(e.which == 13) {
                pesquisarCNPJ();
            }
        });

        $('#pesquisaNomeProduto').keypress(function(e) {
            if(e.which == 13) {
                pesquisarCodigo();
            }
        });

    //Pesquisa um cliente pelo CNPJ
    $('#buttonpesquisaCNPJCliente').click(function() {
        pesquisarCNPJ();
    });

    //Pesquisa um produto pelo código
    $('#buttonPesquisaNomeProduto').click(function() {
        pesquisarCodigo();
    });

    //Pesquisa um produto pelo código
    $('#loteAutomatico').click(function() {
        pesquisarLotesAutomatico();
    });
});