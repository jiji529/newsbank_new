package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.UploadService;

/**
 * Servlet implementation class UploadTest
 */
@WebServlet("*.upload")
public class Upload extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	
	
	public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    }
	
	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public Upload() {
		super();
	}

	/**
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.addHeader("Cache-Control", "no-cache");
		JSONObject json = new JSONObject();
		boolean result = false;
		String message = "";
		String fileName = "";
		int notice_seq = 0;
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = null;
		BoardDTO NoticeInfo = null;

		if (closed) {
			return;
		}

		request.setAttribute("pathType", cmd2);

		if (request.getAttribute("pathType") != null) {
			UploadService us = new UploadService();
			// json = us.execute(request, response);
			us.execute(request, response);
			String fileFullPath = (String) request.getAttribute("filePath");
			fileName =  (String) request.getAttribute("fileName");
			if (fileFullPath == null || fileFullPath.isEmpty()) {
				message = "파일 업로드 실패";
			} else {
				result = true;
				message = "파일 업로드 성공";
				
				if (session.getAttribute("MemberInfo") != null) {
					MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
					NoticeInfo = new BoardDTO();
					switch (cmd2) {
					case "doc":
						MemberInfo.setComDocPath(fileFullPath);
						break;
					case "bank":
						MemberInfo.setCompBankPath(fileFullPath);
						break;
					case "logo":
						MemberInfo.setLogo(fileFullPath);
						break;
					case "contract":
						MemberInfo.setContractPath(fileFullPath);
						break;
					case "notice":
						NoticeInfo.setFileName(fileFullPath);
						break;
					}
					MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
					memberDAO.updateMember(MemberInfo); // 회원정보 업데이트 요청
					
					if(MemberInfo.getType().equals("A")) { // 관리자 회원만 업로드
						BoardDAO boardDAO = new BoardDAO(); // 공지사항 정보 연결
						
						if(request.getParameter("seq") == null || request.getParameter("seq").equals("")){ 
							// 공지사항 신규 첨부파일 추가
							notice_seq = boardDAO.insertNotice(NoticeInfo); 
							
						} else {
							// 공지사항 정보 업데이트 요청(파일 경로 변경)
							notice_seq = Integer.parseInt(request.getParameter("seq"));
							NoticeInfo.setSeq(notice_seq); // 공지사항 고유번호
							boardDAO.updateNotice(NoticeInfo); 
						}
						
					}
				} 
			}

		} else {
			message = "요청한 변수가 올바르지 않습니다.";

		}

		json.put("success", result);
		json.put("message", message);
		json.put("file", fileName);
		json.put("notice_seq", notice_seq);
		response.getWriter().print(json);
		/*
		 * JSONObject json = new JSONObject(); boolean result = false; String message =
		 * "";
		 * 
		 * HttpSession session = request.getSession();
		 * 
		 * MemberDTO MemberInfo = null;
		 * 
		 * String type = request.getParameter("type"); // String savePath =
		 * request.getServletContext().getRealPath("folderName");
		 * 
		 * String savePath = "";
		 * 
		 * switch (type) { case "doc": savePath = PATH_COMP_DOC_BASE_LOCAL; break; case
		 * "bank": savePath = PATH_COMP_BANK_BASE_LOCAL; break; case "logo": savePath =
		 * PATH_LOGO_BASE_LOCAL; break; }
		 * 
		 * if (savePath.isEmpty()) { message = "파일 경로를 찾을 수 없습니다."; } else if
		 * (session.getAttribute("MemberInfo") != null) { MemberInfo = (MemberDTO)
		 * session.getAttribute("MemberInfo");
		 * 
		 * // 파일이 저장될 서버의 경로. 되도록이면 getRealPath를 이용하자.
		 * 
		 * RequestDispatcher rd = null; String fileName = ""; File file = null;
		 * Enumeration files = null;
		 * 
		 * // 파일 크기 15MB로 제한 int sizeLimit = 1024 * 1024 * 15; try {
		 * 
		 * File targetDir = new File(savePath);
		 * 
		 * if (!targetDir.exists()) { // 디렉토리 없으면 생성. targetDir.mkdirs(); }
		 * 
		 * // ↓ request 객체, ↓ 저장될 서버 경로, ↓ 파일 최대 크기, ↓ 인코딩 방식, ↓ 같은 이름의 파일명 방지 처리 //
		 * (HttpServletRequest request, String saveDirectory, int maxPostSize, String //
		 * encoding, FileRenamePolicy policy) // 아래와 같이 MultipartRequest를 생성만 해주면 파일이
		 * 업로드 된다.(파일 자체의 업로드 완료)
		 * 
		 * MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,
		 * "UTF-8", new DefaultFileRenamePolicy()); fileName =
		 * multi.getFilesystemName("uploadFile"); // 파일의 이름 얻기
		 * 
		 * files = multi.getFileNames(); String name = (String) files.nextElement();
		 * file = multi.getFile(name); if (fileName == null) { // 파일이 업로드 되지 않았을때
		 * System.out.print("파일 업로드 되지 않았음"); message = "파일 업로드 실패"; } else { // 파일이 업로드
		 * 되었을때 result = true; message = "파일 업로드 성공"; String now = new
		 * SimpleDateFormat("yyyyMMddHmsS").format(new Date()); // 현재시간
		 * 
		 * String tmpFileName = Integer.toString(MemberInfo.getSeq()); if
		 * (multi.getParameter("name") != null && !multi.getParameter("name").isEmpty())
		 * { tmpFileName = multi.getParameter("name"); }
		 * 
		 * String orgFileName = savePath + "/" + fileName; String reFileName = savePath
		 * + "/" + tmpFileName + fileName.substring(fileName.lastIndexOf(".")); String
		 * bakFileName = savePath + "/" + tmpFileName + "_" + now +
		 * fileName.substring(fileName.lastIndexOf("."));
		 * 
		 * File upfile1 = new File(orgFileName); File upfile2 = new File(reFileName);
		 * File backFile = new File(bakFileName);
		 * 
		 * if (upfile2.exists()) upfile2.renameTo(backFile);
		 * 
		 * if (upfile1.renameTo(upfile2)) { System.out.print("이름변경성공");
		 * 
		 * fileName = upfile2.getName(); String fileFullPath = savePath + "/" +
		 * fileName;
		 * 
		 * switch (type) { case "doc": MemberInfo.setComDocPath(fileFullPath); break;
		 * case "bank": MemberInfo.setCompBankPath(fileFullPath); break; case "logo":
		 * MemberInfo.setLogo(fileFullPath); break; } MemberDAO memberDAO = new
		 * MemberDAO(); // 회원정보 연결 memberDAO.updateMember(MemberInfo); // 회원정보 업데이트 요청
		 * 
		 * System.out.println("User Name : " + type); System.out.println("File Name  : "
		 * + fileName); } else { message = "파일 업로드 실패"; }
		 * 
		 * } // else
		 * 
		 * } catch (Exception e) { System.out.print("예외 발생 : " + e); if
		 * (e.getMessage().indexOf("exceeds limit") > -1) { // 파일사이즈 초과된 경우 message =
		 * "파일 용량을 초과했습니다."; logger.warn("Invalid Request: " + message); }
		 * 
		 * } } else { message = "다시 로그인해주세요."; }
		 * 
		 * 
		 * json.put("success", result); json.put("message", message);
		 * 
		 * response.getWriter().print(json);
		 */
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
