package pds;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsListCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String part = request.getParameter("part")==null?"전체":request.getParameter("part");
		PdsDAO dao = new PdsDAO();
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));	// 현재페이지 구하기
	  int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
	  int totRecCnt = dao.totRecCnt(part);
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;
	  int curBlock = (pag - 1) / blockSize;
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		
	  List<PdsVO> vos = dao.getPdsList(startIndexNo, pageSize, part);  //전체자료
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStrarNo", curScrStrarNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("part", part);
	}

}
