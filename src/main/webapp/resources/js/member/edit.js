$(document).ready(function(){

    var form = $("#modifyForm");

    

    $("#btn_modify_info").on("click", function(){

        //유효성검사 제외
        form.submit();

    });
    
    $("#btn_cancel").on("click", function(){
		
		var result = confirm("회원 정보 수정을 취소하시겠습니까?");
		if(result){
			location.href="/"; 
		} else{}
	});

});


