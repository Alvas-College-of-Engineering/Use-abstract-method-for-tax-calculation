package com.tax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/calculate")
public class TaxCalculatorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String incomeStr   = request.getParameter("income");
        String accountType = request.getParameter("accountType");

        // ── Validation
        if (incomeStr == null || incomeStr.isEmpty() ||
            accountType == null || accountType.isEmpty()) {
            request.setAttribute("error", "Please fill in all fields.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        double income;
        try {
            income = Double.parseDouble(incomeStr);
            if (income < 0) throw new NumberFormatException("Negative");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid income amount. Please enter a positive number.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // ── Business logic (polymorphism from original Java project)
        Account account;
        String bracket;

        if ("savings".equals(accountType)) {
            SavingsAccount sa = new SavingsAccount(income);
            account  = sa;
            bracket  = sa.getTaxBracket();
        } else {
            BusinessAccount ba = new BusinessAccount(income);
            account  = ba;
            bracket  = ba.getTaxBracket();
        }

        double tax         = account.calculateTax();
        double netIncome   = account.getNetIncome();
        double effectiveRate = account.getEffectiveRate();

        // ── Store result in request scope → result.jsp
        request.setAttribute("income",        income);
        request.setAttribute("accountType",   accountType);
        request.setAttribute("tax",           tax);
        request.setAttribute("netIncome",     netIncome);
        request.setAttribute("effectiveRate", effectiveRate);
        request.setAttribute("bracket",       bracket);

        // ── Persist history in session scope
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<TaxRecord> history = (List<TaxRecord>) session.getAttribute("history");
        if (history == null) {
            history = new ArrayList<>();
        }
        history.add(0, new TaxRecord(income, accountType, tax, bracket));
        session.setAttribute("history", history);

        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
