<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입3</title>
    <link rel="stylesheet" href="../css/layout3.css">
</head>
<body>
<div id="join_container">
    
    <p id="logo" style=" margin:20px auto;width:250px;height:250px;">
    <img src="../img/logo_green.png"  alt="#" style="width:250px;height:250px;"></p>
    <h3>회원가입</h3>
    
        <form action="${contextPath}/logintest.do" method="post" id="join" enctype="multipart/form-data">
            <fieldset class="join1">
                <legend>필수 입력 항목</legend>
                <p class="box_i"><label for="u_name"> 아이디</label><input type="text" name="id" id="u_name" class="input_id" autocomplete="off" required><input type="button" value="중복확인" class="zip_btn overlap"></p>
                <p id ="checkId"></p>
                <p class="box_i"><label for="pwd1"> 비밀번호</label><input type="password" name="password" id="pwd1" autocomplete="off" required></p>
                <p id ="pwdtext"></p>
                <p class="box_i"><label for="pwd2"> 비밀번호 확인</label><input type="password" name="password" id="pwd2" autocomplete="off" required></p>
                <p id ="pwdChk"></p>
                <p class="box_i"><label for="u_id"> 닉네임</label><input type="text" class="input_nickname" id="u_id" name="nickname" autocomplete="off" required></p>
                <p id ="checkNickname"></p>
                <p class="box_i"><label for="u_id"> 휴대폰번호</label><input type="text" class="phone_number" id="u_id" name="phone_number" autocomplete="off" required></p>
                <p id ="checkphone"></p>
                <p class="box_i"><label for="u_id"> 이메일주소</label><input type="text" class="email" id="u_id" name="email" autocomplete="off" required><input type="button" value="메일전송" class="zip_btn emailBtn"></p>
                <p id ="checkId"></p>
                <p class="box_i"><label for="u_id"> 인증번호</label><input type="text" id="u_id" class="emailConfirm" name="emailConfirm" autocomplete="off" required><input type="button" value="번호인증" class="zip_btn confirmBtn"></p>
                <p id ="checkEmail"></p>
            </fieldset>
            
            <fieldset class="join1">
                <legend>선택 입력 항목</legend>
                <p class="box_i"><label for="u_name"> 주소</label><input style="width:200px;" type="text" id="address_kakao" name="addr" readonly autocomplete="off"/></p>
                <p class="box_i"><label for="u_name"> 상세주소</label><input style="width:200px;" type="text" name="detail_addr" class="detail_addr" autocomplete="off"/></p>
                <p id="profile_picture"><img id="preview" style="width:200px;
    height:200px;
	margin-left:120px;
	display:none;
	border-radius:50%;
	"/></p>
                <p class="box_i"><label for="u_name"> 프로필사진</label><input type="file" id="u_name" name="profile_img" onchange="readURL(this)" /></p>
          
                
            </fieldset>
            <p class="btn">
                <input class="final" type="submit" value="회원가입">
                <input class="final" type="reset" value="다시작성">
            </p>
        </form>   
      
</div> 



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
    document.getElementById("preview").style.display = 'block';
    
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


  
</body>
</html>