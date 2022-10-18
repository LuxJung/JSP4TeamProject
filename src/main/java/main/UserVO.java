package main;

public class UserVO {

	private String id;
	private String password;
	private String nickname;
	private String phone_number;
	
	public UserVO(String id, String password, String nickname, String phone_number) {
		super();
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.phone_number = phone_number;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return password;
	}

	public void setPwd(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	
	
	
	
	
}
