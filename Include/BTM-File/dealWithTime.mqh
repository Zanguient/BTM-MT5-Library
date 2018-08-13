//+------------------------------------------------------------------+
//|                                                 dealWithTime.mqh |
//|                                          Cesare - BacktestMarket |
//|                                   https://www.backtestmarket.com |
//+------------------------------------------------------------------+
#property copyright "Cesare - BacktestMarket"
#property link      "https://www.backtestmarket.com"


bool dayOfWeek(int dayToCheck) export {
// it's the weekday (0-Sunday, 1-Monday, ... ,6-Saturday)
   MqlDateTime time;
   TimeCurrent(time);

   if(time.day_of_week == dayToCheck)
      return(true);
   else
      return(false);

}

bool WeekdayCheck(bool TDW1, bool TDW2, bool TDW3, bool TDW4, bool TDW5, bool TDW6, bool TDW7) export {
/*
// the input parameters TDW1 is a bool and if it is true means that I want to trade in Monday, etc
input bool TDW_1 = 1; // Monday
input bool TDW_2 = 1; // Tuesday
input bool TDW_3 = 1; // Wednesday
input bool TDW_4 = 1; // Thursday
input bool TDW_5 = 1; // Friday
in this function I check if in this weekday I want to trade
*/
   MqlDateTime time;
   TimeCurrent(time);

   int w = time.day_of_week;

   if( (w == 1 && TDW1 == 1 ) || ( w == 2 && TDW2 == 1 ) || ( w == 3 && TDW3 == 1 ) || ( w == 4 && TDW4 == 1 ) || ( w == 5 && TDW5 == 1)  || ( w == 6 && TDW6 == 1) || ( w == 0 && TDW7 == 1))
      return(true);
   else
      return(false);
}

bool hourOfDay(int hourToCheck, string comparison) export {
// it's the hour of a day (from 0 to 23)
   MqlDateTime time;
   TimeCurrent(time);

   if(comparison == "greater")
      if(time.hour >= hourToCheck)
         return(true);
      else
         return(false);

   if(comparison == "equal")
      if(time.hour == hourToCheck)
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


bool minuteOfHour(int minuteToCheck, string comparison) export {
// it's the minute of an hour (from 0 to 59)
   MqlDateTime time;
   TimeCurrent(time);

   if(comparison == "greater")
      if(time.min >= minuteToCheck)
         return(true);
      else
         return(false);

   if(comparison == "equal")
      if(time.min == minuteToCheck)
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


bool minuteOfDay(int minuteOfDayToCheck, string comparison) export {
// time.hour*60 + time.min  (60 minutes * 24 hours = 1440) ==> it's the minute of a day that goes from 0 (00:00) to 1440 (23:59)
   MqlDateTime time;
   TimeCurrent(time);

   if(comparison == "greater")
      if(time.hour*60 + time.min >= minuteOfDayToCheck)
         return(true);
      else
         return(false);

   if(comparison == "equal")
      if(time.hour*60 + time.min == minuteOfDayToCheck)
         return(true);
      else
         return(false);

   if(comparison == "smaller")
      if(time.hour*60 + time.min < minuteOfDayToCheck)
         return(true);
      else
         return(false);

    else
      return(false);

}
