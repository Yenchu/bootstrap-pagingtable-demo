<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div>
	<div class="row-fluid">
		<div class="span4"><h3>Members</h3></div>
		<div class="span8">
			<div class="btn-group pull-right">
				<button type="button" id="add-btn" class="btn btn-info"><i class="icon-plus icon-white"></i> Add</button>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div>
				<table id="member-table" class="table table-striped table-bordered"></table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var $table;
	
	var options = {
		colModels: [
			{name:'id', header:'ID', hidden:true},
			{name:'action', header:'', width:'20%', formHidden:true, formatter:actionColumn},
			{name:'name', header:'Name', width:'20%', sortable:true, isHiddenField:true},
			{name:'email', header:'Email', width:'20%', editable:true, editor:'textarea'},
			{name:'birthday', header:'Birthday', width:'20%', sortable:true, editable:true, editor:dateEditor},
			{name:'sex', header:'Sex', width:'10%', sortable:true, editable:true, editor:'radio'
				, options:{'1':'Female', '2':'Male'}},
			{name:'language', header:'Language', width:'10%', sortable:true, editable:true, editor:'select'
				, options:{'':'', 'en':'English', 'fr':'French', 'ja':'Japanese', 'zh':'Chinese'}}
		],
		isPageable: true,
		loadOnce: true,
		remote: {url:'${contextPath}/members', editUrl:'${contextPath}/members/edit', deleteUrl:'${contextPath}/members/delete'}
	};

	function createTable() {
		$table = $('#member-table').on('created', function() {
			$(this).on('click', '.edit-row', function() {
				var rowId = $(this).parents('tr').attr('id');
				editRow(rowId);
			});
			$(this).on('click', '.delete-row', function() {
				var rowId = $(this).parents('tr').attr('id');
				deleteRow(rowId);
			});
		}).pagingtable(options);
	}
	
	function actionColumn(colValue, rowData) {
		var rt = '<div class="btn-group"><button type="button" class="btn btn-mini btn-info edit-row"><i class="icon-pencil icon-white"></i> Edit</button>'
		rt += '<button type="button" class="btn btn-mini btn-danger delete-row"><i class="icon-trash icon-white"></i> Delete</button></div>'
		return rt;
	}
	
	function dateEditor(colValue, colModel) {
		var editor = '<input type="text" class="date-picker" name="' + colModel.name + '" value="' + colValue + '">';
		return editor;
	}
	
	function addRow() {
		$table.pagingtable('addRow');
		$('.date-picker').datepicker({format:'yyyy-mm-dd'});
	}
	
	function editRow(rowId) {
		$table.pagingtable('updateRow', rowId);
		$('.date-picker').datepicker({format:'yyyy-mm-dd'});
	}
	
	function deleteRow(rowId) {
		$table.pagingtable('deleteRow', {id:rowId, displayColName:'name'});
	}
	
	$(function() {
		document.onselectstart = function() {
			return false;
		}

		createTable();
		
		$('#add-btn').click(function() {
			addRow();
		});
	});
</script>