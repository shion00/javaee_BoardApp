<%@page import="board.model.News"%>
<%@page import="board.model.NewsDAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/inc/lib.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String news_id=request.getParameter("news_id");
	String title=request.getParameter("title");
	String writer=request.getParameter("writer");
	String content=request.getParameter("content");
	
	NewsDAO dao=new NewsDAO();
	News news=new News();
	news.setNews_id(Integer.parseInt(news_id));
	news.setTitle(title);
	news.setWriter(writer);
	news.setContent(content);
	int result=dao.update(news);
	
	if(result==0){
		out.print(getMsgBack("수정실패"));
	}else{
		out.print(getMsgURL("수정성공", "detail.jsp?news_id="+news_id));
	}

%>