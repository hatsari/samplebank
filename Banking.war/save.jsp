<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
        <meta charset="utf-8" />
		<title>KB Bank SDDC</title>
        <style>
        .np{font-family: 'Nanum Pen Script', cursive;}
        .jg{font-family: 'Jeju Gothic', sans-serif;}
        .jm{font-family: 'Jeju Myeongjo', serif;}
        .kb{font-family: 'KoPub Batang', serif;}
        .nb{font-family: 'Nanum Brush Script', cursive;}
        .ns{font-family: 'Noto Sans KR', sans-serif;}
        .hn{font-family: 'Hanna', sans-serif;}
        .ng{font-family: 'Nanum Gothic', sans-serif;}
        .nm{font-family: 'Nanum Myeongjo', serif;}
        .jh{font-family: 'Jeju Hallasan', cursive;}
        .ngc{font-family: 'Nanum Gothic Coding', monospace;}
        </style>
	</head>
	<body>
        <%
	    DataSource ds = null;
	    Connection conn = null;
	    ResultSet result = null;
	    Statement stmt = null;
	    ResultSetMetaData rsmd = null;
            String name = null;
            String money = null;
	    try{
	      Context context = new InitialContext();
	      ds =  (DataSource)context.lookup("java:jboss/MariaDBDS");
	      if (ds != null) {
		conn = ds.getConnection();
		stmt = conn.createStatement();
		result = stmt.executeQuery("SELECT name,money FROM account WHERE id=1");
                while (result.next()) {
                  name = result.getString(1); 
                  money = result.getString(2); 
                }
	       }
	     }
	     catch (SQLException e) {
		System.out.println("Error occurred " + e);
	      }
        %>
	    <table width=480 bgcolor=white border="0"> 
            <tr>
                <td colspan="2"> <a href="index.jsp"><img src="img/kbtitle.jpg" alt="" border="0" height=120 width=480></img></a></td>
            </tr>
            <tr>
                <td colspan=2 bgcolor=#ffe600 height=50 align=center> <p class="ns" style="color:gray;font-size:20px;">안녕하세요,
                <%= name %>
                </p></td>
            </tr>
            <tr>
                <td bgcolor=#ffe600 height=50 align=center> <p class="ns" style="color:black;font-size:20px;"> 계좌 번호</p></td>
                <td bgcolor=#ffe600 height=50 align=center> <p class="ns" style="color:black;font-size:20px;">111111-11-111111</p></td>
            </tr>
            <tr>
                <td bgcolor=#ffe600 width=240 align=center height=50 border="0"> <p class="ns" style="color=red;font-size:20px;"> 보유금액</p> </td>
                <td bgcolor=#ffe600 width=240 align=center height=50 border="0"> <p class="ns" style="color=white;font-size:25px;"> 
                <%= money%>
                </p> </td>
            </tr>
            <tr>
                <td colspan="2" bgcolor=#ffe600  border="0"> </td>
            </tr>
            <tr>
                <td bgcolor=#ffe600 border="0" align=center height=70> <a href="save.html"><img src="img/p1-save.png" alt="" width=100 height=50></img></a> </td>
                <td bgcolor=#ffe600 border="0" align=center height=70> <a href="wire.html"><img src="img/p1-wire.png" alt="" width=100 height=50></img></a> </td>
            </tr>
            <tr>
                <td bgcolor=#cda500 width=240 align=center height=50 border="0"> <p class="ns" style="color:black;font-size:20px;"> 입금 금액</p> </td>
                <td bgcolor=#cda500 width=240 align=center height=50 border="0"> 
                    <form action="save_result.jsp" method="post">  
                        <fieldset>
                            <input type="text" name="transfered_money"/>원
                             <input type="submit" value="전송">
                        </fieldset>
                    </form>
                </td>
            </tr>
        </table>
	<%
		 // close the connection, resultset, and the statement
		 result.close();
		 stmt.close();
		 conn.close();
	%>
	</body>

</html>
