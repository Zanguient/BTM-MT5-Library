//+------------------------------------------------------------------+
//|                                                       Ordini.mqh |
//|                                          Cesare - BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"

#include <Trade\Trade.mqh>
CTrade mytrade;
CSymbolInfo mysymbol;
COrderInfo myorder;

//--- declare and initialize the trade request and result of trade request

void sendOrder(ENUM_ORDER_TYPE order_type,double volume, ulong deviation, double sl,double tp, ulong Magic_No, const string comment) {

   //mytrade.PositionOpen(symbol,order_type,volume,mysymbol.Ask(),sl,tp,comment);
   
   // define the input parameters and use the CSymbolInfo class
   // object to get the current ASK/BID price
   double Lots = volume;
   // Stoploss must have been defined 
   double SL = sl;
   //Takeprofit must have been defined 
   double TP = tp; 
   // latest ask price using CSymbolInfo class object
   double Oprice = mysymbol.Ask();
   // open a buy trade
   ulong Deviation = deviation;
   
   mytrade.SetDeviationInPoints(Deviation);
   
   mytrade.SetExpertMagicNumber(Magic_No);
   
   
   mytrade.PositionOpen(_Symbol,order_type,Lots,Oprice,SL,TP,"Test Buy");

}

void closePosition() export {



/*if (myposition.Select(_Symbol))
{
 mytrade.PositionClose(_Symbol);  
}*/


}