package com.wlpbook.ejb;

public interface PresidentsHome extends javax.ejb.EJBHome
{
    Presidents create() throws
        java.rmi.RemoteException, javax.ejb.CreateException;
}
