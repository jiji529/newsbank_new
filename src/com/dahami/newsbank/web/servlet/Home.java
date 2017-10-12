package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.dahami.common.mybatis.MybatisSessionFactory;
import com.dahami.common.mybatis.impl.MybatisService;

@WebServlet(urlPatterns = { "/home", "*.home" }, loadOnStartup = 1)
public class Home extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	protected static MybatisSessionFactory HomeFactory;
	static {

		String confBase = "com/dahami/newsbank/web/dao/mybatis/conf";
		MybatisService mybatis = new MybatisService(confBase);
		mybatis.activate();
		HomeFactory = mybatis.getMybatisServiceSessionFactory(Home.class, "service");
	}

	/**
	 * Default constructor.
	 */
	public Home() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		if (closed) {
			return;
		}

		List<Map<String, Object>> ret = mainHttp();
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String[] arr = { "테스트1", "테스트2", "테스트3" };
		request.setAttribute("test", ret);
		response.getWriter().append("Served at: ").append(request.getContextPath());

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private List<Map<String, Object>> mainHttp() {
		List<Map<String, Object>> ret = new ArrayList<>();

		SqlSession session = null;
		try {
			session = HomeFactory.getSession();
			List<Map<String, Object>> outputs = session.selectList("Home.selectSample");
			System.out.println(outputs.size());
			for (Map<String, Object> map : outputs) {
				ret.add(map);
			}

		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}

		return ret;
	}

}
