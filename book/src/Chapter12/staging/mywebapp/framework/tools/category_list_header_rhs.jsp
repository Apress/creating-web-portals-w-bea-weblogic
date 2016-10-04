<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%-- ------------------------------------------------------------ --%>
<%-- page imports                                                 --%>
<%-- ------------------------------------------------------------ --%>

<%@ page errorPage="/framework/error/error.jsp" %>

<%-- ------------------------------------------------------------ --%>
<%-- taglibs                                                      --%>
<%-- ------------------------------------------------------------ --%>
<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>

<%@ include file="/framework/tools/i18n_setup.inc"%>

        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right" height="1" width="7" valign="top"><img src="<wf:createResourceURL resource='<%=imagesPath + "rounded_top_right_top.gif"%>'/>" height="1" width="7" border="0"></td>
            <td height="1" width="1" align="right" valign="top"><img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="1" height="1" border="0"></td>

          </tr>
          <tr>
				<td align="right" height="9" width="7" valign="top"><img src="<wf:createResourceURL resource='<%=imagesPath + "rounded_top_right.gif"%>'/>" height="9" width="7" border="0"></td>
            <td align="right" height="9" width="1" valign="top"><img src="<wf:createResourceURL resource='<%=imagesPath + "rounded_top_vertical.gif"%>'/>" height="9" width="1" border="0"></td>

          </tr>
          <tr>
             <td class="categoryHeadingSpacerCell" height="18" width=="7" align="right" valign="top"><img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="7" height="18" border="0"></td>
             <td class="categoryHeadingBorderCell" height="1" width="1" align="right" valign="top"><img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="1" height="1" border="0"></td>
          </tr>
        </table>