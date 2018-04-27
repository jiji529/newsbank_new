/**
 * <%---------------------------------------------------------------------------
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @Package Name   : com.dahami.newsbank.web.service
 * @fileName : UploadService.java
 * @author   : CHOI, SEONG HYEON
 * @date     : 2017. 11. 23.
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 23.   	  tealight        UploadService.java
 *--------------------------------------------------------------------------%>
 */
package com.dahami.newsbank.web.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * @author p153-1706
 *
 */
public class UploadService extends ServiceBase {

	public static final long serialVersionUID = 1L;
	public static final String PATH_COMP_DOC_BASE = "/data/newsbank/comp/doc";
	public static final String PATH_COMP_BANK_BASE = "/data/newsbank/comp/bank";
	public static final String PATH_COMP_CONTRACT_BASE = "/data/newsbank/comp/contract";
	public static final String PATH_LOGO_BASE = "/data/newsbank/logo";
	public static final String PATH_NOTICE_BASE = "/data/newsbank/notice";
	public static final String PATH_BASE = "/data/newsbank/tmp";

	/*public static final String PATH_COMP_DOC_BASE = "D:/IdeaProjects/git/newsbank/comp/doc";
	public static final String PATH_COMP_BANK_BASE = "D:/IdeaProjects/git/newsbank/comp/bank";
	public static final String PATH_COMP_CONTRACT_BASE =  "D:/IdeaProjects/git/newsbank/comp/contract";
	public static final String PATH_LOGO_BASE = "D:/IdeaProjects/git/newsbank/logo";
	public static final String PATH_BASE = "D:/IdeaProjects/git/newsbank/tmp";
*/
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.dahami.newsbank.web.service.ServiceBase#execute(javax.servlet.http.
	 * HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */

	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// JSONObject json = new JSONObject();
		boolean result = false;
		String message = ""; //결과 메시지


		String fileFullPath = ""; //파일 실제 경로
		String fileName = ""; //파일 명

		if (request.getAttribute("pathType") != null) {
			String pathType = (String)request.getAttribute("pathType");
			// String savePath = request.getServletContext().getRealPath("folderName");

			String savePath = PATH_BASE;

			if (pathType != null && !pathType.isEmpty()) {
				switch (pathType) {
				case "doc":
					savePath = PATH_COMP_DOC_BASE;
					break;
				case "bank":
					savePath = PATH_COMP_BANK_BASE;
					break;
				case "logo":
					savePath = PATH_LOGO_BASE;
					break;
				case "contract":
					savePath = PATH_COMP_CONTRACT_BASE;
					break;
				case "notice":
					savePath = PATH_NOTICE_BASE;
					break;
					
				}
			}
			
			if (savePath.isEmpty()) {
				message = "파일 경로를 찾을 수 없습니다.";
			} else {

				// 파일이 저장될 서버의 경로. 되도록이면 getRealPath를 이용하자.

				RequestDispatcher rd = null;
				
				File file = null;
				Enumeration files = null;

				// 파일 크기 15MB로 제한
				int sizeLimit = 1024 * 1024 * 15;
				try {

					File targetDir = new File(savePath);

					if (!targetDir.exists()) { // 디렉토리 없으면 생성.
						targetDir.mkdirs();
					}

					// ↓ request 객체, ↓ 저장될 서버 경로, ↓ 파일 최대 크기, ↓ 인코딩 방식, ↓ 같은 이름의 파일명 방지 처리
					// (HttpServletRequest request, String saveDirectory, int maxPostSize, String
					// encoding, FileRenamePolicy policy)
					// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)

					MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
					fileName = multi.getFilesystemName("uploadFile"); // 파일의 이름 얻기
					
					String seq = multi.getParameter("seq"); // seq 얻기
					String page = multi.getParameter("page"); // 접근 page 얻기
					
					if(seq != null && page != null) {
						request.setAttribute("seq", seq);
						request.setAttribute("page", page);
						
						// 첨부파일 업로트 파일 규칙 확인 후 주석해제하기
						// 로고 파일은 파일명으로 SEQ
						/*int index = fileName.lastIndexOf(".");
						if (index != -1) {
							String fileExt  = fileName.substring(index + 1);
							fileName = seq + "." + fileExt;
							System.out.println("fileName : " + fileName);
						}*/
					}
					
					
					files = multi.getFileNames();
					String name = (String) files.nextElement();
					file = multi.getFile(name);
					if (fileName == null) { // 파일이 업로드 되지 않았을때
						System.out.print("파일 업로드 되지 않았음");
						message = "파일 업로드 실패";
					} else { // 파일이 업로드 되었을때
						result = true;
						message = "파일 업로드 성공";
						fileFullPath= savePath + "/" + fileName;
										

					} // else

				} catch (Exception e) {
					System.out.print("예외 발생 : " + e);
					if (e.getMessage().indexOf("exceeds limit") > -1) { // 파일사이즈 초과된 경우
						message = "파일 용량을 초과했습니다.";
						logger.warn("Invalid Request: " + message);
					}

				}
			}
			// json.put("success", result);
			// json.put("message", message);
			// response.getWriter().print(json);
		}

		System.out.println("success  : " + result);
		System.out.println("message  : " + message);
		System.out.println("File Name  : " + fileFullPath);

		request.setAttribute("fileName", fileName);
		request.setAttribute("filePath", fileFullPath);

	}

}
