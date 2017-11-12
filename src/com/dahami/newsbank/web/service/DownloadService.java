/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : DownloadService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 30. 오후 2:39:38
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 30.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 30.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.common.util.FileUtil;
import com.dahami.common.util.ImageUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class DownloadService extends ServiceBase {

	private static final String PATH_PHOTO_BASE = "/data/newsbank/serviceImages";
	private static final String PATH_LOGO_BASE = "/data/newsbank/logo";
	/** 임시생성 로고 저장폴더 */
	private static final String PATH_LOGO_TEMP = "/data/newsbank/logo/temp";
	private static final String PATH_PHOTO_TEMP = "/data/newsbank/serviceTemp";
	
	private static final String URL_PHOTO_ERROR_LIST = "/images/error/list_image_processError.jpg";
	private static final String URL_PHOTO_ERROR_VIEW = "/images/error/view_image_processError.jpg";
	private static final String URL_PHOTO_STOP_LIST = "/images/error/list_image_stopSale.jpg";
	private static final String URL_PHOTO_STOP_VIEW = "/images/error/view_image_stopSale.jpg";
	
	private static final int LOGO_MAX_WIDTH = 122;
	private static final int LOGO_MAX_HEIGHT = 122;
	
	private String targetSize;
	private String uciCode;
	
	private PhotoDAO photoDao;
	
	public DownloadService(String targetSize, String uciCode) {
		this.targetSize = targetSize;
		this.uciCode = uciCode;
	}
	
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String downPath = null;
		
		if(uciCode == null || uciCode.trim().length() == 0) {
			if(targetSize.equals("logo")) {
				String seq = request.getParameter("seq");
				File fd = new File(PATH_LOGO_BASE + "/" + seq + ".jpg");
				if(!fd.exists()) {
					fd = new File(PATH_LOGO_BASE + "/" + seq + ".png");
				}
				
				if(fd.exists()) {
					downPath = fd.getAbsolutePath();
				}
				else {
					String tmpLogoPath = PATH_LOGO_TEMP + "/" + seq + ".jpg";
					String tmpLogoInfoPath = PATH_LOGO_TEMP + "/" + seq + ".logoInfo";
					MemberDAO mDao = new MemberDAO();
					MemberDTO mDto = mDao.getMember(Integer.parseInt(seq));
					boolean makeF = false;
					File infoFd = new File(tmpLogoInfoPath);
					if(infoFd.exists()) {
						File logoFd = new File(tmpLogoPath);
						if(logoFd.exists()) {
							if(!mDto.getCompName().equals(FileUtil.readFileToString(infoFd, "UTF-8"))) {
								makeF = true;	
							}
						}
						else {
							makeF = true;
						}
					}
					else {
						makeF = true;
					}
					if(makeF) {
						if(makeLogoFile(mDto.getCompName(), tmpLogoPath)) {
							FileUtil.makeFile(mDto.getCompName().getBytes("UTF-8"), tmpLogoInfoPath);
							downPath = tmpLogoPath;
						}
						else {
							logger.warn("로고생성 실패");
							downPath = PATH_LOGO_BASE + "/error.jpg";
						}
					}
				}
			}
		}
		else {
			photoDao = new PhotoDAO();
			PhotoDTO photo = photoDao.read(this.uciCode);
			// 사진 정보가 없는 경우
			if(photo == null) {
				// 파일 부재(이미지 부재 / 오류) 이미지 전송
				if(targetSize.equals("list")) {
					response.sendRedirect(URL_PHOTO_ERROR_LIST);
				}
				else {
					response.sendRedirect(URL_PHOTO_ERROR_VIEW);
				}
				return;
			}
			
			String orgPath = null;
			// 썸네일 / 뷰 이미지의 경우 서비스중인 이미지에 대해 모두 다운로드 가능함
			if(targetSize.equals("list") || targetSize.equals("view")) {
				if(photo.getSaleState() == PhotoDTO.SALE_STATE_OK) {
					orgPath = photo.getOriginPath();
					if(targetSize.equals("list")) {
						downPath = photo.getListPath();
					}
					else {
						downPath = photo.getViewPath();
					}
				}
				else {
					// 판매중이지 않은 경우에 대한 이미지 전송
					if(targetSize.equals("list")) {
						response.sendRedirect(URL_PHOTO_STOP_LIST);
					}
					else {
						response.sendRedirect(URL_PHOTO_STOP_VIEW);
					}
					return;
				}
			}
			// 구매한 이미지 다운로드
			else if(targetSize.startsWith("service.")) {
				// 보낼 이미지 동적으로 생성해서 downPath에 지정
				System.out.println();
			}
			// 기타 다운로드?? 
			else {
				// 현재 대상이 되는 케이스 없음  / 향후 확장성을 위해
			}
			if(downPath != null) {
				downPath = PATH_PHOTO_BASE + downPath;
			}
		}
		
		if(downPath != null) {
			// 대상 파일이 없는경우 (썸네일/뷰 다운로드 요청에 대해서만) / 원본이 있으면 동적 생성 후 전송
			if(!new File(downPath).exists() && (targetSize.equals("list") || targetSize.equals("view"))) {
				// 파일 부재(이미지 부재 / 오류) 이미지 전송
				if(targetSize.equals("list")) {
					response.sendRedirect(URL_PHOTO_ERROR_LIST);
				}
				else {
					response.sendRedirect(URL_PHOTO_ERROR_VIEW);
				}
				return;
				
//				// 원본도 없는경우
//				if(!new File(orgPath).exists()) {
//					// 파일 부재(이미지 부재 / 오류) 이미지 전송
//					if(targetSize.equals("list")) {
//						response.sendRedirect(URL_PHOTO_ERROR_LIST);
//					}
//					else {
//						response.sendRedirect(URL_PHOTO_ERROR_VIEW);
//					}
//					return;
//				}
//				// 원본이 있는경우
//				else {
//					// 리사이즈 이미지 생성
//					System.out.println();
//				}
			}
			
			if(new File(downPath).exists()) {
				try {
					if(targetSize.equals("logo")) {
						sendImageFile(response, downPath);
					}
					else {
						if(targetSize.equals("service")) {
							sendImageFile(response, downPath, this.uciCode + ".jpg");
						}
						else {
							sendImageFile(response, downPath);
						}
					}
				}catch(Exception e) {
					logger.warn("", e);
				}
			}
			else {
				// 보낼 이미지 없음
				System.out.print("");
			}
		}
		else {
			System.out.println();
		}
	}
	
	private void sendImageFile(HttpServletResponse response, String sendPath) throws IOException {
		sendImageFile(response, sendPath, null);
	}
	
	private void sendImageFile(HttpServletResponse response, String sendPath, String headerFileName) throws IOException {
		// 디스크 읽기
		long rStart = System.currentTimeMillis();
		byte[] data = FileUtil.readFile(sendPath);
		long rEnd = System.currentTimeMillis();
		response.addHeader("TIME_Read", String.valueOf(rEnd-rStart));
		
		response.addHeader("Pragma", "public");
		response.addHeader("Expires", "0");
		response.addHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
		response.addHeader("Cache-Control", "private");
		response.addHeader("Content-Type", "image/jpeg");
		if(headerFileName != null) {
			response.addHeader("Content-Disposition", "attachment; filename=\""+headerFileName+"\";");
		}
		response.addHeader("Content-Transfer-Encoding", "binary");
		
		ServletOutputStream sos = response.getOutputStream();
		try {
			sos.write(data);
			response.getOutputStream().flush();
		}catch(IOException e) {
			String errMsg = e.getLocalizedMessage();
			if(errMsg.indexOf("현재 연결은 사용자의 호스트 시스템의 소프트웨어의 의해 중단되었습니다") == -1) {
				logger.warn("", e);
			}
		}
	}
	
	private boolean makeLogoFile(String mdName, String tgtPath) {
		Font font = new Font("나눔고딕", Font.BOLD, 47);
		FontRenderContext frc = new FontRenderContext(null,  true, true);
		Rectangle2D r2D = font.getStringBounds(mdName, frc);
		int orgLogoImgW = (int) Math.round(r2D.getWidth());
	    int orgLogoImgH = (int) Math.round(r2D.getHeight())+10;
	    
	    BufferedImage logoImg = new BufferedImage(orgLogoImgW, orgLogoImgH, BufferedImage.TYPE_3BYTE_BGR);
	    for(int i = 0; i < logoImg.getWidth(); i++) {
			for(int j = 0; j < logoImg.getHeight(); j++) {
				logoImg.setRGB(i, j, Color.white.getRGB());
			}
		}
	    Graphics g = logoImg.getGraphics();
	    g.setColor(Color.black);
	    g.setFont(font);
	    g.drawString(mdName, 0, orgLogoImgH-10);

	    int imgFullW = orgLogoImgW;
	    int imgFullH = orgLogoImgH;
	    if(imgFullW > imgFullH) {
	    	imgFullH = imgFullW;
	    }
	    else {
	    	imgFullW = imgFullH;
	    }
	    BufferedImage fullImg = new BufferedImage(imgFullW, imgFullH, BufferedImage.TYPE_3BYTE_BGR);
	    for(int i = 0; i < fullImg.getWidth(); i++) {
			for(int j = 0; j < fullImg.getHeight(); j++) {
				fullImg.setRGB(i, j, Color.white.getRGB());
			}
		}
	    g = fullImg.getGraphics();
	    g.drawImage(logoImg, 0, (imgFullH/2)-(orgLogoImgH/2), null);
	    
	    float widthRatio = (float)LOGO_MAX_WIDTH / orgLogoImgW;
	    float heightRatio = (float)LOGO_MAX_HEIGHT / orgLogoImgH;
	    
	    float ratio = widthRatio;
	    if(ratio > heightRatio) {
	    	ratio = heightRatio;
	    }

	    fullImg = ImageUtil.resize(fullImg, LOGO_MAX_WIDTH, LOGO_MAX_HEIGHT, true);
	    
	    return ImageUtil.saveImage(fullImg, tgtPath, ImageUtil.IMAGE_FORMAT_JPEG);
	}
}
