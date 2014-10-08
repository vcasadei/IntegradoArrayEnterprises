

$(document).ready(function() {
    $('#buttonpesquisaCNPJCliente').click(function(){
       $.ajax({
        type: "POST",
        url: "BuscaClienteCNPJ",
        dataType: "html",
        data: {CNPJ: $('#pesquisaCNPJCliente').val() }
      }).done(function(data){
        
        if (data === "null"){
            /*Exibe mensagem de cliente não encontrado*/
        } else {
            
            var vetorDados = "";
            vetorDados = data.split(";");
            
            $('#nomeClienteHidden').removeClass('hidden');
            $('#cnpjCliente').val(vetorDados[1]);
            $('#nomeCliente').val(vetorDados[0]);
        }
        
      }); 
    });

});