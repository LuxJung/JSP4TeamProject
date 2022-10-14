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
<h2>loginchk.jsp</h2>
	
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	boolean sw;
	
	out.print(id);
	out.print(pwd);
	
	if(id.equals("aaa") && pwd.equals("123")){
		
	session.setAttribute("id",id);
	session.setAttribute("pwd",pwd);
	
	//세션 유지기간 설정
	session.setMaxInactiveInterval(60); //1분간 유지.
	response.sendRedirect("../main/main.jsp?sw=true");
	
	}else{
		response.sendRedirect("loginForm.jsp?sw=false");
	}
%>
	
</body>
</html>