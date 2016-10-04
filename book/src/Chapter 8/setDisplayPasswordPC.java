package com.nws.examples;

import com.bea.p13n.appflow.common.PipelineSession;
import com.bea.p13n.appflow.pipeline.PipelineComponentSupport;

public class setDisplayPasswordPC extends PipelineComponentSupport {

  public setDisplayPasswordPC() {
  }

  public PipelineSession process(PipelineSession pipelineSession,
    Object requestContext) throws
    com.bea.p13n.appflow.exception.PipelineException, java.rmi.RemoteException {

    StringBuffer sb = new StringBuffer();
    String namespace = getCurrentNamespace(pipelineSession);

    String pwd = (String)getRequestAttribute("password", namespace,
      requestContext, pipelineSession);

    for(int i = 0; i < pwd.length(); i++) {
      sb.append("*");
    }

    setRequestAttribute("displayPassword", sb.toString(), namespace,
      requestContext, pipelineSession);

    return pipelineSession;
  }
}
