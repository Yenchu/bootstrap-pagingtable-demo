<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${asset}/datepicker/datepicker.css" rel="stylesheet">
<link href="${asset}/bootstrap-pagingtable/bootstrap-pagingtable.css" rel="stylesheet">
<style>
.datepicker {
  z-index: 9999;
}
.paging-bar {
  background-color: #f5f5f5;
}
.icon-chevron-right {
  float: right;
  margin-top: 2px;
  margin-right: -6px;
  opacity: .25;
}
a:hover .icon-chevron-right {
  opacity: .5;
}
.active .icon-chevron-right,
.active a:hover .icon-chevron-right {
  opacity: 1;
}
</style>