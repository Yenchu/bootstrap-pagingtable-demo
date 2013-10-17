<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="panel panel-default">
	<div class="panel-heading">Members</div>
	<div class="panel-body">
		<div class="btn-group pull-right">
			<button type="button" id="add-btn" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span> Add</button>
			<button type="button" id="delete-btn" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Delete</button>
		</div>
	</div>
	<table id="member-table" class="table table-striped"></table>
</div>
<script type="text/javascript">
	var $table;
	
	var options = {
		colModels: [
			{name:'id', header:'ID', hidden:true},
			{name:'name', header:'Name', width:'20%', sortable:true, editable:true, editor:'text'},
			{name:'email', header:'Email', width:'30%', editable:true, editor:'textarea'},
			{name:'birthday', header:'Birthday', width:'20%', sortable:true, editable:true, editor:dateEditor},
			{name:'sex', header:'Sex', width:'10%', sortable:true, editable:true, editor:'radio'
				, options:{'1':'Female', '2':'Male'}},
			{name:'language', header:'Language', width:'20%', sortable:true, editable:true, editor:'select'
				, optionsUrl:'${contextPath}/language/options'}
		],
		inlineEditing: true,
		isMultiSelect: true,
		isPageable: true,
		loadOnce: true,
		remote: {url:'${contextPath}/members', editUrl:'${contextPath}/members/edit', deleteUrl:'${contextPath}/members/delete'}
	};

	function createTable() {
		$table = $('#member-table').pagingtable(options).on('dblclickRow', function(e) {
			var rowId = e.rowId;
			editRow($table, rowId);
		});
	}
	
	$(function() {
		document.onselectstart = function() {
			return false;
		}

		createTable();
		
		$('#add-btn').click(function() {
			addRow($table);
		});
		
		$('#delete-btn').click(function() {
			deleteRows($table);
		});
	});
</script>