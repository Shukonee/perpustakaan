<%-- 
    Document   : jdbc
    Created on : 7 Dec 2024, 23.00.16
    Author     : farre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="db.JDBC"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            JDBC db = new JDBC();
            if (db.isConnected) {
                out.print(db.message + "<br />");
            } else {
                out.print(db.message + "<br />");
            }
       %>
       
<!--        db.runQuery("insert into barang (nama) values ('PC')");
        out.print(db.message + "<br />");
        db.disconnect();
        out.print(db.message + "<br />");-->
        <h1>Hello World!</h1>
    </body>
</html>
