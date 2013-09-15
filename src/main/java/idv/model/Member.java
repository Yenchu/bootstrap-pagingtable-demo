package idv.model;

import idv.model.util.DateJsonSerializer;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public class Member implements Serializable {

	private String id;
	
	private String name;

	private String email;

	@DateTimeFormat(iso=ISO.DATE) // yyyy-MM-dd
	@JsonSerialize(using=DateJsonSerializer.class) // convert long to string when output json
	private Date birthday;
	
	// 1:female, 2:male
	private int sex;
	
	/* LanguageCode	Description
		de	German
		en	English
		fr	French
		ru	Russian
		ja	Japanese
		jv	Javanese
		ko	Korean
		zh	Chinese
	 */
	private String language;

	public Member() {
	}
	
	public Member(String name, String email, int sex, String language) {
		this.name = name;
		this.email = email;
		this.sex = sex;
		this.language = language;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}
	
	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
}
