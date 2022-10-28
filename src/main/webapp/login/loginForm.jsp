<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<<<<<<< HEAD
=======


>>>>>>> minji
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<<<<<<< HEAD
</head>
<body>
<h2>로그인 페이지</h2>

=======




</head>
<body>

<!-- 쿠키값으로 id정보 받아오기 -->
>>>>>>> minji


<c:if test="${loginResult== -1 || loginResult==0}">
	<p style="color:red">아이디나 비밀번호가 일치하지 않습니다.</p>
</c:if>

<<<<<<< HEAD

<form action="${contextPath}/userController/login.do" method="post">
	아이디:<input type="text" name="id"><br>
	비밀번호:<input type="password" name="pwd"><br>
	<input type="submit" value="로그인">

</form>
=======
<form action="${contextPath}/userController/login.do" method="post">
	아이디:<input type="text" name="id" id="userId" autocomplete="off"><br>
	비밀번호:<input type="password" name="password"><br>
	<input name="checkId" type="checkbox" id="idSaveCheck">id저장<br>
	<input type="submit" value="로그인">
</form>


>>>>>>> minji
</body>
</html>