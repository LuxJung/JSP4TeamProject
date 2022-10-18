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
</head>
<body>
<h1>회원가입폼</h1>
<form action="${contextPath}/userController/addUser.do" method="post">
	아이디:<input type="text" name="id"><br>
	비밀번호:<input type="password" name="password"><br>
	닉네임:<input type="text" name="nickname"><br>
	핸드폰번호:<input type="text" name="phone_number"><br>
	<input type="submit" value="회원가입">
</form>
</body>
</html>