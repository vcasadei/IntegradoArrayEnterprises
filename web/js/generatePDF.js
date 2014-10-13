
$(document).ready(function() {
    $('#salvarRelatorioNome').click(function(){
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
			    subject: 'Vendas dia ' + $('#dataVendaModal').val() + ' - ' + 'Vitor Casadei',
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
			doc.text(70, 30, $('#dataVendaModal').val() );

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
			doc.text(65, 48, $('#nomeClienteModal').val());
			doc.text(146, 48, $('#cnpjClienteModal').val());

			doc.setFontType("bold");
			doc.setFontSize(18);
			doc.text(20, 58, 'Produto');
			doc.setLineWidth(0.5);
			doc.line(19, 59, 190, 59);
			doc.setLineWidth(0.2);

			doc.setFontType("bold");
			doc.setFontSize(14);
			doc.text(25, 66, 'Nome do Produto:');
			doc.text(136, 66, 'Código:');
			doc.setFontType("normal");
			doc.setFontSize(14);
			doc.text(67, 66, $('#nomeProdutoModal').val());
			doc.text(155, 66, $('#codProdutoModal').val());

			doc.setFontType("bold");
			doc.setFontSize(14);
			doc.text(25, 74, 'Tipo do Produto:');
			doc.text(116, 74, 'Quantidade (unidades):');
			doc.setFontType("normal");
			doc.setFontSize(14);
			doc.text(67, 74, $('#tipoProdutoModal').val());
			doc.text(169, 74, $('#quantidadeModal').val());

			doc.setFontType("bold");
			doc.setFontSize(14);
			doc.text(25, 83, 'Valor Unitário:');
			doc.text(122, 83, 'Valor Total:');
			doc.setFontType("normal");
			doc.setFontSize(14);
			doc.text(62, 83, 'R$ ' +  $('#valorUnitarioModal').val() );
			doc.text(158, 83, 'R$ ' + $('#valorTotalModal').val());

			
			//Relatorio Automatico
			var quantos = parseInt($('#quantidadeParaRelatorio').val());
			console.log("quantos=" + quantos);
			doc.setFontType("bold");
			doc.setFontSize(18);
			doc.text(20, 93, 'Lote');
			doc.setLineWidth(0.5);
			doc.line(19, 94, 190, 94);
			doc.setLineWidth(0.2);

			var i = 1;
			var local1 = 101;
			var local2 = 110;
			var auxI = 0;
			var auxj = 0;
			var aux = "";
			while(quantos > 0){

				

				doc.setFontType("bold");
				doc.setFontSize(14);
				doc.text(25, local1 + auxI, 'Código do Lote:');
				doc.text(136, local1 + auxI, 'Quantidade:');
				doc.setFontType("normal");
				doc.setFontSize(14);
				console.log("i=" + i);
				 aux = $('#codParaRelatorio' + (i).toString()).val();
				doc.text(62, local1 + auxI, aux);
				i++;
				console.log("i=" + i);
				 aux = $('#quantidadeParaRelatorio' + (i).toString()).val();
				doc.text(165, local1 + auxI, aux);
				i++;

				doc.setFontType("bold");
				doc.setFontSize(14);
				doc.text(25, local2 + auxI, 'Data de Validade:');
				doc.setFontType("normal");
				doc.setFontSize(14);
				 aux = $('#validadeParaRelatorio' + (i).toString()).val();
				doc.text(71, local2 + auxI, aux);
				i++;
				doc.line(30, local2 + auxI + 3, 175, local2 + auxI + 3);

				local1 = local2 + 6;
				local2 = local2 + 9 + 6;
				auxI = auxI + 9;
				quantos--;

			}

			


			//Valor TOTAL da venda
			doc.setFontType("bold");
			doc.setFontSize(16);
			doc.text(120, 280, 'Valor Total: ');
			doc.setFontType("normal");
			doc.text(155, 280, 'R$ ' + $('#valorTotalModal').val());
			doc.setLineWidth(0.7);
			doc.line(114, 284, 202, 284);
			doc.line(114, 272, 202, 272);
			doc.line(114, 272, 114, 284);
			doc.line(202, 272, 202, 284);


			doc.save($('#nomeRelatorio').val() + '.pdf');
			$('#salvarRelatorioComo').modal('hide');
    	} else {
    		$('#erroNomeVazio').fadeIn(200);
            $('#nomeRelatorioInputGroup').addClass('has-error');
    	}

        
    });
});




