<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras" prefix="tilesx" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Samples</title>
<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" rel="stylesheet">
<link href="${asset}/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<style>
/* Sticky footer styles */
html, body {
  height: 100%;
}
#wrap {
  min-height: 100%;
  height: auto !important;
  height: 100%;
  margin: 0 auto -40px;
}
#push, #footer {
  height: 40px;
}
#footer {
  background-color: #f5f5f5;
}
@media (max-width: 767px) {
  #footer {
    margin-left: -20px;
    margin-right: -20px;
    padding-left: 20px;
    padding-right: 20px;
  }
}
</style>
<tilesx:useAttribute id="csses" name="csses" classname="java.util.List" ignore="true" />
<c:forEach var="css" items="${csses}">
<tiles:insertAttribute value="${css}" flush="true" />
</c:forEach>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
<tilesx:useAttribute id="jses" name="jses" classname="java.util.List" ignore="true" />
<c:forEach var="js" items="${jses}">
<tiles:insertAttribute value="${js}" flush="true" />
</c:forEach>
</head>
<body>
<div id="wrap">
	<tiles:insertAttribute name="header" />
	<br/>
	<tiles:insertAttribute name="body" />
	<br/>
	<div id="push"></div>
</div>
<div id="footer">
	<tiles:insertAttribute name="footer" />
</div>
</body>
</html>