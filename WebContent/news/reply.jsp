<%@page import="board.model.CommentsDAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/inc/lib.jsp" %>
<%
	//여기서 쿼리 실행할 것은 아니지만, 계획을 세우기 위해 작성함..
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="comments" class="board.model.Comments"/>
<jsp:setProperty property="*" name="comments"/>
<%
	if(new CommentsDAO().insert(comments)==0){
		out.print(getMsgBack("댓글 등록 실패"));
	}else{
		out.print(getMsgURL("댓글 등록 성공", "detail.jsp?news_id="+comments.getNews_id()));
	}
%>