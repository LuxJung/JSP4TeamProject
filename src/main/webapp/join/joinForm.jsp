<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입폼</title>
<script type="text/javascript">

const form = document.signUpForm;
function emailValCheck(){
	var emailPattern
}

function emailAuthentication(){
	if(!emailValCheck()){
		return false;
	}
	var url="confirmEmail.four?email=" + document.signUpForm.email.value;
	open(url,"confirm",
			"toolbar=no, location=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
}
</script>
</head>
<body>
<h1>회원가입폼</h1>
<form action="${contextPath}/userController/addUser.do" method="post">
	아이디:<input type="text" name="id"><br>
	비밀번호:<input type="password" name="password"><br>
	닉네임:<input type="text" name="nickname"><br>
	핸드폰번호:<input type="text" name="phone_number"><br>
	<hr>
	
	이메일:<input type="text" name="email" id="inputEmailForm"  maxlength="30">
	<button onclick="emailAuthentication()" id="eamilAuthBtn" type="button" class="btnChk">인증 메일 보내기</button><br>
	인증번호 입력:<input type="text" name="authCode" id="inputAuthCode"  maxlength="10" disabled="disabled">
	<button onclick="authCodeCheck()" id="authCodeCheckBtn" type="button" disabled="disabled" class="btnChk">인증</button>
	<input type="hidden" name="authPass" id="authPass" value="false"><br>
	
	<%-- <form action="${contextPath}/userController/pictureUp.do" method="post" enctype="multipart/form-data">
		<img src="${sessionScope.userProfile}" width="350px" height="300px" /><br>
		<input type="file" name="userProfile"/><br>
		<input type="hidden" name="id" value="${sessionScope.id }"/>
		<input type="submit" value="사진등록"/>
	</form> --%>


	<input type="submit" value="회원가입">
</form>
</body>
</html>