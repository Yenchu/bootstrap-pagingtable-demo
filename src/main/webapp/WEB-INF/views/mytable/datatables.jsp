<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row-fluid">
	<div class="span12">
		<div class="btn-group pull-right">
			<button type="button" id="add-btn" class="btn btn-info btn-small"><i class="icon-folder-close icon-white"></i> Add</button>
			<button type="button" id="delete-btn" class="btn btn-danger btn-small"><i class="icon-trash icon-white"></i> Delete</button>
		</div>
	</div>
</div>
<div class="row-fluid">
	<div id="table-container" class="span12">
		<table id="my-table" class="table table-striped table-bordered"></table>
	</div>
</div>
<script type="text/javascript">
var spaceId = '${space.id}', spaceName = '${space.name}', rootFolder = '${space.root}', currentFolder = '${currentFolder}';

var $mytable;

var options = {
	colModels: [
		{name:'path', key:true, hidden:true},
		{name:'name', header:'Name', sortable:true, formatter:formatFileNameColumn, editable:true, editor:'text'},
		{name:'isDir', header:'Type', sortable:true, editable:true, editor:'radio', valueOptions:{'true':'Folder', 'false':'File'}},
		{name:'size', header:'Size', sortable:true},
		{name:'modified', header:'Modified', sortable:true, editable:true, editor:'textarea', sorter:sortDate}
	],
	paramNames: {page:'page', pageSize:'page.size', records:'rows', totalRecords:'totalRecords', sort:'page.sort', sortDir:'page.sort.dir'},
	url: '${appContext}/dev/metadata',
	editUrl: '${appContext}/dev/fileops/edit',
	deleteUrl: '${appContext}/dev/fileops/delete',
	data: {folder:currentFolder},
	isMultiSelect: true,
	loadOnce: true,
	isPageable: true,
	pageSizeOptions: [5, 10, 20, 50],
	pageRangeTemplate: '顯示第 {{fromRecord}} - {{toRecord}} 筆, 共 {{totalRecords}} 筆, 每頁 {{pageSize}} 筆',
	pagingTemplate: '{{firstButton}}{{prevButton}} 頁 {{currentPage}} / {{totalPages}} {{nextButton}}{{lastButton}}',
	pagerLocation: 1
};

function formatFileNameColumn(colValue, rowData) {
	var rt = getFileNameWithIcon(colValue, rowData);
	return rt;
}

function getFileNameWithIcon(fileName, rowData) {
	//* use dynatree css ti display icons
	var rt = null;
	if (isFolder(rowData)) {
		rt = '<div class="dynatree-ico-cf"><span class="dynatree-icon"></span> ' + fileName + '</div>';
	} else {
		var thumbExists = rowData.thumbExists;
		if (thumbExists === true) {
			rt = '<div><img src="${service}/thumbnails/' + spaceId + rowData.path + '" width="16" height="16"/> ' + fileName + '</div>';
		} else {
			rt = '<div><span class="dynatree-icon"></span> ' + fileName + '</div>';
		}
	}
	return rt;
}

function afterLoad() {
	enableDragAndDropRows(onDropRows);
}

function enableDragAndDropRows(dropHandler) {
	var selectRowData = [];

	var $table = $('#my-table');
	var $draggableRows = $table.find('tbody tr td:first-child').draggable({ // got some problem when draggable and droppable are the same elements
		delay: 200,  // this will prevent the dragging action when user only wants to click and select items
		cursor: 'move',
		opacity: 0.75,
		scope: 'files',
		appendTo: '#table-container', // is needed for IE
		revert: 'invalid',
		helper: function() {
			selectRowData = $mytable.mytable('getSelectedRowData');
			var content = [];
			if (selectRowData.length > 0) {
				for (var i = 0, len = selectRowData.length; i < len; i++) {
					var rowData = selectRowData[i];
					var name = rowData.name;
					content[i] = getFileNameWithIcon(name, rowData);
				}
			} else {
				var id = $(this).parent('tr').attr('id');
				var rowData = $mytable.mytable('getRowData', id);
				selectRowData.push(rowData);
				var name = rowData.name;
				content[0] = getFileNameWithIcon(name, rowData);
			}
			
			var container = $('<div class="box"></div>');
			container.html(content.join('')); // separating selected rows by <br/> may block the last row to be dropped
			container.append('<div id="dest-info" class="hide"><i class="icon-arrow-right"></i> move to <span id="dest-folder" class="label label-info"></span></div>');
			return container;
		}
	});
	
	$table.find('tbody tr').droppable({
		accept: $draggableRows,
		scope: 'files',
		tolerance: 'pointer',
		addClasses: false,
		over: function(event, ui) {
			var dropRowId = $(event.target).attr('id');
			var rowData = $mytable.mytable('getRowData', dropRowId);
			if (!isFolder(rowData)) {
				$('#dest-info').hide();
				$('#dest-folder').html('');
				return;
			}

			for (var i = 0, len = selectRowData.length; i < len; i++) {
				var dragRowId = selectRowData[i].path;
				if (dragRowId === dropRowId) {
					$('#dest-info').hide();
					$('#dest-folder').html('');
					return;
				}
			}
			
			var folderName = rowData.name;
			$('#dest-info').show();
			$('#dest-folder').html(folderName);
		},
		out: function(event, ui) {
			if ($mytable.mytable('isFocusout', event)) {
				$('#dest-info').hide();
				$('#dest-folder').html('');
			}
		},
		drop: function(event, ui) {
			var dropRowId = $(event.target).attr('id');
			var rowData = $mytable.mytable('getRowData', dropRowId);
			if (!isFolder(rowData)) {
				return;
			}
			
			var dragRowIds = [];
			for (var i = 0, len = selectRowData.length; i < len; i++) {
				var dragRowId = selectRowData[i].path;
				dragRowIds[i] = dragRowId;
				if (dragRowId === dropRowId) {
					return;
				}
			}
			
			if (dropHandler) {
				dropHandler(dragRowIds, dropRowId);
			}
		}
	});
}

function onDropRows(dragRowIds, dropRowId) {
	log('drag ' + dragRowIds + ' to ' + dropRowId);
}

function dblclickRow(e) {
	var rowId = e.rowId;
	$mytable.mytable('editRow', rowId);
	/*var rowData = mytable.getRowData(rowId);
	if (isFolder(rowData)) {
		loadFolder(rowData);
	} else {
		downloadFile(rowData);
	}*/
}

function isFolder(rowData) {
	var isDir = rowData.isDir;
	if (isDir === true) {
		return true;
	} else {
		return false;
	}
}

function loadFolder(rowData) {
	var name = rowData.name;
	log('load folder: ' + name);
}

function downloadFile(rowData) {
	var name = rowData.name;
	log('download file: ' + name);
}

function sortDate(a, b) {
	var valA = a['modified'], valB = b['modified'];
	if (valA < valB) {
		return -1;
	}
	if (valA > valB) {
		return 1;
	}
	return 0;
}

$(function() {
	// to prevent the selection after the Shift + click in IE
	document.onselectstart = function() {
		return false;
	}
	
	$mytable = $('#my-table').mytable(options);
	$mytable.on('loaded', afterLoad);
	$mytable.on('dblclickRow', dblclickRow);
	$mytable.on('saved', function(resp) {notify('Save operation success.', NotifyType.SUCCESS)});
	$mytable.on('deleted', function(resp) {notify('Delete operation success.', NotifyType.SUCCESS)});
	
	$('#add-btn').click(function() {
		$mytable.mytable('addRow', {name:'new folder'}, false);
	});
	$('#delete-btn').click(function() {
		$mytable.mytable('deleteRow', $mytable.mytable('getSelectedRowIds'));
	});
});
</script>