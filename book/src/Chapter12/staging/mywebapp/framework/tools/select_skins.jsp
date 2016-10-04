<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ page extends="com.bea.portal.jsp.JspBase"%>

<%-- ------------------------------------------------------------ --%>
<%-- page imports                                                 --%>
<%-- ------------------------------------------------------------ --%>
<%@ page import="com.bea.portal.model.SkinDefinition"%>
<%@ page import="com.bea.portal.model.SkinIdentifier"%>
<%@ page import="com.bea.portal.model.PortalIdentifier"%>
<%@ page import="com.bea.portal.manager.internal.InternalFactory"%>
<%@ page import="com.bea.portal.manager.internal.SkinDefinitionImpl"%>
<%@ page import="com.bea.portal.manager.PortalFactory"%>
<%@ page import="com.bea.portal.appflow.PortalAppflowHelper"%>
<%@ page import="com.bea.portal.model.PortalState"%>
<%@ page import="com.bea.portal.appflow.PortalRequest"%>
<%@ page import="com.bea.portal.appflow.PortalSession"%>
<%@ page import="com.bea.portal.appflow.PortalAppflowFactory"%>
<%@ page import="com.bea.portal.model.MutablePortalPersonalization"%>
<%@ page import="com.bea.portal.model.PortalPersonalization"%>
<%@ page import="com.bea.p13n.usermgmt.profile.ProfileIdentity"%>
<%@ page import="com.bea.p13n.usermgmt.profile.ProfileFactory"%>

<%@ page errorPage="/framework/error/error.jsp" %>

<%-- ------------------------------------------------------------ --%>
<%-- taglibs                                                      --%>
<%-- ------------------------------------------------------------ --%>
<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="weblogic.tld" prefix="wl" %>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>
<%@ include file="/framework/tools/i18n_setup.inc"%>

<%-- ------------------------------------------------------------ --%>
<%-- environment setup                                            --%>
<%-- ------------------------------------------------------------ --%>

  <%-- setup variables used in this page --%>
  <wf:getProperty id="portalName" property="portalName" type="String"/>

<%

  String groupPortalGroupId = "groupPortalGroupId";
  String groupPortalName = "groupPortalName";
  int caught = 0;
  String Message = null;

  PortalRequest portalRequest = PortalAppflowFactory.getPortalRequest(request);
  PortalSession portalSession = PortalAppflowFactory.getPortalSession(request);
  PortalState portalState = portalRequest.getPortalState();
  PortalIdentifier portalId = portalState.getPortalIdentifier();

%>

<%-- ------------------------------------------------------------ --%>
<%-- form processing                                              --%>
<%-- ------------------------------------------------------------ --%>

  <!-- If the 'save' button was clicked, go ahead and process the input. -->
  <wl:process name="doUpdate" value="true">

<%
    ServletRequest req = pageContext.getRequest();
    SkinIdentifier skinIdentifier = null;
    SkinDefinition defaultSkin = null;
    String selectedDefaultSkin = req.getParameter("skinId");
    try
    {
        skinIdentifier = (SkinIdentifier)InternalFactory.createSkinIdentifier(portalState.getPortalIdentifier(), selectedDefaultSkin);
        MutablePortalPersonalization mutableP13N = (MutablePortalPersonalization)PortalAppflowHelper.createPortalManager().getMutablePortalPersonalization(portalRequest.getPortalSession().getIdentity(), portalRequest.getPortalContext().getPortalIdentifier());
        mutableP13N.setSelectedSkin(skinIdentifier);      
        PortalAppflowHelper.createPortalManager().setMutablePortalPersonalization(portalRequest.getPortalSession().getIdentity(),(PortalPersonalization)mutableP13N);
    }
    catch (Exception e)
    {
        Message = "<i18n:getMessage messageName='cantSave'/>";
        caught = 1;
    }
    if(caught == 0)
    {
%>
      <SCRIPT LANGUAGE="JavaScript">
        window.location.replace("<wf:createWebflowURL namespace="tools" origin="select_skins.jsp" event="link.back" httpsInd="http"/>");
      </SCRIPT>
<%  }
%>
  </wl:process>

<%
  SkinIdentifier skinId = portalState.getSkin();
  SkinDefinition defaultSkinDef = portalState.getSkin(skinId);

  String defaultSkinName = defaultSkinDef.getDisplayName();
  String defaultSkinId = defaultSkinDef.getIdentifier().getName();
%>
<%-- ------------------------------------------------------------ --%>
<%-- begin rendering                                              --%>
<%-- ------------------------------------------------------------ --%>

<html>
<head>
  <%  // Grab the html title sTRing from the properties file %>
  <i18n:getMessage messageName='pageTitle' id='pageTitle'/>
  <title><%=pageTitle%></title>
  <LINK REL=StyleSheet HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">

  <script language="JavaScript" src="<wf:createResourceURL resource='<%=jsFile+"list_utils.js"%>'/>"></script>

<script language="JavaScript">


function showPreviewThumbnail(selectObject) {

    var val = selectObject.options[selectObject.selectedIndex].value;

    if (val && val != "spacer") {
        var src = "framework/skins/" + val + "/images/preview.gif";
        var img = document.images["previewImage"];

        if (img != null) {
            img.src = src;
        }

    }
}

function setDefaultSkin(selectObjectId) {

    var selectObject = document.forms[0].elements[selectObjectId];
    var val = selectObject.options[selectObject.selectedIndex].value;
    
    if (val && val != "spacer") {
        
        document.forms[0].elements["skinId"].value = val;

        for (var i=0; i<selectObject.options.length; i++) {
            if (selectObject.options[i].text.indexOf("* ") == 0) {
                selectObject.options[i].text = selectObject.options[i].text.substr(2);
            }
    }
    
    var displayName = selectObject.options[selectObject.selectedIndex].text;
        selectObject.options[selectObject.selectedIndex].text =
            "* " + selectObject.options[selectObject.selectedIndex].text;
    }
    
    //Display the default skin's preview
    var src = "framework/skins/" + val + "/images/preview.gif";
    var img = document.images["previewDefault"];
    if (img != null) {
      img.src = src;
    }

    submitForm();
}

function submitForm() {

    var txt = "";
    var selObj = document.forms[0].elements["C1"];

    // skip spacer at end of list
    for (var i=0; i<selObj.options.length-1; i++) {
        txt += selObj.options[i].value;
        if (i < selObj.options.length - 2) {
            txt += "|";
        }
    }

    document.forms[0].elements["selectedSkinIds"].value = txt;

    this.document.forms[0].submit();
    return true;
}

function setDefault()
{
  var skinName = "<%=defaultSkinName%>";
  var skinId = "<%=defaultSkinId%>";
  
  //Put a * by the default skin name in the list
  for (var i=0; i<document.forms[0].C1.options.length; i++) 
  {
    if (document.forms[0].C1.options[i].text.indexOf(skinName) == 0) 
    {
      document.forms[0].C1.options[i].text = "* " + skinName;
    }
  }

  //Display the default skin's preview
  var src = "framework/skins/" + skinId + "/images/preview.gif";
  var img = document.images["previewDefault"];
  if (img != null) {
    img.src = src;
  }
}
</script>

</head>
<BODY onLoad="setDefault();" background="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

  <%@ include file="header.inc"%>
  
  <!-- This outter table has only one row with two data cells, one is used
       as spacer and the other for the main content area -->
  <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">

    <TR>
      <TD align="left" valign="top" width="30px">
        <!-- spacer cell -->
      </TD>
  
      <!-- begin table for main content area -->
      <TD align="left" valign="top">
  
<%
        // Creation of message arguments
        Object[] args = new Object[] { portalName, groupPortalName };
%>
        <span class="pageheader"><i18n:getMessage messageName='portalDisplay'/>   
<%
          if (caught == 1)
          {
%>
            <b> <%=Message %> </b>
<%
          } 
%>
        </span>
        <BR><BR>
        <span class="instructions"><i18n:getMessage messageName='portalDisplaySubHead'/></span>
        <!-- spacer between instructions and select areas -->
        <BR><BR><BR>
        <!-- start Webflow/Pipeline enabled FORM -->
        <wf:form namespace="tools"  event="link.refresh" origin="select_skins.jsp" hide="true" method="post">
  
<%
          // number of labels in category listing header section
          int numberOfLabels = 1;
%>
          <TABLE cellspacing="0" cellpadding="0" border="0" >
            <TR>
              <TD>
                <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                  <TR>
                    <TD class="portletHeading" NOWRAP="nowrap"><i18n:getMessage messageName='selectedItemsLabel'/>
                    </TD>
  				        </TR>
  			        </TABLE>
  		        </TD>
            </TR>	
            <TR>
              <TD colspan="3" >
                <!--SELECTED LIST-->
<%
                ProfileIdentity identity = ProfileFactory.createProfileIdentity(null, portalSession.getIdentity().getGroupname());  
                PortalIdentifier portalIdObj = PortalFactory.createPortalIdentifier(portalId.toString());
        
                // Get this portal's personalization. Note: the  portalRequest.getPortal().getDefaultConfiguration()
                // returns the entire pool of skins for the portal, not the personalized list.
                PortalPersonalization pP13n = (PortalPersonalization)PortalAppflowHelper.createPortalManager().getPortalPersonalization(identity, portalIdObj);
    
                List skinList = pP13n.getSkins();
                StringBuffer selectedNames = new StringBuffer();
                if (skinList != null) 
                {
                  String name = "";
                  String displayName = "";
                  List skins = (List)skinList;
                  for (int i=0; i<skins.size(); i++) 
                  {
                    if (skins.get(i) != null) 
                    {
                      String displayText = ((SkinDefinitionImpl)skins.get(i)).getDisplayName();
    				          String skinIdStr = ((SkinDefinitionImpl)skins.get(i)).getIdentifier().getName();
                      selectedNames.append("<option value=\"" + skinIdStr + "\">" + displayText + "</option>"); 
                      // Type (0=Page/1=PagePersonalization)
                      // Mandatory (M=mandatory/ O=optional) 
%>
                      <input type="hidden" name="<%=displayText+"T"%>" value="1">
                      <input type="hidden" name="<%=displayText+"M"%>" value="0">
<%
                    }
                  }
                }
%>
                <select name="C1" size="13" onChange="processSelectionWPrev(this,this.name, this[selectedIndex].value, this[selectedIndex].text)">
                  <%=selectedNames.toString()%>
                  <option value="spacer">----------------------------------------</option>
                </select>
    
                <!-- HIDDEN ELEMENTS HERE -->
                <input type="hidden" name="selectedListElementIndex" value="">
                <input type="hidden" name="selectedListElementFormName" value="">
                <input type="hidden" name="selectedListElementValue" value="">
                <input type="hidden" name="selectedListElementText" value="">
                <input type="hidden" name="lastSelectedListElementFormName" value="">
                <input type="hidden" name="selectedPageIndex" value="">
                <input type="hidden" name="selectedPageFormName" value="">
                <input type="hidden" name="selectedPageNameValue" value="">
                <input type="hidden" name="selectedPageNameText" value="">
                <input type="hidden" name="lastSelectedPageFormName" value="">
                <input type="hidden" name="doUpdate" value="true">
                <input type="hidden" name="viewScope" value="group">
                <input type="hidden" name="portalName" value="<%=portalName%>">
                <input type="hidden" name="groupId" value="<%=groupPortalGroupId%>">
                <input type="hidden" name="userId" value="">
                <input type="hidden" name="selectedSkinIds" value="">
                <input type="hidden" name="skinId" value="">
  
              </TD>
  
              <TD align="right" valign="middle" width="50%">
            
                <TABLE>
                  <TR>
                    <TD>
                      <b><i18n:getMessage messageName='currentDefault'/></b>
                    </TD>
                  </TR>
                  <TR>
                    <TD align="right" valign="top">
                      <img id="previewDefault" name="previewDefault" src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" border="0" suppress="true" width=76 height=50 >
                    </TD>
                  </TR>
                  <TR>
                    <TD>
                      <b><i18n:getMessage messageName='preview'/></b>
                    </TD>
                  </TR>
                  <TR>
                    <TD align="right" valign="top">
                      <img id="previewImage" name="previewImage" src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" border="0" suppress="true" width=76 height=50 >
                    </TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
  
            <TR>
              <TD ></TD>
              <TD class="emptyRow" colspan="<%=( ( (numberOfLabels+2) * 2) + 2)%>"></TD>
            </TR>
            <TR>
              <TD colspan="<%=(numberOfLabels+2)%>">
                <a href="<wf:createWebflowURL namespace="tools" origin="select_skins.jsp" event="link.back" httpsInd="http"/>"><img src="<wf:createResourceURL resource='<%=imagesPath + "back.gif"%>'/>" border="0" alt="<i18n:getMessage messageName='backLabel'/>"></a>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:setDefaultSkin('C1');"><img src="<wf:createResourceURL resource='<%=imagesPath + "save.gif"%>'/>" border="0" alt="<i18n:getMessage messageName='saveLabel'/>"></a>
                &nbsp;&nbsp;
              </TD>
            </TR>
          </TABLE>
  
        </wf:form>
  
      </TD>
      <!-- end of main content area -->
  
      <TD align="center" valign="top" width="30px">
        <!-- spacer cell -->
      </TD>
    </TR>
  </TABLE>

  <!-- spacer between select areas and footer -->
  <BR><BR>
  
  <jsp:include page="footer.jsp"/>

</BODY>
</HTML>
