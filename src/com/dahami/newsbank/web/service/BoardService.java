package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class BoardService extends ServiceBase {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		BoardDAO boardDAO = new BoardDAO();
			
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
		
		String title = request.getParameter("title"); // 제목
		String description = request.getParameter("description"); // 내용
		String fileName = request.getParameter("fileName"); // 첨부파일 이름
		
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setTitle(title);
		boardDTO.setDescription(description);
		boardDTO.setFileName(fileName);
		
		// action 파라미터 값에 따른 동작
		if(action.equals("insertNotice")) { // 추가
			
			int seq = boardDAO.insertNotice(boardDTO);
			System.out.println("seq : " + seq);
		}else if(action.equals("updateNotice")) { // 수정
			
			int seq = Integer.parseInt(request.getParameter("seq")); // 공지사항 고유번호
			boardDTO.setSeq(seq);
			boardDAO.updateNotice(boardDTO);
			
		} else if(action.equals("deleteNotice")) { // 삭제
			
			int seq = Integer.parseInt(request.getParameter("seq")); // 공지사항 고유번호
			boardDTO.setSeq(seq);
			boardDAO.deleteNotice(boardDTO);
		} else { // 목록
			
			List<BoardDTO> boardList = boardDAO.noticeList(keyword);
			request.setAttribute("boardList", boardList);
		}
		
	}

}
