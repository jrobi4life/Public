//+------------------------------------------------------------------+
//|                                                 BuyNowWealth.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int trade = 1;
int tradecomplete = 1;
extern double lot = 0.1;
extern double pipstoget = 280;
extern int slippage = 3;
extern int slippage2 = 7;
double stoploss1 = -pipstoget - pipstoget/3;
double stoploss2 = pipstoget + pipstoget/3;
double stoploss3 = -pipstoget - pipstoget/3;
double stoploss4 = pipstoget + pipstoget/3;
double stoploss5 = -pipstoget - pipstoget/3;
int number1 = 00007;
int number2 = 00014;
int number3 = 00021;
int number4 = 00028;
int number5 = 00035;
double originallot = lot;
double zone1 = pipstoget/3;
double zone2 = pipstoget/-3;
double trademultiplier[5] = {1,1.9,1.9,3.8,3.8};
double trailingstop = 1.0;
double moveforward = 1;
int order1;
int order2;
int order3;
int order4;
int order5;
int placedorder = 1;
bool isfirst =0;
bool isFirstTick = TRUE;
bool orderselect1 = FALSE;
bool orderselect2 = FALSE;
bool orderselect3 = FALSE;
bool orderselect4 = FALSE;
bool orderselect5 = FALSE;
bool orderCloseSelect1 = TRUE;
bool orderCloseSelect2 = TRUE;
bool orderCloseSelect3 = TRUE;
bool orderCloseSelect4 = TRUE;
bool orderCloseSelect5 = TRUE;
bool close5thSelect = FALSE;
bool close5th = FALSE;
bool close4thSelect = FALSE;
bool close4th = FALSE;
bool close3rdSelect = FALSE;
bool close3rd = FALSE;
bool close2ndSelect = FALSE;
bool close2nd = FALSE;
bool close1stSelect = FALSE;
bool close1st = FALSE;
bool checkOrder5 = FALSE;
bool checkOrder4 = FALSE;
bool checkOrder3 = FALSE;
bool checkOrder2 = FALSE;
bool checkOrder1 = FALSE;
double position, originalbid, originalposition;
int total = OrdersTotal();
bool sequence = FALSE;
int tradeCount;
int tradeCounter = 0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   PlaceOrder1();
//---
   return(INIT_SUCCEEDED);
  }
  //(Symbol(), lot, stoploss, takeprofit, magic number, comment, a default arrow,
// int OrderSend(cons string symbol,int cmd,double volume,double price, int slippage,double stoploss,doubletakeprofit, const string comment=NULL,int magic=0,datetime expiration=0,color arrow_color=clrNONE)
  void PlaceOrder1()
   {
   order1 = OrderSend(Symbol(), OP_BUY, lot, Ask, slippage, Ask + stoploss1 * Point, Ask + pipstoget * Point, "Trade 1 opened", number1, Blue);
  
      if( order1 > 0 )
   {
   Print("Placed order # ", order1);
   tradecomplete = 1;
   tradeCount++;
   sequence = TRUE;
   }
   else
   {
   Print("Order Send failed, error # ", GetLastError() );
   }
   
  
   }
  
   void PlaceOrder2()
   {
   order2 = OrderSend(Symbol(), OP_SELL, lot * trademultiplier[1], Bid, slippage, Bid + stoploss2  * Point, Bid - pipstoget * Point, "Trade 2 opened", number2, Violet);
  
   if( order2 > 0 )
   {
   Print("Placed order # ", order2);
   tradecomplete = 2;
   tradeCount++;
   }
   else
   {
   Print("Order Send failed, error # ", GetLastError() );
   }
   
   }
   
   
   
   void PlaceOrder3()
   {
   
   order3 = OrderSend(Symbol(), OP_BUY, lot * trademultiplier[2], Ask, slippage, Ask + stoploss3  * Point, Ask + pipstoget * Point, "Trade 3 opened", number3, Blue);
  
      if( order3 > 0 )
   {
   Print("Placed order # ", order1);
   tradecomplete = 3;
   tradeCount++;
   }
   else
   {
   Print("Order Send failed, error # ", GetLastError() );
   }
   
   
   }  
   
   
   void PlaceOrder4()
   {
   order4 = OrderSend(Symbol(), OP_SELL, lot * trademultiplier[3], Bid, slippage, Bid + stoploss4  * Point, Bid - pipstoget * Point, "Trade 4 opened", number4, Violet);
  
   if( order4 > 0 )
   {
   Print("Placed order # ", order4);
   tradecomplete = 4;
   tradeCount++;
   }
   else
   {
   Print("Order Send failed, error # ", GetLastError() );
   }
   
   }
  
   
   void PlaceOrder5()
   {
   
   order5 = OrderSend(Symbol(), OP_BUY, lot * trademultiplier[4], Ask, slippage, Ask + stoploss5  * Point, Ask + pipstoget * Point, "Trade 5 opened", number5, Blue);
  
      if( order5 > 0 )
   {
   Print("Placed order # ", order1);
   tradecomplete = 5;
   tradeCount++;
   }
   else
   {
   Print("Order Send failed, error # ", GetLastError() );
   }
   
   
   }  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
  
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
      
double askset = Ask;

   if(isFirstTick){
      isFirstTick = FALSE;
      position = Ask;
      originalposition = Ask;
      originalbid = Bid;
   }
 //trade set
      if
      (
      Ask <= originalposition - pipstoget /3 * Point && tradecomplete == 5 && trade == 5
      )
      {
      orderselect5 = OrderSelect(4, SELECT_BY_POS, MODE_TRADES);
      if (orderselect5)
      trade=6;
      }
      
      
      if
      (
      Ask >= originalposition && tradecomplete == 4 && trade == 4
      )
      {
      orderselect4 = OrderSelect(3, SELECT_BY_POS, MODE_TRADES);
      if (orderselect4)
      trade=5; 
      }
      
      
      if
      (
      Ask <= originalposition - pipstoget /3 * Point && tradecomplete == 3 && trade == 3
      )
      {
      orderselect3 = OrderSelect(2, SELECT_BY_POS, MODE_TRADES);
      if (orderselect3)
      trade=4;
      }

      if
      (
      Ask >= originalposition && tradecomplete == 2 && trade == 2
      )
      {
      orderselect2 = OrderSelect(1, SELECT_BY_POS, MODE_TRADES);
      if (orderselect2)
      trade=3; 
      }

      if
      (
      Ask <= originalposition - pipstoget /3 * Point && tradecomplete == 1 && trade == 1
      ) 
      
      {
      orderselect1 = OrderSelect(0, SELECT_BY_POS, MODE_TRADES);
      if (orderselect1)
      {trade=2;}
      }
     //place orders
      if (trade == 2 && placedorder == 1)
      {PlaceOrder2(); placedorder = 2;}
     
      if (trade == 3 && placedorder == 2)
      {PlaceOrder3(); placedorder = 3;}
      
      if (trade == 4 && placedorder == 3)
      {PlaceOrder4(); placedorder = 4;}
      
      if (trade == 5 && placedorder == 4)
      {PlaceOrder5(); placedorder = 5;}
      
      if (trade == 6)
      {Alert ("5th Target not reached");}
     
      //close orders
      if (placedorder == 5)
      {
      orderCloseSelect1 = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect2 = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect3 = OrderSelect(2, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect4 = OrderSelect(3, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect5 = OrderSelect(4, SELECT_BY_POS, MODE_TRADES);
      if (!orderCloseSelect5 || !orderCloseSelect4 || !orderCloseSelect3 || !orderCloseSelect2 || !orderCloseSelect1)
         {
         
         close5thSelect = OrderSelect (4, SELECT_BY_POS, MODE_TRADES);
         if (close5thSelect && Ask >= originalposition)
            {
            close5th = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         
         
         close4thSelect = OrderSelect (3, SELECT_BY_POS, MODE_TRADES);
         if (close4thSelect && Ask <= originalposition - pipstoget /3 * Point)
            {
            close4th = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         
         
         close3rdSelect = OrderSelect (2, SELECT_BY_POS, MODE_TRADES);
         if (close3rdSelect && Ask >= originalposition)
            {
            close3rd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         
         close2ndSelect = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
         if (close2ndSelect && Ask <= originalposition - pipstoget /3 * Point)
            {
            close2nd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
            
            close1stSelect = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
         if (close1stSelect && Ask >= originalposition)
            {
            close1st = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         }
      }
      
      
      if (placedorder == 4)
      {
      orderCloseSelect1 = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect2 = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect3 = OrderSelect(2, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect4 = OrderSelect(3, SELECT_BY_POS, MODE_TRADES);
      if (!orderCloseSelect4 || !orderCloseSelect3 || !orderCloseSelect2 || !orderCloseSelect1)
         {
         
         close4thSelect = OrderSelect (3, SELECT_BY_POS, MODE_TRADES);
         if (close4thSelect && Ask <= originalposition - pipstoget /3 * Point)
            {
            close4th = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         
         
         close3rdSelect = OrderSelect (2, SELECT_BY_POS, MODE_TRADES);
         if (close3rdSelect && Ask >= originalposition)
            {
            close3rd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         
         close2ndSelect = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
         if (close2ndSelect && Ask <= originalposition - pipstoget /3 * Point)
            {
            close2nd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
            
            close1stSelect = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
         if (close1stSelect && Ask >= originalposition)
            {
            close1st = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         }
      }
      
      
      
      
      if (placedorder == 3)
      {
      orderCloseSelect1 = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect2 = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect3 = OrderSelect(2, SELECT_BY_POS, MODE_TRADES);
      if (!orderCloseSelect3 || !orderCloseSelect2 || !orderCloseSelect1)
         {
         
         close3rdSelect = OrderSelect (2, SELECT_BY_POS, MODE_TRADES);
         if (close3rdSelect && Ask >= originalposition)
            {
            close3rd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         
         close2ndSelect = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
         if (close2ndSelect && Ask <= originalposition - pipstoget /3 * Point)
            {
            close2nd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
            
            close1stSelect = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
         if (close1stSelect && Ask >= originalposition)
            {
            close1st = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         }
      }

 
  if (placedorder == 2)
      {
      orderCloseSelect1 = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
      orderCloseSelect2 = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
      if (!orderCloseSelect2 || !orderCloseSelect1)
         {
         
         
         close2ndSelect = OrderSelect (1 + tradeCounter, SELECT_BY_POS, MODE_TRADES);
         if (close2ndSelect && Ask <= originalposition - pipstoget /3 * Point)
            {
            close2nd = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
            
            close1stSelect = OrderSelect (0 + tradeCounter, SELECT_BY_POS, MODE_TRADES);
         if (close1stSelect && Ask >= originalposition)
            {
            close1st = OrderClose (OrderTicket(), OrderLots(), Bid, slippage2, Red);
            } 
         }
      }
      
         if (sequence==true)
         {
         checkOrder5 = OrderSelect (4, SELECT_BY_POS, MODE_TRADES);
         checkOrder4 = OrderSelect (3, SELECT_BY_POS, MODE_TRADES);
         checkOrder3 = OrderSelect (2, SELECT_BY_POS, MODE_TRADES);
         checkOrder2 = OrderSelect (1, SELECT_BY_POS, MODE_TRADES);
         checkOrder1 = OrderSelect (0, SELECT_BY_POS, MODE_TRADES);
         
            if (!checkOrder5 && !checkOrder4 && !checkOrder3 && !checkOrder2 && !checkOrder1)
         
            {
            sequence = FALSE; trade = 1; tradecomplete = 1; placedorder = 1; isFirstTick = TRUE; tradeCounter = tradeCount + tradeCounter; PlaceOrder1();
            }
            
          }
            
         
          
      
 
   }
  
//+------------------------------------------------------------------+