<%--

    Copyright (C) 2000 - 2011 Silverpeas

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    As a special exception to the terms and conditions of version 3.0 of
    the GPL, you may redistribute this Program in connection with Free/Libre
    Open Source Software ("FLOSS") applications as described in Silverpeas's
    FLOSS exception.  You should have recieved a copy of the text describing
    the FLOSS exception, and it is also available here:
    "http://repository.silverpeas.com/legal/licensing"

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="check.jsp" %>

<% 
// récupération des paramètres
Collection	posts		= (Collection) request.getAttribute("Posts");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%
	out.println(gef.getLookStyleSheet());
%>
<script type="text/javascript" src="<%=m_context%>/util/javaScript/animation.js"></script>
<script type="text/javascript">

function goToPost(id) {
    document.postForm.PostId.value = id;
    document.postForm.submit();
}

function goToCategory(id) {
    document.categoryForm.CategoryId.value = id;
    document.categoryForm.submit();
}

</script>
</head>

<body id="blog">
<div id="<%=instanceId %>">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="blog">
  	<tr>
  		<td colspan="3">&nbsp;</td>
	</tr>
  	<tr>
    	<td valign="top" class="colonneGauche">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		      	<%
		      	Iterator it = (Iterator) posts.iterator();
		      	if (!it.hasNext())
		      	{
		      		out.println("&nbsp;");
		      	}
		  		while (it.hasNext()) 
		  		{
		  			PostDetail post = (PostDetail) it.next();
		  			String categoryId = "";
	  				if (post.getCategory() != null)
		  				categoryId = post.getCategory().getNodePK().getId();
		  			String postId = post.getPublication().getPK().getId();
					%>
					<!--Debut d'un ticket-->
				    <tr>
				       	<td>
				       		<a href="javascript:onClick=goToPost('<%=postId%>')" class="titreTicket"><%=post.getPublication().getName()%></a>
				       	</td>
				    </tr>
				    <tr>
				    	<td class="infoTicket"><%=post.getCreatorName()%> - <%=resource.getOutputDate(post.getDateEvent())%></td>
				    </tr>
				    <tr>
				    	<td>&nbsp;</td>
				    </tr>
				    <!-- <tr>
					    <td>
				        <%
				        	out.flush();
			        		getServletConfig().getServletContext().getRequestDispatcher("/wysiwyg/jsp/htmlDisplayer.jsp?ObjectId="+postId+"&ComponentId="+instanceId).include(request, response);
			        	%>
			        	</td>
					</tr>
					<tr>
				    	<td>&nbsp;</td>
				    </tr>-->
				    <tr>
				    	<td>
							<% if (!categoryId.equals(""))
							{  %>
								<a href="javascript:onClick=goToCategory('<%=categoryId%>')" class="versTopic">&gt;&gt; <%=post.getCategory().getName()%> </a>
							<% } %>
							&nbsp;
						</td>
				    </tr>
				    <!--Fin du ticket-->
				    <tr>
				    	<td class="separateur">&nbsp;</td>
				   	</tr>
				    <%
		  		}
		  	 %>
			</table>
		</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
</table>

<form name="postForm" action="ViewPost" method="post" target="MyMain">
	<input type="hidden" name="PostId"/>
</form>
<form name="categoryForm" action="PostByCategory" method="post" target="MyMain">
	<input type="hidden" name="CategoryId"/>
</form>
</div>
</body>

</html>
