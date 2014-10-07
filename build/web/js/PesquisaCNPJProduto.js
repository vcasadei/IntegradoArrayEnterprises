

$(document).ready(function() {
    $('#buttonpesquisaCNPJCliente').click(function(){
       $.ajax({
        type: "POST",
        url: "BuscaClienteCNPJ",
        dataType: "html",
        data: {CNPJ: $('#pesquisaCNPJCliente').val() }
      }).done(function(data){
          
         var aux = "";
         aux = data.toString();
         
          
        $('#nomeCliente').val();
        $('#cnpjCliente').val();
      }); 
    });

});