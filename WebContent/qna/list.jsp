<%@page import="java.util.List"%>
<%@page import="board.model.QnA"%>
<%@page import="board.model.QnADAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=utf-8"%>

<%
	QnADAO qnaDAO=new QnADAO();
 	List<QnA> list=qnaDAO.selectAll();
 	
 	int totalRecord=list.size();
 	int pageSize=10;
 	int totalPage=(int)Math.ceil((float)totalRecord/pageSize);
 	int blockSize=10;
 	int currentPage=1;
 	
 	if(request.getParameter("currentPage")!=null){
	 	currentPage=Integer.parseInt(request.getParameter("currentPage"));
 	}
 	
 	int firstPage=currentPage-(currentPage-1)%blockSize;
 	int lastPage=firstPage+blockSize-1;
 	int num=totalRecord-(pageSize*(currentPage-1));//페이지당 시작 번호,26,16..
 	int curPos=(currentPage-1)*pageSize;//페이지당 List에서의 시작 index
%>
<!-- ----------------------------------
<%="totalRecord:"+totalRecord+"<br>"%>
<%="pageSize:"+pageSize+"<br>"%>
<%="totalPage:"+totalPage+"<br>"%>
<%="blockSize:"+blockSize+"<br>"%>
<%="currentPage:"+currentPage+"<br>"%>
<%="firstPage:"+firstPage+"<br>"%>
<%="lastPage:"+lastPage+"<br>"%>
<%="num:"+num+"<br>"%>
------------------------------------ -->
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 16px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
img{
	box-sizing:boarder-box; 
}
a{
	text-decoration:none;
}
.pageNum{
	font-size:20px;
	color:blue;
	font-weight:bold;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){//$(); 는 onload 
	$("button").on("click",function(){
		//자바스크립트에서 링크 구현?
		location.href="/qna/regist_form.jsp";
	});
});
</script>
</head>
<body>
<table>
  <tr>
    <th>No</th>
    <th>제목</th>
    <th>작성자</th>
	<th>등록일</th>
	<th>조회수</th>
  </tr>

<%for(int i=1;i<=pageSize;i++){%>
<%if(num<1)break; %><!--break문을 만나지 않았다는 것은 레코드가 있다는 것이므로, break문 아래에서 데이터를 추출하자!-->
<%QnA qna=list.get(curPos++); %>
	<tr>
		<td><%=num--%></td>
		<td>
			<%if(qna.getDepth()>0){%> 
				<img src="/images/reply.png" style="margin-left:<%=20*qna.getDepth()%>px">
			<%}%>
			<a href="/qna/detail.jsp?qna_id=<%=qna.getQna_id()%>"><%=qna.getTitle()%></a>
		</td>
		<td><%=qna.getWriter()%></td>
		<td><%=qna.getRegdate().substring(0,10)%></td>
		<td><%=qna.getHit()%></td>
	</tr>
<%}%>
	<tr>
		<td colspan="5" style="text-align:center">
			<%if(firstPage-1>=1){%>
				<a href="/qna/list.jsp?currentPage=<%=firstPage-1%>">◀</a>
			<%}else{%>
				<a href="javascript:alert('처음 페이지 입니다.')";>◀</a>
			<%}%>
			
			<%for(int i=firstPage;i<=lastPage;i++){%>
				<%if(i>totalPage)break;%>
					<a href="/qna/list.jsp?currentPage=<%=i%>" <%if(i==currentPage){%>class="pageNum"<%}%>>[<%=i%>]</a>
			<%}%>
			
			<%if((lastPage+1)<totalPage){%>			
				<a href="/qna/list.jsp?currentPage=<%=lastPage+1%>">▶</a>
			<%}else{%>
				<a href="javascript:alert('마지막 페이지 입니다.')">▶</a>
			<%}%>
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<button>글등록</button>
		</td>
	</tr>
	<tr>
		<td colspan="5" style="text-align:center">
			<%@ include file="/inc/footer.jsp"%>
		</td>
	</tr>
</table>
</body>
</html>
