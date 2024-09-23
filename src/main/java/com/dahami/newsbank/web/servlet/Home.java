package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.dahami.newsbank.Constants;

@WebServlet(urlPatterns = { "/index.jsp" , "/home", "*.home" }, loadOnStartup = 1)
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
		if(response.isCommitted()) {
			return;
		}
		
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
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start", 0); // 시작 인덱스
		params.put("count", 7); // 카운트
		
		PhotoDAO photoDAO = new PhotoDAO();
		List<PhotoDTO> photoList = photoDAO.editorPhotoList(); // 보도사진		
		
		// 다운로드와 찜은 7개가 될때까지 쿼리를 1개월씩 늘려가며 최대 6개월까지 제한하여 찾아준다.	
		List<PhotoDTO> downloadList = new ArrayList<PhotoDTO>();
		for(int i=-1; i>=-6; i--) {
			params.put("monthDate", i);
			downloadList = photoDAO.downloadPhotoList(params); // 다운로드
			if(downloadList.size()>=7) {
				break;
			}
		}
		List<PhotoDTO> basketList = new ArrayList<PhotoDTO>();
		for(int i=-1; i>=-6; i--) {
			params.put("monthDate", i);
			basketList = photoDAO.basketPhotoList(params); // 찜
			if(basketList.size()>=7) {
				break;
			}
		}
		
		List<PhotoDTO> hitsList = photoDAO.hitsPhotoList(params); // 상세보기
		
		MemberDAO memberDAO = new MemberDAO();
		Map<Object,Object> mediaRangeParam = new HashMap<Object,Object>();
		mediaRangeParam.put("mediaRange", "all");
		List<MemberDTO> mediaList = memberDAO.listActiveMedia(mediaRangeParam);
		
		request.setAttribute("photoList", photoList);
		request.setAttribute("downloadList", downloadList);
		request.setAttribute("basketList", basketList);
		request.setAttribute("hitsList", hitsList);
		request.setAttribute("mediaList", mediaList);
		
		if(Constants.IS_NYT==true) {
			List<PhotoDTO> latestList = photoDAO.latestPhotoList();
			request.setAttribute("latestList", latestList);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"home.jsp");
		dispatcher.forward(request, response);			
	}
}
