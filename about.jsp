<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About – TaxCalc JSP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .about-section { margin-bottom: 2rem; }
        .about-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.35rem; color: var(--gold); margin-bottom: .85rem;
        }
        .about-section p {
            font-size: .9rem; color: var(--text-muted);
            line-height: 1.8; margin-bottom: .65rem;
        }
        .code-block {
            background: var(--bg); border: 1px solid var(--border2);
            border-radius: var(--radius-sm);
            padding: 1rem 1.2rem; font-family: 'Courier New', monospace;
            font-size: .75rem; color: #8fa88d;
            line-height: 1.85; overflow-x: auto; margin: .85rem 0;
        }
        .code-block .kw { color: #6b8fa3; }
        .code-block .cl { color: #c89e6b; }
        .code-block .nm { color: #c87e6b; }
        .code-block .cm { color: var(--text-hint); }

        .file-tree {
            font-family: 'Courier New', monospace; font-size: .78rem;
            color: var(--text-muted); line-height: 2;
        }
        .file-tree .dir  { color: var(--gold); }
        .file-tree .file { color: #8fa88d; }
        .file-tree .note { color: var(--text-hint); font-style: italic; }
    </style>
</head>
<body>

<header>
    <div class="logo"><div class="logo-dot"></div> TaxCalc JSP</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Calculator</a>
        <a href="${pageContext.request.contextPath}/history.jsp">History</a>
        <a href="${pageContext.request.contextPath}/about.jsp" class="active">About</a>
        <span class="nav-badge">JSP 2.3</span>
    </nav>
</header>

<main>
    <div class="hero" style="padding-top:3rem; padding-bottom:1.5rem; text-align:left; max-width:760px; margin:0 auto">
        <div class="hero-tag">About This Project</div>
        <h1 style="font-size:2.2rem">Java Tax Calculator<br>JSP Web Edition</h1>
    </div>

    <div class="page-wrap">

        <%-- ── Architecture ── --%>
        <div class="about-section">
            <h2>Architecture</h2>
            <p>
                This is a classic <strong style="color:var(--text)">MVC JSP/Servlet</strong> web application.
                The <strong style="color:var(--text)">Model</strong> is the original Java class hierarchy —
                abstract <code style="color:var(--gold)">Account</code> with two concrete subclasses.
                The <strong style="color:var(--text)">Controller</strong> is
                <code style="color:var(--gold)">TaxCalculatorServlet</code>, which receives POST requests,
                instantiates the correct account, computes tax, and forwards to the
                <strong style="color:var(--text)">View</strong> — <code style="color:var(--gold)">result.jsp</code>.
            </p>
        </div>

        <%-- ── File Structure ── --%>
        <div class="about-section">
            <h2>Project Structure</h2>
            <div class="code-block">
                <div class="file-tree">
<span class="dir">TaxCalculatorJSP/</span><br>
├── <span class="dir">src/main/</span><br>
│   ├── <span class="dir">java/com/tax/</span><br>
│   │   ├── <span class="file">Account.java</span>              <span class="note">← abstract base class</span><br>
│   │   ├── <span class="file">SavingsAccount.java</span>       <span class="note">← 0/10/15% logic</span><br>
│   │   ├── <span class="file">BusinessAccount.java</span>      <span class="note">← 20/30% logic</span><br>
│   │   ├── <span class="file">TaxCalculatorServlet.java</span> <span class="note">← controller</span><br>
│   │   ├── <span class="file">ClearHistoryServlet.java</span>  <span class="note">← session reset</span><br>
│   │   └── <span class="file">TaxRecord.java</span>            <span class="note">← session POJO</span><br>
│   └── <span class="dir">webapp/</span><br>
│       ├── <span class="file">index.jsp</span>                 <span class="note">← calculator form</span><br>
│       ├── <span class="file">result.jsp</span>                <span class="note">← result view</span><br>
│       ├── <span class="file">history.jsp</span>               <span class="note">← session history</span><br>
│       ├── <span class="file">about.jsp</span>                 <span class="note">← this page</span><br>
│       ├── <span class="dir">css/style.css</span><br>
│       └── <span class="dir">WEB-INF/</span><br>
│           ├── <span class="file">web.xml</span><br>
│           └── <span class="file">footer.jspf</span>           <span class="note">← shared fragment</span><br>
└── <span class="file">pom.xml</span>                           <span class="note">← Maven build</span>
                </div>
            </div>
        </div>

        <%-- ── Original Java ── --%>
        <div class="about-section">
            <h2>Original Java Source (preserved)</h2>
            <div class="code-block">
<span class="cm">// Abstract base class — unchanged from original project</span><br>
<span class="kw">abstract class</span> <span class="cl">Account</span> {<br>
&nbsp;&nbsp;<span class="kw">protected double</span> income;<br>
&nbsp;&nbsp;<span class="kw">abstract double</span> calculateTax();<br>
}<br><br>
<span class="kw">class</span> <span class="cl">SavingsAccount</span> <span class="kw">extends</span> <span class="cl">Account</span> {<br>
&nbsp;&nbsp;<span class="kw">double</span> calculateTax() {<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="kw">if</span> (income &lt;= <span class="nm">50000</span>)   <span class="kw">return</span> <span class="nm">0</span>;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="kw">if</span> (income &lt;= <span class="nm">100000</span>)  <span class="kw">return</span> income * <span class="nm">0.10</span>;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="kw">return</span> income * <span class="nm">0.15</span>;<br>
&nbsp;&nbsp;}<br>
}<br><br>
<span class="kw">class</span> <span class="cl">BusinessAccount</span> <span class="kw">extends</span> <span class="cl">Account</span> {<br>
&nbsp;&nbsp;<span class="kw">double</span> calculateTax() {<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="kw">if</span> (income &lt;= <span class="nm">100000</span>) <span class="kw">return</span> income * <span class="nm">0.20</span>;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span class="kw">return</span> income * <span class="nm">0.30</span>;<br>
&nbsp;&nbsp;}<br>
}
            </div>
        </div>

        <%-- ── How to Run ── --%>
        <div class="about-section">
            <h2>How to Run</h2>
            <p>Requires <strong style="color:var(--text)">Java 17+</strong>, <strong style="color:var(--text)">Maven 3.8+</strong>, and <strong style="color:var(--text)">Apache Tomcat 10.x</strong>.</p>
            <div class="code-block">
<span class="cm"># Build the WAR file</span><br>
mvn clean package<br><br>
<span class="cm"># Deploy to Tomcat (copy WAR to webapps/)</span><br>
cp target/TaxCalculatorJSP.war $CATALINA_HOME/webapps/<br><br>
<span class="cm"># Start Tomcat</span><br>
$CATALINA_HOME/bin/startup.sh<br><br>
<span class="cm"># Open in browser</span><br>
http://localhost:8080/TaxCalculatorJSP/
            </div>
        </div>

        <%-- Runtime info from server --%>
        <div class="about-section">
            <h2>Server Info <span style="font-size:.75rem; font-weight:400; color:var(--text-hint)">(live from JSP)</span></h2>
            <div class="card">
                <div class="card-body">
                    <div class="br-row">
                        <span class="lbl">Server</span>
                        <span class="val" style="font-size:.82rem">${pageContext.servletContext.serverInfo}</span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">Servlet API</span>
                        <span class="val" style="font-size:.82rem">
                            ${pageContext.servletContext.majorVersion}.${pageContext.servletContext.minorVersion}
                        </span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">Java Version</span>
                        <span class="val" style="font-size:.82rem">
                            <%=System.getProperty("java.version")%>
                        </span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">Context Path</span>
                        <span class="val" style="font-size:.82rem">${pageContext.request.contextPath}</span>
                    </div>
                    <div class="br-row">
                        <span class="lbl">Session ID</span>
                        <span class="val" style="font-size:.78rem; font-family:'Courier New',monospace">
                            ${pageContext.session.id.substring(0,16)}…
                        </span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/footer.jspf" %>
</body>
</html>
