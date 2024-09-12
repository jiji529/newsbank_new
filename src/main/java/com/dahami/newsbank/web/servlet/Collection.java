package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.CollectionDAO;
import com.dahami.newsbank.web.dto.CollectionDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class Collection
 */
@WebServlet(
		urlPatterns = {"/collection"},
		loadOnStartup = 1
		)
public class Collection extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Collection() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
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
		
		List<CollectionDTO> collectionList = new ArrayList<CollectionDTO>(); // 컬렉션 목록
		CollectionDTO dto = new CollectionDTO(); // 컬렉션 객체
		
		CollectionDAO dao = new CollectionDAO();
		collectionList = dao.selectCollectionList();
		
		for (CollectionDTO collectionDTO : collectionList) { // 찜 폴더에서 제일 첫번째로 추가한 이미지 1개를 대표이미지로 출력
			int bookmark_seq = collectionDTO.getSeq();
			dto = dao.selectBackgroundPhoto(bookmark_seq);
			collectionDTO.setUciCode(dto.getUciCode());	// uciCode 값만 설정	
		}
		request.setAttribute("collectionList", collectionList);		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"collection.jsp");
		dispatcher.forward(request, response);
	}
}
