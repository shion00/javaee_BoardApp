package board.gui;

import java.awt.Dimension;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import board.model.Notice;
import board.model.NoticeDAO;

public class BoardContent extends Page{
	JTextField t_author;
	JTextField t_title;
	JTextArea area;
	JScrollPane scroll;
	JButton bt_list, bt_edit, bt_del;
	Notice notice; //VO
	NoticeDAO noticeDAO;//DAO

	public BoardContent(BoardMain boardMain) {
		super(boardMain);
		
		//����
		t_author=new JTextField();
		t_title=new JTextField();
		area=new JTextArea();
		scroll=new JScrollPane(area);
		bt_list=new JButton("�������");
		bt_edit=new JButton("����");
		bt_del=new JButton("����");
		noticeDAO=new NoticeDAO();//DAO �����ϱ�
		
		//��Ÿ��
		t_author.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10,25));
		t_title.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10,25));
		scroll.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10,500));
		
		//����
		add(t_author);
		add(t_title);
		add(scroll);
		add(bt_list);
		add(bt_edit);
		add(bt_del);
		
		//��� ��ư�� �̺�Ʈ ����
		bt_list.addActionListener((e)->{
			boardMain.showPage(Pages.valueOf("BoardList").ordinal());
		});
		
		//���� ��ư�� ������ ����
		bt_edit.addActionListener((e)->{
			//�ѹ� ����� ��������!!
			if(JOptionPane.showConfirmDialog(BoardContent.this, "�����ϽǷ���?")==JOptionPane.OK_OPTION){
				edit();
			}
		});
	
		//���� ��ư�� ������ ����
		bt_del.addActionListener((e)->{
			if(JOptionPane.showConfirmDialog(BoardContent.this, "�����ϽǷ���?")==JOptionPane.OK_OPTION) {
				del();
			}
		});
	}
	
	public void edit() {
		//DAO�� �̿��Ͽ� �����۾� ����
		//�ۼ���, ����, ���븸 ��ü
		notice.setAuthor(t_author.getText());//���ο.
		notice.setTitle(t_title.getText());//���ο.
		notice.setContent(area.getText());//���ο.
		int result=noticeDAO.update(notice);
		
		if(result==0) {
			JOptionPane.showMessageDialog(this, "��������");
		}else {
			JOptionPane.showMessageDialog(this, "��������");
			boardMain.showPage(Pages.valueOf("BoardList").ordinal());
		}
	}
	
	public void del() {
		//�����ϰ� ��Ϻ����ֱ�
		int result=noticeDAO.delete(notice.getNotice_id());
		
		if(result==0) {
			JOptionPane.showMessageDialog(this, "��������");
		}else {
			JOptionPane.showMessageDialog(this, "��������");
			BoardList boardList=(BoardList)boardMain.pageList[Pages.valueOf("BoardList").ordinal()];
			boardList.getList();//������ ��������
			boardList.table.updateUI();//ȭ�� ����
			
			boardMain.showPage(Pages.valueOf("BoardList").ordinal());
		}
	}
	
	//������Ʈ�� ������ ä���ֱ�
	//�� �޼��带 ȣ���ϴ� �ڴ�, �Ѱ��� �����͸� VO��Ƽ� ȣ���ϸ� �ȴ�!
	public void setData(Notice notice) {
		this.notice=notice;//���߿� ��������� ����ؼ� �����س���!
		t_author.setText(notice.getAuthor());
		t_title.setText(notice.getTitle());
		area.setText(notice.getContent());
	}
}















