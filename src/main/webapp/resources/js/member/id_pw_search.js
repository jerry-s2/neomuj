$(document).ready(function(){

    // 비밀번호 찾기 : 메일전송
    $("#btn_PW_Search").on("click", function(){

        var userInfo = {mem_id:$("#mem_id").val() , mem_name: $("#mem_name").val()};

        $.ajax({
            url : '/member/pw_search',
            type: 'get',
            data: {id : 'jerry'},
            dataType: 'text',
            success: function(data){
                // 비밀번호 출력작업

                if(data == "SUCCESS"){
                    alert("임시 비밀번호를 가입하신 메일로 전송하였습니다.");

                }else{
                    $("#result").html("입력정보가 틀립니다.");
                }
            }
        });
    });

    
    // 아이디찾기 : 화면출력
    $("#btn_ID_Search").on("click", function(){
       
        $.ajax({
            url : '/member/find_id',
            type: 'post',
            data: { mem_name: $("#mem_name").val()},
            dataType: 'text',
            success: function(data){
                // 비밀번호 출력작업

                if(data != ""){
                    $("#result").html($("#mem_name").val() + " 님의 아이디는? "  + data + " 입니다.");

                }else{
                    $("#result").html("입력정보가 틀립니다.");
                }

                $("#mem_name").val("");
            }
        });
    });

});