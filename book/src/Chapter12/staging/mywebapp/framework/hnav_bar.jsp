<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ page import="com.bea.portal.manager.ejb.PortalManager"%>
<%@ page import="com.bea.portal.model.PortalState"%>
<%@ page import="com.bea.portal.model.PageState"%>
<%@ page import="com.bea.portal.model.Page"%>
<%@ page import="com.bea.portal.model.PageIdentifier"%>
<%@ page import="com.bea.portal.model.PortalPersonalization"%>
<%@ page import="com.bea.portal.model.PagePersonalization"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>
<%@ page import="com.bea.portal.render.servlets.jsp.UserPersonalizationHelper"%>
<%@ page import="com.bea.p13n.usermgmt.profile.ProfileIdentity"%>
<%@ page import="com.bea.p13n.util.debug.Debug"%>
<%@ page import="java.util.*"%>

<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="portal.tld" prefix="ptl" %>

<%@ include file="/framework/resourceURL.inc"%>

<%!
    static final String FIRST_COLUMN_WIDTH = "50%";
    static final String LAST_COLUMN_WIDTH  = "50%";

    // The number of page links you want to
    // display per row in the page navigation area
    static final int PAGES_PER_ROW = 5;

    // Display names or image names
    static final boolean DISPLAY_TEXT_LINKS = false;

    Debug debug = Debug.getInstance( __hnav_bar.class );
%>
<%
    try
    {
%>
        <%-- Avoid multiple calls to createResourceURL --%>
        <wf:createResourceURL id="transparentGIF" resource='<%=imagesPath + "transparent.gif"%>'/> 


        <%-- Start Navigation Bar --%>
       <table class="titlebar" border="0" cellpadding="0" cellspacing="0" width="100%">

        <tr>
            <td width="<%=FIRST_COLUMN_WIDTH%>">
                <img src="<%= transparentGIF %>" width="1" height="1" border="0">
            </td>
            <td width="4" height="1">
                <img src="<%= transparentGIF %>" width="1" height="1" border="0">
            </td>

<%
            // Get the collection of pages
            PortalState portalState = PortalRenderHelper.getPortalState(request);
            int         numPagesRendered = 0;
            boolean     pageWrap = false;

            //We need to order the pages in the order that the logged in user has placed them.  We 
            // do this by creating a list of the PageStates using the order we get from the 
            // PagePersonalizations.  If we're not dealing with a logged in user, then we can just go 
            // off the order dictated by the PageStates as they are.
            Iterator iterator = null;            
            Map pageStateMap = new TreeMap();
            PortalManager portalManager = UserPersonalizationHelper.getPortalManager(request);
            ProfileIdentity profileIdentity = UserPersonalizationHelper.getIdentity(request);
            if(profileIdentity != null)
            {
                PortalPersonalization portalP13n = portalManager.getPortalPersonalization(profileIdentity,portalState.getPortalIdentifier());
                Iterator pageP13nIt = portalP13n.getPagePersonalizations();
                if(pageP13nIt.hasNext())
                {
                    // build Map of p13n
                    HashMap p13nPages = new HashMap();
                    while (pageP13nIt.hasNext())
                    {
                        PagePersonalization pageP13n = (PagePersonalization)pageP13nIt.next();
                        p13nPages.put(pageP13n.getPageIdentifier().getName(), pageP13n);
                    }
                    // build pageStateMap from p13n indices and pageStates
                    int currentIndex = 0;
                    Iterator pageStateIt = portalState.getPageStates();
                    while (pageStateIt.hasNext())
                    {
                        PageState curPageState = (PageState) pageStateIt.next();
                        String curPageName = curPageState.getPageIdentifier().getName();
                        PagePersonalization curP13n = (PagePersonalization)p13nPages.get(curPageName);
                        if (curP13n != null)
                        {
                            int refIndex = curP13n.getIndex();
                            // if index has not been set, put refPageState
                            // into map with index from portalState pageStates
                            if (refIndex == -1)
                            {
                                refIndex = currentIndex;
                            }
                            pageStateMap.put(new Integer(refIndex), curPageState);
                        }
                        else
                        {
                            pageStateMap.put(new Integer(currentIndex), curPageState);
                        }
                        currentIndex++;
                    }
                    iterator = pageStateMap.values().iterator();
                }
                else
                {
                    iterator    = portalState.getPageStates();
                }
            }
            else
            {
                iterator    = portalState.getPageStates();
            }

            // While we have pages...
            while (iterator.hasNext())
            {
                PageState pageState = (PageState)iterator.next();

                String portalPageName = pageState.getPageIdentifier().getName();
                String selectedPage   = PortalRenderHelper.getPageIdentifier(request).getName();
                String displayName    = pageState.getDisplayName();

                numPagesRendered++;
                
                //We want to start a new row if our number of rendered pages exceeds the set number of 
                // pages per row.  We also need to reset the number of pages rendered variable to 1 
                // (since we are dealing with the next page) and then set our boolean to say we have 
                // created a new row.
                if (numPagesRendered > PAGES_PER_ROW )
                {
                    numPagesRendered = 1;
                    pageWrap = true;
%>
                    </tr><tr>
                    <td name=firstIf width="<%=FIRST_COLUMN_WIDTH%>">
                        <img src="<%= transparentGIF %>" width="1" height="1" border="0">
                    </td>
                    <td name=firstIf width="4" height="1">
                        <img src="<%= transparentGIF %>" width="1" height="1" border="0">
                    </td>
<%              }

                if (Page.DISPLAY_TYPE_TEXT.equals(pageState.getDisplayType()))
                {
                    if (portalPageName.equals(selectedPage))
                    {
%>
                        <td valign="bottom" align="right" class="tabselected"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><img src="<wf:createResourceURL resource='<%=imagesPath + "page_name_left_selected.gif" %>' />" border="0"></a></td>
                        <td valign="bottom" background="<wf:createResourceURL resource='<%=imagesPath + "page_name_mid_selected.gif" %>' />" align="center" class="tabselected" nowrap align="center" style="background-repeat: repeat-x;"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><span class="tabselected"><%=displayName%></span></a></td>
                        <td valign="bottom" align="left" class="tabselected"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><img src="<wf:createResourceURL resource='<%=imagesPath + "page_name_right_selected.gif" %>' />" border="0"></a></td>
<%
                    }
                    else
                    {
%>
                        <td valign="bottom" align="right" class="tabunselected"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><img src="<wf:createResourceURL resource='<%=imagesPath + "page_name_left_unselected.gif" %>' />" border="0"></a></td>
                        <td valign="bottom" background="<wf:createResourceURL resource='<%=imagesPath + "page_name_mid_unselected.gif" %>' />" class="tabunselected" nowrap align="center" style="background-repeat: repeat-x;"><a href="<ptl:createPortalPageChangeURL    pageName='<%= portalPageName %>'/>"><span class="tabunselected"><%=displayName%></span></a></td>
                        <td valign="bottom" align="left" class="tabunselected"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><img src="<wf:createResourceURL resource='<%=imagesPath + "page_name_right_unselected.gif" %>' />" border="0"></a></td>
<%
                   }
                }
                else
                {
                    // String rolloverImage = portalPage.getImageName(Page.IMAGE_ROLLOVER);

                    if (portalPageName.equals(selectedPage))
                    {
                        String selectedImage = pageState.getImageName(Page.IMAGE_SELECTED);

%>                      <td align="center" valign="bottom"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><img src="<wf:createResourceURL resource='<%=imagesPath+selectedImage%>' />"  border="0" alt="<%=displayName%>"></a></td>
<%                  }
                    else
                    {
                        String defaultImage  = pageState.getImageName(Page.IMAGE_DEFAULT);

%>                      <td align="center" valign="bottom"><a href="<ptl:createPortalPageChangeURL pageName='<%= portalPageName %>'/>"><img src="<wf:createResourceURL resource='<%=imagesPath+defaultImage%>' />"  border="0" alt="<%=displayName%>"></a></td>
<%                  }
                }

                // Did we meet our max tabs per row?  If so, cap off the end of the row
                if (numPagesRendered == PAGES_PER_ROW )
                {
%>
                    <td>
                        <img src="<%= transparentGIF %>" width="1" height="1" border="0">
                    </td>
                    <td width="<%=LAST_COLUMN_WIDTH%>">
                        <img src="<%= transparentGIF %>" width="1" height="1" border="0">
                    </td>
<%              }
            }
%>
<%
            // If the pages were wrapped, then this was already added.
            if (!pageWrap) {
%>
                <td>
                    <img src="<%= transparentGIF %>" width="1" height="1" border="0">
                </td>
                <td width="<%=LAST_COLUMN_WIDTH%>">
                    <img src="<%= transparentGIF %>" width="1" height="1" border="0">
                </td>
<%          }
%>
        </tr>
        </table>
<% 
   } catch (Exception e) { 
      // If there was some error try not to do a partial output 
      out.clearBuffer(); 
%>
        <table>
            <tr><td>Navbar funcationality temporarily not working</td></tr>
        </table>
<%
        out.flush();
        e.printStackTrace();    
    }
%>
<br>
<%-- end Portal Pages --%>
