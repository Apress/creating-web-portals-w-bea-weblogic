package com.nws.examples;

import com.bea.p13n.appflow.webflow.InputProcessorSupport;
import com.bea.p13n.appflow.exception.ProcessingException;
import javax.servlet.http.HttpServletRequest;

public class BasicIP extends InputProcessorSupport {

  private static final String PARAM_NEXTPAGE = "NEXTPAGE";
  public BasicIP() {
  }

  public Object process(HttpServletRequest request, Object requestContext)
      throws ProcessingException {

    String jumpToPage = request.getParameter(PARAM_NEXTPAGE);
    if (jumpToPage == null) jumpToPage = "main";

    return jumpToPage;
  }
}
