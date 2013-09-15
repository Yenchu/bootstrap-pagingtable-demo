package idv.type;

public enum Gender {

	Unknown(0), Female(1), Male(2);
	
	private final int value;
	
	private Gender(int value) {
		this.value = value;
	}
	
	public int value() {
		return value;
	}
	
	public static Gender get(int value) {
		if (Female.value == value) {
			return Female;
		} else if (Male.value == value) {
			return Male;
		}
		return Unknown;
	}
}
