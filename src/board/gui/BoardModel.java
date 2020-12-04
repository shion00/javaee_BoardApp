package board.gui;

import java.util.ArrayList;

import javax.swing.table.AbstractTableModel;

import board.model.Notice;

public class BoardModel extends AbstractTableModel{
	String[] column= {"notice_id","작성자","제목","등록일","조회수"};
	//ArrayList<E> 데이터 선언.. 배열, 컬렉션 둘다 가능
	ArrayList<Notice> list=new ArrayList<Notice>();
	
	public int getRowCount() {
		return list.size();
	}
	public int getColumnCount() {
		return column.length;
	}
	
	//컬럼 제목 출력
	public String getColumnName(int col) {
		return column[col];
	}
	
	public Object getValueAt(int row, int col) {
		Notice notice=list.get(row);//각 방에 있는 vo를 추출!!
		
		//notice[col] 안됨 notice는 배열이 아니기 때문, if문이 필요함
		String obj=null;
		if(col==0) {//Notice_id
			obj=Integer.toString(notice.getNotice_id());
		}else if(col==1) {//작성자
			obj=notice.getAuthor();
		}else if(col==2) {//제목
			obj=notice.getTitle();
		}else if(col==3) {//등록일
			obj=notice.getRegdate();
		}else if(col==4) {//조회수
			obj=Integer.toString(notice.getHit());
		}
		return obj;
	}
}















