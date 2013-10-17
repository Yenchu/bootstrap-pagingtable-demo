<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="leftnav">
	<div class="list-group">
		<a id="leftnav-remoteLoad" class="list-group-item" href="${contextPath}/pagingtable/remoteLoad"><span class="glyphicon glyphicon-chevron-right"></span> Simple Example</a>
		<a id="leftnav-formEdit" class="list-group-item" href="${contextPath}/pagingtable/formEdit"><span class="glyphicon glyphicon-chevron-right"></span> Form Edit</a>
		<a id="leftnav-customColumn" class="list-group-item" href="${contextPath}/pagingtable/customColumn"><span class="glyphicon glyphicon-chevron-right"></span> Custom Column</a>
		<a id="leftnav-features" class="list-group-item" href="${contextPath}/pagingtable/features"><span class="glyphicon glyphicon-chevron-right"></span> Other Features</a>
	</div>
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
	} else if (path.indexOf('/features') >= 0) {
		$('#leftnav-features').addClass('active');
	} else {
		$('#leftnav-remoteLoad').addClass('active');
	}
}
$(function() {
	highlightLeftNav();
});
</script>