package com.dahami.newsbank.web.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.dahami.common.util.FileUtil;
import com.dahami.common.util.HttpUpDownUtil;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.DownloadService;
import com.dahami.newsbank.web.servlet.NewsbankServletBase;
import com.google.gson.JsonObject;

public class ExcelUtil {
	
	private static final String PATH_TEMP_EXCEL_UPLOAD = "/data/newsbank/serviceTemp/excel"; // 서버 Excel 파일 임시저장경로
	
	static {
		FileUtil.makeDirectory(PATH_TEMP_EXCEL_UPLOAD);
	}
	
	 public static void xlsWiter(HttpServletRequest request, HttpServletResponse response, List<String> headList, List<Integer> columnSize, List<String> columnList, List<Map<String, Object>> mapList, String orgFileName) {
		// 워크북 생성
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 워크시트 생성
        HSSFSheet sheet = workbook.createSheet();
        // 행 생성
        HSSFRow row = sheet.createRow(0);
        // 쎌 생성
        HSSFCell cell;

        // 헤더 정보 구성
        for(int idx=0; idx<headList.size(); idx++) {
        	// 전달된 컬럼 갯수만큼 생성
        	int width = columnSize.get(idx); // 전달받은 컬럼 길이
        	sheet.setColumnWidth(idx, width*256);        	
        	
        	String cellName = headList.get(idx); // 헤더 셀 이름
        	cell = row.createCell(idx);
        	cell.setCellValue(cellName);
        }

	     // 리스트의 size 만큼 row를 생성
	    for(int rowIdx=0; rowIdx < mapList.size(); rowIdx++) {
	    	Map<String, Object> obj = mapList.get(rowIdx);
	    	
	    	// 행 생성
	        row = sheet.createRow(rowIdx+1);
	        
	        // 셀 넣기
	        for(int num=0; num<columnList.size(); num++) {
	        	String key = columnList.get(num); // 컬럼명
	        	String value = ""; // 컬럼명에 대한 값
	        	if(mapList.get(rowIdx).get(key) != null) {
	        		value = mapList.get(rowIdx).get(key).toString();
	        	}
	        	//System.out.println(key+ " / " + value);
	        	cell = row.createCell(num) ;
	        	cell.setCellValue(value);
	    	}
	    }
	    
	    // 입력된 내용 파일로 쓰기
	    orgFileName = orgFileName + ".xls";
	    File file = new File(PATH_TEMP_EXCEL_UPLOAD + "/" + orgFileName);
        FileOutputStream fos = null;
        
        String fileName = orgFileName; // 파일 이름
        String filePath = PATH_TEMP_EXCEL_UPLOAD; // 임시저장 파일 경로
        String deleteFileFullPath = filePath + "/" + fileName; // 삭제할 임시저장 파일경로
        
        try {
            fos = new FileOutputStream(file);
            workbook.write(fos);
            HttpUpDownUtil.fileDownload(request, response, orgFileName, fileName, filePath);
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
            try {
                if(workbook!=null) workbook.close();
                if(fos!=null) fos.close();
                
                File fileExistCheck = new File(deleteFileFullPath);
    			if(fileExistCheck.exists()){
    				fileExistCheck.delete();
    				System.out.println("서버 임시파일 삭제 완료");
    			}else {
                	System.out.println("서버 임시파일 삭제 실패");
                }
                
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

	 }
	 
	 public static void xlsxWiter(HttpServletRequest request, HttpServletResponse response, List<String> headList, List<Integer> columnSize, List<String> columnList, List<Map<String, Object>> mapList, String orgFileName) {
		// 워크북 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        // 워크시트 생성
        XSSFSheet sheet = workbook.createSheet();
        // 행 생성
        XSSFRow row = sheet.createRow(0);
        // 쎌 생성
        XSSFCell cell;
        // 쎌 스타일
        XSSFCellStyle style = workbook.createCellStyle();
        style.setWrapText(true); // 자동 줄바꿈
	        
        // 헤더 정보 구성
        for(int idx=0; idx<headList.size(); idx++) {
        	// 전달된 컬럼 갯수만큼 생성
        	int width = columnSize.get(idx); // 전달받은 컬럼 길이
        	sheet.setColumnWidth(idx, width*256);        	
        	
        	String cellName = headList.get(idx); // 헤더 셀 이름
        	cell = row.createCell(idx);
        	cell.setCellStyle(style);
        	cell.setCellValue(cellName);
        	
        }

	     // 리스트의 size 만큼 row를 생성
	    for(int rowIdx=0; rowIdx < mapList.size(); rowIdx++) {
	    	Map<String, Object> obj = mapList.get(rowIdx);
	    	
	    	// 행 생성
	        row = sheet.createRow(rowIdx+1);
	        
	        // 셀 넣기
	        for(int num=0; num<columnList.size(); num++) {
	        	String key = columnList.get(num); // 컬럼명
	        	String value = ""; // 컬럼명에 대한 값
	        	if(mapList.get(rowIdx).get(key) != null) {
	        		value = mapList.get(rowIdx).get(key).toString();
	        	}
	        	cell = row.createCell(num) ;
	        	cell.setCellStyle(style);
	        	cell.setCellValue(value);
	    	}
	    }
	    
	    // 입력된 내용 파일로 쓰기
	    orgFileName = orgFileName + ".xlsx";
	    File file = new File(PATH_TEMP_EXCEL_UPLOAD + "/" + orgFileName);
        FileOutputStream fos = null;
        
        String fileName = orgFileName; // 파일 이름
        String filePath = PATH_TEMP_EXCEL_UPLOAD; // 임시저장 파일 경로
        String deleteFileFullPath = filePath + "/" + fileName; // 삭제할 임시저장 파일경로
        
        try {
            fos = new FileOutputStream(file);
            workbook.write(fos);
            HttpUpDownUtil.fileDownload(request, response, orgFileName, fileName, filePath);
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
            try {
                if(workbook!=null) workbook.close();
                if(fos!=null) fos.close();
                
                File fileExistCheck = new File(deleteFileFullPath);
    			if(fileExistCheck.exists()){
    				fileExistCheck.delete();
    				System.out.println("서버 임시파일 삭제 완료");
    			}else {
                	System.out.println("서버 임시파일 삭제 실패");
                }
                
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

	 }
	 
	 // 정산관리 (온라인/오프라인 판매대금 정산내역 JSONArray로 전달
	 public static void xlsxWiterJSONParsing(HttpServletRequest request, HttpServletResponse response, JSONArray jArray, String orgFileName) {
		// 워크북 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        // 워크시트 생성
        XSSFSheet sheet = workbook.createSheet();
        // 행 위치(인덱스)
        int rowIndex = 0;
        // 행 생성
        XSSFRow row = sheet.createRow(rowIndex);
        // 쎌 생성
        XSSFCell cell;        
        // 쎌 스타일
        XSSFCellStyle style = workbook.createCellStyle();
        style.setWrapText(true); // 자동 줄바꿈
        
        
	 	JSONParser jsonParser = new JSONParser();
		
	 	try {
	 		JSONArray jsonArray = (JSONArray) jsonParser.parse(jArray.toJSONString());
	 		
			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArray.get(i);
				
				
				String strHeadList = jsonObj.get("headList").toString();
				String strcolumnSize = jsonObj.get("columnSize").toString();
				String strcolumnList = jsonObj.get("columnList").toString();
				String strBody = jsonObj.get("body").toString();
				
				List<String> headerList = Arrays.asList(strHeadList.substring(1,  strHeadList.length()-1).split(","));
				List<String> columnSizeStrList = Arrays.asList(strcolumnSize.substring(1,  strcolumnSize.length()-1).split(","));
				List<String> columnList = Arrays.asList(strcolumnList.substring(1,  strcolumnList.length()-1).split(","));
				List<String> bodyList = Arrays.asList(strBody.substring(1,  strBody.length()-1).split(","));
				List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
				JSONArray jsonBodyArray = (JSONArray) jsonParser.parse(bodyList.toString());
				
				// 온라인, 오프라인 라인 구분
				if(i != 0) {
					rowIndex = rowIndex + 4;
					row = sheet.createRow(rowIndex);
				}
				
				// 헤더 정보 구성
	            for(int idx=0; idx<headerList.size(); idx++) {
	            	// 전달된 컬럼 갯수만큼 생성            
	            	int width = Integer.parseInt(columnSizeStrList.get(i)); // 전달받은 컬럼 길이
	            	sheet.setColumnWidth(idx, width*256);        	
	            		            	
	            	String cellName = headerList.get(idx).replace("\"", ""); // 헤더 셀 이름
	            	cell = row.createCell(idx);
	            	cell.setCellStyle(style);
	            	cell.setCellValue(cellName); 
	            }
	            
	            // 테이블 데이터 구성
	            for(int bodyIdx=0; bodyIdx<jsonBodyArray.size(); bodyIdx++) {
					JSONObject bodyObject = (JSONObject) jsonBodyArray.get(bodyIdx);
					
					row = sheet.createRow(rowIndex + 1);
					rowIndex++;
					
			        // 셀 넣기
			        for(int num=0; num<columnList.size(); num++) {
			        	String key = columnList.get(num).replace("\"", ""); // 컬럼명
			        	String value = ""; // 컬럼명에 대한 값
			        	
			        	if(bodyObject.get(key) != null) {
			        		value = bodyObject.get(key).toString();
			        	}
			        	cell = row.createCell(num) ;
			        	cell.setCellStyle(style);
			        	cell.setCellValue(value);
			    	}			        
				}
			}
			
			// 입력된 내용 파일로 쓰기
    	    orgFileName = orgFileName + ".xlsx";
    	    File file = new File(PATH_TEMP_EXCEL_UPLOAD + "/" + orgFileName);
            FileOutputStream fos = null;
            
            String fileName = orgFileName; // 파일 이름
            String filePath = PATH_TEMP_EXCEL_UPLOAD; // 임시저장 파일 경로
            String deleteFileFullPath = filePath + "/" + fileName; // 삭제할 임시저장 파일경로
            
            try {
                fos = new FileOutputStream(file);
                workbook.write(fos);
                HttpUpDownUtil.fileDownload(request, response, orgFileName, fileName, filePath);
                
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (Exception e) {
    			e.printStackTrace();
    		} finally {
                try {
                    if(workbook!=null) workbook.close();
                    if(fos!=null) fos.close();
                    
                    File fileExistCheck = new File(deleteFileFullPath);
        			if(fileExistCheck.exists()){
        				fileExistCheck.delete();
        				System.out.println("서버 임시파일 삭제 완료");
        			}else {
                    	System.out.println("서버 임시파일 삭제 실패");
                    }
                    
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 }
}
