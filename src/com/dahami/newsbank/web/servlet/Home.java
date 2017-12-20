package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.dahami.common.mybatis.MybatisSessionFactory;
import com.dahami.common.mybatis.impl.MybatisService;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

@WebServlet(urlPatterns = { "/home", "*.home" }, loadOnStartup = 1)
public class Home extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public Home() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if (MemberInfo != null) {
			request.setAttribute("MemberInfo", MemberInfo);
		}
		
		PhotoDAO photoDAO = new PhotoDAO();
		List<PhotoDTO> photoList = photoDAO.editorPhotoList(); // 보도사진
		List<PhotoDTO> downloadList = photoDAO.downloadPhotoList(); // 다운로드
		List<PhotoDTO> basketList = photoDAO.basketPhotoList(); // 찜
		List<PhotoDTO> hitsList = photoDAO.hitsPhotoList(); // 상세보기
		
		MemberDAO memberDAO = new MemberDAO();
		List<MemberDTO> mediaList = memberDAO.listActiveMedia();
		
		request.setAttribute("photoList", photoList);
		request.setAttribute("downloadList", downloadList);
		request.setAttribute("basketList", basketList);
		request.setAttribute("hitsList", hitsList);
		request.setAttribute("mediaList", mediaList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	

}
