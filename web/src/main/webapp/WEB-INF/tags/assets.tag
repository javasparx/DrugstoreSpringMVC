<%@ tag body-content="empty" %>
<%@ attribute name="group" required="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="base" value="${pageContext.request.contextPath}"/>
<c:if test="${empty group}"><c:set var="group" value="main"/></c:if>
<c:if test="${not empty param.debug}">
    <c:set var="debugAssets" value="${param.debug}" scope="session"/>
</c:if>
<c:choose>

    <c:when test="${sessionScope.debugAssets}">
        <link rel="stylesheet" type="text/css" href="${base}/webjars/bootswatch/3.2.0/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="${base}/webjars/jquery-ui/1.11.1/jquery-ui.min.css"/>
        <link rel="stylesheet" type="text/css" href="${base}/styles/style.css"/>
        <link rel="stylesheet" type="text/css" href="${base}/styles/magicsuggest-min.css"/>

        <script type="text/javascript" src="${base}/webjars/jquery/1.8.3/jquery.min.js"></script>
        <script type="text/javascript" src="${base}/webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${base}/webjars/jquery-cookie/1.3.1/jquery.cookie.js"></script>
        <script type="text/javascript" src="${base}/webjars/typeahead.js/0.9.3/typeahead.js"></script>
        <script type="text/javascript" src="${base}/scripts/script.js"></script>
        <script type="text/javascript" src="${base}/scripts/magicsuggest-min.js"></script>
    </c:when>
    <c:otherwise>
        <link rel="stylesheet" type="text/css" href="${base}/assets/v/${applicationScope.assetsVersion}/${group}.css"/>
        <script type="text/javascript" src="${base}/assets/v/${applicationScope.assetsVersion}/${group}.js"></script>
    </c:otherwise>
</c:choose>