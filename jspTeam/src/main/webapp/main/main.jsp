<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<h1>메인화면</h1>

<c:if test="${id!=null}">
	<a href="../login/logout.jsp">로그아웃</a>
	<a href="#">회원가입</a>
</c:if>

<c:if test="${id==null}">
	<a href="../login/loginForm.jsp">로그인</a>
	<a href="#">회원가입</a>
</c:if>

</body>
</html>