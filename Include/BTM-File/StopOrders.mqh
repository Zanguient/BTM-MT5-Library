//+------------------------------------------------------------------+
//|                                                   StopOrders.mqh |
//|                                                   BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"

double SLATR(string symbol, ENUM_TIMEFRAMES timeframe, int period, double multiplier, string tradeDirection) export {

   double highLow[];
   double highCp[];
   double LCp[];
   double TR[];
   
   ArrayResize(highLow,period,1);
   ArrayResize(highCp,period,1);
   ArrayResize(LCp,period,1);
   ArrayResize(TR,period,1);

   double sumTR = 0;

   for(int i=1;i<period;i++)
     {
      highLow[i] = MathAbs(iHigh(symbol,timeframe,0) - iLow(symbol,timeframe,0));
      if(i == 1) {
         highCp[i] = 0;
         LCp[i] = 0;
      }
      else
      {
         highCp[i] = MathAbs(iHigh(symbol,timeframe,0) - iClose(symbol,timeframe,1));
         LCp[i] = MathAbs(iLow(symbol,timeframe,0) - iClose(symbol,timeframe,1));
      }
      
      TR[i] = MathMax(highLow[i], MathMax(highCp[i], LCp[i]));
      
      sumTR += TR[i];
      
     }

   double averageTrueRange = sumTR/ (ArraySize(TR)-1);

   double dAsk_Price = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double dBid_Price = SymbolInfoDouble(_Symbol,SYMBOL_BID);

   double SL;

   if(tradeDirection == "long")
      SL = NormalizeDouble(dBid_Price - (multiplier * averageTrueRange),Digits());
   else
      SL = NormalizeDouble(dAsk_Price + (multiplier * averageTrueRange),Digits());

   return(SL);

}

double TPAsSLMultiple(double prezzoIngresso, double SL, double multiplier) export {
   
   double tp;
   if(SL < prezzoIngresso) {
      tp = prezzoIngresso + MathAbs(prezzoIngresso - SL) * multiplier;
      return(tp);
   }
   else {
      tp = prezzoIngresso - MathAbs(prezzoIngresso - SL) * multiplier;
      return(tp);
   }
   
   return(0);

}