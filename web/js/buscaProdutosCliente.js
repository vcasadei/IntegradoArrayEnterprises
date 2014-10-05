
var $ = jQuery.noConflict();

$(document).ready(
        function()
        {

            $('#SelecionarCliente-bt').click(function(){
                console.log("ahoy");
                $.ajax({
                    type: "GET",
                    url: "BuscarTodosClientes",
                    dataType: "html",
                    data: {uf: "x"}
                }).done(function(data) {
                    $('#tabelaCliente').html(data);
                });
            });

        });