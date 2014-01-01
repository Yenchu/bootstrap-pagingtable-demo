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
			{name:'email', header:'Email', width:'20%', editable:true, editor:'textarea'},
			{name:'birthday', header:'Birthday', width:'20%', sortable:true, editable:true, editor:dateEditor},
			{name:'sex', header:'Sex', width:'20%', sortable:true, editable:true, editor:'radio'
				, options:{'1':'Female', '2':'Male'}},
			{name:'languages', header:'Languages', width:'20%', editable:true, editor:'checkbox'
				, options:{'en':'English', 'fr':'French', 'ja':'Japanese', 'zh':'Chinese'}}
		],
		isPageable: true,
		remote: {url:'${contextPath}/members', isRest:true}
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
			deleteRow($table);
		});
	});
</script>