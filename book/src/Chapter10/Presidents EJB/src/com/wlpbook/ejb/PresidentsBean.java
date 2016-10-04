package com.wlpbook.ejb;


import java.rmi.*;
import java.util.*;
import java.io.*;



public class PresidentsBean implements javax.ejb.SessionBean
{

    private javax.ejb.SessionContext m_context;

    public PresidentsBean()
    {
    }

    public void  getData(ArrayList names)
        throws java.rmi.RemoteException{

      BufferedReader br = null;
      names = new ArrayList();

      String record = null;
      int recCount = 0;

      try{

        InputStreamReader isr = new InputStreamReader(getClass().getResourceAsStream("presidents.txt"), "ASCII");
        br = new BufferedReader(isr);

        while ((record = br.readLine()) != null) {
              names.add(record);
        }
      } catch (IOException e) {
         // catch possible io errors from readLine()
         System.out.println("IOException error!");
         e.printStackTrace();
      }
      finally
      {
          try { if (br != null) br.close(); } catch (IOException ignore) { }
      }


}


/** EJB required methods **/

    public void setSessionContext( javax.ejb.SessionContext context ) throws
        java.rmi.RemoteException
    {
        m_context = context;
    }

    public void ejbCreate() throws
        java.rmi.RemoteException, javax.ejb.CreateException
    {
    }

    public void ejbRemove() throws
        java.rmi.RemoteException
    {
    }

    public void ejbPassivate() throws
        java.rmi.RemoteException
    {
    }

    public void ejbActivate()throws
        java.rmi.RemoteException
    {
    }
}
