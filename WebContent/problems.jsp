<%@ page import="datateam.BaekjoonCrawler,java.util.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.*" %>
<%
	Database db = new Database();
	request.setCharacterEncoding("UTF-8");
	BaekjoonCrawler boj = new BaekjoonCrawler((Map<String, String>)session.getAttribute("cookie"));
	String userid = (String)session.getAttribute("name");
	ArrayList<String> problems = boj.crawlSolvedProblem(userid);
	ArrayList<String> unproblems = boj.crawlUnsolvedProblem(userid);
	ArrayList<String> problems_kimjuho = boj.crawlSolvedProblem_kimjuho(userid);
	ArrayList<String> unproblems_kimjuho = boj.crawlUnsolvedProblem_kimjuho(userid);
	db.insert(userid, "solvedproblem", problems_kimjuho);
	db.insert(userid, "unsolvedproblem", unproblems_kimjuho);
	ArrayList<String[]> ans = db.readUserdata(userid, "solvedproblem");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>BAEKJOON.GG</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['line']});
	google.charts.setOnLoadCallback(drawChart);	
	function drawChart() {
	    var data = new google.visualization.DataTable();
	    data.addColumn('string', '');
	    data.addColumn('number', '푼 문제 수');
	    <%
		    for(int i = 0 ; i < ans.size(); ++i) {
		    	out.println("data.addRow([\'" +ans.get(i)[0] + "\', " + ans.get(i)[1] + "]);");
		    }
	    %>
	    var options = {
			chart: {
	        	title: '<%=userid%>' + '님이 푼 문제 수 그래프',
			},
	      	width: 700,
	      	height: 400
	    };
	    var chart = new google.charts.Line(document.getElementById('linechart_material'));
	    chart.draw(data, google.charts.Line.convertOptions(options));
	}
	function change(val) {
		var value = val;
		document.getElementById("problem").value = value;
		document.getElementById("send").submit();
	}
</script>
<body>

<header id="header">
				<div class="inner">
					<a href="start.jsp" class="logo">BACKJOON.GG</a>
					<nav id="nav">
						<a href="problems.jsp">내정보</a>
						<a href="login.jsp">로그 아웃</a>
					</nav>
				</div>
</header>

			<section id="one">
				<div class="inner">

<center>
		<p id="data"> </p>
		<div id='linechart_material'></div>
		<form action="sourcelist.jsp" id="send" method="post">
			<input type="hidden" name="problem" id="problem">
			<div style=\"line-height:130%\"></br>
				<h2 style="color:green">내가 푼 문제</h2>
					<h3 style="color:MediumSeaGreen; line-height:100%; font-size:15px">
						<%
							for ( int i = 0; i < problems.size(); i++ )
								out.print(problems.get(i));
						%>
					</h3>
			</div>
			<div style=\"line-height:130%\">
				<h2 style="color:red">틀린 문제</h2>
					<h3 style="color:Tomato; line-height:100%; font-size:15px">
						<%
							for ( int i = 0; i < unproblems.size(); i++ )
								out.print(unproblems.get(i)+"\t");
						%>
					</h3>
			</div>
		</form>
</center>
				</div>
			</section>

</body>
</html>