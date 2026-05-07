<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>

<%-- Guard: redirect if accessed directly without calculation --%>
<c:if test="${empty tax}">
    <c:redirect url="/index.jsp"/>
</c:if>

<%-- Compute effective rate and status label in scriptlet --%>
<%
    double income  = (Double) request.getAttribute("income");
    double tax     = (Double) request.getAttribute("tax");
    double pct     = income > 0 ? (tax / income) * 100.0 : 0.0;
    String status;
    String badgeCls;
    if (tax == 0)      { status = "Tax Exempt";           badgeCls = "badge-g"; }
    else if (pct < 15) { status = "Low Tax Bracket";      badgeCls = "badge-g"; }
    else if (pct < 25) { status = "Standard Bracket";     badgeCls = "badge-y"; }
    else               { status = "High Tax Bracket";     badgeCls = "badge-r"; }
    pageContext.setAttribute("pct",      pct);
    pageContext.setAttribute("status",   status);
    pageContext.setAttribute("badgeCls", badgeCls);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tax Result – TaxCalc JSP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%-- ═══ HEADER ═══ --%>
<header>
    <div class="logo"><div class="logo-dot"></div> TaxCalc JSP</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Calculator</a>
        <a href="${pageContext.request.contextPath}/history.jsp">History</a>
        <a href="${pageContext.request.contextPath}/about.jsp">About</a>
        <span class="nav-badge">JSP 2.3</span>
    </nav>
</header>

<main>
    <div class="hero" style="padding-top:3rem; padding-bottom:1rem">
        <div class="hero-tag">Result · Request Scope · Servlet Forward</div>
        <h1>Your Tax<br>Summary</h1>
    </div>

    <div class="grid-2">

        <%-- ═══ LEFT: RESULT BREAKDOWN ═══ --%>
        <div class="card">
            <div class="card-head">
                <div class="card-head-icon">📊</div>
                <h2>Tax Computation Result</h2>
            </div>
            <div class="card-body">

                <%-- Big tax amount --%>
                <div class="result-amount">
                    <div class="result-label">Total Tax Payable</div>
                    <div class="result-tax">
                        <%-- EL Expression renders server-calculated value --%>
                        ₹<fmt:formatNumber value="${tax}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </div>
                    <div class="result-net">
                        Net income:
                        <strong>
                            ₹<fmt:formatNumber value="${netIncome}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                        </strong>
                    </div>
                </div>

                <%-- Tax bar --%>
                <div class="bar-wrap">
                    <div class="bar-labels">
                        <span>Tax portion</span>
                        <span><fmt:formatNumber value="${pct}" maxFractionDigits="1"/>%</span>
                    </div>
                    <div class="bar-track">
                        <div class="bar-fill" style="width: <fmt:formatNumber value="${pct}" maxFractionDigits="1"/>%;"></div>
                    </div>
                </div>

                <%-- Breakdown rows --%>
                <div class="br-row">
                    <span class="lbl">Account Type</span>
                    <span class="val">
                        <c:choose>
                            <c:when test="${accountType == 'savings'}">🏦 Savings Account</c:when>
                            <c:otherwise>🏢 Business Account</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="br-row">
                    <span class="lbl">Gross Income</span>
                    <span class="val">
                        ₹<fmt:formatNumber value="${income}" type="number" minFractionDigits="2"/>
                    </span>
                </div>
                <div class="br-row">
                    <span class="lbl">Tax Bracket</span>
                    <span class="val">${bracket}</span>
                </div>
                <div class="br-row">
                    <span class="lbl">Effective Rate</span>
                    <span class="val"><fmt:formatNumber value="${pct}" maxFractionDigits="2"/>%</span>
                </div>
                <div class="br-row hl">
                    <span class="lbl">Tax Amount</span>
                    <span class="val">
                        ₹<fmt:formatNumber value="${tax}" type="number" minFractionDigits="2"/>
                    </span>
                </div>
                <div class="br-row">
                    <span class="lbl">Status</span>
                    <span class="val">
                        <span class="badge ${badgeCls}">${status}</span>
                    </span>
                </div>

                <%-- JSP EL snippet showing how value was rendered --%>
                <div class="jsp-snip">
                    <span class="t">&lt;%=</span> <span class="a">taxBean.calculateTax()</span> <span class="t">%&gt;</span><br>
                    <%-- Server rendered: --%>
                    <span class="v">// → ₹<fmt:formatNumber value="${tax}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>

                <%-- Actions --%>
                <div style="display:flex; gap:.75rem; margin-top:1.25rem">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn" style="flex:1">← Calculate Again</a>
                    <a href="${pageContext.request.contextPath}/history.jsp" class="btn btn-outline" style="flex:1">View History</a>
                </div>

            </div>
        </div>

        <%-- ═══ RIGHT: JAVA SOURCE PANEL ═══ --%>
        <div>
            <div class="card">
                <div class="card-head">
                    <div class="card-head-icon">☕</div>
                    <h2>Java Class Used</h2>
                </div>
                <div class="card-body">
                    <div class="jsp-snip" style="font-size:.73rem">
                        <c:choose>
                            <c:when test="${accountType == 'savings'}">
<span class="t">class</span> <span class="a">SavingsAccount</span> <span class="t">extends</span> <span class="a">Account</span> {<br>
&nbsp;&nbsp;<span class="t">double</span> <span class="a">calculateTax()</span> {<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">if</span> (income &lt;= <span class="v">50000</span>)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">return</span> <span class="v">0</span>;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">else if</span> (income &lt;= <span class="v">100000</span>)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">return</span> income * <span class="v">0.10</span>;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">else</span><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">return</span> income * <span class="v">0.15</span>;<br>
&nbsp;&nbsp;}<br>
}
                            </c:when>
                            <c:otherwise>
<span class="t">class</span> <span class="a">BusinessAccount</span> <span class="t">extends</span> <span class="a">Account</span> {<br>
&nbsp;&nbsp;<span class="t">double</span> <span class="a">calculateTax()</span> {<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">if</span> (income &lt;= <span class="v">100000</span>)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">return</span> income * <span class="v">0.20</span>;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">else</span><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="t">return</span> income * <span class="v">0.30</span>;<br>
&nbsp;&nbsp;}<br>
}
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <p style="font-size:.78rem; color:var(--text-muted); margin-top:.75rem; line-height:1.7">
                        Input income
                        <strong style="color:var(--gold)">
                            ₹<fmt:formatNumber value="${income}" type="number"/>
                        </strong>
                        was passed to
                        <strong style="color:var(--gold)">
                            <c:choose>
                                <c:when test="${accountType == 'savings'}">SavingsAccount</c:when>
                                <c:otherwise>BusinessAccount</c:otherwise>
                            </c:choose>
                        </strong>
                        and <code style="color:var(--gold)">calculateTax()</code> returned
                        <strong style="color:var(--gold)">
                            ₹<fmt:formatNumber value="${tax}" type="number" minFractionDigits="2"/></strong>.
                    </p>
                </div>
            </div>

            <%-- Scope info card --%>
            <div class="card" style="margin-top:1.5rem">
                <div class="card-head">
                    <div class="card-head-icon">🔁</div>
                    <h2>JSP Scope Info</h2>
                </div>
                <div class="card-body">
                    <div class="br-row">
                        <span class="lbl">income</span>
                        <span class="val" style="font-size:.78rem">request scope</span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">tax</span>
                        <span class="val" style="font-size:.78rem">request scope</span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">history</span>
                        <span class="val" style="font-size:.78rem">session scope</span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">slabData</span>
                        <span class="val" style="font-size:.78rem">application scope</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/footer.jspf" %>
</body>
</html>
