<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="panel panel-default">
	<div class="panel-heading">Members</div>
	<div class="panel-body">
		<div class="btn-group pull-right">
			<button type="button" id="add-btn" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span> Add</button>
		</div>
	</div>
	<table id="member-table" class="table table-striped"></table>
</div>
<script type="text/javascript">
	var $table;
	
	var options = {
		colModels: [
			{name:'id', header:'ID', hidden:true},
			{name:'action', header:'', width:'20%', formHidden:true, formatter:actionColumn},
			{name:'name', header:'Name', width:'20%', sortable:true, editable:true, editor:'text'},
			{name:'email', header:'Email', width:'20%', editable:true, editor:'textarea'},
			{name:'birthday', header:'Birthday', width:'20%', sortable:true, editable:true, editor:dateEditor},
			{name:'sex', header:'Sex', width:'10%', sortable:true, editable:true, editor:'radio'
				, options:{'1':'Female', '2':'Male'}},
			{name:'languages', header:'Languages', width:'10%', editable:true, editor:'checkbox'
				, options:{'en':'English', 'fr':'French', 'ja':'Japanese', 'zh':'Chinese'}}
		],
		isPageable: true,
		loadOnce: true,
		remote: {url:'${contextPath}/members', editUrl:'${contextPath}/members/edit', deleteUrl:'${contextPath}/members/delete'}
	};

	function createTable() {
		$table = $('#member-table').on('created', function() {
			$(this).on('click', '.edit-row', function() {
				var rowId = $(this).parents('tr').attr('id');
				editRow($table, rowId);
			});
			$(this).on('click', '.delete-row', function() {
				var rowId = $(this).parents('tr').attr('id');
				deleteRow($table, rowId);
			});
		}).pagingtable(options);
	}

	function actionColumn(colValue, rowData) {
		var rt = '<div class="btn-group"><button type="button" class="btn btn-sm btn-info edit-row"><span class="glyphicon glyphicon-edit" /> Edit</button>';
		rt += '<button type="button" class="btn btn-sm btn-danger delete-row"><span class="glyphicon glyphicon-trash" /> Delete</button></div>';
		return rt;
	}
	
	$(function() {
		document.onselectstart = function() {
			return false;
		}

		createTable();
		
		$('#add-btn').click(function() {
			addRow($table);
		});
	});
</script>