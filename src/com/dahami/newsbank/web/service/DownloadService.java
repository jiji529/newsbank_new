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

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.dahami.common.util.FileUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.PhotoDAO;

public class DownloadService extends ServiceBase {

	private static final String PATH_PHOTO_BASE = "/data/newsbank/serviceImages";
	private static final String PATH_PHOTO_TEMP = "/data/newsbank/serviceTemp";
	
	private String targetSize;
	private String uciCode;
	
	private PhotoDAO photoDao;
	
	public DownloadService(String targetSize, String uciCode) {
		this.targetSize = targetSize;
		this.uciCode = uciCode;
	}
	
	public void execute(HttpServletResponse response) {
		photoDao = new PhotoDAO();
		PhotoDTO photo = photoDao.read(this.uciCode);
		
		String orgPath = null;
		String downPath = null;
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
				// TODO 판매중이지 않은 경우에 대한 대응
				System.out.println();
			}
		}
		// 구매한 이미지 다운로드
		else if(targetSize.startsWith("service.")) {
			// 보낼 이미지 동적으로 생성해서 downPath에 지정
		}
		// 기타 다운로드?? / 현재 대상 없음
		else {
			
		}
		
		if(downPath != null) {
			downPath = PATH_PHOTO_BASE + downPath;
			// 대상 파일이 없는경우 (썸네일/뷰 다운로드 요청에 대해서만) / 원본이 있으면 동적 생성 후 전송
			if(!new File(downPath).exists() && (targetSize.equals("list") || targetSize.equals("view"))) {
				// 원본도 없는경우
				if(!new File(orgPath).exists()) {
					// TODO 파일 부재(이미지 부재 / 오류) 이미지 전송 후 종료
					
					return;
				}
				// 원본이 있는경우
				else {
					// TODO 리사이즈 이미지 생성
					System.out.println();
				}
			}
			
			if(new File(downPath).exists()) {
				try {
					sendImageFile(response, downPath, this.uciCode + "_" + targetSize + ".jpg");
				}catch(Exception e) {
					logger.warn("", e);
				}
			}
			else {
				// 보낼 이미지 없음
				System.out.println();
			}
		}
		else {
			System.out.println();
		}
	}
	
	private static void sendImageFile(HttpServletResponse response, String sendPath, String headerFileName) throws IOException {
		// 디스크 읽기
		long rStart = System.currentTimeMillis();
		byte[] data = FileUtil.readFile(sendPath);
		long rEnd = System.currentTimeMillis();
		response.addHeader("TIME_Read", String.valueOf(rEnd-rStart));
		
		response.addHeader("Pragma", "public");
		response.addHeader("Expires", "0");
		response.addHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
		response.addHeader("Cache-Control", "private");
		response.addHeader("Content-Type", "image/jpg");
		response.addHeader("Content-Disposition", "attachment; filename=\""+headerFileName+"\";");
		response.addHeader("Content-Transfer-Encoding", "binary");
		
		ServletOutputStream sos = response.getOutputStream();
		sos.write(data);
		response.getOutputStream().flush();
	}
}
