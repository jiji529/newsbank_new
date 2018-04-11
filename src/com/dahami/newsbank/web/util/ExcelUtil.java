package com.dahami.newsbank.web.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

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

	 public static void xlsWiter(HttpServletRequest request, HttpServletResponse response, List<MemberDTO> list, String orgFileName) {
		// 워크북 생성
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 워크시트 생성
        HSSFSheet sheet = workbook.createSheet();
        // 행 생성
        HSSFRow row = sheet.createRow(0);
        // 쎌 생성
        HSSFCell cell;

        // 헤더 정보 구성
        cell = row.createCell(0);
        cell.setCellValue("아이디");
        
        cell = row.createCell(1);
        cell.setCellValue("회사명");
        
        cell = row.createCell(2);
        cell.setCellValue("회원구분");
        
        cell = row.createCell(3);
        cell.setCellValue("이름");
        
        cell = row.createCell(4);
        cell.setCellValue("이메일");
        
        cell = row.createCell(5);
        cell.setCellValue("연락처");
        
        cell = row.createCell(6);
        cell.setCellValue("결제구분");
        
        cell = row.createCell(7);
        cell.setCellValue("그룹구분");
        
        cell = row.createCell(8);
        cell.setCellValue("계약기간");
        
        cell = row.createCell(9);
        cell.setCellValue("가입일자");

	     // 리스트의 size 만큼 row를 생성
	    MemberDTO memberDTO;
	    for(int rowIdx=0; rowIdx < list.size(); rowIdx++) {
	        memberDTO = list.get(rowIdx);
	        
	        // 행 생성
	        row = sheet.createRow(rowIdx+1);
	        
	        cell = row.createCell(0);
	        cell.setCellValue(memberDTO.getId());
	        
	        cell = row.createCell(1);
	        cell.setCellValue(memberDTO.getCompName());
	        
	        cell = row.createCell(2);
	        cell.setCellValue(memberDTO.getType());
	        
	        cell = row.createCell(3);
	        cell.setCellValue(memberDTO.getName());
	        
	        cell = row.createCell(4);
	        cell.setCellValue(memberDTO.getEmail());
	        
	        cell = row.createCell(5);
	        cell.setCellValue(memberDTO.getPhone());
	        
	        cell = row.createCell(6);
	        cell.setCellValue(memberDTO.getDeferred());
	        
	        cell = row.createCell(7);
	        cell.setCellValue(memberDTO.getGroupName());
	        
	        cell = row.createCell(8);
	        cell.setCellValue(memberDTO.getContractStart() + " ~ " + memberDTO.getContractEnd());
	        
	        cell = row.createCell(9);
	        cell.setCellValue(memberDTO.getRegDate());
	        
	    }
	    
	 // 입력된 내용 파일로 쓰기
	    File file = new File("/data/newsbank/serviceTemp/excel/회원현황.xls");
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
	 
	 public void xlsxWiter(List<String> columnList, List<String> sizeList, String title, String fileName) {
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
