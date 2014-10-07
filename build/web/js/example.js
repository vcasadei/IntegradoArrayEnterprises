$(document).ready(function() {
  var $template = $(".template");

  var hash = 1;
  $(".btn-add-panel").on("click", function () {
    var $newPanel = $template.clone();
    var aux = "<div class='col-lg-6 yes'><div class='form-group'><label>Código do Lote</label><input class='form-control' id='codigoLote' name='codigoLote' placeholder='Insira o código do lote' disabled><p class='help-block'>Deixe em branco para auto-gerar código</p></div><div class='col-lg-6 yes'><label>Data de Fabricação</label><div class='form-group input-group'data-date-format='dd-mm-yyyy'><input class='form-control' id='dataFabricacao' name='dataFabricacao' data-date-format='dd/mm/yyyy' placeholder='Clique e selecione' disabled></div></div><div class='col-lg-6yes'><label>Data de Validade</label><div class='form-group input-group' data-date-format='dd-mm-yyyy'><input class='form-control' id='dataValidade' name='dataValidade'data-date-format='dd/mm/yyyy' placeholder='Clique e selecione' disabled></div></div></div><div class='col-lg-6'><div class='form-group'><label>Unidades de Produto</label><input class='form-control' id='quantidadeProduto' name='quantidadeProduto' placeholder='Insira a quantidade do produto no lote' disabled></div><div class='form-group'><label>Observações</label><textarea class='form-control' id='observacoes' name='observacoes' rows='2' disabled></textarea></div></div><div class='col-lg-3'></div><div class='col-lg-9'></div><div class='col-lg-2'><button type='button' class='btn btn-primary' data-toggle='modal' data-target='#selecionarLote'>Selecionar Lote</button></div></div>";
    $newPanel.find(".collapse").removeClass("in");
    $newPanel.find(".accordion-toggle").attr("href",  "#" + (++hash))
    .text("Lote " + hash);
    $newPanel.find(".panel-collapse").attr("id", hash);
    $newPanel.find(".panel-heading").prepend("<span class='glyphicon glyphicon-remove-circle pull-right red' style='color:red ;'></span>");
    $newPanel.find(".panel-body").html(aux);
    $("#accordion").append($newPanel.fadeIn());
  });

  $(document).on('click', '.glyphicon-remove-circle', function () {
    
    $(this).parents('.panel').get(0).remove();

  });
});