<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
<c:if test="${request.text=='fail'}">
	<p style="color="red">비밀번호를 다시 입력해주세요.</p>
</c:if>
<form action="${contextPath}/userController/deleteUser.do" method="post">
	비밀번호:<input type="password" name="password"><br>
	<input type="hidden" name="id" value="${sessionScope.sessionID }">
	<input type="submit" value="회원탈퇴">
</form>

${sessionScope.sessionID }
</body>
</html>