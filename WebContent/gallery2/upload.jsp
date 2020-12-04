<%@page import="common.FileManager"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.DefaultFileItemFactory"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	/*
	파일 업로드 컴포넌트의 종류엔 여러가지가 있지만, 그 중 아파치의 공식 업로드 컴포넌트를 사용해 본다.
	*/
	
	String saveDir="D:/workspace/javaee_workspace/BoardApp/WebContent/data";
	int maxSize=2*1024*1024;//2M byte로 제한

	//업로드 객체를 생성해주는 팩토리 객체 : 주로 설정을 담당(서버의 저장경로, 파일의 용량제한..)
	DefaultFileItemFactory itemFactory=new DefaultFileItemFactory();
	itemFactory.setRepository(new File("saveDir"));//저장될 위치!!
	itemFactory.setSizeThreshold(maxSize);//용량을 지정한 크기로 제한
	
	//이 객체가 실제 업로드를 수행함
	ServletFileUpload upload=new ServletFileUpload(itemFactory);//설정정보를 생성자의 인수로 전달!!
	
	//FileItem 은 클라이언트의 전송 정보 하나 하나를 의미한다. 즉 html에서의 input 텍스트 박스, file 컴포넌트 하나 하나 들..
	//우리의 경우 input type="text" 가 FileItem에 담기고
	//우리의 경우 input type="file" 가 FileItem에 담긴다.
	request.setCharacterEncoding("utf-8");
	List<FileItem> items=upload.parseRequest(request);//업로드 컴포넌트에게 클라이언트의 요청 정보를 전달한다!!
	
	for(FileItem item : items){
		//out.print("저는 "+item.getFieldName());//msg,author,photo
		//out.print(item.getFieldName()+"의 값은 "+item.getString()+"<br>");//msg의 값은 ã¹ã¹ã¹
		
		//반복문으로 처리되다보니, 파일만 따로 처리를 하려면, 구분로직이 필요함.
		//out.print(item.getFieldName()+"은 텍스트 박스 여부 "+item.isFormField()+"<br>");
		if(!item.isFormField()){//텍스트박스가 아닌것만 업로드 처리!!
			//업로드 처리하자!! 현재 메모리상의 이미지 정보를 실제 물리적 파일로 저장하자!!
			//새롭게 생성할 파일명
			//out.print("당신이 업로드한 파일의 원래 이름은 "+item.getName());
			String ext=FileManager.getExtend(item.getName());
			String filename=System.currentTimeMillis()+"."+ext;
			File file=new File(saveDir+"/"+filename);//비어있는 파일
			item.write(file);//저장 정보를 File 클래스의 인스턴스로 전달!!
		}
	}
	
%>









