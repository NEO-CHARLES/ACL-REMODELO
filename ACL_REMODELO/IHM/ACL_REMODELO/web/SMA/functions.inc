<%
Sub myWrite(line)
	Response.write(line)
end sub

Sub myWriteLn(line)
	Response.write(line)
	Response.write("<br>")
end sub

Sub CreateHeader(refresh)
	myWrite "<head>"
	myWrite "<meta http-equiv=""EXPIRES"" content=0>"
	if refresh > 0 then
		myWrite "<meta http-equiv=""refresh"" content=""" & refresh &""">"
	end if
	myWrite "<link rel=""stylesheet"" type=""text/css"" href=""cma.css"" />"	
	myWrite	"</head>"
end sub

Sub CreateFooter()

End Sub

Sub PageTitle(title, logo)
	if showLogo then
		if logo = "" then
			myWrite "<img src=""logo.gif"" alt=""A""/>"
		else
			myWrite "<img src=""" & logo & """ alt=""A""/>"			
		end if
	end if
	if title <> "" then
		myWrite "<h1>" & title & "</h1>"
	end if
end sub

Sub PageDefaultMenu()
	myWrite "<table class=""header"">"
	myWrite "<tr>"

		if Request.QueryString("n") <> "0" then
			myWrite "<td class=""header"">"
				myWrite "<a href=""index.asp?n=0""> Home </a>"
			myWrite "</td>"
			myWrite "<td class=""header"">&nbsp;</td>"
			if Request.QueryString("n") = "1" then 
				if isProcessTagsEnabled then
					myWrite "<td class=""header"">"
						myWrite "<a href=""Tags.asp?n=2""> Process  </a>"
					myWrite "</td>"
				end if
			else 
				myWrite "<td class=""header"">"
					myWrite "<a href=""Alarms.asp?n=1""> Alarms </a>"
				myWrite "</td>"
			end if
			myWrite "<td class=""header"">&nbsp;</td>"
		end if
		myWrite "<td class=""header"">"
			myWrite "<a href=""LogOn.asp?LogOff=Yes""> Log Off </a>"
		myWrite "</td>"
	myWrite "</tr>"
	myWrite "</table>"
end sub

Sub chkWrite(line, condition)
	if condition = true then
		myWrite line
	end if
end sub

'Return Values
'	0: Cookie has been created, logon is needed
'	1: Cookie is valid
'	2: Connection error
Function chkCookie()
	mysession.Cookie = Request.Cookies("Session")
	if mysession.IsValidCookie = false then
		Dim resp
		resp = mysession.CreateCookie(Request.ServerVariables("REMOTE_ADDR"))
		if resp = 0 then
			Response.Cookies("Session") = mysession.Cookie
			chkCookie= 0
		else
			Response.Redirect "ConnectionError.htm"
			chkCookie= 2
		end if
	else
		chkCookie= 1
	end if
end function

Function chkLogon()
	dim resp
	resp = chkCookie()
	if resp = 2 then
		chkLogon = false
	end if
	if resp = 0 Or mysession.IsValidLogon = false then
		ChkLogon =false
		Response.Redirect "logon.asp"
	else 
		chkLogon = True
	end if
end function
%>



