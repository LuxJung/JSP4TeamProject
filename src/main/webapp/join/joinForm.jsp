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
<<<<<<< HEAD
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
=======


</head>
<body>
<h1>회원가입폼</h1>
<form name="joinForm" action="${contextPath}/logintest.do" method="post" enctype="multipart/form-data">
	아이디:<input type="text" name="id" class="input_id" required><input type="button" value="중복확인" class="overlap"><br>
	<font id ="checkId" size="2"></font><br>
	비밀번호:<input type="password" name="password" id="pwd1" required>
	<font id ="pwdtext" size="2"></font><br>
	비밀번호확인:<input type="password" name="password" id="pwd2" required>
	<font id ="pwdChk" size="2"></font><br>
	닉네임:<input type="text" name="nickname" class="input_nickname" required>
	<font id ="checkNickname" size="2"></font><br>
	핸드폰번호:<input type="text" name="phone_number" placeholder="000-0000-0000" class="phone_number" required><font id ="checkphone" size="2"></font><br>
	이메일:<input type="text" name="email" class="email">
	<input type="button" value="이메일 전송" class="emailBtn"><br>
	인증번호:<input type="text" name="emailConfirm" class="emailConfirm">
	<input type="button" value="확인" class="confirmBtn">
	<font id ="checkEmail" size="2"></font><br>
	
	<hr>
	주소:<input type="text" id="address_kakao" name="addr" readonly/><br>
	상세주소:<input type="text" name="detail_addr" class="detail_addr" /><br>
	
	<img id="preview" />
	프로필 사진:<input type="file" name="profile_img" onchange="readURL(this)" /><br>

	 
	 
	<input type="submit" value="회원가입">
</form>



<script src = "../js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

//프로필사진 미리보기
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      document.getElementById('preview').src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    document.getElementById('preview').src = "";
  }
}

//주소검색
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


//핸드폰번호 정규식
$('.phone_number').keyup(function(){
	let phonenumber=$('.phone_number').val();	
	let phonecheck = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	    if (!phonecheck.test(phonenumber)){
	    	$('#checkphone').html('알맞은 핸드폰 번호를 입력해주세요');
			$('#checkphone').attr('color','red');
	    }else{
	    	$('#checkphone').html('알맞은 형식입니다.');
			$('#checkphone').attr('color','green');
	    }	
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
	alert('메일을 보냈습니다.')
})


//아이디중복확인
$('.overlap').click(function(){
	let userId=$('.input_id').val();//input_id에 입력되는 값.
	
	$.ajax({
		url:"${contextPath}/userController/overlapChk.do",
		type:"post",
		data:{userId: userId},
		dataType:'json',
		success:function(result){ //result: overlapChk.do 에서 넘겨준 값
			if(result==0){
				alert('이미 등록된 아이디입니다. 다른 아이디를 입력해주세요.');
			}else{
				alert('사용할 수 있는 아이디입니다.');
			}
		},
		error:function(){
			alert("서버요청실패");
		}
	})
})

//아이디유효성검사
$('.input_id').keyup(function(){
	let idval = $('.input_id').val()
    let idvalcheck = /^[a-z0-9]+$/
    if (!idvalcheck.test(idval) || idval.length<6){
    	$('#checkId').html('영소문자,숫자를 포함해주세요(6자이상)');
		$('#checkId').attr('color','red');
    }else{
    	$('#checkId').html('사용가능한 아이디입니다.');
		$('#checkId').attr('color','green');
    }	
})

//비밀번호 유효성
$('#pwd1').keyup(function(){
	let pwdval = $('#pwd1').val()
    let pwdvalcheck = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/
    if (!pwdvalcheck.test(pwdval) || pwdval.length<8){
    	$('#pwdtext').html('영문자,숫자를 포함해주세요(8~16자)');
		$('#pwdtext').attr('color','red');
    }else{
    	$('#pwdtext').html('사용가능한 비밀번호입니다.');
		$('#pwdtext').attr('color','green');
    }	
})
//비밀번호 일치 확인
$('#pwd2').blur(function(){
	if($('#pwd1').val()!=$("#pwd2").val()){
		if($('#pwd2').val()!=''){
			alert("비밀번호가 일치하지 않습니다. 다시입력해주세요");
			$('#pwd2').val('');
			$('#pwd2').focus();
			$('#pwdChk').html('');
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
				$('#checkNickname').html('이미 등록된 닉네임입니다.');
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
>>>>>>> minji
</body>
</html>