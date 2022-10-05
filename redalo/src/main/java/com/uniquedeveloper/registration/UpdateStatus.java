package com.uniquedeveloper.registration;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Base64;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;
import org.apache.oltu.oauth2.common.token.BasicOAuthToken;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.docusign.admin.client.auth.OAuth.UserInfo;
import com.docusign.esign.api.AuthenticationApi;
import com.docusign.esign.api.EnvelopesApi;
import com.docusign.esign.client.ApiClient;
import com.docusign.esign.client.ApiException;
import com.docusign.esign.client.Configuration;
import com.docusign.esign.model.Document;
import com.docusign.esign.model.EnvelopeDefinition;
import com.docusign.esign.model.EnvelopeSummary;
import com.docusign.esign.model.LoginAccount;
import com.docusign.esign.model.LoginInformation;
import com.docusign.esign.model.RecipientViewRequest;
import com.docusign.esign.model.Recipients;
import com.docusign.esign.model.SignHere;
import com.docusign.esign.model.Signer;
import com.docusign.esign.model.Tabs;
import com.docusign.esign.model.User;

/**
 * Servlet implementation class test3
 */
@WebServlet("/updateStatus")
@MultipartConfig
public class UpdateStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		String accessToken = "eyJ0eXAiOiJNVCIsImFsZyI6IlJTMjU2Iiwia2lkIjoiNjgxODVmZjEtNGU1MS00Y2U5LWFmMWMtNjg5ODEyMjAzMzE3In0.AQsAAAABAAUABwCAJhnYTpraSAgAgGY85pGa2kgCANUp7nFd6hFCn5bRbjxcoLAVAAEAAAAYAAEAAAAFAAAADQAkAAAANjI1ZWEyMzUtZWNkNy00ZDFkLWI5MmMtOGI3YTJlNzZkNzE2IgAkAAAANjI1ZWEyMzUtZWNkNy00ZDFkLWI5MmMtOGI3YTJlNzZkNzE2EgABAAAACwAAAGludGVyYWN0aXZlMACAZ-m3TpraSDcAqoRDRACXsEi2LhUEEtu32A.dqUNrxIHQSMH7WzZCKOqAcz1Jfr5GJetZQ_BW-n_QU8U6NoA3qkkHG9uJYuqh5E3TLMTtE1zedL9i1sN15xYm6RBzAiyInGEmG09oNDSGarCWt6neMSm8fM6h7-kpvDq-eA8_C_duW7snrURPrbO1uGwEgsFFsWhSShnHAST4LPDCc9hvg2z1cHf2EFGPNcGtG581uUerRpfJNPj5QtrEKKk3kBBMC1yz2YAgXHIBeRVYirV2b-ah3S8hvK5Jhl5R0CV4yo-osHBKQ34c8BbPmxVtYyWEDreVcZHQ7owRyn2c8UIGznGEvvg2ZuDahXvKVfkV7SkYtsl3k2V7b5fPQ";
	    String envelopeId = request.getParameter("envelopedId");
	    String integratorKey = "625ea235-ecd7-4d1d-b92c-8b7a2e76d716"; // of the developer acc
		
		RequestDispatcher dispatcher = null ;
		HttpSession session = request.getSession();
		Object Sname = session.getAttribute("name");
		Object Semail = session.getAttribute("email");
		  
	
		    
		    // calling docusign API
		    ApiClient apiClient = new ApiClient("https://demo.docusign.net/restapi");
		    apiClient.addDefaultHeader("Authorization", "Bearer " + accessToken);
		  
			// set client in global config so we don't need to pass it to each API object
            Configuration.setDefaultApiClient(apiClient);
            //String authHeader = "{\"Username\":\"" + Sname + "\", \"Password\":\"" + SPassword + "\", \"IntegratorKey\":\"" + integratorKey + "\"}";
            //Configuration.getDefaultApiClient().addDefaultHeader(integratorKey, authHeader);
			
			
			
		    // initializing the envelope
		    EnvelopesApi envelopesApi = new EnvelopesApi(apiClient);
			EnvelopeDefinition envelope = makeEnvelope(rEmail,rName,fileName);
			
		   /* EnvelopeDefinition envelope = makeEnvelope(rEmail,rName,filePath);*/
		   //try date and time of delivery and completing the signing 
			String accountId = "";
			String envelopeId = "";
			envelopesApi.getEnvelope(accountId, envelopeId);
			       
		    }

	      }
	


	


