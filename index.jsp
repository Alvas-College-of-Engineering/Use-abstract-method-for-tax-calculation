<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tax Calculator – Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%-- ═══ HEADER ═══ --%>
<header>
    <div class="logo"><div class="logo-dot"></div> TaxCalc JSP</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp" class="active">Calculator</a>
        <a href="${pageContext.request.contextPath}/history.jsp">History</a>
        <a href="${pageContext.request.contextPath}/about.jsp">About</a>
        <span class="nav-badge">JSP 2.3</span>
    </nav>
</header>

<main>
    <%-- ═══ HERO ═══ --%>
    <div class="hero">
        <div class="hero-tag">Dynamic Web Application · JSP + Java Servlets</div>
        <h1>Smart Tax<br>Calculator</h1>
        <p>Server-side tax computation using Java polymorphism — SavingsAccount and BusinessAccount.</p>
    </div>

    <div class="grid-2">

        <%-- ═══ LEFT: FORM ═══ --%>
        <div class="card">
            <div class="card-head">
                <div class="card-head-icon">📋</div>
                <h2>Tax Computation Form</h2>
            </div>
            <div class="card-body">

                <%-- JSP useBean declaration snippet --%>
                <div class="jsp-snip">
                    <span class="t">&lt;jsp:useBean</span>
                    <span class="a"> id=</span><span class="v">"taxBean"</span>
                    <span class="a"> class=</span><span class="v">"com.tax.Account"</span>
                    <span class="a"> scope=</span><span class="v">"request"</span>
                    <span class="t"> /&gt;</span>
                </div>

                <%-- Error banner (set by servlet on validation failure) --%>
                <c:if test="${not empty error}">
                    <div class="error-banner">⚠ ${error}</div>
                </c:if>

                <%-- POST to TaxCalculatorServlet --%>
                <form action="${pageContext.request.contextPath}/calculate" method="post">

                    <%-- Account Type --%>
                    <div class="form-group">
                        <label class="form-label">Account Type</label>
                        <div class="account-grid">
                            <label class="acct-card active" id="card-savings">
                                <input type="radio" name="accountType" value="savings" checked
                                       onclick="toggleCard('savings')">
                                <div class="acct-icon">🏦</div>
                                <div class="acct-name">Savings</div>
                                <div class="acct-rate">0% · 10% · 15%</div>
                            </label>
                            <label class="acct-card" id="card-business">
                                <input type="radio" name="accountType" value="business"
                                       onclick="toggleCard('business')">
                                <div class="acct-icon">🏢</div>
                                <div class="acct-name">Business</div>
                                <div class="acct-rate">20% · 30%</div>
                            </label>
                        </div>
                    </div>

                    <%-- Income --%>
                    <div class="form-group">
                        <label class="form-label" for="income">Annual Income</label>
                        <div class="input-wrap">
                            <span class="input-pre">₹</span>
                            <input type="number" id="income" name="income" class="form-control"
                                   placeholder="Enter your income" min="0" step="1000"
                                   value="${param.income}" required>
                        </div>
                    </div>

                    <%-- Quick preset (client-side convenience) --%>
                    <div class="form-group">
                        <label class="form-label" for="quick">Quick Preset</label>
                        <select id="quick" class="form-control" onchange="setIncome(this.value)">
                            <option value="">— Choose a preset —</option>
                            <option value="40000">₹40,000 · Below threshold</option>
                            <option value="75000">₹75,000 · Mid bracket</option>
                            <option value="150000">₹1,50,000 · High bracket</option>
                            <option value="500000">₹5,00,000 · Premium</option>
                        </select>
                    </div>

                    <button type="submit" class="btn">Calculate Tax →</button>
                </form>
            </div>
        </div>

        <%-- ═══ RIGHT: SLAB REFERENCE ═══ --%>
        <div>
            <div class="card">
                <div class="card-head">
                    <div class="card-head-icon">📑</div>
                    <h2>Tax Slab Reference</h2>
                </div>
                <div class="card-body" style="padding: 0.5rem 0;">
                    <table class="slab-table">
                        <thead>
                            <tr>
                                <th>Account</th>
                                <th>Income Range</th>
                                <th>Rate</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td rowspan="3">🏦 Savings</td>
                                <td>₹0 – ₹50,000</td>
                                <td><span class="badge badge-g">0%</span></td>
                            </tr>
                            <tr>
                                <td>₹50,001 – ₹1,00,000</td>
                                <td><span class="badge badge-y">10%</span></td>
                            </tr>
                            <tr>
                                <td>Above ₹1,00,000</td>
                                <td><span class="badge badge-r">15%</span></td>
                            </tr>
                            <tr style="border-top: 1px solid rgba(255,255,255,.07)">
                                <td rowspan="2">🏢 Business</td>
                                <td>₹0 – ₹1,00,000</td>
                                <td><span class="badge badge-y">20%</span></td>
                            </tr>
                            <tr>
                                <td>Above ₹1,00,000</td>
                                <td><span class="badge badge-r">30%</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <%-- JSP EL info box --%>
            <div class="card" style="margin-top:1.5rem">
                <div class="card-head">
                    <div class="card-head-icon">⚙️</div>
                    <h2>How It Works</h2>
                </div>
                <div class="card-body">
                    <div class="jsp-snip">
                        <span class="t">&lt;%@</span> <span class="a">page</span>
                        <span class="v"> import="com.tax.*"</span> <span class="t">%&gt;</span><br>
                        <span class="t">&lt;%</span><br>
                        &nbsp;&nbsp;<span class="a">Account acc = </span><span class="v">new SavingsAccount(income)</span>;<br>
                        &nbsp;&nbsp;<span class="a">double tax = </span><span class="v">acc.calculateTax()</span>;<br>
                        &nbsp;&nbsp;<span class="a">request.setAttribute(</span><span class="v">"tax"</span><span class="a">, tax)</span>;<br>
                        <span class="t">%&gt;</span><br>
                        <span class="t">&lt;p&gt;</span>Tax: <span class="t">${</span><span class="a">tax</span><span class="t">}&lt;/p&gt;</span>
                    </div>
                    <p style="font-size:.8rem; color:var(--text-muted); margin-top:.85rem; line-height:1.7;">
                        Form POSTs to <code style="color:var(--gold)">TaxCalculatorServlet</code>,
                        which instantiates the correct <code style="color:var(--gold)">Account</code> subclass,
                        calls <code style="color:var(--gold)">calculateTax()</code>,
                        and forwards to <code style="color:var(--gold)">result.jsp</code>
                        with request-scoped attributes.
                    </p>
                </div>
            </div>
        </div>

    </div><%-- end grid --%>
</main>

<%@ include file="/WEB-INF/footer.jspf" %>

<script>
    function toggleCard(type) {
        document.getElementById('card-savings').classList.toggle('active', type === 'savings');
        document.getElementById('card-business').classList.toggle('active', type === 'business');
    }
    function setIncome(val) {
        if (val) document.getElementById('income').value = val;
    }
</script>
</body>
</html>
