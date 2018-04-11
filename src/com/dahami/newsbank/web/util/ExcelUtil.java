package com.dahami.newsbank.web.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.dahami.common.util.HttpUpDownUtil;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.DownloadService;
import com.dahami.newsbank.web.servlet.NewsbankServletBase;

public class ExcelUtil {

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
        	//sheet.autoSizeColumn(idx);
        	//sheet.setColumnWidth(idx, (sheet.getColumnWidth(idx))+(short)1024);
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
	    File file = new File("/data/newsbank/serviceTemp/excel/" + orgFileName);
        FileOutputStream fos = null;
        
        String fileName = orgFileName; // 파일 이름
        String filePath = "/data/newsbank/serviceTemp/excel/"; // 임시저장 파일 경로
        String deleteFileFullPath = filePath + fileName; // 삭제할 임시저장 파일경로
        
        try {
            fos = new FileOutputStream(file);
            workbook.write(fos);
            HttpUpDownUtil.fileDownload(request, response, orgFileName, fileName, filePath);
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
			// TODO Auto-generated catch block
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
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

	 }
	 
	 public void xlsxWiter(List<String> headList, List<String> sizeList, String title, String fileName) {
		// 워크북 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        // 워크시트 생성
        XSSFSheet sheet = workbook.createSheet();
        // 행 생성
        XSSFRow row = sheet.createRow(0);
        // 쎌 생성
        XSSFCell cell;
	        
        

	 }


}
