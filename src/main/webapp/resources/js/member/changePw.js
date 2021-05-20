$(document).ready(function(){
	
	var form = $("#modifyPwdForm");
	
	var mem_pw = $("#mem_pw");
	var mem_pw_change = $("#mem_pw_change");
	var mem_pw_check = $("#mem_pw_check");
	
	/* 확인 버튼 클릭 시 */
	$("#btn_modify_pw").on("click", function(){
		// 유효성 검사
		if(mem_pw.val()==null || mem_pw.val()==""){
			alert("현재 비밀번호를 입력해주세요.");
			mem_pw.focus();
			return;
			
		} else if(mem_pw_change.val() ==null || mem_pw_change.val() ==""){
			alert("변경할 비밀번호를 입력해주세요.");
			mem_pw_change.focus();
			return;
			
		} else if(mem_pw_check.val() ==null || mem_pw_check.val() ==""){
			alert("변경할 비밀번호 확인 란을 입력해주세요.");
			mem_pw_check.focus();
			return;
			
		} else if(mem_pw_change.val() != mem_pw_check.val()){
			alert("변경할 비밀번호와 비밀번호 확인 란의 비밀번호가 다릅니다.");
			
			mem_pw_change.val("");
			mem_pw_check.val("");
			mem_pw_change.focus();
			return;
		}
		
		
		// 현재 비밀번호 확인 검사
		var mem_pw_val = mem_pw.val();
		
		$.ajax({
			url: "/member/mypage/mypage_modify_pw",
			type: "post",
			datatype: "text",
			data: {mem_pw : mem_pw_val},
			success: function(data){
				if(data=='SUCCESS'){
					form.submit();
					alert("비밀번호가 변경되었습니다.")
					location.href="/member/mypage/mypage_modify_pw"
					
				} else{
					alert("현재 비밀번호가 다릅니다.");
					mem_pw.val("");
					mem_pw.focus();
				}
			} 
		});
		
	});
	
	$("#btn_cancle").on("click", function(){
		
		var result = confirm("비밀번호 변경을 취소하시겠습니까?");
		if(result){
			location.href="/"; 
		} else{}
	});
});