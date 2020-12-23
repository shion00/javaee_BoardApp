<%@page import="board.model.QnA"%>
<%@page import="java.util.List"%>
<%@page import="board.model.QnADAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	//DB 연동
	QnADAO dao=new QnADAO();
	List<QnA> list=dao.selectAll();

	int totalRecord=list.size();//총 레코드 수, 실제 DB에 있는 데이터 수를 대입하면 된다!
	int pageSize=10;//한 페이지당 보여질 레코드 수
	int totalPage=(int)Math.ceil((float)totalRecord/pageSize);//총 페이지수, 정수/정수 는 '정수'가 나옴, Math.ceil() 함수 : 소수점 자리 무조건 올리는 함수
																				  //floor() 함수 : 소수점 아래를 무조건 무시,round() 함수 : 반올림함수다.
	int blockSize=10;//한 블럭당 보여질 페이지 수, 다음 이전 페이지 단위를 블럭이라 부른다.
	int	 currentPage=1;//현재 페이지
	
	//아래의 코드는 아무때나 하는게 아니다! 즉 누군가가 파라미커를 넘겼을때만, 즉 페이지 넘버를 클릭한 경우를 전제로 숫자화 시키는 코드이다.
	if(request.getParameter("currentPage")!=null){//즉 페이지를 넘겼다면..즉 넘버를 클릭했다면...
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int firstPage=currentPage-(currentPage-1)%blockSize;//반복문의 시작 값, %는 나머지 연산자, 25%10=5
	int lastPage=firstPage+blockSize-1;//반복문의 끝값
	int num=totalRecord-(currentPage-1)*pageSize;//페이지당 시작 번호
	int curPos=(currentPage-1)*pageSize;//페이지당 List에서의 시작 index
%>
<%="총레코드 수는 "+totalRecord+"<br>"%>
<%="페이지당 레코드 수는 "+pageSize+"<br>"%>
<%="totalPage"+totalPage+"<br>"%>
<%="blockSize"+blockSize+"<br>"%>
<%="currentPage"+currentPage+"<br>"%>
<%="firstPage"+firstPage+"<br>"%>
<%="lastPage"+lastPage+"<br>"%>
<%="num"+num+"<br>"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	font-size:15px;
	color:red;
	font-weight:bold;
}
</style>
<script>
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
<%if(num<1)break;%>
<%
	//break문을 만나지 않았다는 것은 레코드가 있다는 것이므로, break문 아래에서 데이터를 추출하자! 
	QnA qna=list.get(curPos++);//1page:0~9,2page:10~19..
%>
	<tr>
		<td><%=num--%></td>
		<td>
			<%if(qna.getDepth()>0){//답변인것만..%>
				<img src="/images/reply.png" style="margin-left:<%=10*qna.getDepth()%>">
			<%} %>
			<%=qna.getTitle() %>
		</td>
		<td><%=qna.getWriter() %></td>
		<td><%=qna.getRegdate() %></td>
		<td><%=qna.getHit() %></td>
	</tr>
<%} %>
	<tr>
		<td colspan="5" style="text-align:center">
			<%if((firstPage-1)>=1){//페이지가 있다면..%>
				<a href="/qna/list2.jsp?currentPage=<%=firstPage-1%>">◀</a>
			<%}else{%>
				<a href="javascript:alert('처음 페이지 입니다.');">◀</a>
			<%}%>
			
			<%for(int i=firstPage;i<=lastPage;i++){%>
				<%if(i>totalPage)break; //페이지를 출력하는 i%>
					<a href="/qna/list2.jsp?currentPage=<%=i%>" <%if(i==currentPage){%>class="pageNum"<%}%>>[<%=i%>]</a>
			<%}%>
			
			<%if((lastPage+1)<totalPage){%>
				<a href="/qna/list2.jsp?currentPage=<%=lastPage+1%>"> ▶</a>
			<%}else{%>
				<a href="javascript:alert('마지막 페이지 입니다.');">▶</a>
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