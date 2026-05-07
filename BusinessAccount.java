package com.tax;

public class BusinessAccount extends Account {

    public BusinessAccount(double income) {
        super(income);
    }

    @Override
    public double calculateTax() {
        if (income <= 100000)
            return income * 0.20;
        else
            return income * 0.30;
    }

    public String getTaxBracket() {
        if (income <= 100000)
            return "₹0 – ₹1,00,000 (20%)";
        else
            return "Above ₹1,00,000 (30%)";
    }
}
