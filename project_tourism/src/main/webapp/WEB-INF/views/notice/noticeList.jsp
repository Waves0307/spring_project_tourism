<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script>
	function list(page) {
		location.href="noticeList?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
	}
	function regFo() {
		location.href="regForm";
	}
</script>
<style type="text/css">
	body {
		max-width: 1200px;
		margin : 20px auto;
		padding : 10px;
	}
	table {
    	width: 100%;
    	border-top: solid #444444;
    	border-collapse: collapse;
  	}
  	th, td {
    	border-bottom: 1px solid #444444;
    	padding: 10px;
  	}
	
	.btnGreen01 { 
		display:inline-block; 
		width:60px; 
		height:25px; 
		padding:2px 0;
		border-radius: 0.5pt;
		border-color: #262626; 
		text-align:center; 
		font-family:NGBold; 
		font-size:13px; 
		color:#fff; 
		background: #069370; 
	}
</style>
</head>
<body>
	<c:import url="../default/header.jsp"/>
		<div style="text-align: center">
			<h2>공지사항</h2>
		</div>
		<table>
			<colgroup>
				<col style="width:5%;">
				<col style="width:auto;">
				<col style="width:10%;">
				<col style="width:10%;">
			</colgroup>
			<thead>
				<tr>
					<th style="height: 30px;">NO</th>
					<th>글제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
				<c:choose>
					<c:when test="${map.list.size() != 0}">
						<c:forEach var="brd" items="${map.list}">
							<tr>
								<td style="text-align: center;">${brd.notice_no }</td>
								<td style="padding: 5px 0 5px 25px;">
								<a href="getDetail?no=${brd.notice_no }" style="text-decoration: none;">
								${brd.notice_title }
								</a>
								</td>
								<td style="text-align: center;">${brd.notice_hit }</td>
								<td><fmt:formatDate value="${brd.notice_reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<th colspan="4">
							현재 작성된 글이 없습니다.
							</th>
						</tr>
					</c:otherwise>					
				</c:choose>
			<tr>
				<td colspan="4" style="text-align: center;">
				<form name="form1" method="post" action="noticeList">
					<select name="searchOption">
						<!-- 검색조건을 검색처리 후 결과화면에 계속 표시해주기 위해 c:out 출력 태그 사용-->
						<option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/>>제목+내용</option>
						<option value="notice_title"<c:out value="${map.searchOption == 'notice_title'?'selected':''}"/>>제목</option>
						<option value="notice_content"<c:out value="${map.searchOption == 'notice_content'?'selected':''}"/>>내용</option>
					</select>
					<input name="keyword" value="${map.keyword }">
					<input type="submit" value="조회" class="btnGreen01">
				</form>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<!-- 처음페이지로 이동 : 현재 페이지가 1보다 크면 [처음] 링크를 화면에 출력 -->
					<c:if test="${map.pagination.curPage > 1 }">
						<a href="javascript:list('1')" style="text-decoration: none;">[처음]</a>
					</c:if>
					
					<!-- 이전페이지 블록으로 이동 : 현재 페이지 블록이 1보다 크면 [이전] 링크를 화면에 출력-->
					<c:if test="${map.pagination.curBlock > 1 }">
						<a href="javascript:list('${map.pagination.prevPage }')" style="text-decoration: none;">[이전]</a>
					</c:if>
					<!-- 하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 -->
					<c:forEach var="num" begin="${map.pagination.blockBegin }" end="${map.pagination.blockEnd }">
						<!-- 현재 페이지면 하이퍼링크 제거 -->
						<c:choose>
							<c:when test="${num == map.pagination.curPage }">
								<span style="color:red;">${num }</span>&nbsp;
							</c:when>
							<c:otherwise>
								<a href="javascript:list('${num }')" style="text-decoration: none;">${num }</a>&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<!-- 다음페이지 블록으로 이동 : 현재 페이지 블록이 전체 페이지 블록보다 작거나 같으면 [다음] 링크를 화면에 출력 -->
					<c:if test="${map.pagination.curBlock <= map.pagination.totBlock}">
						<a href="javascript:list('${map.pagination.nextPage }')" style="text-decoration: none;">[다음]</a>
					</c:if>
					
					<!-- 끝 페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝] 링크를 화면에 출력 -->
					<c:if test="${map.pagination.curPage <= map.pagination.totPage }">
						<a href="javascript:list('${map.pagination.totPage }')" style="text-decoration: none;">[끝]</a>
					</c:if>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					총  <span style="color: blue;">${map.count }</span>개의 게시물이 있습니다.
				</td>
				<td style="text-align: center;">
					<% if (session.getAttribute("e_mail") == null) {%>
						
					<%} else if (session.getAttribute("e_mail").equals("admin@naver.com")) {%>
						<input type="button" value="글작성" onclick="regFo()" class="btnGreen01"/>
					<%} %>
				</td>
			</tr>
			
		</table>
	<c:import url="../default/footer.jsp"/>
</body>
</html>