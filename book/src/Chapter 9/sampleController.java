package com.nws.examples;

import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class sampleController extends HttpServlet {

  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    doPost(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    String op = request.getParameter("OPERATION");

    if ((op != null) && (op.equalsIgnoreCase("SOMETHING"))) {
      doSomething(request);
    }

    getServletConfig().getServletContext().
      getRequestDispatcher("/application?pageid=somepage").
        forward(request, response);

  }

  private void doSomething(HttpServletRequest request) {
    //This method would process the request.
  }

  public void destroy() {
  }

}
