
$(document).ready(function() {
    $('#salvarRelatorioNome').click(function(){
    	console.log("entrou para salvar");
    	console.log($('#nomeRelatorio').val());
    	if( $('#nomeRelatorio').val() != "" ){
    		console.log('é diferente de vazio');
    		var doc = new jsPDF();

	        // $('#dataVendaModal').val(dataVenda);
	        //             $('#nomeClienteModal').val();
	        //             $('#cnpjClienteModal').val();
	        //             $('#nomeProdutoModal').val();
	        //             $('#codProdutoModal').val();
	        //             $('#tipoProdutoModal').val();
	        //             $('#quantidadeModal').val();
	        //             $('#valorUnitarioModal').val();
	        //             $('#valorTotalModal').val();

			//Set PDF properities
			doc.setProperties({
			    title: 'Relório de Vendas',
			    subject: 'Vendas ArrayEnterprises',
			    author: 'ArrayEnterprises',
			    keywords: 'pdf, relatorio, vendas',
			    creator: 'AE'
			});
			console.log("passou por aqui;")

			doc.setFont("times");
			doc.setFontType("bold");
			doc.setFontSize(24);
			doc.text(70, 20, 'Relatório de Vendas');

			doc.line(68, 22, 145, 22);
			var clientData = sessionStorage.getItem( "dataCliente" );
			clientData = JSON.parse(clientData);

			doc.setFontType("bold");
			doc.setFontSize(16);
			doc.text(30, 30, 'Data da Venda: ');
			doc.setFontType("normal");
			doc.text(70, 30, clientData[0].dataVenda );

			doc.setFontType("bold");
			doc.setFontSize(18);
			doc.text(20, 40, 'Cliente');
			doc.setLineWidth(0.5);
			doc.line(19, 41, 190, 41);

			doc.setFontType("bold");
			doc.setFontSize(14);
			doc.text(25, 48, 'Nome do Cliente:');
			doc.text(129, 48, 'CNPJ:');
			doc.setFontType("normal");
			doc.setFontSize(14);
			doc.text(65, 48, clientData[0].nomeCliente);
			doc.text(146, 48, clientData[0].cnpjCliente);

			var produtoX = 58;
			console.log("passou por aqui;:")

			// PRODUTOS
			var productData = sessionStorage.getItem('dataProduto');
			productData = JSON.parse(productData);
			var valorTotalDoRelatorio = 0;
			console.log("passou por aqui;;;")
			console.log("produtctData " + productData.length);
			for(var i = 0; i < productData.length; i++){
				console.log("i: " + i);
				doc.setFontType("bold");
				doc.setFontSize(18);
				doc.text(20, produtoX, 'Produto ' + (i + 1));
				doc.setLineWidth(0.5);
				doc.line(19, produtoX + 1, 190, produtoX + 1);
				doc.setLineWidth(0.2);

				produtoX = produtoX + 8;
				if(produtoX > 280){
					doc.addPage();
					produtoX = 20;
				}

				doc.setFontType("bold");
				doc.setFontSize(14);
				doc.text(25, produtoX, 'Nome do Produto:');
				doc.text(136, produtoX, 'Código:');
				doc.setFontType("normal");
				doc.setFontSize(14);
				doc.text(67, produtoX, productData[i].nomeProduto);
				doc.text(155, produtoX, productData[i].codigoProduto);

				var quantidadePro = productData[i].quantidadeProduto.replace(/ /g, '');
		        var valor = productData[i].valorUnitario.replace(/ /g, '');
		        quantidadePro = parseInt(quantidadePro);
		        valor = parseInt(valor);
		        var total = quantidadePro * valor;
		        valorTotalDoRelatorio = valorTotalDoRelatorio + total;

		        produtoX = produtoX + 8;
		        if(produtoX > 280){
					doc.addPage();
					produtoX = 20;
				}

				doc.setFontType("bold");
				doc.setFontSize(14);
				doc.text(25, produtoX, 'Tipo do Produto:');
				doc.text(116, produtoX, 'Quantidade (unidades):');
				doc.setFontType("normal");
				doc.setFontSize(14);
				doc.text(67, produtoX, productData[i].tipoProduto);
				doc.text(169, produtoX, quantidadePro.toString());

				produtoX = produtoX + 9;
				if(produtoX > 280){
					doc.addPage();
					produtoX = 20;
				}

				doc.setFontType("bold");
				doc.setFontSize(14);
				doc.text(25, produtoX, 'Valor Unitário:');
				doc.text(122, produtoX, 'Valor Total:');
				doc.setFontType("normal");
				doc.setFontSize(14);
				doc.text(62, produtoX, 'R$ ' +  valor.toString());
				doc.text(158, produtoX, 'R$ ' + total.toString());

				var loteData = sessionStorage.getItem('dataLote');
				loteData = JSON.parse(loteData);

				var loteX = produtoX;

				loteX = loteX + 10;
		 		if(loteX > 280){
		 			doc.addPage();
		 			loteX = 20;
		 		}

		 		doc.setFontType("bold");
		 		doc.setFontSize(18);
		 		doc.text(20, loteX, 'Lote');
		 		doc.setLineWidth(0.5);
		 		doc.line(19, loteX + 1, 190, loteX + 1);
		 		doc.setLineWidth(0.2);

				console.log("loteData " + loteData.length);
				 for(var y = 0; y < loteData.length; y++){
				 	console.log("y: " + y);
				 	console.log("loteCod: " + loteData[y].codProduto + "prodCod: " + productData[i].codigoProduto);
				 	if(loteData[y].codProduto == productData[i].codigoProduto){
	

				 		loteX = loteX + 9;
				 		if(loteX > 280){
				 			doc.addPage();
				 			loteX = 20;
				 		}

				 		doc.setFontType("bold");
				 		doc.setFontSize(14);
				 		doc.text(25, loteX, 'Código do Lote:');
				 		doc.text(136, loteX, 'Quantidade:');
				 		doc.setFontType("normal");
				 		doc.setFontSize(14);						 
				 		doc.text(62, loteX, loteData[y].codLote);
				 		doc.text(165, loteX, loteData[y].quantidade.toString());
						
				 		loteX = loteX + 8;
				 		if(loteX > 280){
				 			doc.addPage();
				 			loteX = 20;
				 		}

				 		doc.setFontType("bold");
				 		doc.setFontSize(14);
				 		doc.text(25, loteX, 'Data de Validade:');
				 		doc.setFontType("normal");
				 		doc.setFontSize(14);
				 		doc.text(71, loteX, loteData[y].validade);			
				 		doc.line(30, loteX + 3, 175, loteX + 3);

				 		loteX = loteX + 3;
				 		if(loteX > 280){
				 			doc.addPage();
				 			loteX = 20;
				 		}

				 	}
				 }
				produtoX = loteX;
				produtoX = produtoX + 10;
			}


//Fazer ainda
console.log("saiu");
			var valorX = produtoX + 20;
			if(valorX > 280){
				doc.addPage();
				valorX = 20;
			}

			//Valor TOTAL da venda
			doc.setFontType("bold");
			doc.setFontSize(16);
			doc.text(120, valorX, 'Valor Total: ');
			doc.setFontType("normal");
			doc.text(155, valorX, 'R$ ' + valorTotalDoRelatorio);



			doc.save($('#nomeRelatorio').val() + '.pdf');
			$('#salvarRelatorioComo').modal('hide');
    	} else {
    	 	$('#erroNomeVazio').fadeIn(200);
            $('#nomeRelatorioInputGroup').addClass('has-error');
    	}

        
    });
});




