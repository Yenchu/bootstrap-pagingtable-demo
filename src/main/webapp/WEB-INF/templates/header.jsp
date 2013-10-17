<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="topnav" class="navbar navbar-inverse navbar-static-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Samples</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li class="active"><a href="${contextPath}">Home</a></li>
				<li id="topnav-pagingtable"><a href="${contextPath}/pagingtable">Pagingtable</a></li>
				<li id="topnav-pagingtable"><a href="${contextPath}/public/html/d3.html">D3</a></li>
			</ul>
		</div>
	</div>
</div>
<script>
function highlightTopNav() {
	$('#topnav').find('.nav li').removeClass('active');
	var path = window.location.href;
	if (path.indexOf('/pagingtable') >= 0) {
		$('#topnav-pagingtable').addClass('active');
	}
}
$(function() {
	highlightTopNav();
});
</script>