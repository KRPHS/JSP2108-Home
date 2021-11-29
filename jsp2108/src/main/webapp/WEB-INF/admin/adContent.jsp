<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="../../include/bs4.jsp" %>
</head>
<body>
  <p><br></p>
  <div class="container">
		<h2>작업 상황</h2>
		<hr>
		<p><a href="${ctp}/adMemberList.ad?level=1">신규 가입자(<font color="red"><b>${newMember }</b></font>건)</a></p>
		<hr>
		<p><a href="#">최근 게시글(<font color="red"><b>xx</b></font>건)</a></p>
		<p><a href="#">최근 게시글의 댓글(<font color="red"><b>xx</b></font>건)</a></p>
		<hr>
		<p><a href="#">최근 방목록(<font color="red"><b>xx</b></font>건)</a></p>
		<hr>
		<p><a href="#">최근 접속자(<font color="red"><b>xx</b></font>건)</a></p>
		<hr>
		<p>오늘 방문횟수 <font color="red"><b>xx</b></font>건</p>
  </div>
  <br>
</body>
</html>