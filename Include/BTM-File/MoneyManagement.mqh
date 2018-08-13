//+------------------------------------------------------------------+
//|                                              MoneyManagement.mqh |
//|                                                   BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"

double calculateLotsPercentageOfEquity(double risk, double entryLevel, double stopLoss) export {

   double tickValue = SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE);

   double lots = (AccountInfoDouble(ACCOUNT_EQUITY) * risk) / (tickValue * MathAbs(entryLevel - stopLoss) * MathPow(10,Digits()));
   return(lots);
}
