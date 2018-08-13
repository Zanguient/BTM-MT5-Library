//+------------------------------------------------------------------+
//|                                                       Ordini.mqh |
//|                                          Cesare - BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"

MqlTradeRequest request={0};
MqlTradeResult  result={0};


void sendOrder(ulong Expert_MN, ENUM_ORDER_TYPE order_type, string purpose, double volume) {

   if(purpose != "close") {
      ZeroMemory(request);                                        // clear data
      ZeroMemory(result);                                         // clear data from other orders (valid from 2° order)   
      request.position  =  result.deal;                           // ticket ID
      request.action    =  TRADE_ACTION_DEAL;                     // type of trade operation
      request.symbol    =  Symbol();                              // symbol
      request.volume    =  volume;                                // volume 
      request.type      =  order_type;                            // order type
      request.price     =  SymbolInfoDouble(Symbol(),SYMBOL_ASK); // current price
      request.deviation =  ulong((SymbolInfoDouble(Symbol(),SYMBOL_ASK) - SymbolInfoDouble(Symbol(),SYMBOL_BID)) * 10);                                    // accepted deviation from current price
      request.type_filling = ORDER_FILLING_FOK;                   // filling type -> means all or nothing
      request.comment = MQLInfoString(MQL_PROGRAM_NAME);                                  // comment for excel purposes
      request.magic = Expert_MN;                                  // magic number
   }
   
   else {
      request.position  =  findTicketFromMN(Expert_MN);           // ticket ID
      request.action    =  TRADE_ACTION_DEAL;                     // type of trade operation
      request.symbol    =  Symbol();                              // symbol
      request.volume    =  result.volume;                         // volume 
      request.type      =  order_type;                            // order type
      request.price     =  SymbolInfoDouble(Symbol(),SYMBOL_ASK); // current price
      request.deviation = ulong((SymbolInfoDouble(Symbol(),SYMBOL_ASK) - SymbolInfoDouble(Symbol(),SYMBOL_BID)) * 10);                                     // accepted deviation from current price
      request.type_filling = ORDER_FILLING_FOK;                   // filling type -> means all or nothing
      request.comment = MQLInfoString(MQL_PROGRAM_NAME);                                  // comment for excel purposes
      request.magic = Expert_MN;                                  // magic number
   }
   
   if(OrderSend(request,result))
      printf("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
   else
      GetLastError();

}


ulong findTicketFromMN (long Magic_Number) export {

   int total = PositionsTotal();
   ulong position_ticket;
   long position_magic;
   bool position_select;
   
   for(int i=total-1;i>=0;i--)
     {
      position_select = PositionSelect(_Symbol);
      position_ticket = PositionGetTicket(i);
      position_magic = PositionGetInteger(POSITION_MAGIC);
      if(position_magic == Magic_Number)
         return(position_ticket);
     }
   return(0);
   
}