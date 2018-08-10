//+------------------------------------------------------------------+
//|                                                       Ordini.mqh |
//|                                          Cesare - BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"

MqlTradeRequest request={0};
MqlTradeResult  result={0};


void ordini(ulong Expert_MN, ENUM_ORDER_TYPE order_type, string purpose, double volume, string comment) {

   if(purpose != "close") {
      ZeroMemory(request);                                        //clear data
      ZeroMemory(result);                                         // clear data from other orders (valid from 2° order)   
      request.position  =  result.deal;                           // ticket ID
      request.action    =  TRADE_ACTION_DEAL;                     // type of trade operation
      request.symbol    =  Symbol();                              // symbol
      request.volume    =  volume;                                // volume 
      request.type      =  order_type;                            // order type
      request.price     =  SymbolInfoDouble(Symbol(),SYMBOL_ASK); // current price
      request.deviation = 10;                                     // accepted deviation from current price
      request.type_filling = ORDER_FILLING_FOK;                   // filling type -> means all or nothing
      request.comment = comment;                                  // comment for excel purposes
      request.magic = Expert_MN;                                  // magic number
   }
   
   else {
      request.position  =  result.deal;                           // ticket ID
      request.action    =  TRADE_ACTION_DEAL;                     // type of trade operation
      request.symbol    =  Symbol();                              // symbol
      request.volume    =  volume;                                // volume 
      request.type      =  order_type;                            // order type
      request.price     =  SymbolInfoDouble(Symbol(),SYMBOL_ASK); // current price
      request.deviation = 10;                                     // accepted deviation from current price
      request.type_filling = ORDER_FILLING_FOK;                   // filling type -> means all or nothing
      request.comment = comment;                                  // comment for excel purposes
      request.magic = Expert_MN;                                  // magic number
   }
   
   if(OrderSend(request,result))
      printf("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
   else
      GetLastError();

}