<%@ page import="com.bea.portal.model.SkinIdentifier"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>

<%
    String imagesPath  = null;
    String cssFile     = null;
    String jsFile      = null;

    // Scope SkinId locally to avoid any conflicts with parent JSP
    {
        SkinIdentifier skinId   = PortalRenderHelper.getSelectedSkin( request);

        imagesPath  = "/framework/skins/" + skinId.getName() + "/images/";
        cssFile     = "/framework/skins/" + skinId.getName() + "/css/main.css";
        jsFile      = "/framework/tools/js/";
    }
%>
