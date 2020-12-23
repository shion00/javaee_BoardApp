<%@page import="board.model.ImageBoard"%>
<%@page import="board.model.ImageBoardDAO"%>
<%@page import="common.file.FileManager"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/inc/lib.jsp" %>
<%!
	//파라미터를 넘겨받아, 게시물을 수정한다.
	//주의점) 이미지를 업로드 한 경우만 새로운 이미지로 교체, 아닌 경우는 기존 파일명 유지!!
	
	//클라이언트의 브라우저에서 form 속성을 multipart/form-data 로 전송하면, request 객체로 직접
	//파라미터를 받을 수 없고, 업로드 컴포넌트를 이용해야 한다..cos.jar, apache commons-fileupload
	
	String saveDir="D:/workspace/javaee_workspace/BoardApp/WebContent/data";
	int maxSize=3*1024*1024;//3M byte
	ImageBoardDAO dao=new ImageBoardDAO();
%>
<%
	//실습했던 예제보다 기능이 더 추가됨, db에 넣어야함. DAO 이용
	
	//업로드컴포넌트에 대한 설정을 하기 위해 FileItemFactory 객체를 이용해야 한다.
	DiskFileItemFactory itemFactory=new DiskFileItemFactory();
	itemFactory.setRepository(new File(saveDir));
	itemFactory.setSizeThreshold(maxSize);
	itemFactory.setDefaultCharset("utf-8");
	
	ServletFileUpload upload=new ServletFileUpload(itemFactory);
	
	request.setCharacterEncoding("utf-8");
	List<FileItem> items=upload.parseRequest(request);//업로드된 정보 분석!! 각가의 컴포넌트들을 FileItem 단위로 쪼갠다.
	
	ImageBoard board=new ImageBoard();//Empty상태의 vo 생성
	
	for(FileItem item : items){
		if(item.isFormField()){//textfield 라면, db에 넣자
			//vo에 텍스트필드의 값을 담자!
			if(item.getFieldName().equals("board_id")){//필드명이 author 라면..
				board.setBoard_id(Integer.parseInt(item.getString()));
			}else if(item.getFieldName().equals("author")){
				board.setAuthor(item.getString());
			}else if(item.getFieldName().equals("title")){
				board.setTitle(item.getString());
			}else if(item.getFieldName().equals("content")){
				board.setContent(item.getString());
			}else if(item.getFieldName().equals("filename")){
				board.setFilename(item.getString());
			}
		}else{//textfield가 아니라면, 업로드 처리
			//사용자가 파일을 업로드 했다면 아래 작업 수행
			out.print("업록드한 파일명:"+item.getName().length());//새롭게 업로드 안하면 0
			if(item.getName().length()>0){//파일을 교체한다면, 즉 업로드 하길 원한다면.
				String newName=System.currentTimeMillis()+"."+FileManager.getExtend(item.getName());
				String destFile=saveDir+"/"+newName;
				File file=new File(destFile);
				item.write(file);//물리적 저장 시점!!
				out.print("업로드 완료");
				board.setFilename(newName);//vo 에 파일명 값을 담자!
			}else{
				break;
			}
		}
	}
	
	//반복문을 지나친 이 시점에는 vo에 데이터가 이미 채워진 상태일 것이다!
	int result=dao.update(board);//이 시점에는 채워진 vo를 원함!
	if(result==0){
		out.print(getMsgBack("등록실패"));
	}else{
		out.print(getMsgURL("등록성공", "/imageboard/list.jsp"));
	}
%>







