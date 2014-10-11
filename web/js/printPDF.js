
$(document).ready(function() {
    $('#printRelatorioNome').click(function(){
    	console.log('mandou imprimir');
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


			doc.setFontType("bold");
			doc.setFontSize(18);
			doc.text(20, 93, 'Lote');
			doc.setLineWidth(0.5);
			doc.line(19, 94, 190, 94);
			doc.setLineWidth(0.2);

			doc.setFontType("bold");
			doc.setFontSize(14);
			doc.text(25, 101, 'Código do Lote:');
			doc.text(136, 101, 'Quantidade:');
			doc.setFontType("normal");
			doc.setFontSize(14);
			doc.text(62, 101, '3244');
			doc.text(165, 101, '24');

			doc.setFontType("bold");
			doc.setFontSize(14);
			doc.text(25, 110, 'Data de Fabricação:');
			doc.text(122, 110, 'Data de Validade:');
			doc.setFontType("normal");
			doc.setFontSize(14);
			doc.text(71, 110, '02/04/2013');
			doc.text(163, 110, '02/04/2016');


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

			doc.output('dataurlnewwindow');

			$('#salvarRelatorioComo').modal('hide');
    	} else {
    		$('#erroNomeVazio').fadeIn(200);
            $('#nomeRelatorioInputGroup').addClass('has-error');
    	}

        
    });
});




