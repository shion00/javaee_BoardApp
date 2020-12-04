/*
 *파일과 관련된 유용한 기능을 모아놓은 클래스 
 * */
package common;

public class FileManager {
	
	//확장자만 추출하기
	public static String getExtend(String path) {
		int lastIndex=path.lastIndexOf(".");
		//System.out.println(lastIndex);
		String ext=path.substring(lastIndex+1, path.length());
		//System.out.println(ext);
		return ext;
	}
	
	/*
	//미리 단위 테스트 해보기 위함
	public static void main(String[] args) {
		// d:\photo\summer\2010\지난.여름에.놀러갔던 사진.jpg"
		String filename=" d:\\photo\summer\\2010\\지난.여름에.놀러갔던사진.jpg";
		getExtend(filename);
	}
	*/
}
