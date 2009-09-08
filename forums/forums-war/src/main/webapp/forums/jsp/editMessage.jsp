<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", -1); //prevents caching at the proxy server
%>
<%@ include file="checkForums.jsp"%>
<%@ include file="forumsListManager.jsp"%>
<%!
public void listFolders(JspWriter out, String userId, boolean admin, int rootId, int parentId,
        String indent, ResourceLocator resource, ForumsSessionController fsc)
    throws ForumsException
{
    try
    {
        int[] sonsIds = fsc.getForumSonsIds(rootId);
        int sonId;
        Forum sonForum;
        for (int i = 0; i < sonsIds.length; i++)
        {
        	sonId = sonsIds[i];
        	sonForum = fsc.getForum(sonId);
            if (admin || fsc.isModerator(userId, sonForum.getId()))
            {
                out.print("<option value=\"");
                out.print(sonForum.getId());
                out.print("\">");
                out.print(indent + sonForum.getName());
                out.println("</option>");
            }
            listFolders(out, userId, admin, sonId, parentId, indent + "-", resource, fsc);
        }
    }
    catch (IOException ioe)
    {
        SilverTrace.info("forums", "JSPeditMessage.listFolders()", "root.EX_NO_MESSAGE", null, ioe);
    }
}
%>
<%
    boolean isModerator = false;
    boolean reply = false;
    boolean move = false;
    boolean allowMessagesInRoot = false;
    
    int reqForum = getIntParameter(request, "forumId", 0);
    String call = request.getParameter("call");
    String backURL = ActionUrl.getUrl(call, -1, reqForum);
    
    int params = getIntParameter(request, "params");
    int action = getIntParameter(request, "action", 1);
    
    int folderId = 0;
    int parentId = 0;
    int forumId = 0;
    int messageId = 0;
    try
    {
        switch (action)
        {
            case 1 :
            	folderId = params;
                forumId = reqForum;
                reply = false;
                break;
                
            case 2 :
            	parentId = params;
                reply = true;
                break;
                
            case 3 :
            	forumId = reqForum;
                messageId = params;
                move = true;
                break;
        }
    } 
    catch (NumberFormatException nfe)
    {
        SilverTrace.warn(
            "forums", "JSPeditMessage", "forums.EXE_PARSE_INT_FAILED", "params = "+params, nfe);
    }

    String parentTitle = "";
    if (reply)
    {
        Message parentMessage = fsc.getMessage(parentId);
        parentTitle = Encode.javaStringToHtmlString(parentMessage.getTitle());
        folderId = parentMessage.getForumId();
    }

    String folderName = Encode.javaStringToHtmlString(
        fsc.getForumName(folderId > 0 ? folderId : forumId));
    
    String configFile = null;
    if (!move)
    {
        ResourceLocator settings = fsc.getSettings();
        configFile = SilverpeasSettings.readString(settings, "configFile",
            URLManager.getApplicationURL() + "/wysiwyg/jsp/javaScript/myconfig.js");
    }
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><%
    
    out.println(graphicFactory.getLookStyleSheet());
%>
    <script type="text/javascript" src="<%=context%>/util/javaScript/checkForm.js"></script>
    <script type="text/javascript" src="<%=context%>/forums/jsp/javaScript/forums.js"></script>
    <script type="text/javascript" src="<%=context%>/wysiwyg/jsp/FCKeditor/fckeditor.js"></script>
    <script type="text/javascript"><%
    
    if (move) {
%>
        function validateMessage()
        {
            document.forms["forumsForm"].submit();
        }<%
        
    } else {
%>
        var oFCKeditor = null;
        
        function init()
        {
            oFCKeditor = new FCKeditor("messageText");
            oFCKeditor.Width = "500";
            oFCKeditor.Height = "300";
            oFCKeditor.BasePath = "<%=URLManager.getApplicationURL()%>/wysiwyg/jsp/FCKeditor/";
            oFCKeditor.DisplayErrors = true;
            oFCKeditor.Config["AutoDetectLanguage"] = false;
            oFCKeditor.Config["DefaultLanguage"] = "<%=fsc.getLanguage()%>";
            oFCKeditor.Config["CustomConfigurationsPath"] = "<%=configFile%>";
            oFCKeditor.ToolbarSet = "quickinfo";
            oFCKeditor.Config["ToolbarStartExpanded"] = true;
            oFCKeditor.ReplaceTextarea();
            document.forms["forumsForm"].elements["messageTitle"].focus();
        }

        function validateMessage()
        {
            if (document.forms["forumsForm"].elements["messageTitle"].value == "")
            {
                alert('<%=resource.getString("emptyMessageTitle")%>');
            }
            else if (!isTextFilled())
            {
                alert('<%=resource.getString("emptyMessageText")%>');
            }
            else
            {
                document.forms["forumsForm"].submit();
            }
        }<%
        
    }
%>
    </script>
</head>

<body marginheight="5" marginwidth="5" bgcolor="#FFFFFF" leftmargin="5" topmargin="5" <%addBodyOnload(out, fsc, (move ? "" : "init();"));%>>
<% 
    Window window = graphicFactory.getWindow();

    BrowseBar browseBar = window.getBrowseBar();
    browseBar.setDomainName(fsc.getSpaceLabel());
    browseBar.setComponentName(fsc.getComponentLabel(), ActionUrl.getUrl("main"));
    browseBar.setPath(navigationBar(forumId, resource, fsc));

    out.println(window.printBefore());
    Frame frame=graphicFactory.getFrame();
    out.println(frame.printBefore());

    String formAction = ActionUrl.getUrl(
    	(reqForum > 0 ? "viewForum" : "main"), (move ? 12 : 8), (reqForum > 0 ? reqForum : -1));
%>
    <center>
        <table class="intfdcolor4" border="0" cellpadding="0" cellspacing="0" width="98%">
        <form name="forumsForm" action="<%=formAction%>" method="post">
            <tr align="center">
                <td valign="top" align="center"><%
    
    if (move)
    {
        String messageTitle = fsc.getMessageTitle(messageId);%>


                    <input type="hidden" name="messageId" value="<%=messageId%>">
                    <table border="0" cellspacing="0" cellpadding="5" width="100%" class="contourintfdcolor" align="center">
                        <tr align="center">
                            <td class="intfdcolor4" align="left"><span class="txttitrecol"><%=resource.getString("forum")%>
                                :&nbsp;</span><span class="txtnote"><%=folderName%></span></td>
                        </tr>
                        <tr align="center">
                            <td align="left"><span class="txttitrecol"><%=resource.getString("message")%>
                                :&nbsp;</span><span class="txtnote"><%=messageTitle%></span></td>
                        </tr>
                        <tr align="center">
                            <td align="left"><span class="selectNS">
                                <select name="messageNewFolder">
                                    <option selected value="<%=reqForum%>"><%=resource.getString("selectMessageFolder")%></option>
                                    <option value="<%=reqForum%>">---------------------------------------------------------</option><%

        if (isAdmin && allowMessagesInRoot)
        {
%>
                                    <option <%if (parentId == 0) {%>selected <%}%>value="0"><%=resource.getString("racine")%></option><%

        }
        listFolders(out, userId, isAdmin, 0, reqForum, "", resource, fsc);
%>
                                </select></span>
                            </td>
                        </tr>
                    </table><%

    }
    else
    {
%>
                    <input type="hidden" name="forumId" value="<%=String.valueOf(folderId)%>"><%
                                    
        if (reply)
        {
%>
                    <input type="hidden" name="parentId" value="<%=parentId%>"><%

        }
%>
                                
                    <table border="0" cellspacing="0" cellpadding="5" class="contourintfdcolor" width="100%">
                        <tr>
                            <td valign="top"><span class="txtlibform"><%=resource.getString("messageTitle")%> :</span></td>
                            <td valign="top"><input type="text" name="messageTitle" size="88" maxlength="<%=DBUtil.TextFieldLength%>"></td>
                        </tr>
                        <tr>
                            <td valign="top"><span class="txtlibform"><%=resource.getString("messageText")%> : </span></td>
                            <td valign="top"><font size=1><textarea name="messageText" id="messageText"></textarea></font></td>
                        </tr>
                        <tr>
                            <td valign="top"><span class="txtlibform"><%=resource.getString("forumKeywords")%> : </span></td>
                            <td valign="top"><input type="text" name="forumKeywords" size="50" value=""/></td>
                        </tr>
                        <tr>
                            <td valign="top"><span class="txtlibform"><%=resource.getString("subscribeMessage")%> :</span></td>
                            <td valign="top"><input type="checkbox" name="subscribeMessage"></td>
                        </tr>
                    </table><%

    }
%>
                </td>
            </tr>
        </form>
        </table>
    </center><%

    out.println(frame.printMiddle());
%>
    <br>
    <center><%

    ButtonPane buttonPane = graphicFactory.getButtonPane();
    buttonPane.addButton(graphicFactory.getFormButton(
        resource.getString("valider"), "javascript:validateMessage();", false));
    buttonPane.addButton(graphicFactory.getFormButton(
        resource.getString("annuler"), backURL, false));
    buttonPane.setHorizontalPosition();
    out.println(buttonPane.print());
%>
    </center>
    <br><%

    out.println(frame.printAfter());
    out.println(window.printAfter());
%>
</body>
</html>