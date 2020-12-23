<%@page import="board.model.QnADAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@include file="/inc/lib.jsp" %>
<%
	int qna_id=Integer.parseInt(request.getParameter("qna_id"));
	QnADAO dao=new QnADAO();
	int result=dao.delete(qna_id);
	
	if(result==0){
		out.print(getMsgBack("삭제실패했습니다."));
	}else{
		out.print(getMsgURL("삭제성공했습니다.", "/qna/list.jsp"));
	}
%>