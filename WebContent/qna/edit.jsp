<%@page import="board.model.QnADAO"%>
<%@page import="board.model.QnA"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/inc/lib.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	int qna_id=Integer.parseInt(request.getParameter("qna_id"));
	String writer=request.getParameter("writer");
	String title=request.getParameter("title");
	String content=request.getParameter("content");

	QnA qna=new QnA();
	QnADAO dao=new QnADAO();
	qna.setQna_id(qna_id);
	qna.setWriter(writer);
	qna.setTitle(title);
	qna.setContent(content);
	
	int result=dao.update(qna);
	
	if(result==0){
		out.print(getMsgBack("수정실패했습니다."));
	}else{
		out.print(getMsgURL("수정성공했습니다.", "/qna/detail.jsp?qna_id="+qna_id));
	}
	
%>