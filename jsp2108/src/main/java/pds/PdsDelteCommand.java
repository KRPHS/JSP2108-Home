package pds;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class PdsDelteCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		String pwd = request.getParameter("pwd")==null?"":request.getParameter("pwd");
		String[] fSNames = request.getParameter("fSName").split("/");
		
		PdsDAO dao = new PdsDAO();
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		PdsVO vo = dao.getPdsContent(idx);
		
		if(vo.getPwd().equals(pwd)) {
			String realPath = request.getServletContext().getRealPath("/data/pds/");
			
			for(String fSName : fSNames) {
				new File(realPath + fSName).delete();
			}
			
			dao.pdsDelete(idx);
			
			response.getWriter().write("pdsDeleteOk");
		}
		
	}

}
