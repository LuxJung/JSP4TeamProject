<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
</head>
<body>
<h2>로그인 페이지</h2>



<c:if test="${param.sw==false}">
	<p style="color:red">아이디나 비밀번호가 일치하지 않습니다.</p>
</c:if>


<form action="loginChk.jsp" method="post">
	아이디:<input type="text" name="id"><br>
	비밀번호:<input type="password" name="pwd"><br>
	<input type="submit" value="로그인">

</form>
</body>
</html>