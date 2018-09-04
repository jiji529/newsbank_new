package com.dahami.newsbank.web.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.service.UploadService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUploadUtil;

/**
 * Servlet implementation class UploadExcel
 */
@WebServlet("/upload.excel")
public class UploadExcel extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
	public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    }
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public UploadExcel() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		if(response.isCommitted()) {
			return;
		}
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		request.setAttribute("pathType", cmd.get2());
		
		UploadService us = new UploadService();
		us.execute(request, response);
		
		JSONObject json = new JSONObject();
		String fileFullPath = (String) request.getAttribute("filePath");
		String fileName =  (String) request.getAttribute("fileName");
		if (fileFullPath == null || fileFullPath.isEmpty()) {
			System.out.println("임시 엑셀 파일 업로드 실패");
		} else {
			System.out.println("임시 엑셀 파일 업로드 성공");
		}
		
		ExcelUploadUtil excelUpload = new ExcelUploadUtil();
		String status = excelUpload.excelCalculations(fileFullPath); // 정산관련 엑셀 업로드
		
		json.put("status", status);
		json.put("file", fileName);
		response.setContentType("application/json");
		response.getWriter().print(json);
	}

}
