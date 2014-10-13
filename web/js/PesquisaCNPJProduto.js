

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
                $('#buttonSelectProduto').attr("disabled", true);
                $('#buttonPesquisaNomeProduto').attr("disabled", true);
                $('#pesquisaNomeProduto').attr("disabled", true);
                $('#produtoPanel').fadeTo( "slow", 0.5 );
                $('#inserirVenda').attr("disabled", "true");
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

                $('#inserirVenda').attr("disabled", "true");
                $('.addedPanel').remove();
                $('.addedRelatorio').remove();
                $('.addedPrint').remove();

                if($('#produtoHidden').hasClass('hidden')){

                } else {
                    $('#produtoHidden').addClass('hidden');
                }
                

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
        var teste = $('#quantidadeProduto').val();
        teste = parseInt(teste);
        console.log(teste + " " + $('#quantidadeProduto').val());

        if($('#quantidadeProduto').val() != "" && teste > 0){
            var codProduto =  $('#codigoProduto').val();
            var quantProduto = $('#quantidadeProduto').val();


            var dataString;
            dataString = "codigoProduto=" + codProduto + "&quantidadeProduto=" + quantProduto;
             $.ajax({
                type: "POST",
                url: "BuscaLotesAutomatico",
                dataType: "text",
                data: dataString
            }).done(function(data) {

                if (data === "0;") {
                    //ERRO
                    console.log("não achou os lotes, deu erro");
                    $('#erroLoteInsuficiente').modal('show');
                    $('#inserirVenda').attr("disabled", "true");
                    
                } else {
                    $('#inserirVenda').removeAttr("disabled");
                    console.log("achou os lotes, sucesso " + data);

                    $('.addedPanel').remove();
                    $('.addedRelatorio').remove();
                    $('.addedPrint').remove();
                    buildLotes(data)
                    


                    
                    
                }

            });

        } else {
            $('.addedPanel').remove();
            $('.addedRelatorio').remove();
            $('.addedPrint').remove();
            $('#inserirVenda').attr("disabled", "true");
            $('#formGroupQuantidadeProduto').addClass("has-error");
            $('#formGroupQuantidadeProduto2').addClass("has-error");
            $('#formGroupQuantidadeProduto2').fadeIn(200);

        }
        
    }

    function buildLotes(data){
            var aux = data.split(';');
            // if(aux.length > 2){
            //     //Tenho mais de 1 lote
            //     for(int i = 0; i < aux.length - 1; i++){
            //         var aux2 = aux[i].split(";");
                    
            //         //Aqui posso acessar
            //     }
            // } else {
            //     //Tenho somente 1 lote
            // }
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

                i = i+2;
                var quantidadeAux = aux[i];
                i++;
                $newPanel.find("#quantidadeProduto").val(quantidadeAux);
                $newRelatorio.find("#quantidadeProdutoModal").val(quantidadeAux);
                $('#auxiliarParaRelatorio').append("<input class='addedPrint' id='quantidadeParaRelatorio" + (j++).toString() + "'  value='" + quantidadeAux + "'>");
                var validadeAux = aux[++i];
                $newPanel.find("#validade").val(validadeAux);
                $newRelatorio.find("#dataValidadeModal").val(validadeAux);
                $('#auxiliarParaRelatorio').append("<input class='addedPrint' id='validadeParaRelatorio" + (j++).toString() + "'  value='" + validadeAux + "'>");

                $("#accordion").append($newPanel.fadeIn());
                
                $("#loteRelatorio").append($newRelatorio);
                $("#loteRelatorio").append("<hr width='50%'>");

                i++;
                
                quantidadeLotes--;
                console.log(quantidadeLotes);
            }
            
        
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