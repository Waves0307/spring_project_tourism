<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:import url="../default/header.jsp"/>
	<div>
		<div>
			<h3>공지사항 글 수정</h3>
			<hr>
		</div>
		<form action="modifyOk" method="post">
		<div>
			<input type="text" name="notice_no" value="${contentView.notice_no }" hidden="hidden">
			<input type="text" name="notice_title" placeholder="제목을 입력하세요" value="${contentView.notice_title }">
			<hr>
		</div>
		<div>
			<textarea name="notice_content"placeholder="내용 입력">${contentView.notice_content }</textarea>
			<hr>
		</div>
		<div>
			<input type="submit" value="수정하기">
		</div>
		</form>
	</div>
	<c:import url="../default/footer.jsp"/>
</body>
</html>