<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
	body {
		max-width: 1200px;
		margin : 20px auto;
		padding : 10px;
	}
</style>
<body>
<center>
<table border="1" width="450" height="400">
    
        <br> <br>
        <center>
        <span style="color: green; font-weight: bold;">비밀번호 변경</span> <br> <br>
                       
                        <form action="/member/pass_Change${e_mail}" method="post">
                    <center>
                        <div>
                            인증받은 이메일 : ${e_mail}
                                                    
                        </div>
                        <br>
                        <div>
                            비밀번호 : <input type="password" name="user_pass"
                                placeholder="  비밀번호를 입력하세요. ">
                        </div>
                        <br>
                        <!-- 이메일은 인증받은 이메일을 사용해야 하므로 컨트롤러에서 이메일을 가져와서 사용함 -->
                        <!-- 가져온후에 다시 컨트롤러로 넘긴후에 db에 저장하는 식으로 진행 -->
                        
                        <br> <br>
                        <button type="submit" name="submit">비밀번호 변경</button>
                    </center>
                        </div>
                    </td>
                </tr>
            </table>
            </center>
        </form>   
        </center>
</body>
</html>