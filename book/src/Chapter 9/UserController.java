package com.nws.examples;

import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserController extends HttpServlet {

  private static final String PARAM_FIRSTNAME = "FIRSTNAME";
  private static final String PARAM_LASTNAME = "LASTNAME";
  private static final String PARAM_EMAIL = "EMAIL";

  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doPost(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String url = "";
    UserBean userBean = getBean(request);

    if (isValid(userBean)) {
      url = "/application/?pageid=home";
    }
    else {
      url = "/application/?pageid=misc";
    }

    request.setAttribute("userBean", userBean);

    getServletConfig().getServletContext().getRequestDispatcher(url).
forward(request, response);

  }

  public void destroy() {
  }

  private UserBean getBean(HttpServletRequest request) {

    UserBean bean = new UserBean();
    bean.setFirstname(request.getParameter(PARAM_FIRSTNAME));
    bean.setLastname(request.getParameter(PARAM_LASTNAME));
    bean.setEmail(request.getParameter(PARAM_EMAIL));
    return bean;
  }

  private boolean isValid(UserBean userBean) {
    boolean isValid = true;

    if ((userBean.getFirstname() == null) ||
(userBean.getFirstname().equals(""))) {
      userBean.setFieldError(PARAM_FIRSTNAME, "First Name is required.");
      isValid = false;
    }

    if ((userBean.getLastname() == null) ||
(userBean.getLastname().equals(""))) {
      userBean.setFieldError(PARAM_LASTNAME, "Last Name is required.");
      isValid = false;
    }

    if ((userBean.getEmail() == null) || (userBean.getEmail().equals(""))) {
      userBean.setFieldError(PARAM_EMAIL, "Email is required.");
      isValid = false;
    }
    else if (!validEmail(userBean.getEmail())) {
      userBean.setFieldError(PARAM_EMAIL, "Email is not valid.");
      isValid = false;
    }

    return isValid;
  }

  private boolean validEmail(String email) {
    int position = email.indexOf("@");

    if (position == -1) {
      return false;
    }
    else if (email.substring(position).indexOf(".") == -1) {
      return false;
    }

    return true;
  }
}
