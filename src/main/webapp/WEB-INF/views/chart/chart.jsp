<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="/WEB-INF/views/common/config.jsp" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load('current', {'packages':['corechart'] }  );
    //google.charts.load('current', {'packages':['bar']}); 
    
    google.charts.setOnLoadCallback(drawChart); // drawChart()함수 호출
    
    function drawChart() {
    	
        var jsonData = $.ajax({
            url : "/chart/chartData", // 주소를 호출하면 구글에서 요구하는 차트데이터 포맷에 맞게 데이타를 json형태로 받아온다.
            type: "get",
            dataType : "json",
            // async : 비동기 방식 / async : false -> 동기방식이라는 뜻
            /*
           	ajax 를 쓰는 목적은
            서버측에 데이터를 요청한 후, 그 데이터의 수신이 완료될 때까지 기다리지 않고, 다른 작업을 바로 진행할 수 있다.
            하지만 async : false 를 써서 동기방식으로 쓸 수도 있다.
            */
            async : false,

        }).responseText;  // json 내용을 텍스트로 읽어들임.
        
        console.log(jsonData);

        var data
        = new google.visualization.DataTable(jsonData);
        //제이슨 형식을 구글의 테이블 형식으로 바꿔주기 위해서 집어넣음
        //차트를 출력할 div
        //LineChart, ColumnChart, PieChart에 따라서 차트의 형식이 바뀐다.
        
        var chart = new google.visualization.PieChart(document.getElementById('chart_div')); //원형 그래프
        
        //var chart
        // = new google.visualization.LineChart(
                //document.getElementById('chart_div')); 선 그래프 
                
        //var chart
        //  = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                //차트 객체.draw(데이터 테이블, 옵션) //막대그래프
                
                //cuveType : "function" => 곡선처리
                
       //데이터를 가지고 (타이틀, 높이, 너비) 차트를 그린다.
       chart.draw(data, {
           title : "차트 예제",
           //curveType : "function", //curveType는 차트의 모양이 곡선으로 바뀐다는 뜻
           width : 600,
           height : 400
       });
    }
</script>

<script>
    $(document).ready(function(){

        $("#btnChart").on("click", function(){
            drawChart();
        }); // drawChart()
    });

</script>
</head>
<body>

	<div id="chart_div"></div>
	<button id="btnChart" type="button">클릭!!!</button>
</body>
</html>