 
 /*------------------------------------------------------------------------
    File        : hello
    Purpose     : DevOps Demo
    Author(s)   : Cameron David Wright - cwright@progress.com
    Created     : Mon May 18 13:50:57 EDT 2020
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Web.WebResponseWriter.
using OpenEdge.Net.HTTP.StatusCodeEnum.
using OpenEdge.Web.WebHandler.

block-level on error undo, throw.

class com.progress.devops.hello inherits WebHandler: 

	method override protected integer HandleNotAllowedMethod( input poRequest as OpenEdge.Web.IWebRequest ):
		undo, throw new Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
	end method.

	method override protected integer HandleNotImplemented( input poRequest as OpenEdge.Web.IWebRequest ):
		undo, throw new Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
   	end method.
 	
 	method override protected integer HandleGet( input poRequest as OpenEdge.Web.IWebRequest ):
	
		define variable oResponse as OpenEdge.Net.HTTP.IHttpResponse no-undo.
        define variable oWriter   as OpenEdge.Web.WebResponseWriter  no-undo.
        define variable oBody     as OpenEdge.Core.String            no-undo.
        define variable kName     as character no-undo.
            
        assign 
            oResponse            = new OpenEdge.Web.WebResponse()
            oResponse:StatusCode = integer(StatusCodeEnum:OK)
            kName = poRequest:GetPathParameter("name")
            .
        /* This body object can be a string or something else (JsonObject for instance) */               
        assign 
            oBody = new OpenEdge.Core.String(
                           substitute( 'Hello &1', kName)
                           + '~r~n':u   /*CRLF */
                           + 'This message was returned by HandleGet in com.progress.devops.hello.cls ...'
                           ).
        
        assign 
            oResponse:Entity        = oBody
            /* HTTP messages require a content type */
            oResponse:ContentType   = 'text/plain':u
            /* ContentLength is good too */
            oResponse:ContentLength = oBody:Size
            .
        
        /* The WebResponseWriter ensures that the status line and
           all headers are writted out before the message body/entity. */
        assign 
            oWriter = new WebResponseWriter(oResponse).
        oWriter:Open().
        
        /* Finish writing the response message */
        oWriter:Close().
        
        /* A response of 0 means that this handler will build the entire response;
           a non-zero value is mapped to a static handler in the webapp's /static/error folder.
           The mappings are maintained in the webapps's WEB-INF/web.xml 
           A predefined set of HTTP status codes is provided in the OpenEdge.Net.HTTP.StatusCodeEnum 
           enumeration */
        return 0.
		
 	end method. 
 	
 	
   	
	
end class.