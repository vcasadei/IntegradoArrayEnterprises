$(document).ready(function() {
	$('#header2').load('header.html');

	$('#logout').click(function(e){
		alert("clicou pra sair");
        sessionStorage.clear();
        window.location = "login.html";
    });

	function isAdm(){
		var userSession = sessionStorage.getItem( "userData" );
		if(userSession != null){
			var userObj = JSON.parse(userSession);

			console.log(userObj.tipo);
			if(userObj.tipo == "adm"){

				return true;
			} else {
				return false;
			}
		}
		return false;
	}

	if(!isAdm()){
	    $(".somenteAdm").addClass('hidden');
	} else {
	    $(".somenteAdm").removeClass('hidden');
	}

	
});
