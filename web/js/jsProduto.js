$(document).ready(function () {


    var sessao = sessionStorage.getItem( "dataCliente" );
    var clienteObj = JSON.parse( sessao );
    dataVenda = clienteObj[0].dataVenda;
    codCliente = clienteObj[0].codCliente;
    ramoCliente = clienteObj[0].ramoCliente;
    nomeCliente = clienteObj[0].nomeCliente;
    cnpjCliente = clienteObj[0].cnpjCliente;
    ramoCliente = clienteObj[0].ramoCliente;
    $("#fixDataVenda").val(dataVenda);
    $("#nomeCliente").val(nomeCliente);
    $("#spanNomeCliente").html(nomeCliente);
    $("#cnpjCliente").val(cnpjCliente);
    $("#spanCNPJCliente").html(cnpjCliente);
    $("#codigoCliente").val(codigoCliente);
    $("#ramoCliente").val(ramoCliente);
    $loteTable = $('#table-methods-table');

    console.log(clienteObj);

    var qtdeFaltando;
    var rowsSelecionados = [];


    var rows = [];


    $("tr.item").each(function(i, tr) {
        var value = $(tr + " span.value").html();
        var quantity = $(tr + " input.quantity").val();
    });

 
    
    

    $('#closeErroNomeVazio').click(function (e) {
        $('#erroNomeVazio').fadeOut(300);
    });

    $('#closeErroNomeVazio').click(function (e) {
        $('#erroLotesManual').fadeOut(300);
    });



    $('#buttonSelectProduto').click(function () {
        $('#formGroupQuantidadeProduto').removeClass('has-error');
        $('.help-block').fadeOut(10);

        $('#selecionarProduto').modal('show');
        $loteTable.bootstrapTable('destroy');
        $('#groupUnidadesFalta').fadeOut('fast');

        $('#erroPesquisaCodigo').fadeOut("slow");
        $('#pesquisaNomeProduto').val("");
        $('#nomeProduto').val("");
        $('#codigoProduto').val("");
        $('#valorUnitario').val("");
        if($('#optionsAlimento').is(':checked')){
            $('#optionsAlimento').prop('checked', false);
            console.log("Alimento esta selcionado")
        }
        if($('#optionsMedicamento').is(':checked')){
            $('#optionsMedicamento').prop('checked', false);
            console.log("Medicamento esta selcionado")
        }
 
        $('.addedPanel').remove();
        $('.addedRelatorio').remove();
        $('.addedPrint').remove();
        $('#addToCart').attr('disabled', true);
        $('#quantidadeProduto').val("");
        $('#formGroupQuantidadeProduto').removeClass('has-success');

        if ($('#produtoHidden').hasClass('hidden')) {

        } else {
            $('#produtoHidden').addClass('hidden');
        }
    });



    $('#closeErroPesquisaCodigo').click(function () {
        $('#erroPesquisaCodigo').fadeOut(300);
    });

    var aux2 = "";
    var auxSplit = "none";

    $('#quantidadeProduto').tooltip({
        title: 'Insira a quantidade e clique em Lote Automático ou Lote Manual',
        placement: 'left'
    });


    var table = $('#loadProduto').dataTable({
        language: {
            url: 'localisation/produto.json'
        }
    });

    // post = 10, logic = '>', value = 100;
    // var valid = eval(post + logic + value);
     var j = 2;
     var historyProduto = JSON.parse(sessionStorage.getItem('dataProduto')); // name is the key
     var tamanho = 0;
     if(historyProduto != null){
        tamanho = historyProduto.length;
     }

     var codArr = [];

     for(i = 0; i < tamanho; i++){
        codArr.push(parseInt(historyProduto[i].codigoProduto));
     }
      
     var x = 0;
    $('#loadProduto').find("td.code").each(function(index){
        var myData = $(this).html();
        var post = parseInt($(this).html());
        var logic = '==';
        var value = j;
        for(x = 0; x < tamanho; x++){
            console.log("entrou");
            var aux = historyProduto[x].codigoProduto;
            console.log(aux);
            if(post == aux){
                console.log("entro");
                $(this).closest('tr').addClass('hidden remover');
                
            }
        }
        
        j++;
    });

    $('#loadProduto').find("td.ramo").each(function(index){
        var oRamo = $(this).html().replace(/ /g, '');
        if(ramoCliente == "ambos"){

        } else {
            if(ramoCliente != oRamo){
                $(this).closest('tr').addClass('hidden remover');
            }
        }

    });
     
     
    


    $('#loadProduto tbody').on('click', 'tr', function () {
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
            auxSplit = "none";
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            aux2 = "";
            $(this).find("td").each(function () {
                aux2 = aux2 + "#/" + $(this).text();
            });
            console.log("%%%% Clicou em algum " + aux2);

            auxSplit = aux2.split("#/");
        }
    });

    function getQuantidadeEstoque(codProduto){
        console.log("codigo do produto: " + codProduto)

        var dataString;
            dataString = "codProd=" + codProduto + "&dataVenda=" + $("#fixDataVenda").val();
             $.ajax({
                type: "POST",
                url: "BuscaProdutosEstoque",
                dataType: "text",
                data: dataString
            }).done(function(data) {
                

                if (data === "0" || data == "") {
                    // $('#erroLoteInsuficiente').modal('show');
                    // $('#addToCart').attr("disabled", "true");
                    console.log("deu erro " + data)
                    $('#qtdeEstoque').val("0");
                    
                } else {
                    console.log("parece que funfou: " + data)
                    $('#qtdeEstoque').val(data);
                    // $('#addToCart').removeAttr("disabled");
                    // console.log("achou os lotes, sucesso " + data);

                    // $('.addedPanel').remove();
                    // $('.addedRelatorio').remove();
                    // $('.addedPrint').remove();
                    // buildLotes(data);
                }

            });
    }

    // Camila - buguei o bang de produtos aqui
    $('#selectProduct').click(function () {

        if ($('#loadProduto tbody tr').hasClass('selected')) {
            $('#loadProduto tbody tr').removeClass('selected');

        }

        if (auxSplit === "none") {
            console.log("Nada foi Selecionado");
            $('#modalErroDeSelecao').modal('show');
        } else {
            console.log("------------ SELECIONADO: " + auxSplit);
            var auxCodProd = auxSplit[1];
            getQuantidadeEstoque(auxCodProd);
            var auxNomeProd = auxSplit[2];
            var auxTipoProd = auxSplit[3];
            var auxValorUnitario = auxSplit[4];
            $('#produtoHidden').removeClass('hidden');

            auxValorUnitario = auxValorUnitario.replace(/,/g, '.');
            auxValorUnitario = auxValorUnitario.replace(/\./g, ',');

            $('#hid').removeClass('hidden');
            $('#nomeProduto').val(auxNomeProd);
            $('#codigoProduto').val(auxCodProd);
            $('#valorUnitario').val(auxValorUnitario);
            var osRaio = $('input:radio[name=tipoProduto]');
            console.log(auxSplit[3]);
            if (auxSplit[3] === "alimentício") {
                $('#optionsAlimento').prop('checked', true);
                osRaio.filter('[value=alimento]').attr('checked', true);
            } else {
                $('#optionsMedicamento').prop('checked', true);
                osRaio.filter('[value=medicamento]').attr('checked', true);
                console.log("medicamento");
            }
            
            $('#selecionarProduto').modal('hide');

            setTimeout(
                function ()
                {
                    //do something special
                    $('#quantidadeProduto').prop('autofocus', true);
                    $('#quantidadeProduto').delay(200).focus();
                    $('#quantidadeProduto').tooltip({title: 'Insira a quantidade e clique em Lote Automático ou Lote Manual',
                        placement: 'left', trigger: 'manual'}).tooltip('show');

                },
                500);

        }
        $('#erroPesquisaCodigo').fadeOut(300);
    });


    

    var $template = $(".template");

    var hash = 2;
    $(".btn-add-panel").on("click", function () {
        var $newPanel = $template.clone();
        $newPanel.find(".collapse").removeClass("in");
        $newPanel.find(".accordion-toggle").attr("href", "#" + (++hash))
                .text("Dynamic panel #" + hash);
        $newPanel.find(".panel-collapse").attr("id", hash).addClass("collapse").removeClass("in");
        $("#accordion").append($newPanel.fadeIn());
    });


    //called when key is pressed in textbox
    $("#quantidadeProduto").keypress(function (e) {
        if($("#quantidadeProduto").val() == ""){
            if($('#formGroupQuantidadeProduto2').hasClass( "has-error" )){
                $('#formGroupQuantidadeProduto2').removeClass("has-error");
                $('#formGroupQuantidadeProduto2').fadeOut(200);
                qtdeFaltando = $('#quantidadeProduto').val();
            }
        }

        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message
            //$("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        } else {
             
                $('#formGroupQuantidadeProduto').removeClass("has-error");
                $('#formGroupQuantidadeProduto2').removeClass("has-error");
                $('#formGroupQuantidadeProduto2').fadeOut(200);
                qtdeFaltando = $('#quantidadeProduto').val();
            

            
        }
        
    });

    $("#valorUnitario").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message
            //$("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });

    $("#quantidadeProduto").click(function (e) {
        if($("#quantidadeProduto").val() == ""){
            if($('#formGroupQuantidadeProduto2').hasClass( "has-error" )){
                $('#formGroupQuantidadeProduto2').removeClass("has-error");
                $('#formGroupQuantidadeProduto2').fadeOut(200);
                qtdeFaltando = $('#quantidadeProduto').val();
            }
            
        }
        console.log("clicou");
        $loteTable.bootstrapTable('destroy');
        $('#groupUnidadesFalta').fadeOut('fast');
        $('#addToCart').attr("disabled", "true");
        $('#unidadesFalta').val("");
        $('.addedPanel').remove();
        $('.addedRelatorio').remove();
        $('.addedPrint').remove();

    });

    $("#quantidadeProduto").keyup(function (e) {
        //if the letter is not digit then display error and don't type anything

        var value = document.getElementById('quantidadeProduto').value;
        qtdeFaltando = value;
        var valueUnity = document.getElementById('valorUnitario').value;
        if (valueUnity == "") {
            valueUnity = 0;
        }
        valueUnity = valueUnity.replace(/,/g, '.');
        valueUnity = parseFloat(valueUnity);
        var total = value * valueUnity;
        var totalString = "";
        totalString = total + "";
        totalString = totalString.replace(/,/g, '');
        totalString = totalString.replace(/\./g, ',');
        document.getElementById('valorTotal').value = totalString;

        if ($('#quantidadeProduto').val() == "" || parseInt($('#quantidadeProduto').val()) < 0 || parseInt($('#quantidadeProduto').val()) == 0) {
            $('#addToCart').attr("disabled", "true");
            $('.addedPanel').remove();
            $('.addedRelatorio').remove();
            $('.addedPrint').remove();
            if($('#formGroupQuantidadeProduto2').hasClass( "has-error" )){
                $('#formGroupQuantidadeProduto2').removeClass("has-error");
                $('#formGroupQuantidadeProduto2').fadeOut(200);
            }
        }
    });

    
    $('#formVenda').bootstrapValidator({

                fields: {
                    dataVenda: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, informe a data da venda'
                            }
                        }
                    },
                    qtdeEstoque: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, informe a data da venda'
                            }
                        }
                    },
                    quantidadeProduto: {
                        validators: {
                            notEmpty: {
                                message: 'Por favor, insira a quantidade do produto'
                            },
                            between: {
                                min: 1,
                                max:  'qtdeEstoque',
                                message: 'A quantidade deve ser maior que 0 e menor que a quantidade em estoque'
                            }
                        }
                    }
                },
                submitHandler: function(validator, form, submitButton) {
                    
                }
            }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();
        });
    //Pesquisa pelo código do Prod que só aceita números
    $("#pesquisaNomeProduto").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message
            //$("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });



    $("#resetVenda").click(function () {

        limparFormulario();


    });

    function limparFormulario() {
        $('#nomeProduto').val('');
        $('#codigoProduto').val('');
        $('#dataVenda').val('');
        $('#valorTotal').val('');
        $('input[name="tipoProduto"]:checked').text('');
        $('#quantidadeProduto').val('');
        $('input[name="unidadeProduto"]:checked').text('');
        $('#descricaoProduto').val('');

        $('#nomeCliente').val('');
        $('#cnpjCliente').val('');

        $('#dataVenda').val('');

        $('#codigoLote').val('');
        $('#dataFabricacao').val('');
        $('#dataValidade').val('');
        $('#observacoes').val('');
        $('#quantidadeProduto').val('');
        $('.addedPanel').remove();
        $('.addedRelatorio').remove();
        $('.addedPrint').remove();

        if (!($('#nomeClienteHidden').hasClass('hidden'))) {
            $('#nomeClienteHidden').addClass('hidden');
        }

        if (!($('#hid').hasClass('hidden'))) {
            $('#hid').addClass('hidden');
        }

        if (!($('#loteHidden').hasClass('hidden'))) {
            $('#loteHidden').addClass('hidden');
        }

        $('#buttonSelectCliente').prop("disabled", true);
        $('#buttonpesquisaCNPJCliente').prop("disabled", true);
        $('#pesquisaCNPJCliente').prop("disabled", true);
        $('#addToCart').prop("disabled", true);
        $('#buttonSelectProduto').prop("disabled", true);
        $('#buttonPesquisaNomeProduto').prop("disabled", true);
        $('#pesquisaNomeProduto').prop("disabled", true);
        $('#clientePanel').fadeTo("slow", 0.5);
        $('#produtoPanel').fadeTo("slow", 0.5);
        $('#formVenda').bootstrapValidator('resetForm', true);
    }

    


    $('#loteManual').click(function() {
        if($('#quantidadeProduto').val() != ""){
            $('#erroLotesManual').fadeOut('fast');
            $('#groupUnidadesFalta').removeClass('has-error');
            $('#addToCart').prop('disabled', true);
            $('#unidadesFalta').val(0);
            console.log('Já passou!!!')
            var qtdEst = $('#qtdeEstoque').val().replace(/ /g, '');
            qtdEst = parseInt(qtdEst);
            var qtdSele = $('#quantidadeProduto').val().replace(/ /g, '');
            qtdSele = parseInt(qtdSele);
            if(qtdSele <= qtdEst){
                $loteTable.bootstrapTable('destroy');
                rows = [];
                row = [];
                rowsSelecionados.length = 0;
                rowsSelecionados = [];
                $('#groupUnidadesFalta').fadeOut('fast');
                $('#unidadesFalta').val("");
                $('.addedPanel').remove();
                $('.addedRelatorio').remove();
                $('.addedPrint').remove();
                $('#addToCart').prop('disabled', true);
                if(parseInt($('#quantidadeProduto').val()) <= 0){
                    $('#modalQuantidade0').modal('show');
                    $('#addToCart').attr("disabled", "true");
                } else {
                    pesquisarLotesManual();
                }
                //pesquisarLotesManual();
            } else {
                $('#erroLoteInsuficiente').modal('show');
                $('#addToCart').attr("disabled", "true");
                

            }
        } else {
            $('#modalSemQuantidade').modal('show');
            $('#addToCart').attr("disabled", "true");
            
        }
        
        
    });



    function pesquisarLotesManual() {
        console.log("entrou na funcao de lote manual");
        var teste = $('#quantidadeProduto').val();
        teste = parseInt(teste);

        

        if($('#quantidadeProduto').val() != "" && teste > 0){
            console.log("verificou quantidade");
            var codProduto =  $('#codigoProduto').val();
            var dataVenda = $('#fixDataVenda').val();

            var dataString;
            dataString = "codigoProduto=" + codProduto + "&dataVenda=" + dataVenda;
             $.ajax({
                type: "POST",
                url: "BuscaTodosLotesPorProduto",
                dataType: "text",
                data: dataString
            }).done(function(data) {
                testeData = data;

                if (data === "0;") {
                    // $('#erroLoteInsuficiente').modal('show');
                    // $('#addToCart').attr("disabled", "true");
                    console.log("deu erro " + data)
                    
                } else {
                    console.log("parece que funfou: " + data);
                    montaLoteManual(data);
                    // $('#addToCart').removeAttr("disabled");
                    // console.log("achou os lotes, sucesso " + data);

                    // $('.addedPanel').remove();
                    // $('.addedRelatorio').remove();
                    // $('.addedPrint').remove();
                    // buildLotes(data);
                }

            });

        } else {
            $('.addedPanel').remove();
            $('.addedRelatorio').remove();
            $('.addedPrint').remove();
            $('#addToCart').attr("disabled", "true");

        }
        
    }

    function estaNaSelecao(selecionado, selecionadosFinal){
        var inseriu = false;
            for(var j = 0; j < selecionadosFinal.length; j++){
                if(selecionado.codigoLote == selecionadosFinal[j].codigoLote){
                    inseriu = true;
                }
            }
            return inseriu;
    }

    function montaLoteManual(data){
        rows = [];
        row = null;
        rowsSelecionados.length = 0;
        rowsSelecionados = []; 
        var auxData = data.split(";");
        var qtos = parseInt(auxData[0]);
        var auxRow = null;
        var indice = 1;
        $('#groupUnidadesFalta').fadeIn('fast');
        $('#table-methods-table').bootstrapTable('destroy');
        $loteTable = $('#table-methods-table');
        $loteTable.bootstrapTable('destroy');

        for(var i = 0; i < qtos; i++){
            var auxValidade = auxData[indice + 4];
            auxValidade = auxValidade.split("-");
            auxValidade = auxValidade[2] + "/" + auxValidade[1] + "/" + auxValidade[0];
            auxRow = {
                codigoLote: auxData[indice],
                qtdeEstoque: auxData[indice + 3],
                validade: auxValidade
            };
            console.log(auxRow);
            rows.push(auxRow);
            indice = indice + 5;
        }
        $('#unidadesFalta').val(parseInt($('#quantidadeProduto').val()));
        console.log(rows);
        $('#groupUnidadesFalta').fadeIn('fast');
        console.log("ROWSS");
        console.log(JSON.stringify(rows));

        $loteTable.bootstrapTable({
            data: rows
                        
        }).on('check.bs.table', function (e, row) {
            rowsSelecionados = [];
            var selection = [];

            selection = $loteTable.bootstrapTable('getSelections');
            console.log("$$$$$$$$$$$ selecionados: " + JSON.stringify(selection));
            console.log(selection);
            var quantidadeForm = parseInt($('#quantidadeProduto').val());
            $('#unidadesFalta').val(quantidadeForm);
            var quantidadeObjetivo = quantidadeForm;
            var quantosFalta = 1;
            var jaPassou = false;
            var liberaToCart = false;

            function bubbles(vetor) {
                    var n = vetor.length;
                    var temp;
                   
                    for(var i=0; i < n; i++){
                            for(var j=1; j < (n-i); j++){
                                   
                                    if(parseInt(vetor[j-1].qtdeEstoque) > parseInt(vetor[j].qtdeEstoque)){
                                            temp = vetor[j-1];
                                            vetor[j-1] = vetor[j];
                                            vetor[j] = temp;
                                    }
                                   
                            }
                    }
                    return vetor;
            };

            selection = bubbles(selection);
            console.log("vamo ve ver ver ver: " + JSON.stringify(selection));
            for(var i = 0; i < selection.length; i++){
                rowsSelecionados.push(selection[i]);
                if(quantosFalta > 0){
                    if(quantidadeObjetivo - selection[i].qtdeEstoque > 0){
                        quantidadeObjetivo = quantidadeObjetivo - selection[i].qtdeEstoque;
                        quantosFalta = quantidadeObjetivo;
                        liberaToCart = false;
                    } else {
                        quantidadeObjetivo = selection[i].qtdeEstoque - quantidadeObjetivo;
                        quantidadeObjetivo = selection[i].qtdeEstoque - quantidadeObjetivo;
                        quantosFalta = 0;
                        liberaToCart = true;
                    }
                } else {
                    jaPassou = true;
                    quantosFalta = 0;
                    liberaToCart = false;
                }
                
            }

            if(jaPassou){
                $('#erroLotesManual').fadeIn('fast');
                $('#groupUnidadesFalta').addClass('has-error');
                $('#addToCart').prop('disabled', true);
                $('#unidadesFalta').val(0);
                console.log('Já passou!!!')
            } else {
                console.log("Deu Certo!! " + JSON.stringify(rowsSelecionados))
                if(selection.length == 0){
                    $('#unidadesFalta').val(parseInt($('#quantidadeProduto').val()));
                } else {
                    $('#unidadesFalta').val(quantosFalta);
                }
                
                $('#erroLotesManual').fadeOut('fast');
                $('#groupUnidadesFalta').removeClass('has-error');
                if(liberaToCart){
                    $('#addToCart').prop('disabled', false);
                } else {
                    $('#addToCart').prop('disabled', true);
                }
                var auxTesteData = "";
                var auxQuantidadeForm = 0;
                auxTesteData = rowsSelecionados.length + ";";
                for(var i = 0; i < rowsSelecionados.length; i++){
                    auxTesteData = auxTesteData + rowsSelecionados[i].codigoLote + ";";
                    auxTesteData = auxTesteData + $('#codigoProduto').val() + ";";
                    auxTesteData = auxTesteData + rowsSelecionados[i].qtdeEstoque + ";";
                    if(quantidadeForm - rowsSelecionados[i].qtdeEstoque >= 0){
                        auxTesteData = auxTesteData + rowsSelecionados[i].qtdeEstoque + ";";
                        quantidadeForm = quantidadeForm - rowsSelecionados[i].qtdeEstoque;
                    } else {
                        quantidadeForm = rowsSelecionados[i].qtdeEstoque - quantidadeForm;
                        quantidadeForm = rowsSelecionados[i].qtdeEstoque - quantidadeForm;
                        auxTesteData = auxTesteData + quantidadeForm + ";";
                    }
                    var auxDataManip = rowsSelecionados[i].validade.split("/");
                    auxTesteData = auxTesteData + auxDataManip[2] + "-" + auxDataManip[1] + "-" 
                    + auxDataManip[0] + ";"; 

                }
                testeData = auxTesteData;
                console.log("####### " + testeData);
            } 
  
        }).on('uncheck.bs.table', function (e, row) {

            rowsSelecionados = [];
            var selection = [];
            selection = $loteTable.bootstrapTable('getSelections');
            console.log("$$$$$$$$$$$ selecionados: " + JSON.stringify(selection));
            var quantidadeForm = parseInt($('#quantidadeProduto').val());
            $('#unidadesFalta').val(quantidadeForm);
            var quantidadeObjetivo = quantidadeForm;
            var quantosFalta = 1;
            var jaPassou = false;
            var liberaToCart = false;
            
            function bubbles(vetor) {
                    var n = vetor.length;
                    var temp;
                   
                    for(var i=0; i < n; i++){
                            for(var j=1; j < (n-i); j++){
                                   
                                    if(parseInt(vetor[j-1].qtdeEstoque) > parseInt(vetor[j].qtdeEstoque)){
                                            temp = vetor[j-1];
                                            vetor[j-1] = vetor[j];
                                            vetor[j] = temp;
                                    }
                                   
                            }
                    }
                    return vetor;
            };

            selection = bubbles(selection);

            for(var i = 0; i < selection.length; i++){
                rowsSelecionados.push(selection[i]);
                if(quantosFalta > 0){
                    if(quantidadeObjetivo - selection[i].qtdeEstoque > 0){
                        quantidadeObjetivo = quantidadeObjetivo - selection[i].qtdeEstoque;
                        quantosFalta = quantidadeObjetivo;
                        liberaToCart = false;

                    } else {
                        quantidadeObjetivo = selection[i].qtdeEstoque - quantidadeObjetivo;
                        quantidadeObjetivo = selection[i].qtdeEstoque - quantidadeObjetivo;
                        quantosFalta = 0;
                        liberaToCart = true;
                    }
                } else {
                    jaPassou = true;
                    quantosFalta = 0;
                    liberaToCart = false;
                }
                
            }

            if(jaPassou){
                $('#erroLotesManual').fadeIn('fast');
                $('#groupUnidadesFalta').addClass('has-error');
                $('#addToCart').prop('disabled', true);
                $('#unidadesFalta').val(0);
                console.log('Já passou!!!')
            } else {
                console.log("Deu Certo!! " + JSON.stringify(rowsSelecionados))
                if(selection.length == 0){
                    $('#unidadesFalta').val(parseInt($('#quantidadeProduto').val()));
                } else {
                    $('#unidadesFalta').val(quantosFalta);
                }
                $('#erroLotesManual').fadeOut('fast');
                $('#groupUnidadesFalta').removeClass('has-error');
                if(liberaToCart){
                    $('#addToCart').prop('disabled', false);
                } else {
                    $('#addToCart').prop('disabled', true);
                }
                
                var auxQuantidadeForm = 0;
                auxTesteData = rowsSelecionados.length + ";";
                for(var i = 0; i < rowsSelecionados.length; i++){
                    auxTesteData = auxTesteData + rowsSelecionados[i].codigoLote + ";";
                    auxTesteData = auxTesteData + $('#codigoProduto').val() + ";";
                    auxTesteData = auxTesteData + rowsSelecionados[i].qtdeEstoque + ";";
                    if(quantidadeForm - rowsSelecionados[i].qtdeEstoque >= 0){
                        auxTesteData = auxTesteData + rowsSelecionados[i].qtdeEstoque + ";";
                        quantidadeForm = quantidadeForm - rowsSelecionados[i].qtdeEstoque;
                    } else {
                        quantidadeForm = rowsSelecionados[i].qtdeEstoque - quantidadeForm;
                        quantidadeForm = rowsSelecionados[i].qtdeEstoque - quantidadeForm;
                        auxTesteData = auxTesteData + quantidadeForm + ";";
                    }
                    var auxDataManip = rowsSelecionados[i].validade.split("/");
                    auxTesteData = auxTesteData + auxDataManip[2] + "-" + auxDataManip[1] + "-" 
                    + auxDataManip[0] + ";"; 

                }
                testeData = auxTesteData;
                console.log("####### " + testeData);
            }
        }).on('check-all.bs.table', function (e) {
                console.log('Event: check-all.bs.table ' + JSON.stringify($loteTable.bootstrapTable('getData')));
                rowsSelecionados = $loteTable.bootstrapTable('getData');
        }).on('uncheck-all.bs.table', function (e) {
                rowsSelecionados.length = 0;
                console.log('Event: uncheck-all.bs.table ' + JSON.stringify($loteTable.bootstrapTable('getData')));
        });

        $('#table-methods-table').removeClass('hidden');
        $('#addLoteManual').removeClass('hidden');

        $('[name="btSelectAll"]').prop('disabled', true);
    }

    //Pesquisa um produto pelo código
    $('#loteAutomatico').click(function() {
        rows = [];
        row = null;
        rowsSelecionados.length = 0;
        $('#unidadesFalta').val("");
        $('#table-methods-table').bootstrapTable('destroy');
        rows = [];
        row = [];
        rowsSelecionados.length = 0; 
        $loteTable.bootstrapTable('destroy');
        $('#groupUnidadesFalta').fadeOut('fast');
        if(parseInt($('#quantidadeProduto').val()) <= 0){
            $('#modalQuantidade0').modal('show');
            $('#addToCart').attr("disabled", "true");
        } else {
            pesquisarLotesAutomatico();
        }        
    });

    


    var testeData;

    function pesquisarLotesAutomatico() {
        var teste = $('#quantidadeProduto').val();
        teste = parseInt(teste);

        if($('#quantidadeProduto').val() != "" && teste > 0){
            var codProduto =  $('#codigoProduto').val();
            var quantProduto = $('#quantidadeProduto').val();
            var dataVenda = $('#fixDataVenda').val();


            var dataString;
            dataString = "codigoProduto=" + codProduto + "&quantidadeProduto=" + quantProduto
            + "&dataVenda=" + dataVenda;
             $.ajax({
                type: "POST",
                url: "BuscaLotesAutomatico",
                dataType: "text",
                data: dataString
            }).done(function(data) {
                testeData = data;

                if (data === "0;") {
                    $('#erroLoteInsuficiente').modal('show');
                    $('#addToCart').attr("disabled", "true");
                    
                } else {
                    $('#addToCart').removeAttr("disabled");
                    console.log("achou os lotes, sucesso " + data);

                    $('.addedPanel').remove();
                    $('.addedRelatorio').remove();
                    $('.addedPrint').remove();
                    buildLotes(data);
                }

            });

        } else {
            $('.addedPanel').remove();
            $('.addedRelatorio').remove();
            $('.addedPrint').remove();
            $('#addToCart').attr("disabled", "true");

            $('#modalSemQuantidade').modal('show');

            

        }
        
    }

    function buildLotes(data){
            var qtdeTotal = 0;
            qtdeTotal = parseInt($('#quantidadeProduto').val());
            var aux = data.split(';');

            var qtde = aux[0];

            $('#auxiliarParaRelatorio').append("<input class='addedPrint' id='quantidadeParaRelatorio' value='" + qtde + "'>");
 
            var quantidadeLotes = qtde;
            console.log("quantidade " + quantidadeLotes);
            var $template = $(".template");

            var $relatorioTemplate = $(".relatorioGerado");
               
            var hash = 0;
            var i = 1
            var j = 1;
            while(quantidadeLotes > 0){

                var $newPanel = $template.clone();

                var $newRelatorio = $relatorioTemplate.clone(); 

                var codLote = aux[i];
                
                $newPanel.find(".collapse").removeClass("in");
                $newPanel.find(".accordion-toggle").attr("href", "#" + (++hash))
                        .text("Lote " + codLote );
                $newPanel.find(".panel-collapse").attr("id", hash).addClass("collapse").removeClass("in");
                $newPanel.removeClass("hidden");
                $newPanel.addClass("addedPanel");

                $newRelatorio.removeClass("hidden");
                $newRelatorio.addClass("addedRelatorio");


                $newPanel.find("#codigoLote").val(codLote);
                $newRelatorio.find("#codigoLoteModal").val(codLote);
                $('#auxiliarParaRelatorio').append("<input class='addedPrint' id='codParaRelatorio" + (j++).toString() + "' value='" + codLote + "'>");

                i = i+3;
                var quantidadeAux = aux[i];
                // i++;
                if((qtdeTotal - quantidadeAux) >= 0){
                    qtdeTotal = qtdeTotal - quantidadeAux;
                } else {
                    quantidadeAux = qtdeTotal;
                    qtdeTotal = 0;
                }
                $newPanel.find("#quantidadeProduto").val(quantidadeAux);
                $newRelatorio.find("#quantidadeProdutoModal").val(quantidadeAux);
                $('#auxiliarParaRelatorio').append("<input class='addedPrint' id='quantidadeParaRelatorio" + (j++).toString() + "'  value='" + quantidadeAux + "'>");
                var validadeAux = aux[++i];
                var secAux = validadeAux.split('-');
                validadeAux = secAux[2] + "/" + secAux[1] + "/" + secAux[0];
                $newPanel.find("#validade").val(validadeAux);
                $newRelatorio.find("#dataValidadeModal").val(validadeAux);
                $('#auxiliarParaRelatorio').append("<input class='addedPrint' id='validadeParaRelatorio" + (j++).toString() + "'  value='" + validadeAux + "'>");

                $newRelatorio.removeClass("hidden");
                $newRelatorio.addClass("addedRelatorio");

                $("#accordion").append($newPanel.fadeIn());
                
                $("#loteRelatorio").append($newRelatorio);
                $("#loteRelatorio").append("<hr width='50%'>");

                i++;
                
                quantidadeLotes--;
                console.log(quantidadeLotes);
            }
            
        
    }

    function pesquisarCodigo() {

        if($("#pesquisaNomeProduto").val() != ""){
            var cod = $('#pesquisaNomeProduto').val();
            var data = $('#fixDataVenda').val();
             var dataString;
            dataString = "cod=" + cod + "&dataVenda=" + data;

            $.ajax({
                type: "GET",
                url: "BuscaClienteProdutoCNPJCod",
                dataType: "text",
                data: dataString
            }).done(function(data) {

                if (data === "null") {
                    //Criar mensagem que diz que o o produto com esse código não existe
                    console.log("entrou aqui");
                    $('#erroPesquisaCodigo').fadeIn("slow");
                    $('#pesquisaNomeProduto').val("");
                    $('#nomeProduto').val("");
                    $('#codigoProduto').val("");
                    $('#valorUnitario').val("");
                    $('#qtdeEstoque').val("");
                    if($('#optionsAlimento').is(':checked')){
                        $('#optionsAlimento').prop('checked', false);
                        console.log("Alimento esta selcionado")
                    }
                    if($('#optionsMedicamento').is(':checked')){
                        $('#optionsMedicamento').prop('checked', false);
                        console.log("Medicamento esta selcionado")
                    }

                    $('#addToCart').attr("disabled", "true");
                    $('.addedPanel').remove();
                    $('.addedRelatorio').remove();
                    $('.addedPrint').remove();

                    if($('#produtoHidden').hasClass('hidden')){

                    } else {
                        $('#produtoHidden').addClass('hidden');
                    }
                    

                } else {

                    var aux = data.split(";");

                    console.log("ostipo: " + aux[2] + " ramo: " + ramoCliente);
                    console.log(data);
                    if((jQuery.inArray(parseInt(aux[1]) ,codArr) == -1) && (aux[2] == ramoCliente || ramoCliente == "ambos")){
                        $('#erroPesquisaCodigo').fadeOut("slow");
                        $('#hid').removeClass('hidden');
                        $('#nomeProduto').val(aux[0]);
                        var auxCodProduto = aux[1];
                        $('#codigoProduto').val(aux[1]);
                        var auxValorUnitario = aux[3];


                        auxValorUnitario = auxValorUnitario.replace(/,/g, '.');
                        auxValorUnitario = auxValorUnitario.replace(/\./g, ',');
                        $('#valorUnitario').val(auxValorUnitario);
                        $('#pesquisaNomeProduto').val("");
                        //Seta o rádio do tipo do produto
                        var osRaio = $('input:radio[name=tipoProduto]');
                        console.log(aux[2]);
                        if (aux[2] === "alimentício") {
                            $('#optionsAlimento').prop('checked', true);
                            osRaio.filter('[value=alimento]').attr('checked', true);
                        } else {
                            $('#optionsMedicamento').prop('checked', true);
                            osRaio.filter('[value=medicamento]').attr('checked', true);
                            console.log("medicamento");
                        }
                        if($('#produtoHidden').hasClass('hidden')){
                            $('#produtoHidden').removeClass('hidden');
                        } 

                        getQuantidadeEstoque(auxCodProduto);

                        setTimeout(
                              function() 
                              {
                                //do something special
                                $('#quantidadeProduto').prop('autofocus',true);
                                $('#quantidadeProduto').delay(200).focus();
                                $('#quantidadeProduto').tooltip({title : 'Insira a quantidade e clique em Lote Automático',
                                placement : 'left',trigger: 'manual'}).tooltip('show');
                                
                              }, 500);   
                    } else {
                        $('#erroPesquisaCodigo').fadeIn("slow");
                        $('#pesquisaNomeProduto').val("");
                        $('#qtdeEstoque').val("");
                        $('#nomeProduto').val("");
                        $('#codigoProduto').val("");
                        $('#valorUnitario').val("");
                        if($('#optionsAlimento').is(':checked')){
                            $('#optionsAlimento').prop('checked', false);
                            console.log("Alimento esta selcionado")
                        }
                        if($('#optionsMedicamento').is(':checked')){
                            $('#optionsMedicamento').prop('checked', false);
                            console.log("Medicamento esta selcionado")
                        }

                        $('#addToCart').attr("disabled", "true");
                        $('.addedPanel').remove();
                        $('.addedRelatorio').remove();
                        $('.addedPrint').remove();

                        if($('#produtoHidden').hasClass('hidden')){

                        } else {
                            $('#produtoHidden').addClass('hidden');
                        }
                    }


                    


                }
            });
        }
        
        
    }

    //Pesquisa um produto pelo código
    $('#buttonPesquisaNomeProduto').click(function() {
        $loteTable.bootstrapTable('destroy');
        $('#groupUnidadesFalta').fadeOut('fast');
        if($("#pesquisaNomeProduto").val() != ""){
            pesquisarCodigo();
        } else {
            $('#selecionarProduto').modal('show');
            $('#erroPesquisaCodigo').fadeOut("slow");
            $('#pesquisaNomeProduto').val("");
            $('#nomeProduto').val("");
            $('#codigoProduto').val("");
            $('#valorUnitario').val("");
            if($('#optionsAlimento').is(':checked')){
                $('#optionsAlimento').prop('checked', false);
                console.log("Alimento esta selcionado")
            }
            if($('#optionsMedicamento').is(':checked')){
                $('#optionsMedicamento').prop('checked', false);
                console.log("Medicamento esta selcionado")
            }
            
            // var osRaio = $('input:radio[name=tipoProduto]');
            // osRaio.filter('[value=medicamento]').attr('checked', false);
            // osRaio.filter('[value=alimento]').attr('checked', false);
            $('.addedPanel').remove();
            $('.addedRelatorio').remove();
            $('.addedPrint').remove();
            $('#addToCart').attr('disabled', true);
            $('#quantidadeProduto').val("");
            $('#formGroupQuantidadeProduto').removeClass('has-success');

            if ($('#produtoHidden').hasClass('hidden')) {

            } else {
                $('#produtoHidden').addClass('hidden');
            }
        }
        
    });

    $('#pesquisaNomeProduto').keypress(function(e) {
            if(e.which == 13) {
                $loteTable.bootstrapTable('destroy');
                $('#groupUnidadesFalta').fadeOut('fast');
                if($("#pesquisaNomeProduto").val() != ""){
                    pesquisarCodigo();
                } else {
                    $('#selecionarProduto').modal('show');
                    $('#erroPesquisaCodigo').fadeOut("slow");
                    $('#pesquisaNomeProduto').val("");
                    $('#nomeProduto').val("");
                    $('#codigoProduto').val("");
                    $('#valorUnitario').val("");
                    if($('#optionsAlimento').is(':checked')){
                        $('#optionsAlimento').prop('checked', false);
                        console.log("Alimento esta selcionado")
                    }
                    if($('#optionsMedicamento').is(':checked')){
                        $('#optionsMedicamento').prop('checked', false);
                        console.log("Medicamento esta selcionado")
                    }
                    $('.addedPanel').remove();
                    $('.addedRelatorio').remove();
                    $('.addedPrint').remove();
                    $('#addToCart').attr('disabled', true);
                    $('#quantidadeProduto').val("");
                    $('#formGroupQuantidadeProduto').removeClass('has-success');

                    if ($('#produtoHidden').hasClass('hidden')) {

                    } else {
                        $('#produtoHidden').addClass('hidden');
                    }
                }
                
            }
        });

    $('#addToCart').click(function() {
        // console.log(testeData);
        var qtdeTotal2 = 0;
        qtdeTotal2 = parseInt($('#quantidadeProduto').val());
        console.log(testeData);
        var auxLote = testeData.split(';');

        var quantidadeLotes = auxLote[0];
        var historyLote = sessionStorage.getItem('dataLote'); // name is the key
        historyLote = JSON.parse(historyLote);


        var jsonLote = [];
        var auxJsonLote;
        var i = 1
        while(quantidadeLotes > 0){

            var codLote = auxLote[i];
            
            i = i+3;
            var quantidadeAux = auxLote[i];
            if(qtdeTotal2 - parseInt(quantidadeAux) >= 0){
                qtdeTotal2 = qtdeTotal2 - parseInt(quantidadeAux);
            } else {
                quantidadeAux = qtdeTotal2;
                qtdeTotal2 = 0;
            }
            var validadeAux = auxLote[++i];
            var secAux = validadeAux.split('-');
            validadeAux = secAux[2] + "/" + secAux[1] + "/" + secAux[0];
            var codProduto = $('#codigoProduto').val();
            

            i++;
            auxJsonLote = {
                codProduto: codProduto,
                codLote: codLote,
                quantidade: quantidadeAux,
                validade: validadeAux
            };
            if(historyLote != null){
                historyLote.push(auxJsonLote);
            } else {
                historyLote = [];
                historyLote.push(auxJsonLote);
            }
            
            quantidadeLotes--;

        }
        sessionStorage.setItem('dataLote', JSON.stringify(historyLote));

        // console.log(jsonLote);
        var jsonProduto = {
            codigoProduto: $('#codigoProduto').val(),
            nomeProduto: $('#nomeProduto').val(),
            tipoProduto: $('input[name=tipoProduto]:checked').val(),
            valorUnitario: $('#valorUnitario').val(),
            quantidadeProduto: $('#quantidadeProduto').val()
        };
        

        // console.log(jsonProduto);

        
        
        console.log('antes' + historyProduto);
        

        // var historyLoteAux = JSON.stringify(historyLote);
        // var historyProdutoAux = JSON.stringify(historyProduto);
        // historyLoteAux.push(JSON.stringify( jsonLote ));
        // historyProdutoAux.push(JSON.stringify( jsonProduto ));
        if(historyProduto != null){
            historyProduto.push(jsonProduto);
            
            console.log(historyProduto);

            sessionStorage.setItem('dataProduto', JSON.stringify(historyProduto));
        } else {
            historyProduto = [];
            historyProduto.push(jsonProduto);
            
            console.log(historyProduto);

            sessionStorage.setItem('dataProduto', JSON.stringify(historyProduto));
        }
        




        // sessionStorage.setItem( "dataProduto", historyProduto );
        // sessionStorage.setItem( "dataLote", historyLote );

        var auxJson = sessionStorage.getItem( "dataProduto" );
        console.log('depois' + auxJson);
        // console.log(auxJson);
        var vendaObj = JSON.parse(  auxJson );
        // console.log(vendaObj);

        auxJson = sessionStorage.getItem( "dataLote" );
        // console.log(auxJson);
        vendaObj = JSON.parse( auxJson );
        console.log("------ Vou imprimir os lotes -------");
        for(var i = 0; i < vendaObj.length; i++){
            console.log("** " + JSON.stringify(vendaObj[i]));
        }
        // console.log(vendaObj);
        
        window.location.href = "/ArrayEnterprises/carrinho.jsp";


        
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

    $('#verResumo').click(function() {
        window.location.href = "/ArrayEnterprises/carrinho.jsp";
    });

    $('#alterarCliente').click(function() {
        window.location.href = "/ArrayEnterprises/BuscaClientesProdutos";
    });

});


