package com.nws.examples;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Set;
import java.util.Iterator;

public class UserBean implements Serializable{

  private HashMap errors = new HashMap();

  private String firstname;
  private String lastname;
  private String email;

  public UserBean() {
  }

  public String getFirstname() {
    return firstname;
  }

  public void setFirstname(String firstname) {
    this.firstname = firstname;
  }

  public String getLastname() {
    return lastname;
  }

  public void setLastname(String lastname) {
    this.lastname = lastname;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public void setFieldError(String field, String error) {
    errors.put(field, error);
  }

  public String getFieldError(String field) {
    return (String)errors.get(field);
  }

  public String getErrorMessage() {
    StringBuffer error = new StringBuffer();
    Set keys = errors.keySet();

    if (keys.size() > 0) {
      error.append("Errors have occured<br>");
    }

    for (Iterator i = keys.iterator(); i.hasNext();) {
      error.append(getFieldError((String)i.next()));
      error.append("<br>");
    }

    return error.toString();
  }
}
