
        $(document).ready(function() {

            $('#formVenda').bind("keyup keypress", function(e) {
                  var code = e.keyCode || e.which; 
                  if (code  == 13) {               
                    e.preventDefault();
                    return false;
                  }
                });


        $("#inserirVenda").click(function(e){
            console.log("ALGUM ERRO OCORREU MAS PEGOU O CLICKE!!");
            $('#formVenda').bootstrapValidator('validate');
        });

        function limparFormulario(){
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

                    $('#buttonSelectCliente').prop("disabled",true);
                    $('#buttonpesquisaCNPJCliente').prop("disabled",true);
                    $('#pesquisaCNPJCliente').prop("disabled",true);
                    $('#inserirVenda').prop("disabled",true);
                    $('#buttonSelectProduto').prop("disabled",true);
                    $('#buttonPesquisaNomeProduto').prop("disabled",true);
                    $('#pesquisaNomeProduto').prop("disabled",true);
                    $('#clientePanel').fadeTo( "slow", 0.5 );
                    $('#produtoPanel').fadeTo( "slow", 0.5 );
                    $('#formVenda').bootstrapValidator('resetForm', true);
            }



           $('#formVenda').bootstrapValidator({

                fields: {
                    dataVenda: {
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
                            greaterThan: {
                                value: 1.0,
                                message: 'A quantidade deve ser maior que 0'
                            }
                        }
                    }
                },
                submitHandler: function(validator, form, submitButton) {
                    
                }
            }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();

                var codCliente =  $('#codigoCliente').val();
                codCliente = codCliente.replace(/ /g, '');
                var dataVenda = $('#dataVenda').val();
                var codProduto = $('#codigoProduto').val();
                var QtdeVenda = $('#quantidadeProduto').val();

                    var dataString;
                    dataString = "codCliente=" + codCliente + "&dataVenda=" + dataVenda + "&codProduto=" + codProduto + "&QtdeVenda=" + QtdeVenda;
                    $.ajax({
                        type: "POST",
                        url: "CadastrarVenda",
                        dataType: "json",
                        data: dataString,
                        //if received a response from the server
                        success: function( data) {
                             if(data.success){
                                var dataVenda = $('#dataVenda').val();
                                var nomeCliente = $('#nomeCliente').val();
                                var cnpjCliente = $('#cnpjCliente').val();
                                var nomeProduto = $('#nomeProduto').val();
                                var tipoProduto;
                                var auxTipoProd2;
                                var osRaio2 = $('input:radio[name=tipoProduto]');
                                if (auxTipoProd2 === "medicamento") {
                                    osRaio2.filter('[value=medicamento]').attr('checked', true);
                                    tipoProduto = 'Farmacêutico';
                                } else {
                                    osRaio2.filter('[value=alimento]').attr('checked', true);
                                    tipoProduto = 'Alimentício';
                                }


                                var quantidadeProduto = $('#quantidadeProduto').val();
                                var codigoProduto = $('#codigoProduto').val();
                                var valorUnitario = $('#valorUnitario').val();
                                var valorTotal = $('#valorTotal').val();

                                $('#dataVendaModal').val(dataVenda);
                                $('#nomeClienteModal').val(nomeCliente);
                                $('#cnpjClienteModal').val(cnpjCliente);
                                $('#nomeProdutoModal').val(nomeProduto);
                                $('#codProdutoModal').val(codigoProduto);
                                $('#tipoProdutoModal').val(tipoProduto);
                                $('#quantidadeModal').val(quantidadeProduto);
                                $('#valorUnitarioModal').val(valorUnitario);
                                $('#valorTotalModal').val(valorTotal);

                                $('#relatorioVenda').modal('show');
                             } else {
                                    limparFormulario();
                                    $('#erroVenda').modal('show');
                                        
                             }
                        },
                        
                        //If there was no resonse from the server
                        error: function(){
                            limparFormulario();
                            $('#erroVenda').modal('show');
                              
                        }
                            });
        });
});