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
 * Servlet implementation class UploadDoc
 */
@WebServlet("/UploadDoc")
@MultipartConfig
public class UploadDoc extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//refresh daily
		String accessToken = "eyJ0eXAiOiJNVCIsImFsZyI6IlJTMjU2Iiwia2lkIjoiNjgxODVmZjEtNGU1MS00Y2U5LWFmMWMtNjg5ODEyMjAzMzE3In0.AQoAAAABAAUABwAALC_6gKDaSAgAAGxSCMSg2kgCANUp7nFd6hFCn5bRbjxcoLAVAAEAAAAYAAEAAAAFAAAADQAkAAAANjI1ZWEyMzUtZWNkNy00ZDFkLWI5MmMtOGI3YTJlNzZkNzE2IgAkAAAANjI1ZWEyMzUtZWNkNy00ZDFkLWI5MmMtOGI3YTJlNzZkNzE2MAAAtn7pgKDaSDcAqoRDRACXsEi2LhUEEtu32A.smt5XRkYxq2LZAiQ8OMFEFoQwc23RvkJFq85iHzDyog_SXAFiNAGOFLdIyCyGcWDjqAZRVZqpy_eks29Feq_NKz7btjjglstnZN7j1Dw5Iq1pNOiYMtIlIzYf-OOa0dOsYAQlfl3qhpBe6nTK6gag1IsX7-ekwXg4Dm9Pn6cg_5vU5itM899KdodWm-ayS9YXR_3OEQTqlOC-uwj8h8wt_-yu2s1Y5SapHxvB-_Ld_f2VdHTjrd1FRUqLuGjQ5HPkVnmd6s0stOCKMNRI8gg1o0HkW9FAh_MpDHNP6guHjaU58HbfNk5jdBwYEPSsw6FOjGPU1fUXZrKZYWO_0qS_A";
		//String accountId ="16864462"; 
	    // getting signer email, name and file to be sent from user
	    String SPassword = request.getParameter("senderPass");
	    String integratorKey = "625ea235-ecd7-4d1d-b92c-8b7a2e76d716"; // of the developer acc
		String rEmail = request.getParameter("signerEmail"); 
		String rName = request.getParameter("signerName");
		Part filePart = request.getPart("formFile");
		String fileName = filePart.getSubmittedFileName();
		System.out.println("##1 >>" + fileName);
		RequestDispatcher dispatcher = null ;
		HttpSession session = request.getSession();
		Object Sname = session.getAttribute("name");
		Object Semail = session.getAttribute("email");
		  
		    for (Part part : request.getParts()) {
		      part.write("C:\\Users\\CHAABA AYOUB\\Desktop\\StageSignatureNumeriqueOfficiel\\redalo\\uploads\\" + fileName);
		    }
		    
		    // calling docusign API
		    ApiClient apiClient = new ApiClient("https://demo.docusign.net/restapi");
		    apiClient.addDefaultHeader("Authorization", "Bearer " + accessToken);
		  
		 // set client in global config so we don't need to pass it to each API object
            Configuration.setDefaultApiClient(apiClient);
            String authHeader = "{\"Username\":\"" + Sname + "\", \"Password\":\"" + SPassword + "\", \"IntegratorKey\":\"" + integratorKey + "\"}";
            Configuration.getDefaultApiClient().addDefaultHeader(integratorKey, authHeader);

            // we will retrieve this from the login() results
            String accountId = null;

            // the authentication api uses the apiClient (and X-DocuSign-Authentication header) that are set in Configuration object
            AuthenticationApi authApi = new AuthenticationApi();
            LoginInformation loginInfo;
			try {
				loginInfo = authApi.login();
				accountId = loginInfo.getLoginAccounts().get(0).getAccountId();
				//System.out.print(accountId);
			} catch (ApiException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}       
			
		    // initializing the envelope
		    EnvelopesApi envelopesApi = new EnvelopesApi(apiClient);
		   EnvelopeDefinition envelope = makeEnvelope(rEmail,rName,fileName);
			
		   
		   /* EnvelopeDefinition envelope = makeEnvelope(rEmail,rName,filePath);*/
		   //try date and time of delivery and completing the signing 
		
		        EnvelopeSummary envelopeSummary;
		        
						try {
							envelopeSummary = envelopesApi.createEnvelope(accountId, envelope);
						      String date_time = envelopeSummary.getStatusDateTime();

							String envelopeId = envelopeSummary.getEnvelopeId();
							 System.out.println("Envelope ID = "+envelopeId);			 
							 Class.forName("com.mysql.cj.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false","root","");
								String sql = "insert into recipient(S_email,R_name,R_email,env_id,file_name,env_status,SentOn)  values(?,?,?,?,?,?,?)";
								PreparedStatement pst = con.prepareStatement(sql);
								pst.setString(1,(String) Semail);
								pst.setString(2,rName);
								pst.setString(3, rEmail);
								pst.setString(4,envelopeId);
								pst.setString(5,fileName);
								pst.setString(6,envelope.getStatus());
								pst.setString(7, date_time);

								int rs = pst.executeUpdate();
								dispatcher = request.getRequestDispatcher("index.jsp");
								if(rs > 0) {
				    				request.setAttribute("status", "success");
				    			}else {
				    				request.setAttribute("status", "fail");
				    			} 
								
				    			dispatcher.forward(request, response);
						} catch (ApiException | ClassNotFoundException | SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					
					
			       
		    }
		    private  EnvelopeDefinition makeEnvelope(String signerEmail, String signerName, String fileName) {
		        
		    	byte[] fileBytes = null;
		        // Create a signer recipient to sign the document, identified by name and email
		        // We set the clientUserId to enable embedded signing for the recipient
		        Signer signer = new Signer();
		        signer.setEmail(signerEmail);
		        signer.setName(signerName);
		        // signer.clientUserId("1000"); # will not receive docuSign email to sign if client user id is present
		        signer.recipientId("1");

		        SignHere signHere = new SignHere();
		        signHere.setAnchorString("/sn1/");
		        signHere.setAnchorUnits("pixels");
		        signHere.setAnchorYOffset("20");
		        signHere.setAnchorXOffset("10");

		        Tabs signerTabs = new Tabs();
		        signerTabs.setSignHereTabs(Arrays.asList(signHere));

		        // Add the recipient to the envelope object
		        Recipients recipients = new Recipients();
		        recipients.setSigners(Arrays.asList(signer));

		        EnvelopeDefinition envelopeDefinition = new EnvelopeDefinition();
		        envelopeDefinition.setEmailSubject("Please sign this document");
		        envelopeDefinition.setRecipients(recipients);
		       
		        try {
					fileBytes = Files.readAllBytes(Paths.get("C:\\", fileName));
					//fileBytes = Files.readAllBytes(Paths.get("C:\\", "Users" , "CHAABA AYOUB", "Desktop", "StageSignatureNumeriqueOfficiel","redalo","uploads",fileName));
					System.out.println("fileBytes");
					System.out.println(fileBytes);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		        String extension = FilenameUtils.getExtension(fileName);
		        Document document = new Document();
		        String base64Doc = Base64.getEncoder().encodeToString(fileBytes);
		        document.setDocumentBase64(base64Doc);
		        document.setName(fileName);
		        System.out.println("##2 >>" + fileName);
		        document.setFileExtension(extension);
		        document.setDocumentId("3");

		        envelopeDefinition.setDocuments(Arrays.asList(document));
		        // Request that the envelope be sent by setting |status| to "sent".
		        // To request that the envelope be created as a draft, set to "created"
		       
		        envelopeDefinition.setStatus("sent");
		       
		       
		      
		        return envelopeDefinition;
		    }
		    private RecipientViewRequest makeRecipientViewRequest(String signerEmail, String signerName) {
		        // Data for this method
		        // signerEmail    (argument)
		        // signerName     (argument)
		        // dsReturnUrl    (class constant) url on this app that DocuSign will redirect to
		        // signerClientId (class constant) the id of the signer in this app
		        // dsPingUrl      (class constant) optional url in this app that DocuSign signing ceremony should ping

		        RecipientViewRequest viewRequest = new RecipientViewRequest();
		        // Set the url where you want the recipient to go once they are done signing
		        // should typically be a callback route somewhere in your app.
		        // The query parameter is included as an example of how
		        // to save/recover state information during the redirect to
		        // the DocuSign signing ceremony. It's usually better to use
		        // the session mechanism of your web framework. Query parameters
		        // can be changed/spoofed very easily.
		        viewRequest.setReturnUrl("http://localhost:8080/index.jsp" + "?state=123");

		        // How has your app authenticated the user? In addition to your app's
		        // authentication, you can include authenticate steps from DocuSign.
		        // Eg, SMS authentication
		        viewRequest.setAuthenticationMethod("none");

		        // Recipient information must match embedded recipient info
		        // we used to create the envelope.
		        viewRequest.setEmail(signerEmail);
		        viewRequest.setUserName(signerName);
		        viewRequest.setClientUserId("4e2d294a-43cc-40d5-b2aa-0e2a4e69bc86");

		        // DocuSign recommends that you redirect to DocuSign for the
		        // Signing Ceremony. There are multiple ways to save state.
		        // To maintain your application's session, use the pingUrl
		        // parameter. It causes the DocuSign Signing Ceremony web page
		        // (not the DocuSign server) to send pings via AJAX to your
		        // app,
		        viewRequest.setPingFrequency("600"); // seconds
		        // NOTE: The pings will only be sent if the pingUrl is an https address
		       /* viewRequest.setPingUrl(dsPingUrl);*/ // optional setting

		        return viewRequest;
		    }

	  
	      }
	


	


