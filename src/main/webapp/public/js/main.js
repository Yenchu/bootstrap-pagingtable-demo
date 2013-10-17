/*
 * common JS functions for demo.
 */
function dateEditor(colValue, colModel) {
	var editor = '<input type="text" class="date-picker form-control" name="' + colModel.name + '" value="' + colValue + '">';
	return editor;
}

function addRow($table) {
	$table.pagingtable('addRow');
	$('.date-picker').datepicker({format:'yyyy-mm-dd'});
}

function editRow($table, rowId) {
	$table.pagingtable('updateRow', rowId);
	$('.date-picker').datepicker({format:'yyyy-mm-dd'});
}

function deleteRow($table, rowId) {
	if (!rowId) {
		rowId = $table.pagingtable('getSelectedRowId');
	}
	if (!rowId) {
		alert('Please select a row!');
		return;
	}
	$table.pagingtable('deleteRow', {id:rowId, displayColName:'name'});
}

function deleteRows($table, rowIds) {
	if (!rowIds) {
		rowIds = $table.pagingtable('getSelectedRowIds');
	}
	if (!rowIds) {
		alert('Please select a row!');
		return;
	}
	$table.pagingtable('deleteRow', {id:rowIds, displayColName:'name'});
}