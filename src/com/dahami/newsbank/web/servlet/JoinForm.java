package com.dahami.newsbank.web.servlet;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/form.join")
public class JoinForm extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public JoinForm() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		CmdClass cmd = CmdClass.getInstance(request);
		
		String type = request.getParameter("type"); // 회원 구분
		request.setAttribute("type", type);
		
		//매체목록 세팅
//		request.setAttribute("mediaList", new MemberDAO().listActiveMedia());
		
		if (type == null) {
			response.sendRedirect("/kind.join");
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/join_form.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	/*protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String root = req.getSession().getServletContext().getRealPath("/");
		String pathname = root + "uploadDirectory";

		File f = new File(pathname);
		if (!f.exists()) {
			// 폴더가 존재하지 않으면 폴더 생성
			f.mkdirs();
		}

		String encType = "UTF-8";
		int maxFilesize = 5 * 1024 * 1024;

		// MultipartRequest(request, 저장경로[, 최대허용크기, 인코딩케릭터셋, 동일한 파일명 보호 여부])
		MultipartRequest mr = new MultipartRequest(req, pathname, maxFilesize, encType, new DefaultFileRenamePolicy());

		File file1 = mr.getFile("compDoc");
		File file2 = mr.getFile("logo");
		System.out.println(file1); // 첨부된 파일의 전체경로
		System.out.println(file2);

		System.out.println(req.getParameter("title")); // null
		System.out.println(mr.getParameter("title")); // 입력된 문자
	}
*/
}
