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
            int total_money = 0;
            int current_money = 0;
            int adding_money = 0;
            String sqlstate = null;
            String name = null;
	    try{
	      Context context = new InitialContext();
	      ds =  (DataSource)context.lookup("java:jboss/MariaDBDS");
	      if (ds != null) {
		conn = ds.getConnection();
		stmt = conn.createStatement();
		result = stmt.executeQuery("SELECT name,money FROM account WHERE id=1");
                while (result.next()) { 
                    name = result.getString(1);
                    current_money = Integer.parseInt(result.getString(2));
	        }
                adding_money = Integer.parseInt(request.getParameter("transfered_money"));
                total_money = current_money - adding_money;
                sqlstate = "UPDATE account SET money=" + total_money + " WHERE id=1";
                PreparedStatement ps=conn.prepareStatement(sqlstate);
                ps.executeUpdate();
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
                <td colspan=2 bgcolor=#ffe600 height=50 align=center> <p class="ns" style="color:gray;font-size:20px;"> Wire is 완료되었습니다, 
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
                    <%= total_money %>
                </p> </td>
            </tr>
            <tr>
                <td colspan="2" bgcolor=#ffe600  border="0"> </td>
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
