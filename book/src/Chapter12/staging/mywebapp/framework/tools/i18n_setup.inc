<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ page import="com.bea.portal.model.SkinIdentifier"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>

<i18n:localize/>

<%
  String imagesPath = null;
  String cssFile    = null;
  String jsFile     = null;
%>

<%
	if (imagesPath == null)
	{
        SkinIdentifier skinId   = PortalRenderHelper.getSelectedSkin( request);
		imagesPath	= "/framework/skins/" + skinId.getName() + "/images/";
	}
	if (cssFile == null)
	{
        SkinIdentifier skinId   = PortalRenderHelper.getSelectedSkin( request);
		cssFile		= "/framework/skins/" + skinId.getName() + "/css/main.css";
	}
	if (jsFile == null)
	{
		jsFile       = "/framework/tools/js/";
	}
%>