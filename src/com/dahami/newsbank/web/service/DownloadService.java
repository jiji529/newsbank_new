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
import java.awt.GraphicsEnvironment;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.imaging.ImageReadException;
import org.apache.commons.imaging.ImageWriteException;
import org.apache.commons.imaging.Imaging;
import org.apache.commons.imaging.common.ImageMetadata;
import org.apache.commons.imaging.formats.jpeg.JpegImageMetadata;
import org.apache.commons.imaging.formats.jpeg.exif.ExifRewriter;
import org.apache.commons.imaging.formats.tiff.TiffImageMetadata;
import org.apache.commons.imaging.formats.tiff.constants.ExifTagConstants;
import org.apache.commons.imaging.formats.tiff.constants.TiffTagConstants;
import org.apache.commons.imaging.formats.tiff.fieldtypes.FieldType;
import org.apache.commons.imaging.formats.tiff.write.TiffOutputDirectory;
import org.apache.commons.imaging.formats.tiff.write.TiffOutputField;
import org.apache.commons.imaging.formats.tiff.write.TiffOutputSet;

import com.dahami.common.util.FileUtil;
import com.dahami.common.util.HttpUpDownUtil;
import com.dahami.common.util.HttpUtil;
import com.dahami.common.util.ImageUtil;
import com.dahami.common.util.ZipUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.util.NBImageUtil;
import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.dto.DownloadDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

import kr.or.uci.dist.api.APIHandler;

public class DownloadService extends ServiceBase {
	private static final SimpleDateFormat ymDf = new SimpleDateFormat("yyyyMM");

	/** 다운로드 타입 : 썸네일 */
	public static final String DOWN_TYPE_LIST= "list";
	/** 다운로드 타입 : 상세페이지 */
	public static final String DOWN_TYPE_VIEW= "view";
	/** 다운로드 타입 : 원본 */
	public static final String DOWN_TYPE_SERVICE= "service";
	/** 다운로드 타입 : 시안 */
	public static final String DOWN_TYPE_OUTLINE= "outline";
	/** 다운로드 타입 : zip(원본 리스트) */
	public static final String DOWN_TYPE_ZIP = "zip";
	/** 다운로드 타입 : 제휴(게티 등)업체 */
	public static final String DOWN_TYPE_CORP= "corp";
	
	public static final String PATH_PHOTO_BASE = "/data/newsbank/serviceImages";
	private static final String PATH_LOGO_BASE = "/data/newsbank/logo";

	/** 임시생성 로고 저장폴더 */
	private static final String PATH_LOGO_TEMP = "/data/newsbank/logo/temp";
	private static final String PATH_PHOTO_DOWN = "/data/newsbank/serviceDown";

	private static final String URL_PHOTO_ERROR_LIST = "/images/error/list_image_processError.jpg";
	private static final String URL_PHOTO_ERROR_VIEW = "/images/error/view_image_processError.jpg";
	private static final String URL_PHOTO_ERROR_SERVICE = "/WEB-INF/jsp/error/downloadError.jsp";
	private static final String URL_PHOTO_STOP_LIST = "/images/error/list_image_stopSale.jpg";
	private static final String URL_PHOTO_STOP_VIEW = "/images/error/view_image_stopSale.jpg";

	private static final int LOGO_MAX_WIDTH = 177;
	private static final int LOGO_MAX_HEIGHT = 40;

	private static final Map<String, Set<String>> ACCESS_IP_MAP;
	private static final Map<String, String> CORP_NAME_MAP;
	private static final Map<String, String> CORP_INFO_QUERY_MAP;

	private static final String SERVICE_CODE_GETTY = "gt";
	
	static {
		ACCESS_IP_MAP = new HashMap<String, Set<String>>();
		final Set<String> ipSet = new HashSet<String>();
		ACCESS_IP_MAP.put(SERVICE_CODE_GETTY, ipSet);
		
		// 2016. 05. 18	이매진 IP 추가 -- "121.78.118.233", "121.78.196.177", "121.78.196.178"
		//	2017. 03. 17	이매진 IP 추가 -- "1.214.46.66", "121.78.196.175"
		ipSet.add("1.214.46.66");
		ipSet.add("121.78.196.163");
		ipSet.add("121.78.196.165");
		ipSet.add("121.78.196.175");
		ipSet.add("121.78.196.177");
		ipSet.add("121.78.196.178");
		ipSet.add("121.78.118.233");
//		ipSet.add("121.78.115.56");	// 2018-06-18 제거 / 게티 확인
		
		// 2018.01.24 대전사무실 IP 추가
		ipSet.add("59.27.23.3");
	
	    //  2016. 05. 03    연구소 고정 IP 추가
		ipSet.add("211.217.82.104");
		ipSet.add("106.240.225.154");
		
		// 정체불명
		ipSet.add("59.6.244.140");
		
		// 로컬 테스트
		ipSet.add("127.0.0.1");
		ipSet.add("0:0:0:0:0:0:0:1");
		
		CORP_NAME_MAP = new HashMap<String, String>();
		CORP_NAME_MAP.put("nb", "뉴스뱅크");
		CORP_NAME_MAP.put(SERVICE_CODE_GETTY, "게티이미지코리아");

		CORP_INFO_QUERY_MAP = new HashMap<String, String>();
		CORP_INFO_QUERY_MAP.put(SERVICE_CODE_GETTY, "Member.selGetty");
	}

//	private String targetSize;
//	private String uciCode;

//	public DownloadService(String targetSize, String uciCode) {
//		this.targetSize = targetSize;
//		this.uciCode = uciCode;
//	}
	
	/**
	 * @methodName  : getSuitableDownType
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 3. 29. 오후 3:50:56
	 * @methodCommet: 해당 컨텐츠를 다운로드 받을 권한이 있는지 확인해서(소유/구매 모두 확인) 다운받을 타입 리턴<br />
	 * (참고: 시안요청 이더라도 구매건인 경우 원본으로 리턴)
	 * (참고: 원본요청 이더라도 미권한 로그인 상태이면 시안으로 리턴)
	 * 소유자인 경우 PhotoDTO.isOwnerGroup 세팅함<br />
	 * 연계 업체의 경우 DOWN_TYPE_CORP_downType 리턴
	 * @param photo
	 * @param member
	 * @param downType
	 * @param requestCorp	// 요청 주체(게티 등)
	 * @return 
	 * @returnType  : String downType / 권한 축소해서 다운받아야 하면 축소한 권한값	
	 */
	private String getSuitableDownType(PhotoDTO photo, MemberDTO member, String downType, String requestCorp, String ip) {

		// 1. 연계사 / 허용 IP는 우선 허가
		if(requestCorp != null) {
			Set<String> ipSet = ACCESS_IP_MAP.get(requestCorp);
			if(ipSet != null && ipSet.contains(ip)) {
				return DOWN_TYPE_CORP + "_" + downType;
			}
		}
		
		// 2. 비로그인 처리 / 정상이미지에 대한 리스트/뷰만 허용
		if(member == null) {
			if(photo.getSaleState() == PhotoDTO.SALE_STATE_OK) {
				if(downType.equals(DOWN_TYPE_LIST) || downType.equals(DOWN_TYPE_VIEW)) {
					return downType;
				}
			}
			return null;
		}
		else if(member.getType().equals(MemberDTO.TYPE_ADMIN)) {
			if(downType.equals(DOWN_TYPE_OUTLINE)) {
				downType = DOWN_TYPE_SERVICE;
			}
			return downType;
		}
		
		// 3. 정상 이미지
		if(photo.getSaleState() == PhotoDTO.SALE_STATE_OK) {
			// 3-1. 리스트 / 뷰 요청은 그대로 허용
			if(downType.equals(DOWN_TYPE_LIST) || downType.equals(DOWN_TYPE_VIEW)) {
				return downType;
			}
			// 3-2. 시안 / 원본
			else if(downType.equals(DOWN_TYPE_OUTLINE) || downType.equals(DOWN_TYPE_SERVICE)) {
				// 시안 혹은 원본(후불유저/소유자/구매그룹) 다운로드
				boolean serviceF = false;
				// 3-2-1. 후불회원 원본 다운로드
				if (member.getDeferred() > MemberDTO.DEFERRED_NORMAL) {
					serviceF = true;
				}
				// 3-2-2. 소유자 원본 다운로드
				else {
					int photoOwner = photo.getOwnerNo();
					List<Integer> ownerSeqList = member.getOwnerGroupList();
					for(int curSeq : ownerSeqList) {
						if(photoOwner == curSeq) {
							serviceF = true;
							break;
						}
					}
				}
				// 3-2-3. 구매자 원본 다운로드
				if(!serviceF) {
					serviceF = checkPayDownloadable(photo.getUciCode(), member.getDownloadGroupList());
				}
				
				if(serviceF) {
					// 원본 다운로드
					return DOWN_TYPE_SERVICE;
				}
				// 3-2-4. 아니면 시안요청은 시안 다운로드 / 원본요청은 비정상 접근 처리
				else {
					if(downType.equals(DOWN_TYPE_OUTLINE)) {
						return downType;
					}
					else {
						return null;
					}
				}
			}
			else {
				logger.warn(" 요청 다운로드 타입(" + downType + ") 확인 필요: " + " / " + photo.getUciCode());
				return null;
			}
		}
		// 4. 블라인드 이미지
		else if(photo.getSaleState() == PhotoDTO.SALE_STATE_STOP) {
			// 4-1 소유 권한이 있는 경우에는 모두 허용
			int photoOwner = photo.getOwnerNo();
			List<Integer> ownerSeqList = member.getOwnerGroupList();
			for(int curSeq : ownerSeqList) {
				if(photoOwner == curSeq) {
					return downType;
				}
			}
			return null;
		}
		// 5. 삭제 이미지 : 소유 권한이 있는 경우 리스트만 허가
		// => 관리자 이외에 전송 안하도록 변경 (2018-04-09)
		else if(photo.getSaleState() == PhotoDTO.SALE_STATE_DEL){
//			if(downType.equals(DOWN_TYPE_LIST)) {
//				int photoOwner = photo.getOwnerNo();
//				List<Integer> ownerSeqList = member.getOwnerGroupList();
//				for(int curSeq : ownerSeqList) {
//					if(photoOwner == curSeq) {
//						return downType;
//					}
//				}
//			}
			return null;
		}
		
		logger.warn("확인필요: " + downType + " / " + photo.getUciCode());
		return null;
	}
	
	/**
	 * @methodName : checkPayDownloadable
	 * @author : JEON,HYUNGGUK
	 * @date : 2017. 11. 21. 오후 5:34:09
	 * @methodCommet: 이미지의 구매 및 다운로드 기간 내인지 여부 확인
	 * @param uciCode
	 * @param memberList
	 * @return
	 * @returnType : boolean
	 */
	private boolean checkPayDownloadable(String uciCode, List<Integer> memberList) {
		PhotoDAO dao = new PhotoDAO();
		return dao.checkPayDownloadable(uciCode, memberList);
	}
	
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		CmdClass cmd = CmdClass.getInstance(request);
		String targetSize = cmd.get3();
		String downPath = null;
		
		String uciCode = request.getParameter("uciCode");
		String sendType = request.getParameter("type");
		if (sendType == null) {
			sendType = "view";
		}

		if (uciCode == null || uciCode.trim().length() == 0) {
			if (targetSize.equals("logo")) {
				String seq = request.getParameter("seq");
				File fd = new File(PATH_LOGO_BASE + "/" + seq + ".jpg");
				if (!fd.exists()) {
					fd = new File(PATH_LOGO_BASE + "/" + seq + ".png");
				}

				if (fd.exists()) {
					downPath = fd.getAbsolutePath();
				} else {
					String tmpLogoPath = PATH_LOGO_TEMP + "/" + seq + ".jpg";
					String tmpLogoInfoPath = PATH_LOGO_TEMP + "/" + seq + ".logoInfo";
					MemberDAO mDao = new MemberDAO();
					MemberDTO mDto = mDao.getMember(Integer.parseInt(seq));
					if(mDto == null) {
						mDto = new MemberDTO();
						mDto.setCompName("출처 불명");
					}
					boolean makeF = false;
					File infoFd = new File(tmpLogoInfoPath);
					if (infoFd.exists()) {
						File logoFd = new File(tmpLogoPath);
						if (logoFd.exists()) {
							if (!mDto.getCompName().equals(FileUtil.readFileToString(infoFd, "UTF-8"))) {
								makeF = true;
							} else {
								downPath = tmpLogoPath;
							}
						} else {
							makeF = true;
						}
					} else {
						makeF = true;
					}
					if (makeF) {
						String mdName = mDto.getCompName();
						if (mdName == null || mdName.trim().length() == 0) {
							mdName = mDto.getName();
						}
						if (mdName == null || mdName.trim().length() == 0) {
							mdName = "출처 불명";
						}
						if (makeLogoFile(mdName, tmpLogoPath)) {
							FileUtil.makeFile(mDto.getCompName().getBytes("UTF-8"), tmpLogoInfoPath);
							downPath = tmpLogoPath;
						} else {
							logger.warn("로고생성 실패");
							downPath = PATH_LOGO_BASE + "/error.jpg";
						}
					}
				}
			} else if (targetSize.equals("doc")) {
				String seq = request.getParameter("seq");

				MemberDAO mDao = new MemberDAO();
				MemberDTO mDto = mDao.getMember(Integer.parseInt(seq));
				String path = mDto.getCompDocPath();

				File fd = new File(path);
				if (fd.exists()) {
					downPath = fd.getAbsolutePath();
				} else {
					logger.warn("사업자 등록증 파일 생성 실패");
					downPath = PATH_LOGO_BASE + "/error.jpg";
				}

			} else if (targetSize.equals("bank")) {
				String seq = request.getParameter("seq");
				MemberDAO mDao = new MemberDAO();
				MemberDTO mDto = mDao.getMember(Integer.parseInt(seq));
				String path = mDto.getCompBankPath();

				File fd = new File(path);
				if (fd.exists()) {
					downPath = fd.getAbsolutePath();
				} else {
					logger.warn("계좌번호 이미지 생성 실패");
					downPath = PATH_LOGO_BASE + "/error.jpg";
				}

			}else if (targetSize.equals("contract")) {
				String seq = request.getParameter("seq");
				MemberDAO mDao = new MemberDAO();
				MemberDTO mDto = mDao.getMember(Integer.parseInt(seq));
				String path = mDto.getContractPath();

				File fd = new File(path);
				if (fd.exists()) {
					downPath = fd.getAbsolutePath();
				} else {
					logger.warn("계약서 이미지 생성 실패");
					downPath = PATH_LOGO_BASE + "/error.jpg";
				}

			}else if (targetSize.equals("notice")) {
				int seq = Integer.parseInt(request.getParameter("seq"));

				//MemberDAO mDao = new MemberDAO();
				//MemberDTO mDto = mDao.getMember(Integer.parseInt(seq));
				//String path = mDto.getCompDocPath();
				
				BoardDAO bDao = new BoardDAO();
				BoardDTO bDto = bDao.getNotice(seq);
				String path = bDto.getFileName();

				File fd = new File(path);
				if (fd.exists()) {
					downPath = fd.getAbsolutePath();
				} else {
					logger.warn("공지사항 첨부 파일 생성 실패");
					downPath = PATH_LOGO_BASE + "/error.jpg";
				}

			}
		} else {
			PhotoDAO photoDao = new PhotoDAO();

			// 로그인 정보
			HttpSession session = request.getSession();
			MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");
			if (memberInfo != null) {
				// 멤버정보 현행화
				memberInfo = new MemberDAO().getMember(memberInfo);
			}
			// 접속 IP
			String ip = HttpUtil.getRequestIpAddr(request);
			
			String serviceCode = "nb";	// nb / gt / dt
			String tmpCorp = request.getParameter("corp");
			if(tmpCorp != null && tmpCorp.trim().length() > 0) {
				serviceCode = tmpCorp;
			}
			String serviceName = CORP_NAME_MAP.get(serviceCode); // 뉴스뱅크 / 게티이미지코리아 / 디지털저작권거래소

			// 찜이미지 압축전송
			if (targetSize.equals(DOWN_TYPE_ZIP)) {
				DownloadDTO downLog = new DownloadDTO();
				downLog.setIpAddress(ip);
				
				List<PhotoDTO> photoDtoList = new ArrayList<PhotoDTO>();
				List<File>fileFdList = new ArrayList<File>();
				
				// ZIP은 후불 회원 / 소유자 / 구매자만 다운로드 가능
				if (memberInfo != null) {
					// PhotoDTO 읽기
					String[] uciCodes = request.getParameter("uciCode").split("\\$\\$");
					for (int i = 0; i < uciCodes.length; i++) {
						PhotoDTO photo = photoDao.read(uciCodes[i]);
						String newDownType = getSuitableDownType(photo, memberInfo, DOWN_TYPE_SERVICE, serviceCode, ip);
						// 원본 다운로드 권한 있을때만 가능
						if(newDownType != null && newDownType.equals(DOWN_TYPE_SERVICE)) {
							photoDtoList.add(photo);
						}
					}
				}

				try {
					if (photoDtoList.size() == 0) {
						logger.warn("다운로드 가능한 이미지 없음");
						request.setAttribute("ErrorMSG", "다운로드 가능한 이미지가 없습니다.\\n선택하신 이미지 상태를 확인해 주세요");
						forward(request, response, URL_PHOTO_ERROR_SERVICE);
						return;
					}
					downLog.setMemberSeq(memberInfo.getSeq());
					for (PhotoDTO photo : photoDtoList) {
						downLog.setUciCode(photo.getUciCode());
						photoDao.insDownLog(downLog);
						// 원본 이미지를 실시간으로 카피 / UCI 임베드 / 다운로드 정보 임베드(메타태그) 하여 전송
						String orgPath = PATH_PHOTO_BASE + "/" + photo.getOriginPath();
						if (!new File(orgPath).exists()) {
							logger.warn("원본이미지 없음: " + orgPath);
							request.setAttribute("ErrorMSG", "다운로드 대상(" + photo.getUciCode() + ") 원본파일이 없습니다.\\n관리자에게 문의해 주세요");
							forward(request, response, URL_PHOTO_ERROR_SERVICE);
							return;
						}
						String tmpDir = PATH_PHOTO_DOWN + "/" + ymDf.format(new Date());
						FileUtil.makeDirectory(tmpDir);
						String uciEmbedTmp = tmpDir + "/" + photo.getUciCode() + "." + serviceCode + "." + downLog.getSeq() + ".jpg";
						fileFdList.add(new File(uciEmbedTmp));
						try {
							// UCI 코드 임베딩
							APIHandler.attach(new File(orgPath), new File(uciEmbedTmp), uciCode);
						} catch (Exception e) {
							logger.warn("UCI 임베드 실패", e);
							request.setAttribute("ErrorMSG", "원본(" + photo.getUciCode() + ")  다운로드 중 오류(1)가 발생했습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}

						// 다운로드 정보 메타정보에 추가
						if (!embedMetaTags(uciEmbedTmp, uciCode, serviceName, serviceCode, downLog.getSeq(), photo.isOwnerGroup(), false)) {
							// 생성 실패
							logger.warn("다운로드 정보 임베드 실패: " + uciCode + "." + downLog.getSeq());
							request.setAttribute("ErrorMSG", "원본(" + photo.getUciCode() + ")  다운로드 중 오류(2)가 발생했습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}
					}
					String zipFileName = "newsbank_" + System.currentTimeMillis() + ".zip";
					String zipPath = PATH_PHOTO_DOWN + "/zip/" + ymDf.format(new Date()) + "/" + zipFileName;
					ZipUtil zu = new ZipUtil();
					File[] fdArry = new File[fileFdList.size()];
					fileFdList.toArray(fdArry);
					zu.createZipFile(fdArry, zipPath, true);
					// 압축파일 전송
					sendImageFile(response, zipPath, zipFileName);
				} catch (Exception e) {
					logger.warn("", e);
				} finally {

				}
			}
			// 압축본을 제외한 이미지 전송 요청
			else {
				uciCode = uciCode.trim();
				PhotoDTO photo = photoDao.read(uciCode);
				if(photo != null && !photo.getUciCode().equals(uciCode) && targetSize.equals("list") && serviceCode != null && serviceCode.equals(SERVICE_CODE_GETTY)) {
					String newCode = photoDao.getUciCodeByOldCode(uciCode);
					if(newCode != null) {
						photo = photoDao.read(newCode);
						if(photo != null && photo.getUciCode() != null && photo.getUciCode().equals(newCode)) {
							uciCode = newCode;
						}
					}
				}
				
				// 사진 정보가 없는 경우
				if (photo == null || photo.getUciCode().equals(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI)) {
					// 파일 부재(이미지 부재 / 오류) 이미지 전송
					if (targetSize.equals("list")) {
						response.sendRedirect(URL_PHOTO_ERROR_LIST);
					} else {
						response.sendRedirect(URL_PHOTO_ERROR_VIEW);
					}
					return;
				}
				
				String newDownType = getSuitableDownType(photo, memberInfo, targetSize, serviceCode, ip);
				if(newDownType == null) {
					if(photo.getSaleState() != PhotoDTO.SALE_STATE_OK) {
						if (targetSize.equals("list")) {
							response.sendRedirect(URL_PHOTO_STOP_LIST);
						} else {
							response.sendRedirect(URL_PHOTO_STOP_VIEW);
						}
					}
					else {
						if (targetSize.equals("list")) {
							response.sendRedirect(URL_PHOTO_ERROR_LIST);
						} else {
							response.sendRedirect(URL_PHOTO_ERROR_VIEW);
						}
					}
					return;
				}
				else if(newDownType.startsWith(DOWN_TYPE_CORP + "_")) {
					memberInfo = new MemberDAO().getMember(CORP_INFO_QUERY_MAP.get(serviceCode));
					newDownType = newDownType.substring(DOWN_TYPE_CORP.length()+1);
					
					if(photo.getSaleState() != PhotoDTO.SALE_STATE_OK) {
						if (newDownType.equals("list")) {
							response.sendRedirect(URL_PHOTO_STOP_LIST);
						} else {
							response.sendRedirect(URL_PHOTO_STOP_VIEW);
						}
						return;
					}
				}
				
				targetSize = newDownType;
				if (targetSize.equals(DOWN_TYPE_LIST)) {
					downPath = photo.getListPath();
				} else if(targetSize.equals(DOWN_TYPE_VIEW)){
					downPath = photo.getViewPath();
				}
				// 구매한 이미지 다운로드
				else if (targetSize.equals(DOWN_TYPE_SERVICE) || targetSize.equals(DOWN_TYPE_OUTLINE)) {
					DownloadDTO downLog = new DownloadDTO();
					downLog.setIpAddress(ip);
					downLog.setMemberSeq(memberInfo.getSeq());
					downLog.setUciCode(uciCode);

					try {
						// 원본 이미지를 실시간으로 카피 / UCI 임베드 / 다운로드 정보 임베드(메타태그) 하여 전송
						String orgPath = PATH_PHOTO_BASE + photo.getOriginPath();
						
						// 게티 원본 이미지 고정
//						if(serviceCode.equals(SERVICE_CODE_GETTY)) {
//							orgPath = "/data/newsbank/temp/getty.jpg";
//						}
						
						if (!new File(orgPath).exists()) {
							logger.warn("원본이미지 없음: " + orgPath);
							request.setAttribute("ErrorMSG", "다운로드 대상(" + photo.getUciCode() + ") 원본파일이 없습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}
						String tmpDir = PATH_PHOTO_DOWN + "/" + ymDf.format(new Date());
						FileUtil.makeDirectory(tmpDir);

						//시안 요청
						if(targetSize.equals(DOWN_TYPE_OUTLINE)) {
							// 워터마크본 생성
							String watermarkEmbedTmp = tmpDir + "/" + photo.getUciCode() + "." + serviceCode + "." + downLog.getSeq() + ".wm.jpg";
							NBImageUtil.makeWatermarkOutlineImage(orgPath, watermarkEmbedTmp);
							orgPath = watermarkEmbedTmp;
						}

						String uciEmbedTmp = tmpDir + "/" + photo.getUciCode() + "." + serviceCode + "." + downLog.getSeq() + ".jpg";
						try {
							// UCI 코드 임베딩
							APIHandler.attach(new File(orgPath), new File(uciEmbedTmp), uciCode);
						} catch (Exception e) {
							logger.warn("UCI 임베드 실패", e);
							request.setAttribute("ErrorMSG", "원본(" + photo.getUciCode() + ")  다운로드 중 오류(1)가 발생했습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}

						// 다운로드 정보 메타정보에 추가
						if (!embedMetaTags(uciEmbedTmp, uciCode, serviceName, serviceCode, downLog.getSeq(), photo.isOwnerGroup(), targetSize.equals(DOWN_TYPE_OUTLINE))) {
							// 생성 실패
							logger.warn("다운로드 정보 임베드 실패: " + uciCode + "." + downLog.getSeq());
							request.setAttribute("ErrorMSG", "원본(" + photo.getUciCode() + ")  다운로드 중 오류(2)가 발생했습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}

						// 원본파일 전송
//						logger.warn("TODO 주석제거 원본파일 전송");
						sendImageFile(response, uciEmbedTmp, photo.getUciCode() + ".jpg");
					} finally {
						if(request.getAttribute("ErrorMSG") == null) {
							if (photo.isOwnerGroup()) {
								// 소유자의 경우 콘솔 로그만 남김
								logger.info("Owner Down: " + uciCode);
							} else {
								photoDao.insDownLog(downLog);
							}
						}
					}
				}
				// 기타 다운로드??
				else {
					logger.warn("잘못된 접근: (" + targetSize + ") / " + uciCode);
					// 현재 대상이 되는 케이스 없음 / 향후 확장성을 위해
				}
				if (downPath != null) {
					downPath = PATH_PHOTO_BASE + downPath;
				}
			}
		}

		if (downPath != null) {
			// 대상 파일이 없는경우 (썸네일/뷰 다운로드 요청에 대해서만)
			if (!new File(downPath).exists() && (targetSize.equals("list") || targetSize.equals("view"))) {
				logger.warn("File Not Exist: " + downPath);
				// 파일 부재(이미지 부재 / 오류) 이미지 전송
				if (targetSize.equals("list")) {
					response.sendRedirect(URL_PHOTO_ERROR_LIST);
				} else {
					response.sendRedirect(URL_PHOTO_ERROR_VIEW);
				}
				return;
			}

			if (new File(downPath).exists()) {
				try {
					if (targetSize.equals("logo")) {
						if (sendType.equals("file")) {
							String fileName = "logo.jpg";
							sendImageFile(response, downPath, fileName);
						} else {
							sendImageFile(response, downPath);
						}
					} else if (targetSize.equals("doc") || targetSize.equals("bank") || targetSize.equals("contract") || targetSize.equals("notice")) {
						sendFile(request, response, downPath);
					} else {
						if (targetSize.equals("service")) {
							sendImageFile(response, downPath, uciCode + ".jpg");
						} else {
							if (sendType.equals("file")) {
								String fileName = uciCode + "_" + targetSize + ".jpg";
								sendImageFile(response, downPath, fileName);
							} else {
								logger.debug("Send Image: " + downPath);
								sendImageFile(response, downPath);
							}
						}
					}
				} catch (Exception e) {
					logger.warn("", e);
				}
			} else {
				// 보낼 이미지 없음
				System.out.print("");
			}
		} else {
			System.out.println();
		}
	}

	private static final String DAHAMI_HEADER_DELIMITER_STRING = "$$";
	private static final String DAHAMI_DIST_HEADER_STRING = DAHAMI_HEADER_DELIMITER_STRING + "배포(http://www.newsbank.co.kr) : ";
	private static final String DAHAMI_ID_HEADER_STRING = DAHAMI_HEADER_DELIMITER_STRING + PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI;

	private boolean embedMetaTags(String orgPath, String uciCode, String serviceName, String serviceCode, int downSeq, boolean isOwner, boolean isOutline) {
		File fd = new File(orgPath);
		if (!fd.exists()) {
			return false;
		}
		File orgFd = new File(orgPath + ".jpg");
		fd.renameTo(orgFd);
		fd = orgFd;

		TiffImageMetadata tMeta = null;
		TiffOutputSet outputSet = null;
		TiffOutputDirectory rootDir = null;
		TiffOutputDirectory exifDir = null;
		try {
			ImageMetadata meta = null;
			
			try {
				meta = Imaging.getMetadata(fd);
			}catch(IOException e) {
				logger.warn(e.getMessage() + " / " + fd.getAbsolutePath());
			}

			if (meta == null) {
				outputSet = new TiffOutputSet();
			} else {
				tMeta = ((JpegImageMetadata) meta).getExif();
				if (tMeta == null) {
					outputSet = new TiffOutputSet();
				} else {
					outputSet = tMeta.getOutputSet();
				}
			}

			rootDir = outputSet.getOrCreateRootDirectory();
			exifDir = outputSet.getOrCreateExifDirectory();

			TiffOutputField copyright = null;
			TiffOutputField uniqueId = null;
			for (TiffOutputField curField : rootDir.getFields()) {
				if (curField.tag == TiffTagConstants.TIFF_TAG_COPYRIGHT.tag) {
					copyright = curField;
				}
			}

			for (TiffOutputField curField : exifDir.getFields()) {
				if (curField.tag == ExifTagConstants.EXIF_TAG_IMAGE_UNIQUE_ID.tag) {
					uniqueId = curField;
				}
			}

			String id = uciCode + ".";
			if (isOwner) {
				id += "owner";
			} else if (isOutline) {
				id += "outline";
			} else {
				id += serviceCode + "." + downSeq;
			}
			if (uniqueId != null) {
				String currentValue = "";
				try {
					if (tMeta != null) {
						currentValue = (String) tMeta.getFieldValue(uniqueId.tagInfo);
					}
					currentValue = currentValue.trim();
					if (currentValue.indexOf(DAHAMI_ID_HEADER_STRING) != -1) {
						currentValue = currentValue.substring(0, currentValue.indexOf(DAHAMI_ID_HEADER_STRING)).trim();
					}
				} catch (Exception e) {
				}
				if (currentValue == null || currentValue.trim().length() == 0) {
					currentValue = "";
				}
				id = currentValue + DAHAMI_HEADER_DELIMITER_STRING + id;

				exifDir.removeField(uniqueId.tagInfo);
			}
			byte[] idByte = id.getBytes("UTF-8");
			uniqueId = new TiffOutputField(ExifTagConstants.EXIF_TAG_IMAGE_UNIQUE_ID, FieldType.ASCII, idByte.length, idByte);
			exifDir.add(uniqueId);

			String msg = DAHAMI_DIST_HEADER_STRING + serviceName + "(" + id + ")";
			if (copyright != null) {
				String currentValue = "";
				try {
					if (tMeta != null) {
						currentValue = (String) tMeta.getFieldValue(copyright.tagInfo);
					}
					currentValue = currentValue.trim();
					if (currentValue.indexOf(DAHAMI_DIST_HEADER_STRING) != -1) {
						currentValue = currentValue.substring(0, currentValue.indexOf(DAHAMI_DIST_HEADER_STRING)).trim();
					}
				} catch (Exception e) {
				}

				if (currentValue != null && currentValue.trim().length() > 0) {
					currentValue += "\n";
				} else {
					currentValue = "";
				}
				msg = currentValue + msg;
				rootDir.removeField(copyright.tagInfo);
			}
			byte[] msgByte = msg.getBytes("UTF-8");
			copyright = new TiffOutputField(TiffTagConstants.TIFF_TAG_COPYRIGHT, FieldType.ASCII, msgByte.length, msgByte);
			rootDir.add(copyright);
			FileInputStream fis = null;
			FileOutputStream fos = null;

			try {
				fis = new FileInputStream(fd);
				fos = new FileOutputStream(new File(orgPath));
				new ExifRewriter().updateExifMetadataLossy(fis, fos, outputSet);
			} finally {
				try {
					fis.close();
				} catch (Exception e) {
				}
				try {
					fos.close();
				} catch (Exception e) {
				}
			}
			FileUtil.delete(fd);
			return true;
		} catch (ImageWriteException | ImageReadException | IOException e) {
			logger.warn("", e);
		}
		return false;
	}

	private void sendImageFile(HttpServletResponse response, String sendPath) throws IOException {
		sendImageFile(response, sendPath, null);
	}

	private void sendImageFile(HttpServletResponse response, String sendPath, String headerFileName) throws IOException {
		// 디스크 읽기
		long rStart = System.currentTimeMillis();
		byte[] data = FileUtil.readFile(sendPath);
		long rEnd = System.currentTimeMillis();
		response.addHeader("TIME_Read", String.valueOf(rEnd - rStart));

		response.addHeader("Pragma", "public");
		response.addHeader("Expires", "0");
		response.addHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
		response.addHeader("Cache-Control", "private");
		if (headerFileName != null && headerFileName.endsWith(".zip")) {
			response.addHeader("Content-Type", "application/zip");
		} else {
			response.addHeader("Content-Type", "image/jpeg");
		}
		if (headerFileName != null) {
			response.addHeader("Content-Disposition", "attachment; filename=\"" + headerFileName + "\";");
		}
		response.addHeader("Content-Transfer-Encoding", "binary");

		ServletOutputStream sos = response.getOutputStream();
		try {
			sos.write(data);
			sos.flush();
		} catch (IOException e) {
			String errMsg = e.getLocalizedMessage();
			if (errMsg.indexOf("현재 연결은 사용자의 호스트 시스템의 소프트웨어의 의해 중단되었습니다") == -1) {
				logger.warn("", e);
			}
		}
	}

	private boolean makeLogoFile(String mdName, String tgtPath) {
		Font font = null;
		GraphicsEnvironment ge = null;
        ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        Font[] fonts = ge.getAllFonts();
        
        for(int i=0; i<fonts.length;i++){
           if(fonts[i].getFontName().equals("나눔고딕")){
        	 font = new Font("나눔고딕", Font.BOLD, 47);
        	 break;
           }else if(fonts[i].getFontName().equals("나눔고딕코딩")){
        	 font = new Font("나눔고딕코딩", Font.BOLD, 47);
        	 break;
           }
        }
		
		FontRenderContext frc = new FontRenderContext(null, true, true);
		Rectangle2D r2D = font.getStringBounds(mdName, frc);
		int orgLogoImgW = (int) Math.round(r2D.getWidth());
		int orgLogoImgH = (int) Math.round(r2D.getHeight()) + 10;

		BufferedImage logoImg = new BufferedImage(orgLogoImgW, orgLogoImgH, BufferedImage.TYPE_3BYTE_BGR);
		for (int i = 0; i < logoImg.getWidth(); i++) {
			for (int j = 0; j < logoImg.getHeight(); j++) {
				logoImg.setRGB(i, j, Color.white.getRGB());
			}
		}
		Graphics g = logoImg.getGraphics();
		g.setColor(Color.black);
		g.setFont(font);
		g.drawString(mdName, 0, orgLogoImgH - 10);

		int imgFullW = orgLogoImgW;
		int imgFullH = orgLogoImgH;
//		if (imgFullW > imgFullH) {
//			imgFullH = imgFullW;
//		} else {
//			imgFullW = imgFullH;
//		}
		BufferedImage fullImg = new BufferedImage(imgFullW, imgFullH, BufferedImage.TYPE_3BYTE_BGR);
		for (int i = 0; i < fullImg.getWidth(); i++) {
			for (int j = 0; j < fullImg.getHeight(); j++) {
				fullImg.setRGB(i, j, Color.white.getRGB());
			}
		}
		g = fullImg.getGraphics();
		g.drawImage(logoImg, 0, (imgFullH / 2) - (orgLogoImgH / 2), null);

		float widthRatio = (float) LOGO_MAX_WIDTH / orgLogoImgW;
		float heightRatio = (float) LOGO_MAX_HEIGHT / orgLogoImgH;

		float ratio = widthRatio;
		if (ratio > heightRatio) {
			ratio = heightRatio;
		}

		fullImg = ImageUtil.resize(fullImg, LOGO_MAX_WIDTH, LOGO_MAX_HEIGHT, true);

		return ImageUtil.saveImage(fullImg, tgtPath, ImageUtil.IMAGE_FORMAT_JPEG);
	}

	private void sendFile( HttpServletRequest request, HttpServletResponse response, String sendPath ) throws Exception  {
		File fd = new File(sendPath);
		HttpUpDownUtil.fileDownload(request, response, fd.getName(), fd.getName(), fd.getParent(), "octet-stream");
	}
}
