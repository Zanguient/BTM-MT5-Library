//+------------------------------------------------------------------+
//|                                                 dealWithTime.mqh |
//|                                          Cesare - BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"


int dayOfWeek(int dayToCheck) export { 

   MqlDateTime time;
   TimeCurrent(time);
   
   if(time.day_of_week == dayToCheck)
      return(true);   
   else
      return(false);

}

int hourOfDay(int hourToCheck, string comparison) export {

   MqlDateTime time;
   TimeCurrent(time);
   
   if(comparison == "greater")
      if(time.hour >= hourToCheck)
         return(true);
      else
         return(false);
         
   if(comparison == "smaller")
      if(time.hour < hourToCheck)
         return(true);
      else
         return(false);
         
    else
      return(false);

}

int minuteOfHour(int minuteToCheck, string comparison) export {

   MqlDateTime time;
   TimeCurrent(time);
   
   if(comparison == "greater")
      if(time.min >= minuteToCheck)
         return(true);
      else
         return(false);
         
   if(comparison == "smaller")
      if(time.min < minuteToCheck)
         return(true);
      else
         return(false);
         
    else
      return(false);

}