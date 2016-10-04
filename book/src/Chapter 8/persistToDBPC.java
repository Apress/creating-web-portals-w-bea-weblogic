package com.nws.examples;

import com.bea.p13n.appflow.common.PipelineSession;
import com.bea.p13n.appflow.pipeline.*;
import java.util.Collection;
import java.util.Iterator;

public class persistToDBPC extends PipelineComponentSupport {

  public persistToDBPC() {
  }

  public PipelineSession process(PipelineSession pipelineSession,
    Object requestContext) throws
    com.bea.p13n.appflow.exception.PipelineException, java.rmi.RemoteException {

    String namespace = getCurrentNamespace(pipelineSession);

    String username = (String)getRequestAttribute("username", namespace,
      requestContext, pipelineSession);

    String password = (String)getRequestAttribute("password", namespace,
      requestContext, pipelineSession);

    String maritalStatus = (String)getRequestAttribute("maritalStatus",
      namespace, requestContext, pipelineSession);

    Collection expertise = (Collection)getRequestAttribute("expertise",
      namespace, requestContext, pipelineSession);

    String comments = (String)getRequestAttribute("comments", namespace,
      requestContext, pipelineSession);

    String email = (String)getRequestAttribute("email", namespace,
      requestContext, pipelineSession);

    persist(username, password, maritalStatus, expertise, comments, email);

    return pipelineSession;
  }

  private void persist(String username, String password, String maritalStatus,
    Collection expertise, String comments, String email) {

    // A Database connection would be made here to store all of the values
    // contained within the Pipeline Session
  }
}
