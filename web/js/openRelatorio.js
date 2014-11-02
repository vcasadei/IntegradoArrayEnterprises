
    function gerarRelatorioPorVenda(data){
    	var auxDados = data.split(";");
    	console.log("Gerando PDF.....");

    	var codVenda = auxDados[1];
    	var dataVenda = auxDados[2];
    	var auxDataVenda = dataVenda.split('-');
    	dataVenda = auxDataVenda[2] + "-" + auxDataVenda[1] + "-" + auxDataVenda[0];
    	auxDataVenda = auxDataVenda[2] + "/" + auxDataVenda[1] + "/" + auxDataVenda[0];
    	
    	var valorTotal = auxDados[3];
    	var codCliente = auxDados[4];
    	var cnpj = auxDados[5];
    	var clienteNome = auxDados[6];
    	var ramoCliente = auxDados[7];

    	var qtdeProdutos = parseInt(auxDados[8]);



    	var doc = new jsPDF();
    	//Set PDF properities
		doc.setProperties({
		    title: 'Relório de Vendas',
		    subject: 'Vendas ArrayEnterprises',
		    author: 'ArrayEnterprises',
		    keywords: 'pdf, relatorio, vendas',
		    creator: 'AE'
		});

		doc.setFont("times");
		doc.setFontType("bold");
		doc.setFontSize(24);
		doc.text(70, 20, 'Relatório de Vendas');

		doc.line(68, 22, 145, 22);

		doc.setFontType("bold");
		doc.setFontSize(16);
		doc.text(30, 30, 'Data da Venda: ');
		doc.setFontType("normal");
		doc.text(70, 30, auxDataVenda );

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
		doc.text(65, 48, clienteNome);
		doc.text(146, 48, cnpj);

		var produtoX = 58;
		console.log("Chegou antes dos produtos");

		//é indice 8
		var o = 8;
		var add = 0;
		console.log("produtctData " + qtdeProdutos);
		for(var i = 0; i < qtdeProdutos; i++){

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
			doc.text(67, produtoX, auxDados[o + 3]);
			doc.text(155, produtoX, auxDados[o + 1]);


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
			doc.text(67, produtoX, auxDados[o + 4]);
			doc.text(169, produtoX, auxDados[o + 2]);

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
			doc.text(62, produtoX, 'R$ ' +  auxDados[o + 5]);
			doc.text(158, produtoX, 'R$ ' + auxDados[o + 6]);



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

	 		var qtdeLotes = parseInt(auxDados[o + 7]);
			console.log("loteData " + qtdeLotes);
			var oLote = o + 7;
			 for(var y = 0; y < qtdeLotes; y++){

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
		 		doc.text(62, loteX, auxDados[oLote + 1]);
		 		doc.text(165, loteX, auxDados[oLote + 4]);
				
		 		loteX = loteX + 8;
		 		if(loteX > 280){
		 			doc.addPage();
		 			loteX = 20;
		 		}

		 		var validadeLote = auxDados[oLote + 5].split("-");
		 		validadeLote = validadeLote[2] + "/" + validadeLote[1] + "/" + validadeLote[0];
		 		doc.setFontType("bold");
		 		doc.setFontSize(14);
		 		doc.text(25, loteX, 'Data de Validade:');
		 		doc.setFontType("normal");
		 		doc.setFontSize(14);
		 		doc.text(71, loteX, auxDados[oLote + 5]);			
		 		doc.line(30, loteX + 3, 175, loteX + 3);

		 		loteX = loteX + 3;
		 		if(loteX > 280){
		 			doc.addPage();
		 			loteX = 20;
		 		}

		 		oLote = oLote + 5;
			 	
			 }
			o = oLote;
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
		doc.text(155, valorX, 'R$ ' + valorTotal);



		// doc.save("RelatorioVenda" + dataVenda + '.pdf');
		doc.output('dataurlnewwindow');



    }






