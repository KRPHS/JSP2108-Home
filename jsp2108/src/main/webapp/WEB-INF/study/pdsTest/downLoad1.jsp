<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>downLoad1.jsp</title>
<%@ include file="/include/bs4.jsp"%>
</head>
<body>
	<%@ include file="/include/header_guest.jsp"%>
	<%@ include file="/include/nav.jsp"%>
	<p><br></p>
	
	<div class="container">
		<h2>파일 다운로드 테스트</h2>
		<p>(서버에 저장되어 있는 파일 리스트)</p>
		<p>${ctp }/data/pdsTest/*.*</p>
		<hr>
		<table class="table table-hover text-center">
			<tr>
				<th>번호</th>
				<th>파일명</th>
				<th>그림파일/일반파일</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="file" items="${files }" varStatus="st">
				<tr>
					<td>${st.count }</td>
					<td>${file }</td>
					<td>
						<c:set var="fNameArr" value="${fn:split(file,'.') }"/>
						<c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1]) }"/>
						<c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'}">
							<%-- <a href="${ctp }/data/pdsTest/${file}" download="${file }"> --%>
							<a href="${ctp }/fileDownLoad?file=${file}">
								<img src="${ctp }/data/pdsTest/${file}" width="150px">
							</a>
						</c:if>
						<c:if test="${extName != 'jpg' && extName != 'gif' && extName != 'png'}">
							<a href="${ctp }/data/pdsTest/${file}" download="${file }">${file }</a>
						</c:if>
					</td>
					<td><a href="${ctp }/fileDelete?file=${file}" class="btn btn-danger btn-sm">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<hr>
	<div class="row">
		<div class="col"><a href="${ctp }/pdsTest1.st" class="btn btn-secondary">싱글파일 업로드폼으로 돌아가기</a></div>
		<div class="col"><a href="${ctp }/pdsTest2.st" class="btn btn-secondary">멀티파일 업로드폼1으로 돌아가기</a></div>
		<div class="col"><a href="${ctp }/pdsTest3.st" class="btn btn-secondary">멀티파일 업로드폼2으로 돌아가기</a></div>
	</div>
	<br>
	<%@ include file="/include/footer.jsp"%>
</body>
</html>