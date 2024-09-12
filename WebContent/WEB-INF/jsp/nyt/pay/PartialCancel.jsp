<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
    /*
     * [결제 부분취소 요청 페이지]
     *
     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 부분취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
     */
    String CST_PLATFORM         	= request.getParameter("CST_PLATFORM");                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
    String CST_MID              	= request.getParameter("CST_MID");                      //LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
    String LGD_MID              	= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
                                                                                        	//상점아이디(자동생성)
    String LGD_TID              	= request.getParameter("LGD_TID");                      //LG유플러스으로 부터 내려받은 거래번호(LGD_TID)
    String LGD_CANCELAMOUNT     	= request.getParameter("LGD_CANCELAMOUNT");             //부분취소 금액
    String LGD_REMAINAMOUNT     	= request.getParameter("LGD_REMAINAMOUNT");             //남은 금액
//    String LGD_CANCELTAXFREEAMOUNT  = request.getParameter("LGD_CANCELTAXFREEAMOUNT");      //면세대상 부분취소 금액 (과세/면세 혼용상점만 적용)
    String LGD_CANCELREASON     	= request.getParameter("LGD_CANCELREASON"); 		    //취소사유
    String LGD_RFBANKCODE     		= request.getParameter("LGD_RFBANKCODE"); 		    	//환불계좌 은행코드 (가상계좌만 필수)
    String LGD_RFACCOUNTNUM     	= request.getParameter("LGD_RFACCOUNTNUM"); 		    //환불계좌 번호 (가상계좌만 필수)
    String LGD_RFCUSTOMERNAME     	= request.getParameter("LGD_RFCUSTOMERNAME"); 		    //환불계좌 예금주 (가상계좌만 필수)
    String LGD_RFPHONE     			= request.getParameter("LGD_RFPHONE"); 		    		//요청자 연락처 (가상계좌만 필수)
     
    String configPath 				= "C:/lgdacom";  										//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
    
        
    LGD_CANCELAMOUNT     			= ( LGD_CANCELAMOUNT == null )?"":LGD_CANCELAMOUNT; 
    LGD_REMAINAMOUNT     			= ( LGD_REMAINAMOUNT == null )?"":LGD_REMAINAMOUNT; 
//    LGD_CANCELTAXFREEAMOUNT     = ( LGD_CANCELTAXFREEAMOUNT == null )?"":LGD_CANCELTAXFREEAMOUNT;
    LGD_CANCELREASON       			= ( LGD_CANCELREASON == null )?"":LGD_CANCELREASON;
    LGD_RFBANKCODE       			= ( LGD_RFBANKCODE == null )?"":LGD_RFBANKCODE;
    LGD_RFACCOUNTNUM       			= ( LGD_RFACCOUNTNUM == null )?"":LGD_RFACCOUNTNUM;
    LGD_RFCUSTOMERNAME       		= ( LGD_RFCUSTOMERNAME == null )?"":LGD_RFCUSTOMERNAME;
    LGD_RFPHONE       				= ( LGD_RFPHONE == null )?"":LGD_RFPHONE;
    
    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
    xpay.Init_TX(LGD_MID);
  	xpay.Set("LGD_TXNAME", "PartialCancel");
    xpay.Set("LGD_TID", LGD_TID);    
    xpay.Set("LGD_CANCELAMOUNT", LGD_CANCELAMOUNT);
    xpay.Set("LGD_REMAINAMOUNT", LGD_REMAINAMOUNT);
//    xpay.Set("LGD_CANCELTAXFREEAMOUNT", LGD_CANCELTAXFREEAMOUNT);
	xpay.Set("LGD_RFBANKCODE", LGD_RFBANKCODE);
    xpay.Set("LGD_RFACCOUNTNUM", LGD_RFACCOUNTNUM);
    xpay.Set("LGD_RFCUSTOMERNAME", LGD_RFCUSTOMERNAME);
    xpay.Set("LGD_RFPHONE", LGD_RFPHONE);
 
    /*
     * 1. 결제 부분취소 요청 결과처리
     *
     */
    if (xpay.TX()) {
        //1)결제 부분취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
        out.println("결제 부분취소 요청이 완료되었습니다.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
        
        for (int i = 0; i < xpay.ResponseNameCount(); i++)
        {
            out.println(xpay.ResponseName(i) + " = ");
            for (int j = 0; j < xpay.ResponseCount(); j++)
            {
                out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
            }
        }
        out.println("<p>");
        
    }else {
        //2)API 요청 실패 화면처리
        out.println("결제 부분취소 요청이 실패하였습니다.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }
%>
