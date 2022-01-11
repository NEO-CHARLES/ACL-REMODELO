
<% @language = "vbscript" %>
<!--#include file="config.inc"-->
<!--#include file="variables.inc"-->
<!--#include file="functions.inc"-->
<% 	
	call chkCookie 
	dim user
	dim pwd
	dim accessOk
	dim callExit
	
	if isEnabled = false then
		Response.Redirect("disabled.htm")	
	end if
	
	callExit = Request.QueryString("LogOff")
	user = Request.Form("User")
	pwd = Request.Form("Password")
	accessOk = true

	Function LogOn()
		On Error Resume Next
		LogOn = false
		LogOn =  mysession.LogOn(user, pwd, logonExpiration)	
		if LogOn = true then
			accessOk = mysession.IsValidLevel(accessLevel)
		end if
	end function
	
	if callExit <> "" then
		mysession.Destroy()
		Response.Redirect("LogOn.asp")
    elseif LogOn and accessOk then
		Response.Redirect("index.asp?n=0")
	end if
%>



<% call CreateHeader(0) %>

<% call PageTitle("LogOn", "logo.gif") %>


<form method="POST" action="LogOn.asp">
	<table>
	<tr> 
		<td class="header"> User: </td>  <td class="header"> <input type="text" name="User">  </td>
	</tr>
	<tr>
		<td class="header"> Password: </td> <td class="header"><input type="password" name="Password"> </td>
	</tr>
	</table>
	<input type="submit" value="LogOn" name="LogOn"><input type="reset" value="Reset" name="B2">
</form>

<%
	if user <> "" Or pwd <> "" then
	    myWriteLn "Invalid Logon!!!"	    	    	    
	    Select Case mysession.LastLogonError
	    Case -1	    		    
		    myWriteLn "Detail: The user does not exist."
		Case -2
		    myWriteLn "Detail: Invalid Password."
		Case -3, -4
		    'Exceeded the Number allowed by the License.		    
		    Response.Redirect "ConnectionError.htm"
		Case -5
		    'Logon was not Performed.
		    myWriteLn "Detail: Logon was not Performed."
		End Select
		
		if accessOk = false then
			myWriteLn "Detail: The specified user does not have rights to access the application remotely"
		end if
	end if
%>


</body>
</html>
