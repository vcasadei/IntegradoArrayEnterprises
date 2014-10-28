$(document).ready(function() {

   

    if(sessionStorage.length != 0 && sessionStorage.getItem( "dataCliente" ) != null){
        var sessao = sessionStorage.getItem( "dataCliente" );
        console.log(sessao);
        var clienteObj = JSON.parse( sessao );
        dataVenda = clienteObj[0].dataVenda;
        codCliente = clienteObj[0].codCliente;
        ramoCliente = clienteObj[0].ramoCliente;
        nomeCliente = clienteObj[0].nomeCliente;
        cnpjCliente = clienteObj[0].cnpjCliente;
        $("#fixDataVenda").val(dataVenda);
        $("#nomeCliente").val(nomeCliente);
        $("#cnpjCliente").val(cnpjCliente);
        $("#codigoCliente").val(codigoCliente);
        $("#ramoCliente").val(ramoCliente);

        

        var produto = sessionStorage.getItem( "dataProduto" );
        if(produto == '[]'){
            rows = [];
            $('#total').val(0);
            $('#terminarCompra').prop("disabled",true);

        } else {
            var produtoObj = JSON.parse( produto );
            console.log(produtoObj);
            $('#nomeProduto').text(produtoObj[0].nomeProduto);
            $('#tipoProduto').text(produtoObj[0].tipoProduto);
            $('#codigoProduto').text(produtoObj[0].codigoProduto);
            var quantidade = produtoObj[0].quantidadeProduto.replace(/ /g, '');
            $('#quantidade').val(quantidade);
            var valorUnitario = produtoObj[0].valorUnitario.replace(/ /g, '');
            $('#valorUnitario').text(valorUnitario);
            quantidade = parseInt(quantidade);
            valorUnitario = parseInt(valorUnitario);
            var valorTotal = quantidade * valorUnitario;
            $('#valorTotal').text(valorTotal);
            $('#totalCompra').text(valorTotal);

            console.log(produtoObj.length);

            var j = 0;
            for(j = 0; j < 5; j++){
                console.log(j);
            }
                
            var rows = [];
            var i = 0

            operateAux =  '<button type="button" class="btn btn-danger remove ml10" href="javascript:void(0)">' + 
            '<span class="glyphicon glyphicon-trash"></span>'+
            ' Remover</button>'

            var codigo, produtoNome, tipoProduto, quantidadePro, valor, total, compraTotal;
            compraTotal = 0;
            for (i = 0; i < produtoObj.length; i++) {
                quantidadePro, valor, total = 0;
                console.log(i);
                codigo = produtoObj[i].codigoProduto;
                console.log(codigo);
                produtoNome = produtoObj[i].nomeProduto;
                tipoProduto = produtoObj[i].tipoProduto;
                quantidadePro = produtoObj[i].quantidadeProduto.replace(/ /g, '');
                valor = produtoObj[i].valorUnitario.replace(/ /g, '');
                quantidadePro = parseInt(quantidadePro);
                valor = parseInt(valor);
                total = quantidadePro * valor;
                compraTotal = compraTotal + total;

                rows.push({
                    
                    id: i,
                    codigoProduto: codigo,
                    produto: produtoNome,
                    tipo: tipoProduto,
                    quantidade: quantidadePro,
                    preco: 'R$ ' + valor,
                    subtotal: 'R$ ' + total,
                    operate: operateAux
                });
                
             }
             console.log(rows);
             $('#total').val(compraTotal);
             $('#terminarCompra').prop("disabled",false);
        }
    } else {
        var rows = [];
        $('#terminarCompra').prop("disabled",true);
    }
    

    

            

    // init table use data
    $(function () {
                $table = $('#table-methods-table').bootstrapTable({
                    data: rows
                    
                    
                });

    $('#btnDelteYes').click(function () {
        var id = $('#modalExcuirProduto').data('id');
        alert('current data: ' + JSON.stringify($table.bootstrapTable('getData')));
        $('#table-methods-table').bootstrapTable('remove', {
            field: 'id',
            values: [id]
        });
        $('#modalExcuirProduto').modal('hide');
        // alert('current data: ' + JSON.stringify($table.bootstrapTable('getData')));
        var auxLote = sessionStorage.getItem('dataLote');
        auxLote = JSON.parse(auxLote);
        var auxSaveLote = [];
        


        var auxTeste = $table.bootstrapTable('getData');
        if(auxTeste.length == 0){
            $('#total').val(0);
            $('#terminarCompra').prop("disabled",true);
        }
        console.log("aux teste ", auxTeste);
        var jsonData = [];
        var auxJsonData;
        compraTotal = 0;
        for(var i = 0; i < auxTeste.length; i++){
            var cod = auxTeste[i].codigoProduto.replace(/ /g, '');
            // console.log(cod);
            var nome = auxTeste[i].produto;
            // console.log(nome);
            var tipos = auxTeste[i].tipo.replace(/ /g, '');
            // console.log(tipos);
            var valorUni = auxTeste[i].preco.replace(/ /g, '');
            valorUni = valorUni.replace(/R\$/g, '');
            var qtde = auxTeste[i].quantidade.toString();
            compraTotal = compraTotal + (parseInt(qtde) * parseInt(valorUni));
            $('#total').val(compraTotal);
            auxJsonData = {
                codigoProduto: cod,
                nomeProduto: nome,
                tipoProduto: tipos,
                valorUnitario: valorUni,
                quantidadeProduto: qtde
            }
            console.log(auxJsonData);
            jsonData.push(auxJsonData);

            for(var y = 0; y < auxLote.length; y++){
                if(auxLote[y].codProduto == cod){
                    auxSaveLote.push(auxLote[y]);

                }
            }

        }
        sessionStorage.setItem('dataProduto', JSON.stringify(jsonData));
        console.log(sessionStorage.getItem('dataProduto'));

        sessionStorage.setItem('dataLote', JSON.stringify(auxSaveLote));
        console.log(sessionStorage.getItem('dataLote'));

        
        
    });
});

    

    window.operateEvents = {
        'click .remove': function (e, value, row, index) {
            $('#modalExcuirProduto').data('id', row.id).modal('show');
        }
    };




            $('#get-selections').click(function () {
                alert('Selected values: ' + JSON.stringify($table.bootstrapTable('getSelections')));
            });
            $('#get-data').click(function () {
                alert('current data: ' + JSON.stringify($table.bootstrapTable('getData')));
            });
            // This demonstrates utilizing the data-method attribute to use one 
            //     jQuery handler to execute multiple methods. 
            // ($this).data('method') retrieves the value of the data-method 
            //     attribute of the object that was clicked which is then passed to 
            //     the bootstrapTable function. 
            // Only the load and append methods require a parameter                                 
            $('#load-data, #append-data, #check-all, #uncheck-all, ' +
                    '#show-loading, #hide-loading').click(function () {
                $table.bootstrapTable($(this).data('method'), getRows());
            });
            $('#refresh').click(function () {
                $table.bootstrapTable('refresh', {
                    url: 'data1.json'
                });
            });
            $('#remove-data').click(function () {
                var selects = $table.bootstrapTable('getSelections');
                    ids = $.map(selects, function (row) {
                        return row.id;
                    });

                $table.bootstrapTable('remove', {
                    field: 'id',
                    values: ids
                });
            });
            $('#update-row').click(function () {
                $table.bootstrapTable('updateRow', {
                    index: 1,
                    row: {
                        name: 'test111111',
                        price: '$111111'
                    }
                });
            });
            $('#merge-cells').click(function () {
                $table.bootstrapTable('mergeCells', {
                    index: 1,
                    field: 'name',
                    colspan: 2,
                    rowspan: 3
                })
            });
            $('#show-column, #hide-column').click(function () {
                $table.bootstrapTable($(this).data('method'), 'id');
            });            


    

    $('#closeErroNomeVazio').click(function(e){
        $('#erroNomeVazio').fadeOut(300);
    });


    // The function you currently have
    $('#nomeRelatorio').keypress(function (e) {
        var allowedChars = new RegExp("^[a-zA-Z0-9\-]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (allowedChars.test(str)) {
            return true;
        }
        e.preventDefault();
        return false;
    }).keyup(function() {
        // the addition, which whill check the value after a keyup (triggered by Ctrl+V)
        // We take the same regex as for allowedChars, but we add ^ after the first bracket : it means "all character BUT these"
        var forbiddenChars = new RegExp("[^a-zA-Z0-9\-]", 'g');
        if (forbiddenChars.test($(this).val())) {
            $(this).val($(this).val().replace(forbiddenChars, ''));
        }
    });

    $('#salvarRelatorio').click(function() {

        var auxDataVenda = $('#dataVenda').val();
        auxDataVenda = auxDataVenda.replace(/\//g, "-");

        $('#nomeRelatorio').val('RelatorioVendas' + auxDataVenda);
        $('#salvarRelatorioComo').modal('show');

    });

    $('#newProduct').click(function() {
        window.location.href = "/ArrayEnterprises/BuscaTodosProdutos";
    });

    $('#terminarCompra').click(function() {
        var sessao = sessionStorage.getItem( "dataCliente" );
        var clienteObj = JSON.parse( sessao );
        auxDataVenda = clienteObj[0].dataVenda;
        auxDataVenda = auxDataVenda.replace(/\//g, "-");

        $('#nomeRelatorio').val('RelatorioVendas' + auxDataVenda);
        $('#salvarRelatorioComo').modal('show');
        console.log("clicou para salvar");
    });

    $('#cancelarVenda').click(function() {
        $('#alertaCancelarVenda').modal('show');
    });

    $('#simCancelarVenda').click(function() {
        sessionStorage.removeItem('dataProduto');
        sessionStorage.removeItem('dataLote');
        sessionStorage.removeItem('dataCliente');
        window.location.href = "/ArrayEnterprises/index.html";
    });
    

});