package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBManager;
import sun.security.pkcs11.Secmod.DbMode;

public class NewsDAO {
	DBManager dbManager=new DBManager();
	
	//목록, 리스트
	public List selectAll() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		News news=null;
		ArrayList list=new ArrayList();
		
		con=dbManager.getConnection();
		StringBuilder sb=new StringBuilder();
		sb.append("select n.news_id as news_id, writer, title, regdate, hit, count(comments_id) as cnt");
		sb.append(" from news n left outer join comments c");
		sb.append(" on n.news_id=c.news_id");
		sb.append(" group by n.news_id, writer, title, regdate, hit order by n.news_id desc");
		try {
			pstmt=con.prepareStatement(sb.toString());
			rs=pstmt.executeQuery();
			while(rs.next()) {
				news=new News();
				news.setNews_id(rs.getInt("news_id"));
				news.setTitle(rs.getString("title"));
				news.setWriter(rs.getString("writer"));
				news.setRegdate(rs.getString("regdate"));
				news.setHit(rs.getInt("hit"));
				news.setCnt(rs.getInt("cnt"));
				list.add(news);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt, rs);
		}
		return list;
	}
	
	//디테일, 1건 보기
	public News select(int news_id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		News news=null;
		
		String sql="select * from news where news_id=?";
		con=dbManager.getConnection();
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				news=new News();
				news.setNews_id(rs.getInt("news_id"));
				news.setTitle(rs.getString("title"));
				news.setWriter(rs.getString("writer"));
				news.setContent(rs.getString("content"));
				news.setRegdate(rs.getString("regdate"));
				news.setHit(rs.getInt("hit"));
			}
			
			//조회수 증가
			sql="update news set hit=hit+1 where news_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			int result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt, rs);
		}
		return news;
	}
	
	//등록하기
	public int insert(News news) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;
		
		String sql="insert into news(title,writer,content) values(?,?,?)";
		con=dbManager.getConnection();
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, news.getTitle());
			pstmt.setString(2, news.getWriter());
			pstmt.setString(3, news.getContent());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt);
		}
		return result;
	}
	
	//수정하기
	public int update(News news) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;
		
		String sql="update news set writer=?, title=?, content=? where news_id=?";
		con=dbManager.getConnection();
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,news.getWriter());
			pstmt.setString(2, news.getTitle());
			pstmt.setString(3, news.getContent());
			pstmt.setInt(4, news.getNews_id());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt);
		}
		return result;
	}
	
	//삭제하기
	public int delete(int news_id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;
		
		String sql="delete from news where news_id=?";
		con=dbManager.getConnection();
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt);
		}
		return result;
	}
	
	//게시물 지우지 않고, 삭제된 게시물이라는 표시 처리
	public int replace(int news_id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;
		String sql="update news set title='작성자에 의해 삭제된 게시물입니다.', writer='', content='' where news_id=?";
		con=dbManager.getConnection();
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt);
		}
		return result;
	}
}



















































