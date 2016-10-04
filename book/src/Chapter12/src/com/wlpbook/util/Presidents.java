package com.wlpbook.util;


import java.rmi.*;
import java.util.*;
import java.io.*;



public class Presidents
{

    private javax.ejb.SessionContext m_context;
    private static final String CLASSNAME = "com.wlpbook.ejb.Presidents";

    public Presidents()
    {
    }

    public ArrayList getData()
        throws java.rmi.RemoteException{

            ArrayList names = new ArrayList();

              System.out.println(CLASSNAME + ".getData():Begin");
        String item = null;
        String rowclass = "row1";

        // Retrieve name list
          String record = null;

          BufferedReader br = null;
          try {
              System.out.println(CLASSNAME + ".getData():Getting FileReader");
             FileReader fr     = new FileReader("\\bea\\user_projects\\myDomain\\beaApps\\portalApp\\mywebapp\\portlets\\firstPortlet\\presidents.txt");
//             FileReader fr     = new FileReader("..\\..\\..\\..\\mywebapp\\portlets\\firstPortlet\\presidents.txt");
//             InputStreamReader fr = new InputStreamReader(application.getResourceAsStream("/portlets/firstPortlet/presidents.txt"), "ASCII");
//             InputStreamReader fr = new InputStreamReader(this.getClass().getResourceAsStream("/mywebapp/portlets/firstPortlet/presidents.txt"), "ASCII");
//             InputStreamReader fr = new InputStreamReader(this.getClass().getResourceAsStream("../../../../mywebapp/portlets/firstPortlet/presidents.txt"), "ASCII");
              System.out.println(CLASSNAME + ".getData():After getting FileReader");

             br = new BufferedReader(fr);
              System.out.println(CLASSNAME + ".getData():After getting BufferedReader");

             while ((record = br.readLine()) != null) {
                names.add(record);
             }
              System.out.println(CLASSNAME + ".getData():After reading records");
          } catch (IOException e) {
             // catch possible io errors from readLine()
             System.out.println("IOException error!");
             e.printStackTrace();
          }
          finally
          {
              try { if (br != null) br.close(); } catch (IOException ignore) { }
          }

          return names;

/*

//      ArrayList names = null;
      names = new ArrayList();

      String record = null;
      int recCount = 0;

      try {

         FileReader fr     = new FileReader("\\bea\\user_projects\\myDomain\\beaApps\\portalApp\\mywebapp\\portlets\\firstPortlet\\presidents.txt");
         BufferedReader br = new BufferedReader(fr);

         record = new String();
         while ((record = br.readLine()) != null) {
            recCount++;
            names.add(record);
         }

      } catch (Exception e) {
         // catch possible io errors from readLine()
         System.out.println("IOException error!");
         e.printStackTrace();
      }
      finally{
//        return names;
      }

*/
    }



}
