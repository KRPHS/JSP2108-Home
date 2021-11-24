<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memInfor</title>
  <%@ include file="/include/bs4.jsp" %>
  
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  
  <p><br></p>
  <div class="container">
		<h2>회 원 정 보</h2>
		<br>
		<table class="table">
			<tr><td>아이디 : ${vo.mid }</td></tr>
			<tr><td>닉네임 : ${vo.nickName }</td></tr>
			<tr><td>성함 : ${vo.name }</td></tr>
			<tr><td>성별 : ${vo.gender }</td></tr>
			<tr><td>생일 : ${fn:substring(vo.birthday, 0, 10)}</td></tr>
			<tr><td>전화번호 : ${vo.tel }</td></tr>
			<tr><td>주소 : ${vo.address }</td></tr>
			<tr><td>이메일 : ${vo.email }</td></tr>
			<tr><td>홈페이지주소 : ${vo.homePage }</td></tr>
			<tr><td>직업 : ${vo.job }</td></tr>
			<tr><td>취미 : ${vo.hobby }</td></tr>
			<tr><td>사진 : <img src="images/${vo.photo }" width="100px"></td></tr>
			<tr><td>소개 : ${fn:replace(vo.content, newLine, '<br>') }</td></tr>
		</table>
		<hr>
		<a href="${ctp }/memList.ad" class="btn btn-secondary">돌아가기</a>
  </div>
  <br>
  
  <%@ include file="/include/footer.jsp" %>
</body>
</html>