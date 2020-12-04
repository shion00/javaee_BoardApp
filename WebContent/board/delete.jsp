<%@page import="board.model.NoticeDAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="db.DBManager"%>
<%@ page import="java.sql.*"%>
<%@ include file="/inc/lib.jsp"%>
<%
	//웹에서 모두 문자이다!!
	String notice_id=request.getParameter("notice_id");

	//삭제 후 완료메시지 보여주고, list.jsp 를 요청할 것
	NoticeDAO noticeDAO=new NoticeDAO();
	int result=noticeDAO.delete(Integer.parseInt(notice_id));

	if(result==0){
		out.print(getMsgBack("삭제실패"));
	}else{
		out.print(getMsgURL("글이 삭제되었습니다.","/board/list.jsp"));
	}
%>