package com.tax;

public class SavingsAccount extends Account {

    public SavingsAccount(double income) {
        super(income);
    }

    @Override
    public double calculateTax() {
        if (income <= 50000)
            return 0;
        else if (income <= 100000)
            return income * 0.10;
        else
            return income * 0.15;
    }

    public String getTaxBracket() {
        if (income <= 50000)
            return "₹0 – ₹50,000 (0% — Exempt)";
        else if (income <= 100000)
            return "₹50,001 – ₹1,00,000 (10%)";
        else
            return "Above ₹1,00,000 (15%)";
    }
}
