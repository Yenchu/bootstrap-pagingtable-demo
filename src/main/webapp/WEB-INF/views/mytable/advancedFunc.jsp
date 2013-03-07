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
		</div>
	</div>
	<div class="context-menu dropdown hide">
		<ul class="dropdown-menu" role="menu" style="display:block">
			<li><a tabindex="-1" href="#">Regular link</a></li>
			<li><a tabindex="-1" href="#">Disabled link</a></li>
			<li><a tabindex="-1" href="#">Another link</a></li>
		</ul>
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
				, valueOptions:{'1':'Female', '2':'Male'}},
			{name:'language', header:'Language', width:'10%', sortable:true, editable:true, editor:'select'
				, valueOptions:{'':'', 'en':'English', 'fr':'French', 'ja':'Japanese', 'zh':'Chinese'}}
		],
		inlineEditing: true,
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
			console.log('pageY=' + orignEvent.pageY + ', pageX=' + orignEvent.pageX);
			$('.context-menu').offset({top:orignEvent.pageY, left:orignEvent.pageX}).removeClass('hide');
		});
		$(document).click(function() {
			if (!$('.context-menu').hasClass('hide')) {
				$('.context-menu').addClass('hide')
			}
		});
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