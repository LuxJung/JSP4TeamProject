package main;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
		try {
		conn = dataFactory.getConnection();
		String query="select password from user_T where id=?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, _id);
		System.out.println(query);
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next()) {
			if(rs.getString("password").equals(_password)) {
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
	//1 ->아이디,비번 모두 ok
	//0 ->아이디ㅇㅇ 비번 ㄴㄴ 
	//-1 ->아이디부터 다름
	
	
	
	public void addMember(UserVO u) {
		try {
			conn = dataFactory.getConnection();
			String id = u.getId();
			String password = u.getPwd();
			String nickname = u.getNickname();
			String phone_number = u.getPhone_number();
			/*String profile_img = null;
			String addr = null;
			String detail_addr = null;*/
			String query = "INSERT INTO user_T(id, password, nickname, phone_number )" + " VALUES(?, ? ,? ,?)";
//			String query = "INSERT INTO user_T(id, password, nickname, phone_number,profile_img,addr,detail_addr   )" + " VALUES(?, ? ,? ,?,?,?,?)";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, nickname);
			pstmt.setString(4, phone_number);
			/*pstmt.setString(5, profile_img);
			pstmt.setString(6, addr);
			pstmt.setString(7, detail_addr);*/
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}