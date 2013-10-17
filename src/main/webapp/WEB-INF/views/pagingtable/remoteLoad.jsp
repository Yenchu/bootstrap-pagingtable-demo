<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="panel panel-default">
	<div class="panel-heading">Members</div>
	<table id="member-table" class="table table-striped"></table>
</div>
<script type="text/javascript">
	var options = {
		colModels: [
			{name:'id', header:'ID', hidden:true},
			{name:'name', header:'Name', width:'20%', sortable:true},
			{name:'email', header:'Email', width:'20%'},
			{name:'birthday', header:'Birthday', width:'20%', sortable:true},
			{name:'sex', header:'Sex', width:'20%', sortable:true
				, options:{'1':'Female', '2':'Male'}},
			{name:'language', header:'Language', width:'20%', sortable:true
				, options:{'':'', 'en':'English', 'fr':'French', 'ja':'Japanese', 'zh':'Chinese'}}
		],
		isPageable: true,
		loadOnce: true,
		remote: {url:'${contextPath}/members'}
	};
	
	$(function() {
		$('#member-table').pagingtable(options);
	});
</script>