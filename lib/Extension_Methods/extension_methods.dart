
extension ExtensionMethods on DateTime{
  static bool ThisDay(DateTime date){
    Duration duration= DateTime.now().difference(date);
    if(duration.inDays<=1){
      return true;
    }
    else return false;
  } 


   static bool ThisWeek(DateTime date){
    Duration duration= DateTime.now().difference(date);
    if(duration.inDays<=7){
      return true;
    }
    else return false;
  } 


   static bool ThisMonth(DateTime date){
    Duration duration= DateTime.now().difference(date);
    if(duration.inDays<=30){
      return true;
    }
    else return false;
  } 

   static bool ThisYear(DateTime date){
    Duration duration= DateTime.now().difference(date);
    if(duration.inDays<=365){
      return true;
    }
    else return false;
  } 
}