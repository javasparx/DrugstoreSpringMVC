<%@ include file="/common/taglibs.jsp" %>

<menu:useMenuDisplayer name="Velocity" config="navbarMenu.vm" permissions="rolesAdapter">
    <div class="collapse navbar-collapse" id="navbar">
        <ul class="nav navbar-nav">
            <c:if test="${empty pageContext.request.remoteUser}">
                <li class="active">
                    <a href="<c:url value="/login"/>"><fmt:message key="login.title"/></a>
                </li>
            </c:if>
                <%--TODO - make it welcome page and dynamic--%>
            <li>
                <a href="<c:url value="/app/search"/>"><fmt:message key="search.title"/></a>
            </li>
            <menu:displayMenu name="Home"/>
                <%--<menu:displayMenu name="Search"/>--%>
            <menu:displayMenu name="UserMenu"/>
            <menu:displayMenu name="AdminMenu"/>
            <menu:displayMenu name="Logout"/>
        </ul>
    </div>
</menu:useMenuDisplayer>
