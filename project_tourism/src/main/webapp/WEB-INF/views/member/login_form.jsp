<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="576736845363-o0474pib5q69qlcv6lm7o42hs6lu5u59.apps.googleusercontent.com">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name = "viewport" content = "user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0,
width=device-width" />
 
<title>Insert title here</title>
 
</head>
 
<table border="1" width="300">
 
<tr>
<td>
<br>
<center>
<span style="color:green; font-weight : bold;">회원 로그인</span>
</center>
 
 
<!-- 로그인창 -->
<form action ="/member/login_form" method = "post">
<center>
<br>
아이디 : <input type = "text" name="user_id" placeholder="  ID를 입력하세요 "><br><br>
비밀번호 : <input type = "password" name="user_pass" placeholder="  비밀번호를 입력하세요 "><br><br>
<button type = "submit" name = "submit" >로그인</button>
 
<br>
<br>
<div class = "row">
    <div class="col-xs-8">
        <div class="checkbox icheck">
        <label>
            <input type = "checkbox" name = "useCookie"> 로그인유지
        </label>
        </div>
    </div>
</div>
</center>
 
<center>
 
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
</head>
<body>
<br>
<!-- 네이버아이디로로그인 버튼 노출 영역 -->
<div id="naverIdLogin"></div>
<!-- //네이버 아이디로 로그인 버튼 노출 영역 -->
 
<!-- 네이버 아이디로 로그인 초기화 Script -->
<script type="text/javascript">
    var naverLogin = new naver.LoginWithNaverId(
        {
            //클라이언트 id와 콜백 url (결과페이지)
            clientId: "DphfmDygX4WFkf8nghMJ",
            callbackUrl: "http://localhost/hansub_project/login_result",
            isPopup: false, /* 팝업을 통한 연동처리 여부 */
            loginButton: {color: "green", type: 3, height: 40} /* 로그인 버튼의 타입을 지정 */
        }
    );
    
    /* 설정정보를 초기화하고 연동을 준비 */
    naverLogin.init();
    
</script>
</center>
 
 
</center>
 
<center>
<!-- 카카오톡 아이디 연동해서 로그인 -->
<script src = "//developers.kakao.com/sdk/js/kakao.min.js"></script>
<a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<script type='text/javascript'>
 
Kakao.init('bd21082a499aaa79b4c08e01935a8a70'); //아까 카카오개발자홈페이지에서 발급받은 자바스크립트 키를 입력함
 
//카카오 로그인 버튼을 생성합니다. 
 
Kakao.Auth.createLoginButton({ 
    container: '#kakao-login-btn', 
    success: function(authObj) { 
           Kakao.API.request({
 
               url: '/v1/user/me',
 
               success: function(res) {
 
                     console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
 
                     console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
 
                     console.log(res.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
                             
                 // res.properties.nickname으로도 접근 가능 )
                     console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
          
          var id = res.id;    //카카오톡 닉네임을 변수에 저장
          var kakaonickname = res.properties.nickname;    //카카오톡 닉네임을 변수에 저장
          var kakaoe_mail = res.kaccount_email;    //카카오톡 이메일을 변수에 저장함
         
          
 
          window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/hansub_project/home?kakaonickname="+kakaonickname+"kakaotalk"+"&kakaoe_mail="+kakaoe_mail);
      
                   }
                 })
               },
               fail: function(error) {
                 alert(JSON.stringify(error));
               }
             });
</script>
</center>
 
 
 
</form>
 
<br>
<!-- 아이디 찾기 -->
<form action ="find.user_id.do">
<center>
<button>아이디 찾기</button>
</center>
</form>
 
<br>
<!-- 비밀번호 찾기 -->
<form action ="find.member_pass.do">
<center>
<button>비밀번호찾기</button>
</center>
</form>
<br>
 
</td>
</tr>
</table>
 
 
<body>
<!-- 로그인 실패나 성공시 메시지를 받아서 출력하는 자바스크립트 구문 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
    $(function(){
        var responseMessage = "<c:out value="${message}" />";
        if (responseMessage != ""){
            alert(responseMessage)
        }
    })
</script>
 
 
</body>
</html>