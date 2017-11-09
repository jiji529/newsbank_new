package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.dto.PhotoTagDTO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dao.TagDAO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class CMSView
 */
@WebServlet(
		urlPatterns = {"/view.cms"},
		loadOnStartup = 1
		)
public class CMSView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CMSView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.getWriter().write("Success Data");
		
		//SearchDAO searchDAO = new SearchDAO();
		PhotoDAO photoDAO = new PhotoDAO();
		String uciCode = request.getParameter("uciCode");
		PhotoDTO photoDTO = photoDAO.read(uciCode);
		photoDAO.hit(uciCode);
		request.setAttribute("photoDTO", photoDTO);
		
		TagDAO tagDAO = new TagDAO();
		List<PhotoTagDTO> photoTagList = tagDAO.select_PhotoTag(uciCode);
		request.setAttribute("photoTagList", photoTagList);
		
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String titleKor = request.getParameter("titleKor");
		String descriptionKor = request.getParameter("descriptionKor");
		String tagName = request.getParameter("tagName");
		String columnName = request.getParameter("columnName");
		String columnValue = request.getParameter("columnValue");
		
		if(action.equals("insertTag")){		
			boolean exist = false;
			//System.out.println("photoTagList 갯수 : "+photoTagList.size());
			
			for(PhotoTagDTO photoTagDTO : photoTagList) {
				if(tagName.equals(photoTagDTO.getTag_tagName())) {
					exist = exist | true;
				}else {
					exist = exist | false;					
				}				
			}
			
			if(!exist) {
				this.insertTag(uciCode, tagName);				
			}			
			
		}else if(action.equals("deleteTag")) {
			tagDAO.delete_PhotoTag(uciCode, tagName);
		}else if(action.equals("updateCMS")){
			this.updateCMS(uciCode, titleKor, descriptionKor);
		}else if(action.equals("updateOne")){
			this.updateOne(uciCode, columnName, columnValue);
		}else{
			//System.out.println("ACTION parameter null or empty");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/cms_view.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void insertTag(String uciCode, String tagName) {
		PhotoTagDTO phototagDTO = new PhotoTagDTO();
		phototagDTO.setPhoto_uciCode(uciCode);
		phototagDTO.setTag_tagName(tagName);
				
		TagDAO tagDAO = new TagDAO();
		tagDAO.insert_Tag(uciCode, tagName);		
	}
	
	private void updateCMS(String uciCode, String titleKor, String descriptionKor) {
		PhotoDTO photoDTO = new PhotoDTO();
		photoDTO.setUciCode(uciCode);
		photoDTO.setTitleKor(titleKor);
		photoDTO.setDescriptionKor(descriptionKor);
		
		PhotoDAO photoDAO = new PhotoDAO();
		photoDAO.update(photoDTO);
	}
	
	private void updateOne(String uciCode, String columnName, String value){
		// 블라인드, 초상권 해결
		PhotoDTO photoDTO = new PhotoDTO();
		photoDTO.setUciCode(uciCode);
		PhotoDAO photoDAO = new PhotoDAO();
		
		if(columnName.equals("saleState")) {
			photoDTO.setSaleState(Integer.parseInt(value));
			photoDAO.update_SaleState(photoDTO);
		}else if(columnName.equals("portraitRightState")) {
			photoDTO.setPortraitRightState(value);
			photoDAO.update_PortraitRightState(photoDTO);
		} 		
	}

}

