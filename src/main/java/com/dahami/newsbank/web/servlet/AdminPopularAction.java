package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class AdminPopularAction
 */
@WebServlet("/admin.popular.api")
public class AdminPopularAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminPopularAction() {
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
		
		String[] insArr = null; // 추가할 대상
		String[] delArr = null; // 삭제할 대상
		String exhName = "에디터"; // 전시대상
		String tabName = null; // 탭 이름
		String action = null; // 모드
		int start = 0; // LIMIT 시작
		int count = 0; // LIMIT 갯수
		
		boolean check = true;
		boolean result = false;
		
		JSONObject json = new JSONObject();
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("exhName", exhName);
		
		if(check && request.getParameter("action") != null) {
			action = request.getParameter("action"); // 모드
		}
		
		if(check && request.getParameter("tabName") != null) {
			tabName = request.getParameter("tabName"); // 탭 이름
		}
		
		if (check && request.getParameterValues("insArr") != null && !ArrayUtils.isEmpty(request.getParameterValues("insArr"))) {
			insArr = request.getParameterValues("insArr"); // 추가할 대상
		}
		
		if (check && request.getParameterValues("delArr") != null && !ArrayUtils.isEmpty(request.getParameterValues("delArr"))) {
			delArr = request.getParameterValues("delArr"); // 삭제할 대상
		}
		
		if(request.getParameter("start") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			params.put("start", start);
		}
		
		if(request.getParameter("count") != null) {
			count = Integer.parseInt(request.getParameter("count"));
			params.put("count", count);
		}
		
		PhotoDAO photoDAO = new PhotoDAO();
		
		if(check) {
			
			if(action.equals("U")) { // 수정 
				
				switch(tabName) {
				case "selected": // 엄선한 사진
					Map<String, Object> exhibition = photoDAO.getExhibition(params);
					String exhibitionList_seq = exhibition.get("seq").toString();
					params.clear();
					
					// 엄선한 사진 추가
					if(insArr != null){
						for(String uciCode : insArr) {
							params.put("exhibitionList_seq", exhibitionList_seq);
							params.put("uciCode", uciCode);
							photoDAO.insertPhotoExh(params);
							params.clear();
						}
					}
					
					// 엄선한 사진 삭제
					if(delArr != null){
						for(String uciCode : delArr) {
							params.put("exhibitionList_seq", exhibitionList_seq);
							params.put("uciCode", uciCode);
							photoDAO.deletePhotoExh(params);
							params.clear();
						}
					}
				break;
				
				case "download": // 다운로드
					// 삭제한 사진 photoBlock에 추가
					if(delArr != null){
						for(String uciCode : delArr) {							
							params.put("uciCode", uciCode);
							params.put("reason", "다운로드"); // 추가하는 이유 기재
							System.out.println(params.toString());
							photoDAO.insertPhotoBlock(params);
							params.clear();
						}
					}
					
					
				break;
					
				case "zzim": // 찜
					// 찜사진 photoBlock에 추가
					if(delArr != null){
						for(String uciCode : delArr) {							
							params.put("uciCode", uciCode);
							params.put("reason", "찜"); // 추가하는 이유 기재
							System.out.println(params.toString());
							photoDAO.insertPhotoBlock(params);
							params.clear();
						}
					}
					
				break;
				
				case "detail": // 상세보기
					// 상세보기 사진 photoBlock에 추가
					if(delArr != null){
						for(String uciCode : delArr) {							
							params.put("uciCode", uciCode);
							params.put("reason", "상세보기"); // 추가하는 이유 기재
							System.out.println(params.toString());
							photoDAO.insertPhotoBlock(params);
							params.clear();
						}
					}
					
				break;
					
				}
				
			}else if(action.equals("D")) { // 개별삭제에 따른 자동완성
				params.put("tabName", tabName);
				
				if(Integer.parseInt(params.get("count").toString()) == 1) { // 1개씩 불러와야함
					List<PhotoDTO> photoList = new ArrayList<>();
					String photoCount = ""; // Tab별 횟수(다운로드 횟수, 찜 횟수, 조회 수)
					switch(tabName) {
						case "download": // 다운로드
							photoList = photoDAO.downloadPhotoList(params);
							photoCount = String.valueOf(photoList.get(0).getDownCount()); // 다운로드 횟수
							break;
						
						case "zzim": // 찜
							photoList = photoDAO.basketPhotoList(params);
							photoCount = String.valueOf(photoList.get(0).getZzimCount()); // 찜 횟수
							break;
							
						case "detail": // 상세보기
							photoList = photoDAO.hitsPhotoList(params);
							photoCount = String.valueOf(photoList.get(0).getHitCount()); // 조회 횟수
							break;
							
					}
					
					String uciCode = photoList.get(0).getUciCode();
					String ownerName = photoList.get(0).getOwnerName();
					
					Map<String, Object> data = new HashMap<String, Object>();
					data.put("uciCode", uciCode);
					data.put("ownerName", ownerName);
					data.put("photoCount", photoCount);
					
					json.put("list", data);
					
				}
				
			}
			
		
			response.setContentType("application/json");
			response.getWriter().print(json);
			
		}
	}

}