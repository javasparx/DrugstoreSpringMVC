<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="col-lg-12">
    <div class="well bs-component">

        <form:form name="searchform" action="/search" method="GET" cssClass="form-horizontal">
            <%--<img src="<c:url value="/resources/images/showcase-logo.png" />"--%>
            <%--height="50px"--%>
            <%--title="sping-data-solr-showcase"/>--%>
            <div class="input-group">
                <span class="input-group-addon">$</span>
                    <%--<label class="sr-only" for="queryField">Search</label>--%>
                    <%--<input type="email" class="form-control" id="exampleInputEmail2" placeholder="Enter email">--%>
                <input id="queryField" class="form-control" name="q" type="text" value="${query}" placeholder="Search">
        <span class="input-group-btn">
            <input class="btn btn-success" type="submit" value="Search">
        </span>
            </div>

            <script type="text/javascript">
                $(function () {
                    $("#queryField").autocomplete({
                        source: '<c:url value="/app/autocomplete"/>',
                        minLength: 1,

                        select: function (event, ui) {
                            $("#queryField").value = ui.item.value;
                            document.searchform.submit();
                        }
                    });
                });
            </script>
            <%--<input type="submit" class="btn btn-success" value="Search"/>--%>
        </form:form>
    </div>
</div>
<%--<div class="col-lg-12">--%>
<%--<input type="text" style="margin: 0 auto;" data-provide="typeahead" data-items="4">--%>

<%--<script type="text/javascript">--%>
<%--$(function () {--%>

<%--$('.typeahead').typeahead({--%>
<%--source: function (query, process) {--%>
<%--return $.get('<c:url value="/app/autocomplete"/>', { query: query }, function (data) {--%>
<%--return process(data.options);--%>
<%--});--%>
<%--}--%>
<%--});--%>

<%--});--%>
<%--</script>--%>
<%--</div>--%>