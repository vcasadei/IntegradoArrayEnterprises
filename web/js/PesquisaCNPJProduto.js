

$(document).ready(function() {
    $('#buttonpesquisaCNPJCliente').click(function() {
        $.ajax({
            type: "POST",
            url: "BuscaClienteProdutoCNPJCod",
            dataType: "html",
            data: {CNPJ: $('#pesquisaCNPJCliente').val()}
        }).done(function(data) {

            var aux = "";
            aux = data.split(";");

            $('#nomeClienteHidden').removeClass('hidden');
            $('#nomeCliente').val(aux[0]);
            $('#cnpjCliente').val(aux[1]);
        });
    });

});