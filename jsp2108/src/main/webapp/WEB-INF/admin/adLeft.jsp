<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <c:set var="ctp" value="<%=request.getContextPath()%>"/> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adLeft</title>
  <%@ include file="../../include/bs4.jsp" %>
  <script>
  	function logoutCheck() {
  		parent.location.href = "";
  	}
  </script>
  <style>
  	body {background-color: #ddd}
  </style>
</head>
<body>
  <p><br></p>
  <div class="container">
		<h6><a href="${ctp }/adContent.ad" target="adContent"><font color=black>관리자 메뉴</font></a></h6>
		<hr>
		<p><a href="${ctp}/adMemberList.ad" target="adContent">회원관리</a></p>		
		<hr>
		<p><a href="<%=request.getContextPath()%>/" target="_top">돌아가기</a></p>		
		<p><a href="javascript:logoutCheck()">로그아웃</a></p>		
		<hr>
  </div>
  <br>
</body>
</html>