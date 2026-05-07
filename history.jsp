<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>History – TaxCalc JSP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header>
    <div class="logo"><div class="logo-dot"></div> TaxCalc JSP</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Calculator</a>
        <a href="${pageContext.request.contextPath}/history.jsp" class="active">History</a>
        <a href="${pageContext.request.contextPath}/about.jsp">About</a>
        <span class="nav-badge">JSP 2.3</span>
    </nav>
</header>

<main>
    <div class="page-wrap">
        <h1>Calculation History</h1>
        <p class="sub">
            Stored in <code style="color:var(--gold)">HttpSession</code> scope —
            persists across requests until session expires or is cleared.
        </p>

        <%-- Session history list using JSTL c:forEach --%>
        <c:choose>
            <c:when test="${empty sessionScope.history}">
                <div class="empty-state">
                    <div style="font-size:2.5rem; opacity:.3; margin-bottom:.75rem">📋</div>
                    No calculations yet.
                    <a href="${pageContext.request.contextPath}/index.jsp"
                       style="color:var(--gold); display:block; margin-top:.5rem">
                        ← Go calculate
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <%-- Clear button --%>
                <div style="text-align:right; margin-bottom:1rem">
                    <a href="${pageContext.request.contextPath}/clearHistory"
                       class="btn btn-outline"
                       style="width:auto; display:inline-block; padding:.5rem 1.25rem; font-size:.78rem">
                        Clear History
                    </a>
                </div>

                <%-- Iterate session-scoped list --%>
                <c:forEach var="rec" items="${sessionScope.history}" varStatus="loop">
                    <div class="hist-item">
                        <div>
                            <div class="hi-type">
                                <c:choose>
                                    <c:when test="${rec.accountType == 'savings'}">🏦 Savings Account</c:when>
                                    <c:otherwise>🏢 Business Account</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="hi-inc">
                                ₹<fmt:formatNumber value="${rec.income}" type="number" minFractionDigits="2"/>
                            </div>
                            <div style="font-size:.72rem; color:var(--text-hint); margin-top:3px">
                                Bracket: ${rec.bracket}
                            </div>
                        </div>
                        <div class="hi-right">
                            <div class="hi-lbl">Tax Paid</div>
                            <div class="hi-tax">
                                ₹<fmt:formatNumber value="${rec.tax}" type="number" minFractionDigits="2"/>
                            </div>
                            <div class="hi-time">${rec.time}</div>
                            <div style="margin-top:4px">
                                <span class="badge ${rec.tax == 0 ? 'badge-g' : (rec.tax / rec.income * 100 < 15 ? 'badge-g' : (rec.tax / rec.income * 100 < 25 ? 'badge-y' : 'badge-r'))}">
                                    #${loop.index + 1}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <p style="font-size:.75rem; color:var(--text-hint); text-align:center; margin-top:1rem">
                    ${fn:length(sessionScope.history)} record(s) in this session
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<%@ include file="/WEB-INF/footer.jspf" %>
</body>
</html>
