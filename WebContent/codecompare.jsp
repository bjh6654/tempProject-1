<%@ page import="datateam.BaekjoonCrawler,swTeam.CodeCompare,swTeam.SourceAnalysis,java.util.*" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
   <style>
      .code {
         border:inset 2px silver; 
         width:700px;
         height:800px; 
         padding:1 1 1 1;
         font-size:9pt; 
         overflow:auto;
      }
   </style>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
BaekjoonCrawler boj = new BaekjoonCrawler((Map<String, String>)session.getAttribute("cookie"));
   String code1 = boj.getSource(request.getParameter("code1"));
   String code2 = boj.getSource(request.getParameter("code2"));
   CodeCompare cp = new CodeCompare(code1, code2);
%>
<div style='display:inline; width:1200px;'>
<div class="code" style="float:left">
<h2> ���� ��ȣ : <%=request.getParameter("code1") %> </h2>
<pre>
<%
out.print(cp.printCode(0));
%>
</pre>
</div>
<div class="code">
<h2> ���� ��ȣ : <%=request.getParameter("code2") %> </h2>
<pre>
<%
out.print(cp.printCode(1));
%>
</pre>
</div>
</div>
</body>
</html>