<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<!-- css file -->
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<script src="/ckeditor/ckeditor.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
			<%@include file="/WEB-INF/views/admin/include/main-header.jsp" %>
			
	
		<!-- Left side column. contains the logo and sidebar -->
			<%@include file="/WEB-INF/views/admin/include/main-sidebar.jsp" %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Page Header <small>Optional description</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Level</a>
					</li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
	
	<div class="row">
		<div class="col-lg-12">
			<form id="searchForm" action="/admin/product/pro_list" method="get">
				<select name="type" id="type">
					<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
					<option value="N" <c:out value="${pageMaker.cri.type == 'N' ? 'selected':'' }" />>상품명</option>
					<option value="D" <c:out value="${pageMaker.cri.type == 'D' ? 'selected':'' }" />>상품설명</option>
					<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected':'' }" />>상품회사</option>
					<option value="ND" <c:out value="${pageMaker.cri.type == 'ND' ? 'selected':'' }" />>상품명 or 상품설명</option>
					<option value="NC" <c:out value="${pageMaker.cri.type == 'NC' ? 'selected':'' }" />>상품명 or 상품회사</option>
					<option value="NDC" <c:out value="${pageMaker.cri.type == 'NDC' ? 'selected':'' }" />>상품명 or 내용 or 상품회사</option>
				</select>
				<input type="text" name="keyword" value="${ pageMaker.cri.keyword}">
				<input type="hidden" name="pageNum" value="${ pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${ pageMaker.cri.amount}">
				<button id="btnSearch" type="button" class="btn btn-primary">검색</button>
			</form>
		</div>
	</div>
			

<!-- 상품리스트 -->
	<div class="row">
	  	<div class="col-lg-12">
	  		<div class="panel panel-default">
	  			<div class="panel-heading text-right">
	  			 <button id="regBtn" type="button" class="btn btn-primary pull-right">글쓰기</button>
	  			</div>
	  			
	  			<div class="panel-body">
	  			 <!-- 리스트 -->
	  			 <table class="table table-striped">
			  <thead>
			    <tr>
			      <th scope="col">번호</th>
			      <th scope="col">상품명</th>
			      <th scope="col">가격</th>
			      <th scope="col">작성일</th>
			      <th scope="col">상품표시</th>
			      <th scope="col">수정</th>
			      <th scope="col">삭제</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${pro_list }" var="proVO">
			    <tr>
			      <th scope="row"><c:out value="${proVO.pdt_num }"></c:out></th>
			      <td>
			      	<a class="move" href="${proVO.pdt_num }"><c:out value="${proVO.pdt_name }"></c:out></a>
			      	<img src="/admin/product/displayFile?fileName=${proVO.pdt_img}">
			      </td>
			      <td><fmt:formatNumber type="currency" value="${proVO.pdt_price }"></fmt:formatNumber>  </td>
			      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${proVO.pdt_date_sub }"/></td>
			      <td>
			      	<select>
			      		<option <c:out value="${proVO.pdt_buy == 'Y' ? 'selected':'' }"></c:out>>Y</option>
			      		<option <c:out value="${proVO.pdt_buy == 'N' ? 'selected':'' }"></c:out>>N</option>
			  	    </select>
			      </td>
			      <td>
			      	<button type="button" data-pdt_num="${proVO.pdt_num }" class="btn btn-primary btn-edit">수정</button>
			      </td>
			      <td>
			      	<button type="button" data-pdt_num="${proVO.pdt_num }" data-pdt_img="${proVO.pdt_img }" class="btn btn-danger btn-del">삭제</button>
			      </td>
			    </tr>
			   </c:forEach>
			   </tbody>
			</table>
	  			</div>
	  		</div>
	  	</div>
	  </div>
    
    <div class="row">
    	<div class="col-lg-12">
    	<!-- 페이징 표시 -->
    			<div class="panel-footer">
    			   <ul class="pagination">
    			   <c:if test="${pageMaker.prev }">
					    <li class="page-item">
					      <a href="${pageMaker.startPage - 1 }" class="page-link" href="#" tabindex="-1">Prev</a>
					    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${ pageMaker.endPage}" var="num">
				    	<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : ""}">
				    		<a href="${num }" class="page-link" href="#">${num }</a>
				    	</li>
				    </c:forEach>
				    <c:if test="${pageMaker.next }">
					    <li class="page-item">
					      <a href="${pageMaker.endPage + 1 }" class="page-link" href="#">Next</a>
					    </li>
				    </c:if>
				  </ul>
		
		    				<hr>
		    				${pageMaker }
    			</div>
    	</div>
    </div>
    
    <!-- 페이지번호클릭시, 수정클릭시 상품코드정보추가, 삭제클릭시 상품코드정보추가 -->
    <form id="actionForm" action="/admin/product/pro_list" method="get">
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
	</form>

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
			<%@include file="/WEB-INF/views/admin/include/main-footer.jsp" %>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
					<a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a>
				</li>
				<li>
					<a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;"> <i class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design
									<span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading">
								Report panel usage
								<input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->

	<%@include file="/WEB-INF/views/admin/include/scripts.jsp" %>

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
<script>

	$(document).ready(function(){
		/* ckEditor 작업 */
		// config.js를 사용하지 않고 개별 설정하는 부분
		var ckeditor_config = {
				resize_enabled : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				toolbarCanCollapse : true,
				removePlugins : "elementspath", 
				// 파일 업로드 기능 추가
				// CKEditor를 이용해 업로드 사용 시 해당 주소에 업로드 됨
				filebrowserUploadUrl: '/admin/product/imgUpload'
		};
		CKEDITOR.replace("pdt_detail", ckeditor_config);
		// config.js의 설정을 사용하려면, 다음과 같이 사용
		// CKEDITOR.replace("desc", "");

		//1차카테고리 선택
		$("#mainCategory").on("change", function(){
			var mainCategoryCode = $(this).val();
			var url = "/admin/product/subCategoryList/" + mainCategoryCode;

			$.getJSON(url, function(subCGListData){

				//2차카테고리 추가작업
				subCategoryList(subCGListData, $("#subCategory"),$("#subCGListTemplate"));

			});
		});

	});

</script>

<script>
	var subCategoryList = function(subCGListData, subCategoryTarget, subCategoryTemplate){
		var subCGTemplate = Handlebars.compile(subCategoryTemplate.html());
		var options = subCGTemplate(subCGListData);

		$("#subCategory option").remove(); //기존 option태그 제거
		subCategoryTarget.append(options); // 새로운 2차카테고리 option태그 추가
	}
</script>

<script id="subCGListTemplate" type="text/x-handlebars-template">
	<option value="default">2차카테고리 선택</option>
	{{#each .}}
	<option value="{{cg_code}}">{{cg_name}}</option>
	{{/each}}
</script>
<script src="/js/admin/product/insert.js"></script>

<script>
	
	$(document).ready(function(){

		var actionForm = $("#actionForm");
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();

			console.log("click");

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();


		});

		//수정클릭시

		$("table td .btn-edit").on("click", function(){
			console.log('수정');

			// 상품번호값을 필드로 추가작업
			actionForm.append("<input type='hidden' name='pdt_num' value='" + $(this).attr("data-pdt_num") + "'>");
			
			actionForm.attr("action", "/admin/product/modify");
			actionForm.submit();


		});

		// 삭제 클릭 시
		$("table td .btn-del").on("click", function(){
			actionForm.append("<input type='hidden' name='pdt_num' value='" + $(this).attr("data-pdt_num")+"'>");
			actionForm.append("<input type='hidden' name='pdt_img' value='" + $(this).attr("data-pdt_img")+"'>");

			actionForm.attr("action", "/admin/product/delete");
			actionForm.submit();
		});


		var searchForm = $("#searchForm");

		$("#searchForm #btnSearch").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}

			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 입력하세요");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");

			searchForm.submit();

		});



	});
	
	

</script>

</body>
</html>