<%-- 
    Document   : error
    Created on : Jan 7, 2025, 5:23:40 AM
    Author     : dipay
--%>

<%@ page isErrorPage="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="alert alert-danger">
                <h4>Error</h4>
                <p>${pageContext.exception.message}</p>
            </div>
            <a href="javascript:history.back()" class="btn btn-primary">Go Back</a>
        </div>
    </body>
</html>
