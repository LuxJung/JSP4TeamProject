package main;
import java.sql.Connection;
<<<<<<< HEAD
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
=======
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

>>>>>>> minji
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class UserDAO {
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	public UserDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
<<<<<<< HEAD
	public UserVO findUser(String _id) {
		UserVO userInfo = null;
		try {
			conn=dataFactory.getConnection();
			String query="select * from t_member where id=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, _id);
			System.out.println(query);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			
			String id=rs.getString("id");
			String password=rs.getString("password");
			String nickname=rs.getString("nickname");
			String phone_number=rs.getString("phone_number");
			
			userInfo=new UserVO(id,password,nickname,phone_number);
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
	
	public int login(String _id, String _password) {
=======
	
	
	public int login(String id, String password) {
>>>>>>> minji
		try {
		conn = dataFactory.getConnection();
		String query="select password from user_T where id=?";
		pstmt=conn.prepareStatement(query);
<<<<<<< HEAD
		pstmt.setString(1, _id);
=======
		pstmt.setString(1, id);
>>>>>>> minji
		System.out.println(query);
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next()) {
<<<<<<< HEAD
			if(rs.getString("password").equals(_password)) {
=======
			if(rs.getString("password").equals(password)) {
>>>>>>> minji
				return 1;
			}else {
				return 0;
			}
		}
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
<<<<<<< HEAD
	//1 ->¾ÆÀÌµð,ºñ¹ø ¸ðµÎ ok
	//0 ->¾ÆÀÌµð¤·¤· ºñ¹ø ¤¤¤¤ 
	//-1 ->¾ÆÀÌµðºÎÅÍ ´Ù¸§
	
	
	
	public void addMember(UserVO u) {
=======
	
	public void deleteUser(String id, String password) {
		try {
			conn = dataFactory.getConnection();
			String query="DELETE FROM user_T WHERE id =?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
		} catch (Exception e) {
		}
	}
	
	
	public void addMember(UserVO u) {
		
		System.out.println("ë‹¤ì˜¤ì ‘ê·¼");
>>>>>>> minji
		try {
			conn = dataFactory.getConnection();
			String id = u.getId();
			String password = u.getPwd();
			String nickname = u.getNickname();
			String phone_number = u.getPhone_number();
<<<<<<< HEAD
			/*String profile_img = null;
			String addr = null;
			String detail_addr = null;*/
			String query = "INSERT INTO user_T(id, password, nickname, phone_number )" + " VALUES(?, ? ,? ,?)";
//			String query = "INSERT INTO user_T(id, password, nickname, phone_number,profile_img,addr,detail_addr   )" + " VALUES(?, ? ,? ,?,?,?,?)";
			System.out.println(query);
=======
			String profile_img = u.getProfile_img();
			String addr = u.getAddr();
			String detail_addr = u.getDetail_addr();
			String query = "INSERT INTO user_T(id, password, nickname, phone_number, profile_img, addr, detail_addr)" + " VALUES(?, ? ,? ,?,?,?,?)";
			System.out.println(query);
			
			System.out.println("ë‹¤ì˜¤id=" + id);
			System.out.println("ë‹¤ì˜¤addr=" + addr);
>>>>>>> minji
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, nickname);
			pstmt.setString(4, phone_number);
<<<<<<< HEAD
			/*pstmt.setString(5, profile_img);
			pstmt.setString(6, addr);
			pstmt.setString(7, detail_addr);*/
=======
			pstmt.setString(5, profile_img);
			pstmt.setString(6, addr);
			pstmt.setString(7, detail_addr);
>>>>>>> minji
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
<<<<<<< HEAD
=======
	
	public int checkId(String id) {
		int idCheck=0;
		try {
			conn = dataFactory.getConnection();
			String query="select * from user_T where id=?"; 
			System.out.println("prepareStatement: " + query);
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs=pstmt.executeQuery();
			
		if(rs.next()) {	
				idCheck=0; //ì´ë¯¸ ì¡´ìž¬í•˜ëŠ” ê²½ìš°, ìƒì„± ë¶ˆê°€ëŠ¥
			}else {
				idCheck=1; //ì¡´ìž¬í•˜ì§€ ì•ŠëŠ” ê²½ìš°, ìƒì„± ê°€ëŠ¥
			}
			conn.close();
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return idCheck;
	}
	
	public int checkNickname(String nickname) {
		int nickCheck=0;
		try {
			conn = dataFactory.getConnection();
			String query="select * from user_T where nickname=?"; 
			System.out.println("prepareStatement: " + query);
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, nickname);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()||nickname.equals("")) {
				nickCheck=0; 
			}else {
				nickCheck=1; 
			}
			conn.close();
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return nickCheck;
	}
	
	public UserVO readUser(String id) {
		UserVO user = new UserVO();
		try{
			
		
		conn = dataFactory.getConnection();
		String query="select * from user_t where id=?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, id);
		System.out.println(query);
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next()) {
			id = rs.getString("id");
			String password = rs.getString("password");
			String nickname = rs.getString("nickname");
			String phone_number = rs.getString("phone_number");
			String profile_img = rs.getString("profile_img");
			String addr = rs.getString("addr");
			String detail_addr = rs.getString("detail_addr");
			
			System.out.println("DAO="+id);
			System.out.println(password);
			System.out.println(nickname);
			System.out.println(phone_number);
			System.out.println(profile_img);
			System.out.println(addr);
			System.out.println(detail_addr);
			
			user.setId(id);
			user.setPwd(password);
			user.setNickname(nickname);
			user.setPhone_number(phone_number);
			user.setProfile_img(profile_img);
			user.setAddr(detail_addr);
			user.setDetail_addr(detail_addr);
			
		}
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		return user;
		
		
	}
	
	
	
	
>>>>>>> minji
}