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
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css"><!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<link rel="stylesheet" href="${asset}/css/main.css">
<tilesx:useAttribute id="csses" name="csses" classname="java.util.List" ignore="true" />
<c:forEach var="css" items="${csses}">
<tiles:insertAttribute value="${css}" flush="true" />
</c:forEach>
<!--[if lt IE 9]>
	<script src="${asset}/js/html5shiv.js"></script>
	<script src="${asset}/js/respond.min.js"></script>
<![endif]-->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="${asset}/js/main.js"></script>
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