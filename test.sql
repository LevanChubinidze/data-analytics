SELECT Customer_No, SUM(Amount_LCY) AS Total
FROM Detailed_Customer_Ledger_Entries
GROUP BY Customer_No;
