package com.tax;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class TaxRecord {
    private double income;
    private String accountType;
    private double tax;
    private String bracket;
    private String time;

    public TaxRecord(double income, String accountType, double tax, String bracket) {
        this.income      = income;
        this.accountType = accountType;
        this.tax         = tax;
        this.bracket     = bracket;
        this.time        = LocalTime.now().format(DateTimeFormatter.ofPattern("hh:mm a"));
    }

    public double getIncome()      { return income; }
    public String getAccountType() { return accountType; }
    public double getTax()         { return tax; }
    public String getBracket()     { return bracket; }
    public String getTime()        { return time; }
}
