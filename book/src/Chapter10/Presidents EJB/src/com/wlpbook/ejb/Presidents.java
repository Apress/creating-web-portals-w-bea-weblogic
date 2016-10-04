package com.wlpbook.ejb;

import java.util.*;

public interface Presidents extends javax.ejb.EJBObject {

  public ArrayList getData()
        throws java.rmi.RemoteException;

}