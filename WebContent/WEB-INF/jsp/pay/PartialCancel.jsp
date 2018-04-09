<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
    /*
     * [���� �κ���� ��û ������]
     *
     * LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ �κ���� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG���÷������� ���� �������� PAYKEY�� ȥ������ ������.)
     */
    String CST_PLATFORM         	= request.getParameter("CST_PLATFORM");                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              	= request.getParameter("CST_MID");                      //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID              	= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        	//�������̵�(�ڵ�����)
    String LGD_TID              	= request.getParameter("LGD_TID");                      //LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)
    String LGD_CANCELAMOUNT     	= request.getParameter("LGD_CANCELAMOUNT");             //�κ���� �ݾ�
    String LGD_REMAINAMOUNT     	= request.getParameter("LGD_REMAINAMOUNT");             //���� �ݾ�
//    String LGD_CANCELTAXFREEAMOUNT  = request.getParameter("LGD_CANCELTAXFREEAMOUNT");      //�鼼��� �κ���� �ݾ� (����/�鼼 ȥ������� ����)
    String LGD_CANCELREASON     	= request.getParameter("LGD_CANCELREASON"); 		    //��һ���
    String LGD_RFBANKCODE     		= request.getParameter("LGD_RFBANKCODE"); 		    	//ȯ�Ұ��� �����ڵ� (������¸� �ʼ�)
    String LGD_RFACCOUNTNUM     	= request.getParameter("LGD_RFACCOUNTNUM"); 		    //ȯ�Ұ��� ��ȣ (������¸� �ʼ�)
    String LGD_RFCUSTOMERNAME     	= request.getParameter("LGD_RFCUSTOMERNAME"); 		    //ȯ�Ұ��� ������ (������¸� �ʼ�)
    String LGD_RFPHONE     			= request.getParameter("LGD_RFPHONE"); 		    		//��û�� ����ó (������¸� �ʼ�)
     
    String configPath 				= "C:/lgdacom";  										//LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.
    
        
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
     * 1. ���� �κ���� ��û ���ó��
     *
     */
    if (xpay.TX()) {
        //1)���� �κ���Ұ�� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
        out.println("���� �κ���� ��û�� �Ϸ�Ǿ����ϴ�.  <br>");
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
        //2)API ��û ���� ȭ��ó��
        out.println("���� �κ���� ��û�� �����Ͽ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }
%>
