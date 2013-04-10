<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="topnav" class="navbar navbar-inverse navbar-static-top">
	<div class="navbar-inner">
		<div class="container-fluid">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			<a class="brand" href="#">Samples</a>
			<div class="nav-collapse collapse">
				<ul class="nav">
					<li id="topnav-pagingtable"><a href="${contextPath}/pagingtable">Paging Table</a></li>
				</ul>
			</div>
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