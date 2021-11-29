<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boContent.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  	function delCheck() {
  		var ans = confirm('게시글을 삭제하시겠습니까?');
  		if(ans) location.href="${ctp}/boDelete.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately }";
  	}
  	function goodCheck2(flag) {
  		var query = {
  			idx : ${vo.idx},
  			flag : flag
  		}
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/boGood2.bo",
  			data : query,
  			success : function() {
  				location.reload();
  			}
  		});
  	}
  	function goodCheck3() {
  		var query = {
  			idx : ${vo.idx}
  		}
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/boGood3",
  			data : query,
  			success : function(data) {
  				if(data == "1") {
  					alert("이미 좋아요를 클릭하셨습니다.")
  				} else {
	  				location.reload();
  				}
  			}
  		});
  	}
  	function replyCheck() {
  		var content = replyForm.content.value;
  		if(content.trim() == "") {
  			alert("내용즘 입력해주시지?");
  			replyForm.content.focus();
  			return false;
  		} else {
  			replyForm.submit();
  		}
  	}
  	function boReplyUpdate(replyIdx) {
  		var query = {
  			idx : ${vo.idx},
  			pag : ${pag},
  			pageSize : ${pageSize},
  			lately : ${lately},
  			replyIdx : replyIdx
  		}
  		
  		$.ajax({
  			type: "post",
  			url: "${ctp}/boContent.bo",
  			data: query,
  			success: function(date) {
  				replyForm.content.value = data;
  			}
  		});
  	}
  	function replyUpdateCheck(replyIdx) {
  		var content = $("#content").val();
  		query = {
  			replyIdx: replyIdx,
  			content: content,
  			hostIp: "${pageContext.request.remoteAddr}"
  		}
  		
  		$.ajax({
  			type: "post",
  			url: "${ctp}/boReplyUpdateOk.bo",
  			data: query,
  			success: function() {
  				alert("댓글이 수정처리 되었습니다.");
  				location.reload();
  				location.href="${ctp }/boContent.bo?idx=${vo.idx }&pag=${pag}&pageSize=${pageSize }&lately=${lately }";
  			}
  		});
  	}
  	function replyDelCheck(replyIdx) {
  		var query = {replyIdx : replyIdx}
  		var ans = confirm("선택하신 댓글을 삭제하시겠습니까?");
  		if(!ans) return false;
  		
  		$.ajax({
  			type: "get",
  			url: "${ctp}/boReplyDelete.bo",
  			data: query,
  			success: function() {
  				alert("삭제처리 되었습니다.");
  				location.reload();
  			}
  		});
  	}
  	/* $(document).ready(function(){
  		for(let i = 1; i < 100; i++) {
	  		$("#repc"+i).hide();
  		}
  	});
  	function repfn(n) {
  		$("#repc"+n).show();
  		$("#replyView"+n).hide();
  	} */
  </script>
  <style>
  	th {
  		background-color: #ddd;
  		text-align: center;
  		width: 100px;
  	}
  </style>
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  
  <p><br></p>
  <div class="container">
		<h2 class="text-center">글 내 용 보 기</h2>
		<table class="table table-borderless">
			<tr>
				<th>글쓴이</th>
				<td>${vo.nickName } &nbsp;&nbsp; <a href="${ctp }/boGood.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&sw=search&lately=${lately }">👍(${vo.good })</a></td>
				<th>글쓴날짜</th>
				<td>${fn:substring(vo.wDate, 0, 19) }</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${vo.email }</td>
				<th>조회수</th>
				<td>${vo.readNum }</td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td>
					<c:if test="${fn:length(vo.homePage) > 10 }"><a href="${vo.homePage }" target="_blank">${vo.homePage }</a></c:if>
					<c:if test="${fn:length(vo.homePage) <= 10 }">- 없음 -</c:if>
				</td>
				<th>접속IP</th>
				<td>${vo.hostIp }</td>
			</tr>
			<tr>
				<td colspan="4"><a href="javascript:goodCheck2(1)">👍</a>(${vo.good })<a href="javascript:goodCheck2(-1)">👎</a></td>
			</tr>
			<tr>
				<th>글제목</th>
				<td colspan="3">${vo.title }<a href="javascript:goodCheck3()">💯(${vo.good })</a></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td colspan="3" style="height: 200px;">${fn:replace(vo.content, newLine, "<br>") }</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<c:if test="${sw != 'search' }">
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boList.bo?pag=${pag }&pageSize=${pageSize }&lately=${lately }';">
						<c:if test="${sMid == vo.mid }">
							<input type="button" value="수정하기" onclick="location.href='${ctp}/boUpdate.bo?idx=${vo.idx }&pag=${pag }&pageSize=${pageSize }&lately=${lately }';">
							<input type="button" value="삭제하기" onclick="delCheck()">
						</c:if>
					</c:if>
					<c:if test="${sw == 'search' }">
						<input type="button" value="돌아가기" onclick="history.back()">
					</c:if>
				</td>
			</tr>
		</table>
		<br>
		<!-- 이전글/다음글 처리 -->
		<c:if test="${sw != 'search'}">
			<table class="table table-borderless">
				<tr>
					<td>
						<c:if test="${nextVO.nextIdx != 0 }">
							<b>👆다음글</b>   <a href="${ctp }/boContent.bo?idx=${nextVO.nextIdx}&pag=${pag}&pageSize=${pageSize}&lately=${lately }">${nextVO.nextTitle }</a><br>
						</c:if>
						<c:if test="${preVO.preIdx != 0 }">
							<b>👇이전글</b>   <a href="${ctp }/boContent.bo?idx=${preVO.preIdx}&pag=${pag}&pageSize=${pageSize}&lately=${lately }">${preVO.preTitle }</a><br>
						</c:if>
					</td>
				</tr>
			</table>
		</c:if>
		<br>
		<!-- 댓글 출력/입력 처리부분 -->
		<!-- 댓글 출력 -->
		<table class="table">
			<tr>
				<th>작성자</th>
				<th>댓글내용</th>
				<th>작성일자</th>
				<th>접속IP</th>
			</tr>
			<c:forEach var="replyVO" items="${replyVOS }">
				<tr>
					<td class="text-center" style="width:10%">${replyVO.nickName }
						<%-- <p id="replyView${replyVO.idx }">${replyVO.nickName }</p> --%>
						<c:if test="${sMid == replyVO.mid }">
							<br><font size="3">(<a href="${ctp }/boContent.bo?replyIdx=${replyVO.idx }&idx=${vo.idx}&pag=${pag }&pageSize=${pageSize }&lately=${lately }">수정</a>/<a href="javascript:replyDelCheck(${replyVO.idx })">삭제</a>)</font>
							<%-- <br><font size="3">(<a href="javascript:boReplyUpdate(${replyVO.idx })">수정</a>/<a href="">삭제</a>)</font> --%>
							<%-- <br><font size="3">(<a href="javascript:repfn(${replyVO.idx })">수정1</a>/<a href="">삭제1</a>)</font> --%>
						</c:if>
					</td>
					<td>${fn:replace(replyVO.content, newLine, '<br>') }
					<%-- <textarea rows="1" name="repc" id="repc${replyVO.idx }" class="form-control">${replyVO.content }</textarea> --%>
					</td>
					<td class="text-center" style="width:20%">
						<c:if test="${vo.wNdate <= 24 }">${fn:substring(replyVO.wDate, 11, 19) }</c:if>
	  				<c:if test="${vo.wNdate > 24 }">${fn:substring(replyVO.wDate, 0, 10) }</c:if>
					</td>
					<td class="text-center" style="width:10%">${replyVO.hostIp }</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 댓글 입력 -->
		<form name="replyForm" method="post" action="${ctp }/boReplyInput.bo">
			<table class="table" >
				<tr>
					<td style="width:90%;">글내용 : <textarea rows="4" name="content" id="content" class="form-control">${replyContent}</textarea></td>
					<td style="width:10%;"><br>
						<p>작성자 : <br> ${sNickName }</p>
						<c:if test="${empty replyContent }"><p><input type="button" value="댓글달기" onclick="replyCheck()"/></p></c:if>
						<c:if test="${!empty replyContent }"><p><input type="button" value="수정하기" onclick="replyUpdateCheck(${replyIdx})"/></p></c:if>
					</td>
				</tr>
			</table>
			<input type="hidden" name="boardIdx" value="${vo.idx }"/>
			<input type="hidden" name="mid" value="${sMid }"/>
			<input type="hidden" name="nickName" value="${sNickName }"/>
			<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr }"/>
			<input type="hidden" name="pag" value="${pag }"/>
			<input type="hidden" name="pageSize" value="${pageSize }"/>
			<input type="hidden" name="lately" value="${lately }"/>
		</form>
  </div>
  <br>
  
  <%@ include file="/include/footer.jsp" %>
</body>
</html>