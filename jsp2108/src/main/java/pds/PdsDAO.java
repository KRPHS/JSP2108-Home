package pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;
import conn.TimeDiff;

public class PdsDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	PdsVO vo = null;

	public int setPdsInputOk(PdsVO vo) {
		int res = 0;
		try {
			sql = "insert into pds values (default,?,?,?,?,?,?,?,?,default,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getfName());
			pstmt.setString(4, vo.getfSName());
			pstmt.setInt(5, vo.getfSize());
			pstmt.setString(6, vo.getTitle());
			pstmt.setString(7, vo.getPart());
			pstmt.setString(8, vo.getPwd());
			pstmt.setString(9, vo.getOpenSw());
			pstmt.setString(10, vo.getContent());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public int totRecCnt(String part) {
		int totRecCnt=0;
		try {
			if(part.equals("전체")) {
				sql = "select count(*) from pds";
				pstmt = conn.prepareStatement(sql);
			} else {
				sql = "select count(*) from pds where part = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return totRecCnt;
	}

	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part) {
		List<PdsVO> vos = new ArrayList<PdsVO>();
		try {
			if(part.equals("전체")) {
				sql = "select * from pds order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			} else {
				sql = "select * from pds where part=? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new PdsVO();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setfName(rs.getString("fName"));
				vo.setfSName(rs.getString("fSName"));
				vo.setfSize(rs.getInt("fSize"));
				vo.setTitle(rs.getString("title"));
				vo.setPart(rs.getString("part"));
				vo.setPwd(rs.getString("pwd"));
				
				// 날짜를 24시간제로 체크하기위해서 사용자정의메소드로 만든 timeDiff()를 사용한다.
				vo.setfDate(rs.getString("fDate"));   // 만약 wDate가 날짜타입일경우
				vo.setwCdate(rs.getString("fDate"));  // 날짜타입 wDate를 문자타입 wCdate로 저장후
				TimeDiff td = new TimeDiff();
				vo.setwNdate(td.timeDiff(vo.getwCdate()));  // 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내어서 오늘시간과 계산하여 시간차를 돌려받는다.
				
				vo.setDownNum(rs.getInt("downNum"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return vos;
	}

	public PdsVO getPdsContent(int idx) {
		vo = new PdsVO();
		try {
			sql = "select * from pds where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			rs.next();
			vo.setIdx(rs.getInt("idx"));
			vo.setMid(rs.getString("mid"));
			vo.setNickName(rs.getString("nickName"));
			vo.setfName(rs.getString("fName"));
			vo.setfSName(rs.getString("fSName"));
			vo.setfSize(rs.getInt("fSize"));
			vo.setTitle(rs.getString("title"));
			vo.setPart(rs.getString("part"));
			vo.setPwd(rs.getString("pwd"));
			
			// 날짜를 24시간제로 체크하기위해서 사용자정의메소드로 만든 timeDiff()를 사용한다.
			vo.setfDate(rs.getString("fDate"));   // 만약 wDate가 날짜타입일경우
			vo.setwCdate(rs.getString("fDate"));  // 날짜타입 wDate를 문자타입 wCdate로 저장후
			TimeDiff td = new TimeDiff();
			vo.setwNdate(td.timeDiff(vo.getwCdate()));  // 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내어서 오늘시간과 계산하여 시간차를 돌려받는다.
			
			vo.setDownNum(rs.getInt("downNum"));
			vo.setOpenSw(rs.getString("openSw"));
			vo.setContent(rs.getString("content"));
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	public void setPdsDownUpdate(int idx) {
		try {
			sql = "update pds set downNum = downNum+1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	public void pdsDelete(int idx) {
		try {
			sql = "delete from pds where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
}
