package main;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@WebServlet("/logintest.do")
public class joinController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	UserDAO userDAO;
	UserVO userVO;
	
	  public void init() throws ServletException{
			userDAO=new UserDAO();
			userVO=new UserVO();
	    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		

		String nextPage="";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		Map<String,String> articleMap=upload(request,response);
		System.out.println("서블릿접근");
		String id=articleMap.get("id");
		String password=articleMap.get("password");
		String nickname=articleMap.get("nickname");
		String phone_number=articleMap.get("phone_number");
		String profile_img=articleMap.get("profile_img");
		String addr=articleMap.get("addr");
		String detail_addr=articleMap.get("detail_addr");
		
		
		System.out.println("이건가?"+id);
		System.out.println(password);
		System.out.println(nickname);
		System.out.println(phone_number);
		System.out.println(profile_img);
		System.out.println(addr);
		System.out.println(detail_addr);
		
		
		userVO.setId(id);
		userVO.setPwd(password);
		userVO.setNickname(nickname);
		userVO.setPhone_number(phone_number);
		userVO.setProfile_img(profile_img);
		userVO.setAddr(addr);
		userVO.setDetail_addr(detail_addr);
		
		UserVO userVO = new UserVO(id, password, nickname, phone_number,profile_img,addr,detail_addr);
		userDAO.addMember(userVO);
		//nextPage="../index/index.jsp";
		response.sendRedirect("../index/index.jsp");
		
		//RequestDispatcher dispatch = request.getRequestDispatcher("../index/index.jsp");
		//dispatch.forward(request, response);
		
	}
	
	private Map<String,String> upload(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String encoding = "utf-8";
		Map<String, String> articleMap = new HashMap<String, String>();
		File currentDirPath = new File("D:\\TeamProject\\jspTeam\\src\\main\\webapp\\img");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);
		
		String fileName="";

		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);

				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("파라미터명:" + fileItem.getFieldName());
					System.out.println("파일명:" + fileItem.getName());
					System.out.println("파일크기:" + fileItem.getSize() + "bytes");

					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						fileName = fileItem.getName().substring(idx + 1);
						System.out.println("파일명:" + fileName);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						fileItem.write(uploadFile);
					} // end if
				} // end if
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//result=currentDirPath + "\\" + fileName;
		
		//System.out.println(result);
		return articleMap;
		
	}

}
