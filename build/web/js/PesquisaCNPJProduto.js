

$(document).ready(function() {

    //Pesquisa um cliente pelo CNPJ
    $('#buttonpesquisaCNPJCliente').click(function() {
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
            } else {

                var aux = "";
                aux = data.split(";");

                $('#nomeClienteHidden').removeClass('hidden');
                $('#nomeCliente').val(aux[0]);
                $('#cnpjCliente').val(aux[1]);
                $('#pesquisaCNPJCliente').val("");
            }

        });
    });

    //Pesquisa um produto pelo código
    $('#buttonPesquisaNomeProduto').click(function() {
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
            }
        });
    });
});