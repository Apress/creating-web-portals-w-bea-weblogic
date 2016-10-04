package com.nws.examples;

import javax.servlet.http.HttpServletRequest;
import com.bea.p13n.appflow.common.PipelineSession;
import com.bea.p13n.appflow.exception.ProcessingException;
import com.bea.p13n.appflow.webflow.InputProcessorSupport;
import com.bea.p13n.appflow.webflow.forms.ValidatedValues;
import com.bea.p13n.appflow.webflow.forms.ValidatedValuesFactory;
import com.bea.p13n.appflow.webflow.forms.ValidatedForm;
import com.bea.p13n.appflow.webflow.forms.ValidatedFormFactory;
import com.bea.p13n.appflow.webflow.forms.MinMaxExpression;
import com.bea.p13n.appflow.webflow.forms.InvalidFormDataException;
import java.util.Collection;

public class AdvancedIP extends InputProcessorSupport {

  private static final String SUCCESS = "success";

  public AdvancedIP() {
  }
  public Object process(HttpServletRequest request, Object requestContext)
    throws com.bea.p13n.appflow.exception.ProcessingException {

    PipelineSession pipelineSession = getPipelineSession(request);
    String namespace = getCurrentNamespace(pipelineSession);

    ValidatedValues values = ValidatedValuesFactory.getValidatedValues(request);
    ValidatedForm form = ValidatedFormFactory.getValidatedForm();
    MinMaxExpression minMax = new MinMaxExpression();

    String username = form.validate(values, STRING_VALIDATOR, "username",
      minMax.set(1, 25), "Username is required");

    String password = form.validate(values, STRING_VALIDATOR, "password",
      minMax.set(1, 25), "Password is required");

    String maritalStatus = form.validate(values, "maritalStatus");

    Collection expertise = form.validateMultiple(values, "expertise", 2,
      "Please select at least two areas of expertise");

    String comments = form.validate(values, STRING_VALIDATOR, "comments",
      minMax.set(0,500), "Please limit your comment to 500 characters");

    String email = form.validate(values, "email");

    if (values.getInvalidFieldCount() > 0) {
      throw new InvalidFormDataException("Form data is invalid!");
    }

    setRequestAttribute("username", username, namespace, requestContext,
      pipelineSession);

    setRequestAttribute("password", password, namespace, requestContext,
      pipelineSession);

    setRequestAttribute("maritalStatus", maritalStatus, namespace,
      requestContext, pipelineSession);

    setRequestAttribute("expertise", expertise, namespace, requestContext,
      pipelineSession);

    setRequestAttribute("comments", comments, namespace, requestContext,
      pipelineSession);

    setRequestAttribute("email", email, namespace, requestContext,
      pipelineSession);

    return SUCCESS;
  }
}
