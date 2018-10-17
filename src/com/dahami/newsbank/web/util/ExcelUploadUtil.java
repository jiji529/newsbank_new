package com.dahami.newsbank.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.dahami.common.mybatis.MybatisSessionFactory;
import com.dahami.common.mybatis.impl.MybatisService;
import com.dahami.newsbank.Constants;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;


public class ExcelUploadUtil {
	
	public String excelCalculations(String excelPath) { // 정산관련 엑셀 업로드	
		/*
		 * 성공하면 SUCCESS, 실패하면 FAIL 리턴
		 * 
		 * 트랜잭션 구성
		 * 1. UsageList INSERT
		 * 2. Calculations INSERT
		 * 3. PaymentMange INSERT
		 * 4. PaymentDetail INSERT
		 * 
		 * Mybatis 설정, 네임스페이스 수정 필요 
		 */
		MybatisSessionFactory sfSR;
		
		//Mybatis 설정 경로 변경 필요
		String confBase = "com/dahami/newsbank/web/dao/mybatis/conf";
		MybatisService mybatis = new MybatisService(confBase);
		mybatis.activate();
		
		//대상 클래스 변경 필요
		sfSR = mybatis.getMybatisServiceSessionFactory(ExcelUploadUtil.class, Constants.TARGET_DB);	
		
		MybatisSessionFactory mySql_sf = null;
		SqlSession mySql_session = null;
		mySql_sf = sfSR;
		int finFlag = 0;
		try {
			//mySql_session = mySql_sf.getSession();
			mySql_session = mySql_sf.getSession(ExecutorType.BATCH, false);
	
			List<Map<String, Object>> offlineCal = new ArrayList<Map<String, Object>>();
			
			DataFormatter formatter = new DataFormatter();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			FileInputStream fis = new FileInputStream(excelPath);
			XSSFWorkbook workbook = new XSSFWorkbook(fis);
			
			XSSFRow row;
			XSSFCell cell;
	
			//System.out.println("Phase1");
			
			for(int cn = 0; cn < 1; cn++){
				
				//System.out.println("Sheet Name : " + workbook.getSheetName(cn));
				//System.out.println(workbook.getSheetName(cn) + " Sheet Data Start");			
	
				//0번째 sheet 정보 취득
				XSSFSheet sheet = workbook.getSheetAt(cn);
	
				//취득된 sheet에서 rows수 취득
				int rows = totalRows(sheet);
				
				//System.out.println(workbook.getSheetName(cn) + " Sheet Row Count : " + rows);
	
				//취득된 row에서 취득대상 cell수 취득
				int cells = sheet.getRow(cn).getPhysicalNumberOfCells();
				//System.out.println(workbook.getSheetName(cn) + " Row's Cell Count: " + cells);
									
				for (int r = 0; r < rows; r++) {
					row = sheet.getRow(r); // row 가져오기
					if(r == 0)
					{
						continue;
					}
					Map<String, Object> param = new HashMap<String, Object>();
					String fragUsage = "";
					if (row != null) {
						for (int c = 0; c < cells; c++) {
							cell = row.getCell(c);
							if (cell != null) {
								
								String value = null;
								
								switch (cell.getCellType()) {
								    case XSSFCell.CELL_TYPE_STRING:
								        value = cell.toString().trim();
								        break;
								    case Cell.CELL_TYPE_NUMERIC:
								        if (c < 2) {
								            value = sdf.format(cell.getDateCellValue());
								        } else {
								        	value = formatter.formatCellValue(cell);
								        }
								        break;
								    case Cell.CELL_TYPE_BLANK:
								    	value = "";
								        break;
								    case Cell.CELL_TYPE_ERROR:
								    	value = "";
								        break;
								    case Cell.CELL_TYPE_BOOLEAN:
								    	value = String.valueOf(cell.getBooleanCellValue());
								    break;
								}
								
								String paramName = "";
								
								
								switch(c+1)
								{
									case 1:
										paramName = "subDate";
										param.put(paramName, value.trim());
										break;
									case 2:
										paramName = "calDate";
										param.put(paramName, value.trim());
										break;
									case 3:
										paramName = "id";
										param.put(paramName, value.trim());
										break;
									case 4:
										fragUsage = "["+value.trim()+"]";								
										break;		
									case 5:
										paramName = "uciCode";
										value = value.toUpperCase();
										param.put(paramName, value);			
										//paramName = "payType";
										//param.put(paramName, "후불");
										paramName = "fees";
										param.put(paramName, "0");
										break;	
									case 6:
										paramName = "usage";
										param.put(paramName, fragUsage+" "+value.trim());
										break;
									case 7:
										paramName = "price";
										value = value.replace(",", "");
										param.put(paramName, value.trim());
										break;
									default:
										break;
								}
								
							} else {
								//System.out.print("ERROR : null");
								finFlag = 2;
							}
						} // for(c) 문
						
						//분리 시작
						String pairId = param.get("id").toString().trim();
						int paramSeq = mySql_session.selectOne("Member.selMemExp",pairId);
						param.put("paramSeq", paramSeq);
	
						mySql_session.insert("Usage.insUsageList", param);
						int usageSeq =  mySql_session.selectOne("Usage.selUsageSeq", param);
						
						param.put("usage", usageSeq);
						
						try {
							int memberRate = mySql_session.selectOne("Photo.selPostRate", param.get("uciCode").toString());
							if(memberRate == 0)
							{
								//System.out.println("ERROR : Return 0 : "+param.get("uciCode").toString());
								finFlag = 2;
							}
							else {
								param.put("rate", memberRate);
							}	
						}
						catch (Exception e){
							//System.out.println(e+"ERROR : "+param.get("uciCode").toString());
							finFlag = 2;
						}
						
						offlineCal.add(param);
						
						//String checkPair = paramSeq+"|"+param.get("uciCode").toString()+"|"+param.get("rate")+"|"+param.get("usage").toString()+"|"+param.get("price").toString()+"|"+param.get("calDate").toString();						
						//System.out.println(checkPair);
	
					}
				} // for(r) 문
			}
			
			 for(Map<String, Object> codeCur : offlineCal) {
					String payType = "SC9999";
					String id = String.valueOf(codeCur.get("id")).trim();
					String uciCode = String.valueOf(codeCur.get("uciCode")).trim();
					String price = String.valueOf(codeCur.get("price")).trim();
					int fees = 0;
					String rate = String.valueOf(codeCur.get("rate")).trim();
					String regDate = String.valueOf(codeCur.get("calDate")).trim();		
					String usageString = String.valueOf(codeCur.get("usage")).trim();
					int usage = Integer.parseInt(usageString);
					String paramSeqSt = String.valueOf(codeCur.get("paramSeq")).trim();
					int member_seq = Integer.parseInt(paramSeqSt);
					
					Map<String, Object> param = new HashMap<String, Object>();
					param.put("member_seq", member_seq);
					Map<String, String> memberSet = mySql_session.selectOne("Member.selName", param);
					
					String buyerName = String.valueOf(memberSet.get("name")).trim();
					String buyerPhone = String.valueOf(memberSet.get("phone")).trim();
					String resultCode = "0000";
					String resultMsg = "결제성공";
					String paymentMethod = "SC9999";
					String paymentDate = regDate.replace("-", "").replace(":", "").replace(" ","").replace(".0", "");
					Random random = new Random();
					
					String orderNo = id+"_"+regDate.replace("-", "").replace(":", "").replace(" ","").replace(".0", "").substring(0, 8)+(random.nextInt(23 - 10 + 1) + 10)+(random.nextInt(59 - 10 + 1) + 10)+(random.nextInt(59 - 10 + 1) + 10);
					String tid = "dahami_"+regDate.replace("-", "").replace(":", "").replace(" ","").replace(".0", "")+(random.nextInt(100 - 10 + 1) + 10);
					String goodName = buyerName+"("+id+")_"+price+"_구매";
					
					String bankName = "";
					String bankAccount = "";
					
					param.put("id", id);
					param.put("payType", payType);
					param.put("type", 1);
					param.put("uciCode", uciCode);
					param.put("price", price);
					param.put("fees", fees);
					param.put("rate", rate);
					param.put("usage", usage);
					param.put("regDate", regDate);
					
					mySql_session.insert("calculation.insCalculations", param);
					
	
					
					param.put("LGD_BUYER", buyerName);
					param.put("LGD_BUYERID", id);
					param.put("LGD_BUYERPHONE", buyerPhone);
					param.put("LGD_RESPCODE", resultCode);
					param.put("LGD_RESPMSG", resultMsg);
					param.put("LGD_OID", orderNo);
					param.put("LGD_AMOUNT", price);
					param.put("LGD_TID", tid);
					param.put("LGD_PAYTYPE", paymentMethod);
					param.put("LGD_PAYDATE", paymentDate);
					param.put("LGD_PRODUCTINFO", goodName);
					param.put("LGD_FINANCENAME", bankName);
					param.put("LGD_ACCOUNTNUM", bankAccount);
	
					
					mySql_session.insert("payment.insPaymentManageDev", param);
					
					//System.out.println("SELECT seq	FROM paymentManage	WHERE LGD_OID = " + orderNo + " AND LGD_TID = " + tid);
					
					int manageSeq = mySql_session.selectOne("payment.selManageSeq", param);
					param.put("manageSeq", manageSeq);
					
					SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMddHHmmss");
					SimpleDateFormat convertFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date downStart = transFormat.parse(regDate);
					
					Calendar cal = Calendar.getInstance();
					cal.setTime(downStart);
					cal.add(Calendar.DATE, 1);
					Date downEnd = cal.getTime();
					
					param.put("paymentManage_seq", manageSeq);
					param.put("usageList_seq", usage);
					param.put("photo_uciCode", uciCode);
					param.put("price", price);
					param.put("downStart", convertFormat.format(downStart));
					param.put("downEnd", convertFormat.format(downEnd));
					
					mySql_session.insert("payment.insPaymentDetailDev", param);
					
	            }
	        
	        fis.close();
	        if(finFlag == 2)
	        {
	        	//System.out.println("CRACK - SQL EXCEPTION" + e);
				mySql_session.rollback();
				mySql_session.clearCache();
				//logger.info("INSERT FAIL");
				finFlag = 2;
	        }
	        else {
	        	 try {
	 				mySql_session.flushStatements();
	 				mySql_session.commit();
	 				//logger.info("INSERT END");
	 				finFlag = 1;
	 			} catch (Exception e) {
	 				//System.out.println("CRACK - SQL EXCEPTION" + e);
	 				mySql_session.rollback();
	 				mySql_session.clearCache();
	 				//logger.info("INSERT FAIL");
	 				finFlag = 2;
	 			}
	        }
	       
	       
	        //return finFlag;
		}catch(Exception e) {
			finFlag = 2;
			//logger.warn("",e);
			System.out.println(e);     
		}finally{
			mySql_session.close();
			
			File fileExistCheck = new File(excelPath);
			if(fileExistCheck.exists()){
				fileExistCheck.delete();
				System.out.println("서버 임시파일 삭제 완료");
			}else {
            	System.out.println("서버 임시파일 삭제 실패");
            }
			
			if(finFlag == 1)
			{
				return "SUCCESS";
			}
			else {
				return "FAIL";
			}
			
		}
	}
	
	public int totalRows(XSSFSheet sheet) { // 빈 행 존재여부를 체크
		int totalRow = 0;
		int lastRowNum = sheet.getPhysicalNumberOfRows();
		XSSFRow row;
		
		for (int r = 0; r < lastRowNum; r++) {
			row = sheet.getRow(r);
			if(!isRowEmpty(row)) {
				totalRow += 1;
			}
		}
		
		return totalRow;
	}
	
	public static boolean isRowEmpty(XSSFRow row) {
	    for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
	        Cell cell = row.getCell(c);
	        if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)
	            return false;
	    }
	    return true;
	}
}
