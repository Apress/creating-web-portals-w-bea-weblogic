package com.nws.samples;

import java.io.*;

public class UserBean implements Serializable{

  private String firstName;
  private String lastName;
  private int age;
  private String type;

  public UserBean() {
  }

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String value) {
    this.firstName = value;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String value) {
    this.lastName = value;
  }

  public int getAge() {
    return age;
  }

  public void setAge(int value) {
    this.age = value;
  }

  public String getType() {
    return type;
  }

  public void setType(String value) {
    this.type = value;
  }
}
