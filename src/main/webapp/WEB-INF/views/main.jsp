<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.80.0">


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Study Neomuj - Bootstrap v4.6</title>

<%@include file="/WEB-INF/views/common/config.jsp"%>
<script>
	var message = '${status}';

	if (message == 'loginSuccess') {
		alert('로그인이 되었습니다.');
	} else if (message == 'loginIDFail') {
		alert('아이디가 틀립니다.');
	} else if (message == 'loginPWFail') {
		alert('비밀번호가 틀립니다.');
	} else if (message == 'logout') {
		alert('로그아웃되었습니다.');
	} else if (message == 'modifySuccess') {
		alert('회원정보가 수정되었습니다.');
	} else if (message == 'insertSuccess') {
		alert('회원가입을 축하합니다.');
	} else if (message == 'regdelete') {
		alert('정상적으로 탈퇴되었습니다.');
	} else if (message == "modifyPwSuccess"){
		alert('비밀번호가 변경되었습니다.')
	}
</script>

<meta name="theme-color" content="#563d7c">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

div#position{
	top: 50%;

}
</style>

</head>
<body>

	<!-- nav.jsp -->
	<%@include file="/WEB-INF/views/common/nav.jsp"%>

	<main role="main" class=".container-fluid">

		<div class="row">
			<!-- 카테고리 목록 -->
			<div class="col-2" style="background-color: white; color:black;">
				<%@include file="/WEB-INF/views/common/category_list.jsp"%>
			</div>

			<!-- carousel -->
			<div class="col-10">

				<div id="carouselExampleInterval" class="carousel slide"
					data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active" data-interval="2000">
							<img
							border="0" src="/img/img1.jpg" class="d-block w-100" alt="행사1" />
						</div>
						<div class="carousel-item" data-interval="2000">
							<img
							border="0" src="/img/img2.jpg" class="d-block w-100" alt="행사2" />
						</div>
						<div class="carousel-item" >
							<img
							border="0" src="/img/img3.jpeg" class="d-block w-100" alt="행사3" />
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleInterval"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleInterval"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>

			</div>
			
		</div>
		
		
		<!-- content -->
		
		<hr>
		
		<div class="row"style="text-align:center">			
			<div class="col-5" id="position">
				<h2>NEOMUJ 맨유 유니폼 입점</h2>
				<p>맨체스터 유나이티드 유니폼 이젠 NEOMUJ에서 !</p>				
			</div>
			<div class="col-7">
				<img alt="맨유 유니폼" src="/img/manu.gif" class="w-100">
			</div>
		</div>
		
		<hr>
		

		
	
	<!-- /.container -->

	<!-- footer -->
	<div class="text-center">
		<hr>
		<ul style="list-style: none">
			<li>회사소개</li>
			<li>개인정보취급방침</li>
			<li>이용약관</li>
			<li>고객센터</li>
		</ul>

		<div class="row">
			<div class="col-md-12">
				<p>주소 : 서울 강남구 역삼동 | 사업자등록번호 : 123-10-789143</p>
				<p>통신판매업신고번호 : 41-456-2589 | 개인정보관리자 : 홍길동 | 대표 : 홍길동 | 상호명 :
					NEOMUJ</p>
				<p>전화번호 : 02-777-7777 | 팩스번호 : 02-8888-8888 | 메일 :
					admin@neomuj.co.kr</p>
			</div>
		</div>
	</div>
	</main>


</body>
</html>