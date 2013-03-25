<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div>
	<div class="row-fluid">
		<div class="span4"><h3>Members</h3></div>
		<div class="span8">
			<div class="btn-group pull-right">
				<button type="button" id="add-btn" class="btn btn-info"><i class="icon-plus icon-white"></i> Add</button>
				<button type="button" id="delete-btn" class="btn btn-danger"><i class="icon-trash icon-white"></i> Delete</button>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div>
				<table id="member-table" class="table table-striped table-bordered"></table>
			</div>
			<div class="context-menu dropdown hide">
				<ul class="dropdown-menu" style="display:block">
					<li id="act-download"><a href="#"><i class="icon-download-alt"></i> Download</a></li>
					<li id="act-link"><a href="#"><i class="icon-share"></i> Share link</a></li>
					<li id="act-rename"><a href="#"><i class="icon-pencil"></i> Rename</a></li>
					<li id="act-delete"><a href="#"><i class="icon-trash"></i> Delete</a></li>
					<li id="act-move"><a href="#"><i class="icon-move"></i> Move</a></li>
					<li id="act-copy"><a href="#"><i class="icon-book"></i> Copy</a></li>
					<li id="act-revision"><a href="#"><i class="icon-list"></i> Revisions</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var $table;
	
	var options = {
		colModels: [
			{name:'id', header:'ID', hidden:true},
			{name:'name', header:'Name', width:'20%', sortable:true, editable:true, editor:'text'},
			{name:'email', header:'Email', width:'20%', editable:true, editor:'textarea'},
			{name:'birthday', header:'Birthday', width:'20%', sortable:true, editable:true, editor:dateEditor},
			{name:'sex', header:'Sex', width:'10%', sortable:true, editable:true, editor:'select'
				, options:{'1':'Female', '2':'Male'}},
			{name:'language', header:'Language', width:'10%', sortable:true, editable:true, editor:'select'
				, options:{'':'', 'en':'English', 'fr':'French', 'ja':'Japanese', 'zh':'Chinese'}}
		],
		inlineEditing: true,
		isMultiSelect: true,
		isPageable: true,
		loadOnce: true,
		remote: {url:'${contextPath}/members', editUrl:'${contextPath}/members/edit', deleteUrl:'${contextPath}/members/delete'}
	};
	
	function createTable() {
		$table = $('#member-table').mytable(options).on('dblclickRow', function(e) {
			var rowId = e.rowId;
			editRow(rowId);
		}).on('rowContextmenu', function(e) {
			var orignEvent = e.orignEvent;
			//console.log('y=' + orignEvent.pageY + ', x=' + orignEvent.pageX);
			//console.log('y2=' + e.position().top + ', x2=' + e.position().left);
			$('.context-menu').removeClass('hide').offset({top:orignEvent.pageY, left:orignEvent.pageX});
			
			var rowId = e.rowId;
			var selRowIds = $table.mytable('getSelectedRowIds');
			if (selRowIds.length > 1) {
				for (var i = 0, len = selRowIds.length; i < len; i++) {
					if (rowId === selRowIds[i]) {
						configContextMenu4MultiSelect(selRowIds);
						return true;
					}
				}
			}
			$table.mytable('selectRow', $table.mytable('getRow', rowId));
			configContextMenu(rowId);
		});
		$(document).on('click', function(e) {
			if (!$('.context-menu').hasClass('hide')) {
				$('.context-menu').addClass('hide')
			}
		});
		bindHandlerToContextmenu();
	}
	
	function bindHandlerToContextmenu() {
		$('#act-rename').on('click', function(e) {
			var rowId = $table.mytable('getSelectedRowId');
			console.log(rowId);
			editRow(rowId);
		});
	}
	
	function configContextMenu(rowId) {
		console.log(rowId);
	}
	
	function configContextMenu4MultiSelect(rowIds) {
		console.log(rowIds);
	}
	
	function dateEditor(colValue, colModel) {
		var editor = '<input type="text" class="date-picker" name="' + colModel.name + '" value="' + colValue + '">';
		return editor;
	}
	
	function addRow() {
		$table.mytable('addRow');
		$('.date-picker').datepicker({format:'yyyy-mm-dd'});
	}
	
	function editRow(rowId) {
		$table.mytable('updateRow', rowId);
		$('.date-picker').datepicker({format:'yyyy-mm-dd'});
	}
	
	function deleteRow() {
		var rowIds = $table.mytable('getSelectedRowIds');
		if (!rowIds || rowIds.length == 0) {
			alert('Please select a row!');
			return;
		}
		$table.mytable('deleteRow', {id:rowIds, displayColName:'name'});
	}
	
	$(function() {
		document.onselectstart = function() {
			return false;
		}

		createTable();
		
		$('#add-btn').click(function() {
			addRow();
		});
		
		$('#delete-btn').click(function() {
			deleteRow();
		});
	});
</script>