<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="leftnav">
	<ul class="nav nav-tabs nav-stacked">
		<li id="leftnav-remoteLoad"><a href="${contextPath}/mytable/remoteLoad"><i class="icon-chevron-right"></i> Remote Data</a></li>
		<li id="leftnav-formEdit"><a href="${contextPath}/mytable/formEdit"><i class="icon-chevron-right"></i> Form Edit</a></li>
		<li id="leftnav-customColumn"><a href="${contextPath}/mytable/customColumn"><i class="icon-chevron-right"></i> Custom Column</a></li>
		<li id="leftnav-advancedFunc"><a href="${contextPath}/mytable/advancedFunc"><i class="icon-chevron-right"></i> Advanced Function</a></li>
	</ul>
</div>
<script>
function highlightLeftNav() {
	$('#leftnav').find('.nav li').removeClass('active');
	var path = window.location.href;
	if (path.indexOf('/remoteLoad') >= 0) {
		$('#leftnav-remoteLoad').addClass('active');
	} if (path.indexOf('/formEdit') >= 0) {
		$('#leftnav-formEdit').addClass('active');
	} else if (path.indexOf('/customColumn') >= 0) {
		$('#leftnav-customColumn').addClass('active');
	} else if (path.indexOf('/advancedFunc') >= 0) {
		$('#leftnav-advancedFunc').addClass('active');
	} else {
		$('#leftnav-remoteLoad').addClass('active');
	}
}
$(function() {
	highlightLeftNav();
});
</script>