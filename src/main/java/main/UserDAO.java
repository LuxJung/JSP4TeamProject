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
	
	
	public int login(String id, String password) {
		try {
		conn = dataFactory.getConnection();
		String query="select password from user_T where id=?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, id);
		System.out.println(query);
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next()) {
			if(rs.getString("password").equals(password)) {
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
		try {
			conn = dataFactory.getConnection();
			String id = u.getId();
			String password = u.getPwd();
			String nickname = u.getNickname();
			String phone_number = u.getPhone_number();
			String profile_img = u.getProfile_img();
			String addr = u.getAddr();
			String detail_addr = u.getDetail_addr();
			String query = "INSERT INTO user_T(id, password, nickname, phone_number,profile_img,addr,detail_addr   )" + " VALUES(?, ? ,? ,?,?,?,?)";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, nickname);
			pstmt.setString(4, phone_number);
			pstmt.setString(5, profile_img);
			pstmt.setString(6, addr);
			pstmt.setString(7, detail_addr);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int checkId(String id) {
		int idCheck=0;
		try {
			conn = dataFactory.getConnection();
			String query="select * from user_T where id=?"; 
			System.out.println("prepareStatement: " + query);
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()||id.equals("")) {
				idCheck=0; //이미 존재하는 경우, 생성 불가능
			}else {
				idCheck=1; //존재하지 않는 경우, 생성 가능
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
}