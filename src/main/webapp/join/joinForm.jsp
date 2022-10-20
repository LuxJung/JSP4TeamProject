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
<form name="joinForm" action="${contextPath}/userController/addUser.do" method="post">
	아이디:<input type="text" name="id" class="input_id">
	<font id ="checkId" size="2"></font><br>
	비밀번호:<input type="password" name="password" id="pwd1"><br>
	비밀번호확인:<input type="password" name="password" id="pwd2">
	<font id ="pwdChk" size="2"></font><br>
	닉네임:<input type="text" name="nickname"><br>
	핸드폰번호:<input type="text" name="phone_number"><br>
	
	<input type="submit" value="회원가입">
</form>


<script src = "../js/jquery-3.6.0.min.js"></script>
<script>

$('.input_id').keyup(function(){
	let userId=$('.input_id').val();//input_id에 입력되는 값.
	
	$.ajax({
		url:"${contextPath}/userController/overlapChk.do",
		type:"post",
		data:{userId: userId},
		dataType:'json',
		success:function(result){ //result: overlapChk.do 에서 넘겨준 값
			if(result==0){
				$('#checkId').html('이미 존재하는 아이디입니다.');
				$('#checkId').attr('color','red');
			}else{
				$('#checkId').html('사용할 수 있는 아이디입니다.');
				$('#checkId').attr('color','green');
			}
		},
		error:function(){
			alert("서버요청실패");
		}
	})
})

$('#pwd2').blur(function(){
	if($('#pwd1').val()!=$("#pwd2").val()){
		if($('#pwd2').val()!=''){
			alert("비밀번호가 일치하지 않습니다.");
			$('#pwd2').val('');
			$('#pwd2').focus();
		}
	}else{
		$('#pwdChk').html('비밀번호가 일치합니다.');
		$('#pwdChk').attr('color','green');
	}
})

</script>
</body>
</html>