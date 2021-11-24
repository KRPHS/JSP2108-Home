package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class AdMemberListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int level = request.getParameter("level")==null?99:Integer.parseInt(request.getParameter("level"));
		String mid = request.getParameter("mid")==null?"":(String)request.getParameter("mid");
		
		MemberDAO dao = new MemberDAO();
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));	// 현재페이지 구하기
	  
	  int pageSize = 5;
	  int totRecCnt = dao.totRecCnt(level, mid);
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;	
		
		ArrayList<MemberVO> vos = dao.getMemberList(startIndexNo, pageSize, level, mid);
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStrarNo", curScrStrarNo);
		request.setAttribute("level", level);
		request.setAttribute("mid", mid);
	}

}
