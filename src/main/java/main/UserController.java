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
			
			UserVO userVO = new UserVO(id, password, nickname, phone_number);
			userDAO.addMember(userVO);
			nextPage="../index/main.jsp";
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
			
		}else if(action.equals("/login.do")) {
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			String checkbox=request.getParameter("checkbox");
			
			
			System.out.println(id);
			System.out.println(password);
			
			int loginResult=userDAO.login(id, password);
			System.out.println(loginResult);
			
			if(loginResult==1) {
				request.setAttribute("loginResult", loginResult);
				HttpSession session = request.getSession();
				session.setAttribute("sessionID", id);
				session.setMaxInactiveInterval(20*60);
//	            response.sendRedirect(request.getContextPath()+"/");
				
				System.out.println(session.getAttribute("sessionID"));
				nextPage="../index/main.jsp";
			}else {
				request.setAttribute("loginResult", loginResult);
				nextPage="../login/loginForm.jsp";
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
		}
		
	}
	
	

}