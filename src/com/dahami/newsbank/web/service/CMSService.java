package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.common.util.HttpUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.dto.PhotoTagDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.TagDAO;
import com.dahami.newsbank.web.dto.ActionLogDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.StatsDTO;

public class CMSService extends ServiceBase {
	private boolean isViewMode;
	private boolean isAdmin;
	
	public CMSService(boolean isViewMode) {
		this(isViewMode, false);
	}
	
	public CMSService(boolean isViewMode, boolean isAdmin) {
		this.isViewMode = isViewMode;
		this.isAdmin = isAdmin;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean errorF = false;
		HttpSession session = request.getSession();
		MemberDAO mDao = new MemberDAO();
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		memberInfo = mDao.getMember(memberInfo);
		
		if(isViewMode) {
			PhotoDAO photoDAO = new PhotoDAO();
			String uciCode = request.getParameter("uciCode");
			PhotoDTO photoDTO = photoDAO.read(uciCode);
			
			if(photoDTO == null) {
				errorF = true;
			}
			else {
				boolean ownerF = false;
				for(int ownerNo : memberInfo.getOwnerGroupList()) {
					if(ownerNo == photoDTO.getOwnerNo()) {
						ownerF = true;
						break;
					}
				}
				
				// 관리자가 아닌경우 소유자이어야 함
				if(!isAdmin && !ownerF) {
					errorF = true;
				}
				else {
					StatsDTO statsDTO = photoDAO.getStats(uciCode);
					List<PhotoTagDTO> photoTagList = new TagDAO().select_PhotoTag(uciCode);
					
					// CMS 는 히트 안함
//					photoDAO.hit(uciCode);
					request.setAttribute("photoDTO", photoDTO);
					request.setAttribute("statsDTO", statsDTO);
					request.setAttribute("photoTagList", photoTagList);
					
					String action = request.getParameter("action") == null ? "" : request.getParameter("action");
					String titleKor = request.getParameter("titleKor");
					String descriptionKor = request.getParameter("descriptionKor");
					String tagName = request.getParameter("tagName");
					String columnName = request.getParameter("columnName");
					String columnValue = request.getParameter("columnValue");
					
					TagDAO tagDAO = null;
					
					if(action.length() > 0) {
						ActionLogDTO log = new ActionLogDTO();
						log.setMemberSeq(memberInfo.getSeq());
						log.setUciCode(photoDTO.getUciCode());
						log.setIp(HttpUtil.getRequestIpAddr(request));
						
						tagDAO = new TagDAO();
						if(action.equals("insertTag")){
							boolean exist = false;
							for(PhotoTagDTO photoTagDTO : photoTagList) {
								if(tagName.equals(photoTagDTO.getTag_tagName())) {
									exist = exist | true;
								}else {
									exist = exist | false;					
								}				
							}
							
							if(!exist) {
								PhotoTagDTO phototagDTO = new PhotoTagDTO();
								phototagDTO.setPhoto_uciCode(uciCode);
								phototagDTO.setTag_tagName(tagName);
										
								if(tagName.length() > 0) {
									tagDAO.insert_Tag(uciCode, tagName);
									log.setActionType(ActionLogDTO.ACTION_TYPE_ADD_TAG);
									log.setDescription(tagName);
								}
							}			
							
						}else if(action.equals("deleteTag")) {
							tagDAO.delete_PhotoTag(uciCode, tagName);
							log.setActionType(ActionLogDTO.ACTION_TYPE_DEL_TAG);
							log.setDescription(tagName);
						}else if(action.equals("updateCMS")){
							photoDTO.setUciCode(uciCode);
							int actionType = 0;
							String logDescription = "";
							if(!photoDTO.getTitleKor().equals(titleKor)) {
								actionType |= ActionLogDTO.ACTION_TYPE_MOD_TITLE;
								logDescription += photoDTO.getTitleKor();
							}
							photoDTO.setTitleKor(titleKor);
							
							if(!photoDTO.getDescriptionKor().equals(descriptionKor)) {
								actionType |= ActionLogDTO.ACTION_TYPE_MOD_CONTENT;
								if(logDescription.length() > 0) {
									logDescription += "\n\n##\n\n";
								}
								logDescription += photoDTO.getDescriptionKor();
							}
							photoDTO.setDescriptionKor(descriptionKor);
							
							// 실제 변경이 된 경우만 디비 업데이트
							if(actionType > 0) {
								photoDAO.update(photoDTO);
								log.setActionType(actionType);
								log.setDescription(logDescription);
							}
						}else if(action.equals("updateOne")){
							// 블라인드, 초상권 해결
							if(columnName.equals("saleState")) {
								int actionType = 0;
								int curSaleState = photoDTO.getSaleState();
								int newSaleState = Integer.parseInt(columnValue);
								if(newSaleState == PhotoDTO.SALE_STATE_DEL) {
									actionType = ActionLogDTO.ACTION_TYPE_SET_DELETE;
								}
								else if(newSaleState == PhotoDTO.SALE_STATE_STOP) {
									actionType = ActionLogDTO.ACTION_TYPE_SET_BLIND;
								}
								else {	// OK
									if(curSaleState == PhotoDTO.SALE_STATE_STOP) {
										actionType = ActionLogDTO.ACTION_TYPE_UNSET_BLIND;	
									}
									else if(curSaleState == PhotoDTO.SALE_STATE_DEL) {
										actionType = ActionLogDTO.ACTION_TYPE_UNSET_DELETE;
									}
								}
								if(actionType == 0) {
									System.out.println();
								}
								photoDTO.setSaleState(Integer.parseInt(columnValue));
								photoDAO.update_SaleState(photoDTO);
								log.setActionType(actionType);
							}else if(columnName.equals("portraitRightState")) {
								photoDTO.setPortraitRightState(columnValue);
								photoDAO.update_PortraitRightState(photoDTO);
								if(columnValue.equals(PhotoDTO.PORTRAITRIGHTSTATE_ACQUIRE)) {
									log.setActionType(ActionLogDTO.ACTION_TYPE_SET_PRIGHT);
								}
								else {
									log.setActionType(ActionLogDTO.ACTION_TYPE_UNSET_PRIGHT);
								}
							}
						}else{
							//System.out.println("ACTION parameter null or empty");
						}
						
						photoDAO.insertActionLog(log);
					}
				}
			}
		}
		else {
			List<MemberDTO> mediaList = null;
			if(isAdmin) {
				mediaList = mDao.listActiveMedia();	
			}
			else {
				mediaList = mDao.listAdjustMedia(memberInfo);
			}
			request.setAttribute("mediaList", mediaList);	
		}
		
		String forward = null;
		if(errorF) {
			// TODO 잘못된 접근에 대한 처리
		}
		else if(isViewMode) {
			if(isAdmin) {
				forward = "/WEB-INF/jsp/admin_cms_view.jsp";
			}
			else {
				forward = "/WEB-INF/jsp/cms_view.jsp";
			}
		}
		else {
			if(isAdmin) {
				forward = "/WEB-INF/jsp/admin_cms.jsp";
			}
			else {
				forward = "/WEB-INF/jsp/cms.jsp";
			}
		}
		
		request.setAttribute("sParam", makeSearchParamMap(request.getParameterMap()));
		forward(request, response, forward);
	}
}
