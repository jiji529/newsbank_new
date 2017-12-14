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
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.invoke.MethodHandles;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
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
import com.dahami.common.util.HttpUtil;
import com.dahami.common.util.ImageUtil;
import com.dahami.common.util.ZipUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.dto.DownloadDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

import kr.or.uci.dist.api.APIHandler;

public class DownloadService extends ServiceBase {
	private static final SimpleDateFormat ymDf = new SimpleDateFormat("yyyyMM");

	private static final String PATH_PHOTO_BASE = "/data/newsbank/serviceImages";
	private static final String PATH_LOGO_BASE = "/data/newsbank/logo";

	/** 임시생성 로고 저장폴더 */
	private static final String PATH_LOGO_TEMP = "/data/newsbank/logo/temp";
	private static final String PATH_PHOTO_DOWN = "/data/newsbank/serviceDown";

	private static final String URL_PHOTO_ERROR_LIST = "/images/error/list_image_processError.jpg";
	private static final String URL_PHOTO_ERROR_VIEW = "/images/error/view_image_processError.jpg";
	private static final String URL_PHOTO_ERROR_SERVICE = "/downloadError.jsp";
	private static final String URL_PHOTO_STOP_LIST = "/images/error/list_image_stopSale.jpg";
	private static final String URL_PHOTO_STOP_VIEW = "/images/error/view_image_stopSale.jpg";

	private static final int LOGO_MAX_WIDTH = 177;
	private static final int LOGO_MAX_HEIGHT = 40;

	private static final Map<String, Set<String>> ACCESS_IP_MAP;
	private static final Map<String, String> CORP_NAME_MAP;
	private static final Map<String, String> CORP_INFO_QUERY_MAP;

	static {
		ACCESS_IP_MAP = new HashMap<String, Set<String>>();
		final Set<String> ipSet = new HashSet<String>();
		ACCESS_IP_MAP.put("gt", ipSet);
		ipSet.add("59.27.23.3");
		ipSet.add("127.0.0.1");

		CORP_NAME_MAP = new HashMap<String, String>();
		CORP_NAME_MAP.put("nb", "뉴스뱅크");
		CORP_NAME_MAP.put("gt", "게티이미지코리아");

		CORP_INFO_QUERY_MAP = new HashMap<String, String>();
		CORP_INFO_QUERY_MAP.put("gt", "Member.selGetty");
	}

	private String targetSize;
	private String uciCode;

	public DownloadService(String targetSize, String uciCode) {
		this.targetSize = targetSize;
		this.uciCode = uciCode;
	}

	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String downPath = null;
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

			// 접속 IP
			String ip = HttpUtil.getRequestIpAddr(request);

			// 찜이미지 압축전송
			if (targetSize.equals("zip")) {
				DownloadDTO downLog = new DownloadDTO();
				downLog.setIpAddress(ip);
				boolean downConfirm = false;
				boolean isOwner = false;
				String corp = "nb";

				PhotoDTO[] photoDtos = null;
				File[] fileFds = null;

				// ZIP은 후불 회원 혹은 소유자만 다운로드 가능
				if (memberInfo != null) {
					// PhotoDTO 읽기
					String[] uciCodes = request.getParameterValues("uciCode");
					photoDtos = new PhotoDTO[uciCodes.length];
					fileFds = new File[uciCodes.length];
					for (int i = 0; i < uciCodes.length; i++) {
						PhotoDTO photo = photoDao.read(uciCodes[i]);
						photoDtos[i] = photo;
					}

					// 후불 체크
					int memberSeq = memberInfo.getSeq();
					MemberDAO mDao = new MemberDAO();
					memberInfo = mDao.getMember(memberSeq);
					if (memberInfo.getDeferred() != null && memberInfo.getDeferred().equals("Y")) {
						downLog.setDeferUse("Y");
						downConfirm = true;
					}

					// 소유자 체크
					if (!downConfirm) {
						isOwner = true;
						for (PhotoDTO cur : photoDtos) {
							if (cur.getOwnerNo() != memberInfo.getSeq()) {
								isOwner = false;
								break;
							}
						}
						if (isOwner) {
							downConfirm = true;
						}
					}
				}

				if (!downConfirm) {
					response.sendRedirect(URL_PHOTO_ERROR_VIEW);
					return;
				}
				downLog.setMemberSeq(memberInfo.getSeq());

				String serviceCode = corp; // nb / gt / dt
				String serviceName = CORP_NAME_MAP.get(corp); // 뉴스뱅크 / 게티이미지코리아 / 디지털저작권거래소

				try {
					for (int i = 0; i < photoDtos.length; i++) {
						PhotoDTO photo = photoDtos[i];
						downLog.setUciCode(photo.getUciCode());
						photoDao.insDownLog(downLog);
						// 원본 이미지를 실시간으로 카피 / UCI 임베드 / 다운로드 정보 임베드(메타태그) 하여 전송
						String orgPath = PATH_PHOTO_BASE + "/" + photo.getOriginPath();
						if (!new File(orgPath).exists()) {
							logger.warn("원본이미지 없음: " + orgPath);
							request.setAttribute("ErrorMSG", "다운로드 대상(" + photo.getUciCode() + ") 원본파일이 없습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}
						String tmpDir = PATH_PHOTO_DOWN + "/" + ymDf.format(new Date());
						FileUtil.makeDirectory(tmpDir);
						String uciEmbedTmp = tmpDir + "/" + photo.getUciCode() + "." + serviceCode + "." + downLog.getSeq() + ".jpg";
						fileFds[i] = new File(uciEmbedTmp);
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
						if (!embedMetaTags(uciEmbedTmp, uciCode, serviceName, serviceCode, downLog.getSeq(), isOwner, false)) {
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
					zu.createZipFile(fileFds, zipPath, true);
					// 압축파일 전송
					sendImageFile(response, zipPath, zipFileName);
				} catch (Exception e) {
					logger.warn("", e);
				} finally {

				}
			} else {
				PhotoDTO photo = photoDao.read(this.uciCode);
				// 사진 정보가 없는 경우
				if (photo == null) {
					// 파일 부재(이미지 부재 / 오류) 이미지 전송
					if (targetSize.equals("list")) {
						response.sendRedirect(URL_PHOTO_ERROR_LIST);
					} else {
						response.sendRedirect(URL_PHOTO_ERROR_VIEW);
					}
					return;
				}

				String orgPath = null;

				// 썸네일 / 뷰 이미지의 경우 서비스중인 이미지에 대해 모두 다운로드 가능함
				if (targetSize.equals("list") || targetSize.equals("view")) {
					// 서비스중이거나
					if (photo.getSaleState() == PhotoDTO.SALE_STATE_OK
							// 소유자일 때 이미지 전송
							|| (memberInfo != null && photo.getOwnerNo() == memberInfo.getSeq())) {
						orgPath = photo.getOriginPath();
						if (targetSize.equals("list")) {
							downPath = photo.getListPath();
						} else {
							downPath = photo.getViewPath();
						}
					} else {
						// 판매중이지 않은 경우에 대한 이미지 전송
						if (targetSize.equals("list")) {
							response.sendRedirect(URL_PHOTO_STOP_LIST);
						} else {
							response.sendRedirect(URL_PHOTO_STOP_VIEW);
						}
						return;
					}
				}
				// 구매한 이미지 다운로드
				else if (targetSize.equals("service") || targetSize.equals("outline")) {
					DownloadDTO downLog = new DownloadDTO();
					downLog.setIpAddress(ip);
					boolean downConfirm = false;
					boolean isOwner = false;
					boolean isOutline = false;

					// 소유자 여부 체크
					if (memberInfo != null) {
						if (memberInfo.getSeq() == photo.getOwnerNo()) {
							downConfirm = true;
							isOwner = true;
						}
					}

					String corp = null;
					if (!downConfirm) {
						corp = request.getParameter("corp");
						// 다운로드 가능 여부 확인(연계 / IP 제한)
						if (corp != null && corp.trim().length() > 0) {
							Set<String> ipSet = ACCESS_IP_MAP.get(corp);
							if (ipSet != null && ipSet.size() > 0) {
								if (ipSet.contains(ip)) {
									// 연계계정 정보 읽기(ex. 게티)
									MemberDAO mDao = new MemberDAO();
									memberInfo = mDao.getMember(CORP_INFO_QUERY_MAP.get(corp));
									downConfirm = true;
								}
							}
						}
					}
					if (corp == null || corp.trim().length() == 0) {
						corp = "nb";
					}

					if (!downConfirm) {
						// 연계 이외에는 로그인한 경우만 다운로드 가능
						if (memberInfo != null) {
							// 후불 체크
							int memberSeq = memberInfo.getSeq();
							MemberDAO mDao = new MemberDAO();
							memberInfo = mDao.getMember(memberSeq);
							if (memberInfo.getDeferred() != null && memberInfo.getDeferred().equals("Y")) {
								downLog.setDeferUse("Y");
								downConfirm = true;
							}
							// 구매여부 체크
							else {
								if (checkDownloadable(this.uciCode, memberSeq)) {
									downConfirm = true;
								}
							}
						}
					}

					if (!downConfirm) {
						// 로그인은 했고 아웃라인의 경우 아웃라인(원본+썸네일) 생성하여 다운로드 하도록 처리
						if (targetSize.equals("outline") && memberInfo != null) {

						} else {
							response.sendRedirect(URL_PHOTO_ERROR_VIEW);
							return;
						}
					}

					downLog.setMemberSeq(memberInfo.getSeq());
					downLog.setUciCode(uciCode);

					if (downConfirm && !isOwner) {
						photoDao.insDownLog(downLog);
					} else if (isOwner) {
						// 소유자의 경우 콘솔 로그만 남김
						logger.info("Owner Down: " + this.uciCode);
					}

					String serviceCode = corp; // nb / gt / dt
					String serviceName = CORP_NAME_MAP.get(corp); // 뉴스뱅크 / 게티이미지코리아 / 디지털저작권거래소

					try {
						// 원본 이미지를 실시간으로 카피 / UCI 임베드 / 다운로드 정보 임베드(메타태그) 하여 전송
						orgPath = PATH_PHOTO_BASE + "/" + photo.getOriginPath();
						if (!new File(orgPath).exists()) {
							logger.warn("원본이미지 없음: " + orgPath);
							request.setAttribute("ErrorMSG", "다운로드 대상(" + photo.getUciCode() + ") 원본파일이 없습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}
						String tmpDir = PATH_PHOTO_DOWN + "/" + ymDf.format(new Date());
						FileUtil.makeDirectory(tmpDir);

						// 원본 다운로드 허가 없는 경우 => 시안 요청 단순 로그인 (참고: 시안요청 이더라도 구매건인 경우 원본으로 다운로드 됨)
						if (!downConfirm) {
							// 워터마크본 생성
							String watermarkEmbedTmp = tmpDir + "/" + photo.getUciCode() + "." + serviceCode + "." + downLog.getSeq() + ".wm.jpg";
							makeWatermarkImage(orgPath, watermarkEmbedTmp);
							orgPath = watermarkEmbedTmp;
							isOutline = true;
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
						if (!embedMetaTags(uciEmbedTmp, uciCode, serviceName, serviceCode, downLog.getSeq(), isOwner, isOutline)) {
							// 생성 실패
							logger.warn("다운로드 정보 임베드 실패: " + uciCode + "." + downLog.getSeq());
							request.setAttribute("ErrorMSG", "원본(" + photo.getUciCode() + ")  다운로드 중 오류(2)가 발생했습니다.\n관리자에게 문의해 주세요");
							response.sendRedirect(URL_PHOTO_ERROR_SERVICE);
							return;
						}

						// 원본파일 전송
						// TODO 주석제거 원본파일 전송 
						logger.warn("TODO 주석제거 원본파일 전송");
//						sendImageFile(response, uciEmbedTmp, this.uciCode + ".jpg");
					} finally {
					}

					// 원본/시안 다운로드는 아래로 내려가지 않음
				}
				// 기타 다운로드??
				else {
					logger.warn("잘못된 접근: " + targetSize + " / " + uciCode);
					// 현재 대상이 되는 케이스 없음 / 향후 확장성을 위해
				}
				if (downPath != null) {
					downPath = PATH_PHOTO_BASE + downPath;
				}
			}
		}

		if (downPath != null) {
			// 대상 파일이 없는경우 (썸네일/뷰 다운로드 요청에 대해서만) / 원본이 있으면 동적 생성 후 전송
			if (!new File(downPath).exists() && (targetSize.equals("list") || targetSize.equals("view"))) {
				logger.warn("File Not Exist: " + downPath);
				// 파일 부재(이미지 부재 / 오류) 이미지 전송
				if (targetSize.equals("list")) {
					response.sendRedirect(URL_PHOTO_ERROR_LIST);
				} else {
					response.sendRedirect(URL_PHOTO_ERROR_VIEW);
				}
				return;

				// // 원본도 없는경우
				// if(!new File(orgPath).exists()) {
				// // 파일 부재(이미지 부재 / 오류) 이미지 전송
				// if(targetSize.equals("list")) {
				// response.sendRedirect(URL_PHOTO_ERROR_LIST);
				// }
				// else {
				// response.sendRedirect(URL_PHOTO_ERROR_VIEW);
				// }
				// return;
				// }
				// // 원본이 있는경우
				// else {
				// // 리사이즈 이미지 생성
				// System.out.println();
				// }
			}

			if (new File(downPath).exists()) {
				try {
					if (targetSize.equals("logo")) {
						sendImageFile(response, downPath);
					} else if (targetSize.equals("doc") || targetSize.equals("bank") || targetSize.equals("contract") || targetSize.equals("notice")) {
						sendFile(response, downPath);
					} else {
						if (targetSize.equals("service")) {
							sendImageFile(response, downPath, this.uciCode + ".jpg");
						} else {
							if (sendType.equals("file")) {
								String fileName = this.uciCode + "_" + targetSize + ".jpg";
								sendImageFile(response, downPath, fileName);
							} else {
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
	private static final String DAHAMI_ID_HEADER_STRING = DAHAMI_HEADER_DELIMITER_STRING + "I011-";

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
			ImageMetadata meta = Imaging.getMetadata(fd);

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
			response.getOutputStream().flush();
		} catch (IOException e) {
			String errMsg = e.getLocalizedMessage();
			if (errMsg.indexOf("현재 연결은 사용자의 호스트 시스템의 소프트웨어의 의해 중단되었습니다") == -1) {
				logger.warn("", e);
			}
		}
	}

	/**
	 * @methodName : checkDownloadable
	 * @author : JEON,HYUNGGUK
	 * @date : 2017. 11. 21. 오후 5:34:09
	 * @methodCommet: 해당 컨텐츠를 다운로드 받을 권한이 있는지 확인
	 * @param uciCode
	 * @param memberSeq
	 * @return
	 * @returnType : boolean
	 */
	private boolean checkDownloadable(String uciCode, int memberSeq) {
		PhotoDAO dao = new PhotoDAO();
		return dao.checkDownloadable(uciCode, memberSeq);
	}

	private static BufferedImage watermarkBimg;
	private static int wImgWidth;
	private static int wImgHeight;
	static {
		watermarkBimg = ImageUtil.getBufferedImage(MethodHandles.lookup().lookupClass().getClassLoader().getResource("com/dahami/newsbank/web/service/resources/watermarkTemplate.png").getFile()).get(0);
		wImgWidth = watermarkBimg.getWidth();
		wImgHeight = watermarkBimg.getHeight();
	}

	private boolean makeWatermarkImage(String orgPath, String outPath) {
		File inputFd = new File(orgPath);
		BufferedImage bImg = ImageUtil.getBufferedImage(inputFd).get(0);
		short colorBit = (short) bImg.getColorModel().getPixelSize();
		if (colorBit != 24) {
			logger.info("NOT 24bit: " + inputFd.getAbsolutePath());
		}
		Graphics g = bImg.getGraphics();
		int width = bImg.getWidth();
		int height = bImg.getHeight();

		// 이미지 높이에 맞춰서 워터마크 반복
		int startY = 0;
		do {
			// 이미지 넓이에 맞춰서 워터마크 반복
			int startX = 0;
			do {
				g.drawImage(watermarkBimg, startX, startY, null);
				startX += wImgWidth;
			} while (startX < width);
			g.drawImage(watermarkBimg, 0, startY, null);
			startY += wImgHeight;
		} while (startY < height);
		return ImageUtil.saveImage(bImg, outPath, ImageUtil.IMAGE_FORMAT_JPEG, colorBit);
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

	private void sendFile( HttpServletResponse response, String sendPath, String fileName ) throws Exception  {
		File file = new File(sendPath);
		
		/*HttpServletRequest request,
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv:11") > -1;
		String fileName = null;
		if (ie) {
			fileName = URLEncoder.encode(file.getName(), "utf-8");
		} else {
			fileName = new String(file.getName().getBytes("utf-8"), "iso-8859-1");
		}*/
		
		if(fileName!="") {
			
		}
		int pos = file.getName().lastIndexOf( "." );
		String ext = file.getName().substring( pos + 1 );
		fileName = URLEncoder.encode(fileName, "utf-8");
		fileName = fileName+"."+ext;
		//fileName = URLEncoder.encode(file.getName(), "utf-8");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=\"" +fileName  + "\";");

		FileInputStream fis = new FileInputStream(file);
		BufferedInputStream bis = new BufferedInputStream(fis);
		ServletOutputStream so = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(so);

		byte[] data = new byte[2048];
		int input = 0;
		while ((input = bis.read(data)) != -1) {
			bos.write(data, 0, input);
			bos.flush();
		}

		if (bos != null)
			bos.close();
		if (bis != null)
			bis.close();
		if (so != null)
			so.close();
		if (fis != null)
			fis.close();
	}
	private void sendFile( HttpServletResponse response, String sendPath ) throws Exception  {
		File file = new File(sendPath);
		
	
		String fileName = URLEncoder.encode(file.getName(), "utf-8");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=\"" +fileName  + "\";");

		FileInputStream fis = new FileInputStream(file);
		BufferedInputStream bis = new BufferedInputStream(fis);
		ServletOutputStream so = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(so);

		byte[] data = new byte[2048];
		int input = 0;
		while ((input = bis.read(data)) != -1) {
			bos.write(data, 0, input);
			bos.flush();
		}

		if (bos != null)
			bos.close();
		if (bis != null)
			bis.close();
		if (so != null)
			so.close();
		if (fis != null)
			fis.close();
	}
}
