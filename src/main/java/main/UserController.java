package main;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/userController/*")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO userDAO;
	String mailnumber;
	
    public UserController() {
    }
    
    
    public void init() throws ServletException{
    	userDAO = new UserDAO();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}
	
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String nextPage=null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("action:" + action);
		
		if(action.equals("/addUser.do")) {
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			String nickname=request.getParameter("nickname");
			String phone_number=request.getParameter("phone_number");
			String profile_img=request.getParameter("profile_img");
			String addr=request.getParameter("addr");
			String detail_addr=request.getParameter("detail_addr");
			
			System.out.println(id);
			System.out.println(password);
			System.out.println(nickname);
			System.out.println(phone_number);
			System.out.println(profile_img);
			System.out.println(addr);
			System.out.println(detail_addr);
			
			UserVO userVO = new UserVO(id, password, nickname, phone_number,profile_img,addr,detail_addr);
			userDAO.addMember(userVO);
			nextPage="../index/index.jsp";
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
			
		}else if(action.equals("/login.do")) {
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			String loginChk = request.getParameter("loginChk");
			
			System.out.println(id);
			System.out.println(password);
			
			int loginResult=userDAO.login(id, password);
			System.out.println(loginResult);
			
			if(loginResult==1) {
				System.out.println("로그인 성공");
				
				request.setAttribute("loginResult", loginResult);
				HttpSession session = request.getSession();
				session.setAttribute("sessionID", id);
				session.setMaxInactiveInterval(20*60);
				UserVO userInfo=userDAO.readUser(id);
				
				 if(loginChk != null){
		                Cookie cookie = new Cookie("id", id);
		                
		                cookie.setMaxAge(60);
		                cookie.setPath("/");
		                response.addCookie(cookie);
		            }
				 
				 session.setAttribute("userInfo", userInfo);
				 String picname=userInfo.getProfile_img();
				 Cookie cookie2 = new Cookie("picname", picname);
				 cookie2.setMaxAge(60);
	                cookie2.setPath("/");
	                response.addCookie(cookie2);
				 System.out.println(userInfo.getProfile_img());
				 
				 
				
				System.out.println(session.getAttribute("sessionID"));
				nextPage="../index/index.jsp";
			}else {
				System.out.println("로그인실패");
				request.setAttribute("loginResult", loginResult);
				nextPage="../login/loginForm_.jsp";
			}
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		}else if(action.equals("/deleteUser.do")) {
			
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			
			System.out.println(id);
			System.out.println(password);
			
			if(userDAO.login(id, password)==1) {
				userDAO.deleteUser(id, password);
				nextPage="../login/logout.jsp";
			}else {
				request.setAttribute("text", "fail");
				RequestDispatcher dis = request.getRequestDispatcher("deleteForm.jsp");
				dis.forward(request, response);
			}
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		}else if(action.equals("/overlapChk.do")) {
			String userId=request.getParameter("userId");
			System.out.println("userId="+userId);
			PrintWriter out = response.getWriter();
			
			UserDAO userDAO = new UserDAO();
			
			int idCheck=userDAO.checkId(userId);
			System.out.println("idCheck="+idCheck);
			
			//개발자용 성공여부 확인
			if(idCheck==0) {
				System.out.println("이미 존재하는 아이디입니다.");
			}else if(idCheck==1) {
				System.out.println("사용 가능한 아이디입니다.");
			}
			out.write(idCheck+""); //->ajax결과값인 result가 됨.
			//-->String으로 값을 내보낼 수 있도록 +"" 를 해준다.
		}else if(action.equals("/overlapChkNickname.do")) {
			String userNickname=request.getParameter("userNickname");
			System.out.println("userNickname="+userNickname);
			PrintWriter out = response.getWriter();
			
			UserDAO userDAO = new UserDAO();
			
			int nickCheck=userDAO.checkNickname(userNickname);
			System.out.println("nickCheck="+nickCheck);
			
			//개발자용 성공여부 확인
			if(nickCheck==0) {
				System.out.println("이미 존재하는 닉네임입니다.");
			}else if(nickCheck==1) {
				System.out.println("사용 가능한 닉네임입니다.");
			}
			out.write(nickCheck+"");
		}
		else if(action.equals("/sendEmail.do")) {
			String emailadr=request.getParameter("emailAdr");
			EmailSMTP email=new EmailSMTP();
			mailnumber=email.SendEmail(emailadr);
			System.out.println("mailnumber="+mailnumber);
			System.out.println("이메일 전송 성공");
			nextPage="../join/joinForm.jsp";
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		}else if(action.equals("/emailConfirm.do")) {
			
			int numberChk;
			PrintWriter out = response.getWriter();
			System.out.println("인증번호서블릿확인");
			String emailConfirm = request.getParameter("emailConfirm");
			System.out.println("emailConfirm=" + emailConfirm);
			System.out.println("mailnumber=" + mailnumber);
			
			if(emailConfirm.equals(mailnumber)) {
				numberChk=1;
			}else {
				numberChk=0;
			}
			out.write(numberChk+"");
			System.out.println("numberChk="+numberChk);
		}else if(action.equals("/logout.do")) {
			//request.getSession().invalidate();
			//HttpSession session=request.getSession();
			
			 Cookie[] cookies = request.getCookies();
			    if(cookies!=null){
			        for(Cookie tempCookie : cookies){
			            if(tempCookie.getName().equals("id")){
			                tempCookie.setMaxAge(0);
			                tempCookie.setPath("/");
			                response.addCookie(tempCookie);
			                
			            }
			        }
			    }
			    
			    request.getSession().removeAttribute("sessionID");//세션제거
				response.sendRedirect("../index/index.jsp");
				
		}else if(action.equals("/kakaologin.do")) {
			System.out.println("카카오로그인컨트롤러접근");
			System.out.println(request.getParameter("email"));
			System.out.println(request.getParameter("nickname"));
		}
		
	}
	
	

}