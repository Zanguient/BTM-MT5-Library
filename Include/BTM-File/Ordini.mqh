//+------------------------------------------------------------------+
//|                                                       Ordini.mqh |
//|                                          Cesare - BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"


MqlTradeRequest request={0};
MqlTradeResult  result={0};

void openPositionAtMarket(string symbol, ENUM_ORDER_TYPE order_type, double volume, double sl, double tp, string comment, ulong Expert_MN) { // open new position

      ZeroMemory(request);                                                                                                      // clear data
      ZeroMemory(result);                                                                                                       // clear data from other orders (valid from 2° order)   
      request.action    =  TRADE_ACTION_DEAL;                                                                                   // type of trade operation
      request.symbol    =  symbol;                                                                                              // symbol
      request.volume    =  volume;                                                                                              // volume 
      request.type      =  order_type;                                                                                          // order type
      if(order_type == ORDER_TYPE_BUY)                                                                                          // decide the pricing when opening the position --> go to market
         request.price = SymbolInfoDouble(Symbol(),SYMBOL_ASK);                                                                 // ^
      else                                                                                                                      // ^
         request.price = SymbolInfoDouble(Symbol(),SYMBOL_BID);                                                                 // ^  
      request.deviation =  ulong((SymbolInfoDouble(Symbol(),SYMBOL_ASK) - SymbolInfoDouble(Symbol(),SYMBOL_BID)) * 10);         // accepted deviation from current price
      request.type_filling = ORDER_FILLING_FOK;                                                                                 // filling type -> means all or nothing
      request.comment = MQLInfoString(MQL_PROGRAM_NAME);                                                                        // comment for excel purposes
      request.magic = Expert_MN;                                                                                                // magic number

   if(OrderSend(request,result))                                                                                                // send order to market and close the position
      printf("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
   else
      GetLastError();

}

void closePosition(long Expert_MN) {                                                                                            // close the last opened position for the current EA

      request.position = findTicketFromMN(Expert_MN);                                                                           // ticket ID  
      request.action = TRADE_ACTION_DEAL;                                                                                       // type of trade operation
      request.symbol = PositionGetString(POSITION_SYMBOL);                                                                      // symbol
      request.volume = PositionGetDouble(POSITION_VOLUME);                                                                      // volume 
      if(PositionGetInteger(POSITION_TYPE) == ORDER_TYPE_BUY) {                                                                 // decide what to do according to openPositionAtMarket
         request.type = ORDER_TYPE_SELL;                                                                                        // ^
         request.price = SymbolInfoDouble(Symbol(),SYMBOL_BID);                                                                 // ^
        }                                                                                                                       // ^
      else {                                                                                                                    // ^
         request.type = ORDER_TYPE_BUY;                                                                                         // ^
         request.price = SymbolInfoDouble(Symbol(),SYMBOL_ASK);                                                                 // ^
        }                                                                                                                       // ^
      request.deviation = ulong((SymbolInfoDouble(Symbol(),SYMBOL_ASK) - SymbolInfoDouble(Symbol(),SYMBOL_BID)) * 10);          // accepted deviation from current price
      request.type_filling = ORDER_FILLING_FOK;                                                                                 // filling type -> means all or nothing
      request.comment = MQLInfoString(MQL_PROGRAM_NAME);                                                                        // comment for excel purposes
      
   if(OrderSend(request,result))                                                                                                // send order to market and close the position
      printf("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
   else
      GetLastError();


}

ulong findTicketFromMN (long Magic_Number) export {                                                                             //return the last opened position from the current EA

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