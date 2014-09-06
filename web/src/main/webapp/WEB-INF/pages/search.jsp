<%@ include file="/common/taglibs.jsp" %>

<head>
    <title><fmt:message key="search.title"/></title>
    <meta name="menu" content="Home"/>
    <script type="text/javascript">
        $(function () {

            <%--$('#queryField').typeahead({--%>
            <%--remote: '<c:url value="/app/autocomplete"/>?term=%QUERY',--%>
            <%--hint: false/*,--%>
            <%--selected: function (event, ui) {--%>
            <%--alert("asasasa");--%>
            <%--$("#queryField").value = ui.item.value;--%>
            <%--$('#searchform').submit();--%>
            <%--}*/--%>
            <%--});--%>

            jQuery.ajaxSettings.traditional = true;

            var ms = $('#magicsuggest').magicSuggest({
                placeholder: 'Make a selection',
                method: 'GET',
                name: 'q',
                data: '<c:url value="/app/autocomplete"/>',
                hideTrigger: true,
                maxSuggestions: 4,
                allowFreeEntries: false,
                useZebraStyle: true,
                ajaxConfig: {
                    traditional: true
                }
            });

//            $(ms).on('load', function () {
//                ms.setSelection([
//                    {name: 'Paris', value: 1}
//                ]);
//            });


        });
    </script>
</head>

<body>

<div class="col-lg-12">
    <%--<div class="well bs-component">--%>

        <form:form id="searchform" name="searchform" action="/search" method="POST" cssClass="form-horizontal">

        <div class="input-group">
                <%--<div id="magicsuggest" class="form-control input-lg"></div>--%>
                <%--value="${query}"--%>
            <input id="magicsuggest" class="form-control" type="text">

        <span class="input-group-btn">
                    <input class="btn btn-success" type="submit" value="Search">
        </span>

        </div>

    </form:form>
    <%--</div>--%>
</div>

<hr/>
<c:choose>
    <c:when test="${fn:length(page.content) == 0}">
        <div class="ui-state-highlight ui-corner-all" style="margin-top: 5px; padding: 0 .7em;">
            <p>
                <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                Sorry, no match found for <strong>'${query}'</strong>.
            </p>
        </div>
    </c:when>
    <c:otherwise>
        <div style="margin-top: 5px; padding: 0 .7em;">
            <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            Found ${page.totalElements} item(s).
        </div>
        <br/>
        <fmt:setLocale value="en_US"/>
        <c:forEach var="item" items="${page.content}" varStatus="status">
            <div class="ui-widget-content ui-corner-all"
                 style="margin-top: .5em; padding-left: .5em; background: ${status.index %2==0 ?'#eee':'#fff'}">
                <h3><a href="<c:url value="/product/${item.id}" />">${item.name}</a></h3>
                <c:if test="${fn:length(item.features) > 0}">${item.features[0]} <br/></c:if>
                <c:if test="${item.price != null}">Price: <fmt:formatNumber value="${item.price}" type="currency"/><br/></c:if>
                Available: ${item.available?"yes":"no"}<br/>
                <br/>
                <c:forEach var="highlight" items="${page.getHighlights(item) }" varStatus="highlightStatus">
                    ${highlight.getSnipplets()}
                </c:forEach>
            </div>
        </c:forEach>
        <br/>
        <jsp:include page="fragments/pager.jsp"></jsp:include>
    </c:otherwise>
</c:choose>
</body>