package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/boGood3")
public class BoGood3 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String res = "1";
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = request.getSession();
		ArrayList<String> good3Idx = (ArrayList) session.getAttribute("sGood3Idx");
		if(good3Idx == null) {
			good3Idx = new ArrayList<String>();
			session.setAttribute("sGood3Idx", good3Idx);
		}
		String imsiGoodIdx = "good3"+idx;
		if(!good3Idx.contains(imsiGoodIdx)) {
			dao.setGoodUpdate(idx);
			good3Idx.add(imsiGoodIdx);
			res = "0";
		}

		response.getWriter().write(res);
	}
}
