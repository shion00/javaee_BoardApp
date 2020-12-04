/*�Խ��� ��� ������*/
package board.gui;

import java.awt.Dimension;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import board.model.Notice;
import board.model.NoticeDAO;

public class BoardList extends Page{
	JTable table;
	JScrollPane scroll;
	JButton bt;//
	BoardModel model;
	NoticeDAO noticeDAO;
	ArrayList<Notice> boardList;//���� ����� ���� ������ ���
	
	public BoardList(BoardMain boardMain) {
		super(boardMain);
		
		//����
		table=new JTable(model=new BoardModel());//JTable�� �� ��ü���� ����!!
		scroll=new JScrollPane(table);
		bt=new JButton("�۵��");
		noticeDAO=new NoticeDAO();

		//��Ÿ��
		scroll.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth(),600));
		
		//����
		add(scroll);
		add(bt);
		
		getList();
		table.updateUI();
		
		bt.addActionListener((e)->{
			boardMain.showPage(Pages.valueOf("BoardWrite").ordinal());
		});
		
		table.addMouseListener(new MouseAdapter() {
			public void mouseReleased(MouseEvent e) {
				//�󼼺���� �������� notice_id�� ����
				int col=0;
				int row=table.getSelectedRow();
//				String notice_id=(String)table.getValueAt(row, col);//������ ������ �·�
//				System.out.println("����� ��å�� �Խù��� notice_id = "+notice_id);
				Notice notice=boardList.get(row);
				BoardContent boardContent=(BoardContent)boardMain.pageList[Pages.valueOf("BoardContent").ordinal()];
				boardContent.setData(notice);
				boardMain.showPage(Pages.valueOf("BoardContent").ordinal());//ȭ����ȯ
			}
		});
	}
	
	//DAO �̿��Ͽ� ������ ��������!!
	public void getList() {
	    boardList=noticeDAO.selectAll();
		model.list=boardList;
	}
}


















