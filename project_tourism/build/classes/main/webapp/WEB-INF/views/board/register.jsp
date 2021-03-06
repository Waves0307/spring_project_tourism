<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:import url="../default/header.jsp"/>
	<div align="center" style="padding:50px;">
	<h1>게시물 작성</h1>
		<form id="registerForm">
			<input type="text" name="title" id="title" placeholder="제목"><br><br>
			<textarea name="content" id="content" placeholder="내용"></textarea><br>
			<input type="file" name="uploadFile" id="uploadFile" placeholder="파일첨부" multiple><br>
			<input type="button" value="작성하기" onclick="register()">
		</form>
	</div>
	<c:import url="../default/footer.jsp"/>
</body>
<script>
function register(){
	
	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;
	console.log(files);
	
	for(var i = 0; i < files.length; i++){
		formData.append("uploadFile", files[i]);
	}
	
	$.ajax({
		url : "/board/fileUpload",
		type : "POST",
		processData: false,
		contentType: false,
		data : formData,
		success : function(data)	{
			alert("Uploaded");
		}
	});
	
	var result = 0;
	$.ajax({
		url : "/board/register",
		type : "POST",
		cache : false,
		async : false,
		dataType : "JSON",
		data : $("#registerForm").serialize(),
		success : function(data)	{
			if(data === 1){
				self.location="/board/list";
			}else{
				alert("게시물 등록에 실패하였습니다.");
			}
		},
		error : function(data){
			alert("서버에러!");
		} 
	});
}
</script>
</html>