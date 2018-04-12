package com.dahami.newsbank.web.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import com.dahami.common.util.FileUtil;
import com.dahami.common.util.HttpUtil;
import com.dahami.common.util.ImageUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.dto.PhotoTagDTO;
import com.dahami.newsbank.util.NBImageUtil;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.TagDAO;
import com.dahami.newsbank.web.dto.ActionLogDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.StatsDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CMSService extends ServiceBase {
	
	private static final String PATH_TEMP_PIC_UPLOAD = "/data/newsbank/serviceTemp/picUpload";
	
	static {
		FileUtil.makeDirectory(PATH_TEMP_PIC_UPLOAD);
	}
	
	private boolean isViewMode;
	private boolean isAdmin;
	private boolean isUpload;
	
	public CMSService(boolean isViewMode) {
		this(isViewMode, false, false);
	}
	
	public CMSService(boolean isViewMode, boolean isAdmin, boolean isUpload) {
		this.isViewMode = isViewMode;
		this.isAdmin = isAdmin;
		this.isUpload = isUpload;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean errorF = false;
		HttpSession session = request.getSession();
		MemberDAO mDao = new MemberDAO();
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		memberInfo = mDao.getMember(memberInfo);
		
		String uciCode = null;
		String action = null;
		PhotoDTO photoDTO = null;
		String forward = null;
		MultipartRequest multi = null;
		
		if(isUpload) {
			multi = new MultipartRequest(request, PATH_TEMP_PIC_UPLOAD, 100*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			uciCode = multi.getParameter("uciCode");
			action = multi.getParameter("action");
		}
		else if(isViewMode) {
			uciCode = request.getParameter("uciCode");
			action = request.getParameter("action") == null ? "" : request.getParameter("action");
		}
		
		if(isViewMode || isUpload) {
			photoDTO = new PhotoDAO().read(uciCode);
			
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
			}
			
			if(!errorF) {
				if(isViewMode) {
					PhotoDAO photoDAO = new PhotoDAO();
					TagDAO tagDAO = new TagDAO();
					if(action.length() == 0) {
						StatsDTO statsDTO = photoDAO.getStats(uciCode);
						List<PhotoTagDTO> photoTagList = tagDAO.select_PhotoTag(uciCode);
						
						// CMS 는 히트 안함
	//					photoDAO.hit(uciCode);
						request.setAttribute("photoDTO", photoDTO);
						request.setAttribute("statsDTO", statsDTO);
						request.setAttribute("photoTagList", photoTagList);
						
						if(isAdmin) {
							forward = "/WEB-INF/jsp/admin_cms_view.jsp";
						}
						else {
							forward = "/WEB-INF/jsp/cms_view.jsp";
						}
					}
					else {
						String titleKor = request.getParameter("titleKor");
						String descriptionKor = request.getParameter("descriptionKor");
						String tagName = request.getParameter("tagName");
						String columnName = request.getParameter("columnName");
						String columnValue = request.getParameter("columnValue");
						
						ActionLogDTO log = new ActionLogDTO();
						log.setMemberSeq(memberInfo.getSeq());
						log.setUciCode(photoDTO.getUciCode());
						log.setIp(HttpUtil.getRequestIpAddr(request));
						
						tagDAO = new TagDAO();
						if(action.equals("insertTag")){
							boolean exist = false;
							List<PhotoTagDTO> photoTagList = tagDAO.select_PhotoTag(uciCode);
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
							errorF = true;
						}
						
						photoDAO.insertActionLog(log);
					}
				}
				else if(isUpload) {
					if(action.equals("updatePic")) {
						photoDTO.getListPath();
						File upFile = multi.getFile("uploadFile");
						
						BufferedImage bImg = ImageUtil.getBufferedImage(upFile).get(0);
						short colorBit = (short)bImg.getColorModel().getPixelSize();
						if(colorBit != 24) {
							logger.info("NOT 24bit: " + upFile.getAbsolutePath());
						}
						
						// 뷰용 이미지 생성
						BufferedImage viewBImg = NBImageUtil.resizeToViewSize(bImg);
						// 리스트용 이미지 생성
						BufferedImage listBImg = NBImageUtil.resizeToListSize(viewBImg);
						
//						multi.getOriginalFileName("uploadFile")
						System.out.println();
					}
					else {
						errorF = true;
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
			
			if(isAdmin) {
				forward = "/WEB-INF/jsp/admin_cms.jsp";
			}
			else {
				forward = "/WEB-INF/jsp/cms.jsp";
			}
		}
		
		if(errorF) {
			// TODO 잘못된 접근에 대한 처리
			return;
		}
		
		if(!StringUtils.isBlank(forward)) {
			request.setAttribute("sParam", makeSearchParamMap(request.getParameterMap()));
			forward(request, response, forward);
		}
		else {
			response.getWriter().write("OK");
			response.getWriter().flush();
		}
		
	}
}
