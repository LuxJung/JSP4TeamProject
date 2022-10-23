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
	닉네임:<input type="text" name="nickname" class="input_nickname">
	<font id ="checkNickname" size="2"></font><br>
	핸드폰번호:<input type="text" name="phone_number"><br>
	<hr>
	프로필사진(구현못함):<input type="text" name="profile_img">
	이메일:<input type="text" name="email" class="email">
	<input type="button" value="이메일 전송" class="emailBtn">
	인증번호:<input type="text" name="emailConfirm" class="emailConfirm">
	<input type="button" value="확인" class="confirmBtn">
	<font id ="checkEmail" size="2"></font><br>
	
	주소:<input type="text" id="address_kakao" name="addr" readonly /><br>
	상세주소:<input type="text" name="detail_addr" class="detail_addr" /><br>

	 
	 
	<input type="submit" value="회원가입">
</form>



<script src = "../js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}

//이미지첨부(구현아직못함...)
$('.input_file').on("change",function(){
	
	$.ajax({
		url:"${contextPath}/upload.do",
		type:"post",
		//data:{emailConfirm: emailConfirm},
		//dataType:'text',
		success:function(result){
			alert('성공');
		},
		//error:function(request,status,error){        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       }
	})
})

//인증번호확인
$('.confirmBtn').click(function(){
	
	let emailConfirm=$('.emailConfirm').val();
	if(emailConfirm==''){
		alert('인증번호를 입력하세요');
		return;
	}
	
	$.ajax({
		url:"${contextPath}/userController/emailConfirm.do",
		type:"post",
		data:{emailConfirm: emailConfirm},
		//dataType:'text',
		success:function(result){
			if(result==1){
				$('#checkEmail').text('인증되었습니다.');
				$('#checkEmail').attr('color','green');
			}else{
				alert('번호가 일치하지 않습니다. 다시 입력해주세요.')
				$('.emailConfirm').focus();
				//$('#checkEmail').text('실패.');
				//$('#checkEmail').attr('color','red');
			}
		},
		error:function(request,status,error){        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       }
	})
})

//인증이메일전송
$('.emailBtn').click(function(){
	let emailAdr=$('.email').val();
	
	$.ajax({
		url:"${contextPath}/userController/sendEmail.do",
		type:"post",
		data:{emailAdr: emailAdr},
		//dataType:'json',
		success:function(result){ 
			console.log('보내기 성공')
		},
		error:function(request,status,error){        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       }
	})
})


//아이디중복확인
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


//비밀번호 일치 확인
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


//닉네임 중복확인
$('.input_nickname').keyup(function(){
	let userNickname=$('.input_nickname').val();//input_id에 입력되는 값.
	
	$.ajax({
		url:"${contextPath}/userController/overlapChkNickname.do",
		type:"post",
		data:{userNickname: userNickname},
		dataType:'json',
		success:function(result){ //result: overlapChk.do 에서 넘겨준 값
			if(result==0){
				$('#checkNickname').html('이미 존재하는 닉네임입니다.');
				$('#checkNickname').attr('color','red');
			}else{
				$('#checkNickname').html('사용할 수 있는 닉네임입니다.');
				$('#checkNickname').attr('color','green');
			}
		},
		error:function(){
			alert("서버요청실패");
		}
	})
})






 
</script>
</body>
</html>