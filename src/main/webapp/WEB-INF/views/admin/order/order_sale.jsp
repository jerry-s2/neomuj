<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 얘는 원래 session="true" 가 디폴트인데 그래야 {sessionScope} 를 쓸 수 있다. 이게 안 되어있으면 false 로 되어있는지 봐야 함 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- prefix="fmt 얘는 항상 뒤쪽에 와야 한다. fmt : 통화, 날짜, 숫자 기능 지원 -->

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
			<form id="format" action="/admin/order/order_sale" method="get">
				<c:set var="today" value="<%= new java.util.Date() %>" /> <!-- 자바코드를 가져다가 쓸 수 있음 -->
				<c:set var="year" ><fmt:formatDate value="${today }" pattern="yyyy"/></c:set>
				<c:set var="month" ><fmt:formatDate value="${today }" pattern="MM"/></c:set>
				<select name="year" id="type">
				<c:forEach begin="0" end="2" var="i" step="1">
					<option value="<c:out value="${year-2+i }" />
					<c:out value="${year-2+i }" />" ${(year-2+i ) == sel_year ? 'selected' : ''}><c:out value="${year-2+i }" />
					</option>
				</c:forEach>
				
				<c:forEach begin="1" end="2" var="i" step="1">
					<option value="<c:out value="${year+i }" />" ${(year+i) == sel_year ? 'selected' : '' }><c:out value="${year+i }" /></option>
				</c:forEach>
				</select>년
				<select name="month" id="type">
					<c:forEach begin="1" end="12" var="i" step="1">
					<fmt:formatNumber var="dal" minIntegerDigits="2" value="${i }" type="number" />
					<fmt:formatNumber var="cur_month" minIntegerDigits="2" value="${month }" type="number" />
						<option value="${dal }" ${dal == sel_month ? 'selected' : '' }>${dal }</option>
					</c:forEach>
				</select>월
				<button id="btnSearch" type="submit" class="btn btn-primary">검색</button>
				
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
			      <th scope="col">일별통계</th>
			      <th scope="col">주문건수</th>
			    </tr>
			  </thead>
			  <tbody>
			  											<!-- varStatus : 상태변수 -->
			  <c:forEach items="${order_salelist }" var="orderSaleDTO">
			    <tr>
			      <th scope="row"> 
			     	${orderSaleDTO.hiredate }(${orderSaleDTO.day })
			     </th>
				<td>
				 	${orderSaleDTO.cnt}
				</td>
				
				  <!-- <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${orderVO.odr_date }"/></td> --> 

			    </tr>
			   </c:forEach>
			   </tbody>
			</table>
	  			</div>
	  		</div>
	  	</div>
	  </div>

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


</body>
</html>