package com.tax;

public abstract class Account {
    protected double income;

    public Account(double income) {
        this.income = income;
    }

    public double getIncome() {
        return income;
    }

    public abstract double calculateTax();

    public double getNetIncome() {
        return income - calculateTax();
    }

    public double getEffectiveRate() {
        if (income == 0) return 0;
        return (calculateTax() / income) * 100;
    }
}
