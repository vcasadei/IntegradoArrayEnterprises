$(document).ready(function() {

    

    sessionStorage.removeItem('dataProduto');
        sessionStorage.removeItem('dataLote');
        sessionStorage.removeItem('dataCliente');



    //Para a produção do Relatório
   $('#loadVenda tbody').on( 'click', 'button', function () {
        var data = table.row( $(this).parents('tr') ).data();
        var codVenda = data[0].replace(/ /g, '');
        var dataVenda = data[1];
        var clienteNome = data[2];
        var totalvenda = data[3];
        //Implementar chamada AJAX
        console.log("clicou!");
        getVendaData(codVenda);


    } );

    //Inicia dataTable para clientes
    var table = $('#loadVenda').DataTable( {
        language: {
            url: 'localisation/Portuguese-Brasil.json'
        }
    } );


    var aux2 = "";
    var auxSplit = "none";


    function getVendaData(codigoVenda){
        var dataString;
        dataString = "codVenda=" + codigoVenda;
        console.log(dataString);
         $.ajax({
            type: "POST",
            url: "BuscaDadosRelatorio",
            dataType: "text",
            data: dataString
        }).done(function(data) {
            auxData = data.split(';');
            if(auxData[0] == "success"){
                console.log("Sucesso + " + data)
                gerarRelatorioPorVenda(data);
            } else {
                //Error
                console.log("Erro: " + data);
                $('#erroRelatorio').modal('show');
            }
        });

    }



});