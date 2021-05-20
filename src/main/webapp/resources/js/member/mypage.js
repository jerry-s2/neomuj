$(document).ready(function(){

	$("#btnModifyInfo").on("click",function(){
		location.href="/member/mypage/mypage_modify";
	});
	
	
	$("#btnModifyPwd").on("click",function(){
		location.href="/member/mypage/mypage_modify_pw";
	});
	
	$("#btnDelete").on("click",function(){
		location.href="/member/mypage/mypage_delete";
	});
	
});


