package com.arch.webcontroller;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.arch.event.*;
import com.arch.exception.WebException;
import com.arch.util.*;
import com.arch.initfunmapping.*;
import java.util.HashMap;
import java.util.List;

import com.arch.basebean.*;



public class MainServlet extends HttpServlet {

	private ActionMapping actionMappings;
	private ViewMapping viewMappings;

	private RequestProcessor processor = null;


	/**
	 *处理get请求
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		doProcess(request, response);
	}

	/**
	 * 处理post请求
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		doProcess(request, response);
	}

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		doProcess(request, response);
	}

	/**
	 *初始化Servlet
	 */
	public void init() throws ServletException {
		//String xmlpath = this.getServletContext().getRealPath("/").replace(
			//	"\\", "/")
			//	+ "xml/";
		//initXmldoc(xmlpath);
		SysConst.trace("*****************System init begin*****************");
		String actionmappingsrc = this.getInitParameter("actionmappingsrc");
		SysConst.trace(this.getServletContext().getRealPath("").replace("\\",
				"/"));
		SysConst.FUNCTION_FILE_NAME = this.getServletContext().getRealPath("")
				.replace("\\", "/")
				+ SysConst.FUNCTION_FILE_NAME;
		initActionMappings(actionmappingsrc);
		initViewMappings();
		if (ControllerExtendClass.initDataBaseConnection()) {
			initRequestProcessor();
		} else {
			SysConst
					.trace("!!!!!Not complete the system inition work.Can not start server.Please check the reason.");
		}
		SysConst.trace("*****************System init end*****************");
	}

	private void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		long inTime = 0;
		if (SysConst.PERFERMANCE_FLAG) {
			inTime = System.currentTimeMillis();
			SysConst.trace("------------- System and request information: ");
			SysConst.trace("Time Start = "
					+ new java.util.Date(inTime).toString());
		}
		EventResponse eventResponse = null;

		SysConst.trace("Struct path:"
				+ request.getAttribute(SysConst.GLOBE_FLAG));

			eventResponse = processor.processRequest(request, response);

			// 进行ViewDispatch
			processResponse(request, response, eventResponse);

			if (SysConst.PERFERMANCE_FLAG) {
				long outTime = System.currentTimeMillis();
				SysConst.trace("Time end= "
						+ new java.util.Date(outTime).toString()
						+ " Interval = " + (outTime - inTime));
			}
			if (!(eventResponse.getFunctionID().equals(SysConst.LOGIN_FID))) {
				for (int i = 0; i < eventResponse.getOperationlength(); i++) {
					if (((OracleRowSet[]) ((HashMap) eventResponse.getBody())
							.get("operation" + (i + 1))) != null) {
						for (int j = 0; j < ((OracleRowSet[]) ((HashMap) eventResponse
								.getBody()).get("operation" + (i + 1))).length; j++) {
							((OracleRowSet[]) ((HashMap) eventResponse
									.getBody()).get("operation" + (i + 1)))[j] = null;
						}
					}
				}
				// ((HashMap)eventResponse.getBody()).clear();
			}
			eventResponse = null;
		
		SysConst
				.trace("*****************Bussiness Process end*****************");
	}

	private void processResponse(HttpServletRequest request,
			HttpServletResponse response, EventResponse result)
			throws IOException, ServletException {
		request.setAttribute("result", result);
		this.getServletContext().getRequestDispatcher("/viewdispatchservlet")
				.forward(request, response);
	}

	// 初始化RequestProcessor
	private void initRequestProcessor() {
		processor = new RequestProcessor();
		processor.init(getServletContext(), getServletConfig());
	}

	private void initXmldoc(String srcpath) {
		HashMap xmldocMappings = new HashMap();
		try {
			SAXBuilder builder = new SAXBuilder();
			Document xmlDoc = null;

			File theFile = new File(srcpath);
			File allFiles[] = theFile.listFiles();
			Element contentXml = null;
			List handleListXml = null;
			Element handleXml = null;
			for (int i = 0; i < allFiles.length; i++) {
				try {
					xmlDoc = builder.build(allFiles[i]);

					// /验证：对引用的模版文件路径进行验证
					if (xmlDoc.getDocType() == null) {
						throw new WebException("错误代码：s000004");
					}
					String systemId = xmlDoc.getDocType().getSystemID();
					// /验证：对引用的模版文件路径进行验证
					if (systemId == null) {
						throw new WebException("错误代码：s000005");
					}
					// /验证：对引用的模版文件路径进行验证
					if (!systemId.startsWith("..\\")) {
						throw new WebException("错误代码：s000006");
					}
					contentXml = xmlDoc.getRootElement();
					handleListXml = contentXml.getChildren();

					// 定位到要找的UID上,即定位到唯一的Handle项
					for (int j = 0; j < handleListXml.size(); j++) {
						handleXml = (Element) handleListXml.get(j);
						xmldocMappings
								.put(allFiles[i].getName() + "@"
										+ handleXml.getAttributeValue("UID"),
										handleXml);
					}
				} catch (Exception e) {
					e.getMessage();
				}
			}
		} catch (NullPointerException npe) {

		}

		getServletContext().setAttribute(SysConst.Xmldoc, xmldocMappings);
	}

	private void initActionMappings(String actionmappingsrc) {
		ActionMappingDAO dao = ActionMappingDAOFactory.getDAO();
		actionMappings = dao.getActionMapping(actionmappingsrc);
		getServletContext().setAttribute(SysConst.ACTION_MAPPINGS,
				actionMappings);
	}

	private void initViewMappings() {
		ViewMappingDAO dao = ViewMappingDAOFactory.getDAO();
		viewMappings = dao.getViewMapping();
		getServletContext().setAttribute(SysConst.VIEW_MAPPINGS, viewMappings);

	}

}
