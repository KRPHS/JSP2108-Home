<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
	  function inputCheck() {
	  	var name = $("#name").val();
	  	var age = $("#age").val();
	  	var idx = $("#idx").val();
	  	
	  	if(name == "") {
	  		alert("성명을 입력하세요!");
	  		$("#name").focus();
	  		return false;
	  	} else if (age == "") {
	  		alert("나이을 입력하세요!");
	  		$("#age").focus();
	  		return false;
	  	}
	  	
	  	var query = {
	  			name : name,
	  			age  : age,
	  			idx : idx
	  	}
	  	
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/userUpdateOk",
	  		data : query,
	  		success : function(data) {
	  			if(data == "1") {
	  				alert("수정성공!");
	  				location.href='${ctp}/ajax1.st';
	  			}
	  		}
	  	});
	  }
  </script>
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  
  <p><br></p>
  <div class="container">
		<form name="inputForm">
	  	<table class="table table-bordered">
		  	<tr style="text-align:center;">
    	  	<th colspan="2"><h3>${vo.name } 님의 정보 수정</h3></th>
  			</tr>
    		<tr>
      		<th>성명</th>
      		<td><input type="text" name="name" id="name" class="form-control" autofocus required value="${vo.name }" /></td>
      	</tr>
      	<tr>
	        <th>나이</th>
        	<td><input type="number" name="age" id="age" value="${vo.age }" class="form-control"/>
        		<input type="hidden" id="idx" value="${vo.idx }"/>
        	</td>
      	</tr>
      	<tr>
	        <td colspan="2" style="text-align:center;">
          	<input type="button" value="수정" onclick="inputCheck()" class="btn btn-secondary"/>
          	<input type="button" value="돌아가기" onclick="javascript:location.href='${ctp}/ajax1.st';" class="btn btn-secondary"/>
        	</td>
      	</tr>
    	</table>
  	</form>
  </div>
  <br>
  
  <%@ include file="/include/footer.jsp" %>
</body>
</html>