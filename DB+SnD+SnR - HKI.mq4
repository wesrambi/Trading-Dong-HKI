//+------------------------------------------------------------------------+
//|                                                     EA Fibo + SnR.mq4 |
//+------------------------------------------------------------------------+
#property copyright "Trading-Dong | WES FER RIK"
#property version   "1.1"

datetime EAExpired = D'2023.03.31';    //Ea Expiration Date

//| Expert Initialization function |

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

// Initialization for SnR
extern bool Use_Sunday_Data = TRUE;
extern bool Daily = TRUE;
extern bool Daily_SR_Levels = TRUE;
extern bool Daily_Mid_Levels = FALSE;
extern bool Weekly = TRUE;
extern bool Weekly_SR_Levels = FALSE;
extern bool Weekly_Mid_Levels = FALSE;
extern bool Monthly = TRUE;
extern bool Monthly_SR_Levels = FALSE;
extern bool Monthly_Mid_Levels = FALSE;

extern color Daily_Pivot = Blue;
extern color Daily_S_Levels = LimeGreen;
extern color Daily_R_Levels = Red;
extern color Daily_Mid_Level = Yellow;

extern color Weekly_Pivot = Fuchsia;
extern color Weekly_S_Levels = SteelBlue;
extern color Weekly_R_Levels = Peru;
extern color Weekly_Mid_Level = LightPink;

extern color Monthly_Pivot = Gray;
extern color Monthly_S_Levels = Orange;
extern color Monthly_R_Levels = Blue;
extern color Monthly_Mid_Level = LightSalmon;

double Gd_164;
double Gd_172;
double Gd_180;
double Gda_188[][6];
double G_price_192;
double G_price_200;
double G_price_208;
double G_price_216;
double G_price_224;
double G_price_232;
double G_price_240;
double G_price_248;
double G_price_256;
double G_price_264;
double G_price_272;
double G_price_280;
double G_price_288;
double Gd_428;
double Gd_436;
double Gd_444;
double Gda_452[][6];
double G_price_456;
double G_price_464;
double G_price_472;
double G_price_480;
double G_price_488;
double G_price_496;
double G_price_504;
double G_price_512;
double G_price_520;
double G_price_528;
double G_price_536;
double G_price_544;
double G_price_552;
double lotvolumeW ;                    //Lot volume of each trade
double stopLossW ;
double takeProfitW ;
bool snr;

//Initialization for Marubozu and Fibo
int Slippage;                          //The maximum allowed deviation of the requested order open price from the market price for market orders (points) ||  0.1 Slippage = 1 Pips on 3 digit broker (3 digit after decimal), 1 Slippage = 1 Pips on a 4 digit Broker, 10 Slippage = 1 Pips on a 5 digit Broker (Exness is 5 digit broker)
string txComment;                      //A text comment for identify order timeframe
double lotvolume;                      //Lot volume of each trade
double TakeProfit2_bum;                //Take profit each trade for Order 2 on Fibo Bullish Marubozu Candle
double TakeProfit2_bem;                //Take profit each trade for Order 2 on Fibo Bearish Marubozu Candle
double StopLoss_bum;                   //Stop loss each trade for Bullish Marubozu Candle
double StopLoss_bem;                   //Stop loss each trade for Bearish Marubozu Candle
double StopLossPlus_bum;               //Stop loss plus each trade for Bullish Marubozu Candle
double StopLossPlus_bem;               //Stop loss plus each trade for Bearish Marubozu Candle
double MinStopLossPlus_bum;            //Condition for making Stop loss plus each trade for Bullish Marubozu Candle
double MinStopLossPlus_bem;            //Condition for making Stop loss plus each trade for Bearish Marubozu Candle
int MagicNumber;                       //A magic number is an order parameter that helps MetaTrader 4 and MQL4 identify orders (MagicNumber+1 for buy, MagicNumber+2 for sell)
int pendingexp;                        //Expired Pending Order Time
double maxma_bum;                      //Max Amount of Distance between EMA and Price for Bullish Marubozu Candle
double maxma_bem;                      //Max Amount of Distance between EMA and Price for Bearish Marubozu Candle
double periodMA_bum;                   //Period of MA for Bullish Marubozu Candle
double periodMA_bem;                   //Period of MA for Bearsih Marubozu Candle
double long_bar_bum;                   //Body size of Bullish Marubozu Candle
double long_bar_bem;                   //Body size of Bearish Marubozu Candle
int shift2=0;                          //For make it run percandle
int shift;                             //Number of current candle for make it run per candle
int bum_close_bar;                     //Lowest candle position from Bullish Marubozu untill current candle
int bum_highest_bar;                   //Highest candle position from Bullish Marubozu untill current candle
int bum_bar;                           //Bullish Marubozu candle position from all candle position
int bum_bar2;                          //Bullish Marubozu candle position from current candle position
double closeafterbum_fibo;             //Close Price candle after Bullish Marubozu Candle for Fibonacci
double openbum_fibo;                   //Open Price Bullish Marubozu Candle for Fibonacci
int down_fibo;                         //Check if down Fibonacci is needed
int bem_lowest_bar;                    //Lowest candle position from marubozu untill current candle
int bem_close_bar;                     //Highest candle position from marubozu untill current candle
int bem_bar;                           //Marubozu candle position from all candle position
int bem_bar2;                          //Marubozu candle position from current candle position
double closeafterbem_fibo;             //Close Price candle after Bearish Marubozu Candle for Fibonacci
double openbem_fibo;                   //Open Price Bearish Marubozu Candle for Fibonacci
int up_fibo;                           //Check if up Fibonacci is needed
double Fibo_Level_0 = 0.000;
double Fibo_Level_1 = 0.236;
double Fibo_Level_2 = 0.382;
double Fibo_Level_3 = 0.500;
double Fibo_Level_4 = 0.618;
double Fibo_Level_5 = 1.000;
double Fibo_Level_6 = 1.618;
double Fibo_Level_7 = 2.618;
int    StartBar     = 1;
color FiboLinesColors = Yellow;
double f_1_bum;
double f_2_bum;
double f_3_bum;
double f_4_bum;
double f_5_bum;
double f_6_bum;
double f_7_bum;
double f_8_bum;
double f_1_bem;
double f_2_bem;
double f_3_bem;
double f_4_bem;
double f_5_bem;
double f_6_bem;
double f_7_bem;
double f_8_bem;

//| Expert Opening Program function |
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   Alert("Please note that Trading-Dong only supports M30, H1, and H4 Timeframes on XAUUSD, GBPUSD, and USDJPY chart");
   Alert("Trading-Dong : Hi, Enjoy the Trading-Dong. Happy Trading and Good Luck !");
   return(INIT_SUCCEEDED);
  }

//| Expert Closing Program function |
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print(__FUNCTION__," Deinitialization Reason Code = ",reason); //Print out Reason Deinit
   Print(__FUNCTION__," Reason = ",getUninitReasonText(_UninitReason)); //Print out Code Reason Deinit based on https://www.mql5.com/en/docs/event_handlers/ondeinit
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string getUninitReasonText(int reasonCode) //Return a textual description of the reason code for closing the program
  {
   string text="";
   switch(reasonCode)
     {
      case REASON_ACCOUNT:
         text="Account was changed";
         break;
      case REASON_CHARTCHANGE:
         text="Symbol or timeframe was changed";
         break;
      case REASON_CHARTCLOSE:
         text="Chart was closed";
         break;
      case REASON_PARAMETERS:
         text="Input-parameter was changed";
         break;
      case REASON_RECOMPILE:
         text="Program "+__FILE__+" was recompiled";
         break;
      case REASON_REMOVE:
         text="Program "+__FILE__+" was removed from chart";
         break;
      case REASON_TEMPLATE:
         text="New template was applied to chart";
         break;
      default:
         text="Another reason";
     }
   return text;
  }

//| Expert tick function |
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

//Detect Expiration Date
   //if(TimeCurrent() > EAExpired)
   //  {   
   //   ExpertRemove();
   //   Alert("Trading-Dong is Expired!!");
   //   Print(__FUNCTION__," Trading-Dong will be unloaded");
   //  }

//Detect Pair
//=== Pair XAUUSD (1 Pips = 0.1 Points of Price or 1 Pips = Value x 1000) ===
   if(Symbol() == "XAUUSDm")
     {
      //Timeframe H4
      if(Period() == 240)
        {
         Comment("The Period is H4");
         //Variable Initialization for Marubozu and Fibo
         txComment =            "Fibo H4 timeframe XAUUSD";
         MagicNumber =                                1133;
         pendingexp =                                72000;
         Slippage =                                    300; //3   Pips
         lotvolume =                                  0.02;
         maxma_bum =                           35000*Point;
         long_bar_bum =                         6000*Point;
         TakeProfit2_bum =                     10000*Point; //100 Pips
         StopLoss_bum =                         5000*Point; //60  Pips
         MinStopLossPlus_bum =                  7000*Point; //70  Pips
         StopLossPlus_bum =                     1000*Point; //10  Pips
         periodMA_bum =                                 50;
         maxma_bem =                           35000*Point;
         long_bar_bem =                         6000*Point;
         TakeProfit2_bem =                     10000*Point; //100 Pips
         StopLoss_bem =                         5000*Point; //60  Pips
         MinStopLossPlus_bem =                  7000*Point; //70  Pips
         StopLossPlus_bem =                     1000*Point; //10  Pips
         periodMA_bem =                                 50;
         //Variable Initialization for SnR
         lotvolumeW =                                 0.03;
         stopLossW =                            10000*Point;
         takeProfitW =                          5000*Point; // 4000 better cuman beda dikit aja  (2jan-7apr)
         snr =                                        TRUE;
        }
      //Timeframe H1
      else if(Period() == 60)
           {
            Comment("The Period is H1");
            //Variable Initialization for Marubozu and Fibo
            txComment =         "Fibo H1 timeframe XAUUSD";
            MagicNumber =                             1122;
            pendingexp =                             18000;
            Slippage =                                 300; //3  Pips
            lotvolume =                               0.03;
            maxma_bum =                        10000*Point;
            long_bar_bum =                      2500*Point;
            TakeProfit2_bum =                   3500*Point; //35 Pips
            StopLoss_bum =                      2000*Point; //20 Pips
            MinStopLossPlus_bum =               5000*Point; //50 Pips
            StopLossPlus_bum =                   500*Point; //5  Pips
            periodMA_bum =                              50;
            maxma_bem =                        10000*Point;
            long_bar_bem =                      2500*Point;
            TakeProfit2_bem =                   3500*Point; //35 Pips
            StopLoss_bem =                      2000*Point; //20 Pips
            MinStopLossPlus_bem =               5000*Point; //50 Pips
            StopLossPlus_bem =                   500*Point; //5  Pips
            periodMA_bem =                              50;
            //Variable Initialization for SnR
            lotvolumeW =                              0.01; // lotvolume 0.03 0.02 tdk bisa karena minus rentang waktu 2 jan-7apr
            stopLossW =                         10000*Point;
            takeProfitW =                       5000*Point;
            snr =                                     TRUE;
           }
      //Timeframe M30
      else if(Period() == 30)
           {
            Comment("The Period is M30");
            //Variable Initialization for Marubozu and Fibo
            txComment =        "Fibo M30 timeframe XAUUSD";
            MagicNumber =                             1111;
            pendingexp =                              9000;
            Slippage =                                 300; //3  Pips
            lotvolume =                               0.01;
            maxma_bum =                         8000*Point;
            long_bar_bum =                      2000*Point;
            TakeProfit2_bum =                   2500*Point; //25 Pips
            StopLoss_bum =                      1500*Point; //15 Pips
            MinStopLossPlus_bum =               4000*Point; //40 Pips
            StopLossPlus_bum =                   500*Point; //5  Pips
            periodMA_bum =                              50;
            maxma_bem =                         8000*Point;
            long_bar_bem =                      2000*Point;
            TakeProfit2_bem =                   2500*Point; //25 Pips
            StopLoss_bem =                      1500*Point; //15 Pips
            MinStopLossPlus_bem =               4000*Point; //40 Pips
            StopLossPlus_bem =                   500*Point; //5  Pips
            periodMA_bem =                              50;
            //Variable Initialization for SnR
            lotvolumeW =                              0.02;
            stopLossW =                         8000*Point;
            takeProfitW =                       4000*Point;
            snr =                                     TRUE;
           }           
      //Timeframe except H4, H1, and M30
      else
        {
         ExpertRemove();
         Alert("Trading-Dong : Invalid Timeframe input, please select M30, H1, or H4 timeframes");
         Print(__FUNCTION__," Trading-Dong will be unloaded");
        }
     }
    
    
    
//=== Pair GBPUSD ===
   else if(Symbol() == "GBPUSDm")
        {
         //Timeframe H4
         if(Period() == 240)
           {
            Comment("The Period is H4");
            //Variable Initialization for Marubozu and Fibo
            txComment =          "Fibo H4 timeframe GBPUSD";
            MagicNumber =                              2133;
            pendingexp =                              72000;
            Slippage =                                   30; //3 Pips
            lotvolume =                                0.05;
            maxma_bum =                          1000*Point;
            long_bar_bum =                        300*Point;
            TakeProfit2_bum =                     300*Point; //30 Pips
            StopLoss_bum =                        150*Point; //15 Pips
            MinStopLossPlus_bum =                 150*Point; //15 Pips
            StopLossPlus_bum =                     30*Point; //3  Pips
            periodMA_bum =                               50;
            maxma_bem =                          1000*Point;
            long_bar_bem =                        300*Point;
            TakeProfit2_bem =                     300*Point; //30 Pips
            StopLoss_bem =                        150*Point; //15 Pips
            MinStopLossPlus_bem =                 150*Point; //15 Pips
            StopLossPlus_bem =                     30*Point; //3  Pips
            periodMA_bem =                               50;
            //Variable Initialization for SnR
            lotvolumeW =                               0.03;
            stopLossW =                           700*Point; //120 Pips 
            takeProfitW =                         350*Point;
            snr =                                      TRUE;
           }
         //Timeframe H1
         else if(Period() == 60)
              {
               Comment("The Period is H1");
               //Variable Initialization for Marubozu and Fibo
               txComment =       "Fibo H1 timeframe GBPUSD";
               MagicNumber =                           2122;
               pendingexp =                           18000;
               Slippage =                                30; //3 Pips
               lotvolume =                             0.01;
               maxma_bum =                       1000*Point;
               long_bar_bum =                     150*Point;
               TakeProfit2_bum =                  170*Point; //17 Pips
               StopLoss_bum =                      70*Point; //7  Pips
               MinStopLossPlus_bum =              150*Point; //15 Pips
               StopLossPlus_bum =                  30*Point; //3  Pips
               periodMA_bum =                            14;
               maxma_bem =                       1000*Point;
               long_bar_bem =                     150*Point;
               TakeProfit2_bem =                  170*Point; //17 Pips
               StopLoss_bem =                      70*Point; //7  Pips
               MinStopLossPlus_bem =              150*Point; //15 Pips
               StopLossPlus_bem =                  30*Point; //3  Pips
               periodMA_bem =                            14;   
               //Variable Initialization for SnR
               lotvolumeW =                            0.01; //0.03
               stopLossW =                       1000*Point; //100 pips
               takeProfitW =                      200*Point; //30  pips
               snr =                                   TRUE;
              }
        //Timeframe M30
         else if(Period() == 30)
              {
               Comment("The Period is M30");
               //Variable Initialization for Marubozu and Fibo
               txComment =      "Fibo M30 timeframe GBPUSD";
               MagicNumber =                           2111;
               pendingexp =                            9000;
               Slippage =                                30; //3 Pips
               lotvolume =                             0.03;
               maxma_bum =                        300*Point;
               long_bar_bum =                     100*Point;
               TakeProfit2_bum =                  170*Point; //17 Pips
               StopLoss_bum =                      50*Point; //5  Pips
               MinStopLossPlus_bum =              150*Point; //15 Pips
               StopLossPlus_bum =                  20*Point; //2  Pips
               periodMA_bum =                            14;
               maxma_bem =                        300*Point;
               long_bar_bem =                     100*Point;
               TakeProfit2_bem =                  170*Point; //17 Pips
               StopLoss_bem =                      50*Point; //5  Pips
               MinStopLossPlus_bem =              150*Point; //15 Pips
               StopLossPlus_bem =                  20*Point; //2  Pips
               periodMA_bem =                            14;
               //Variable Initialization for SnR
               lotvolumeW =                            0.01;
               stopLossW =                        500*Point;
               takeProfitW =                      100*Point;
               snr =                                  FALSE;
              }
         //Timeframe except H4, H1, and M30
         else
           {
            ExpertRemove();
            Alert("Trading-Dong : Invalid Timeframe input, please select M30, H1, or H4 timeframes");
            Print(__FUNCTION__," Trading-Dong will be unloaded");
           }
        }

 
 
 
 
 
 
 
//=== Pair USDJPY ===
   else if(Symbol() == "USDJPYm")
        {
         //Timeframe H4
         if(Period() == 240)
           {
            Comment("The Period is H4");
            //Variable Initialization for Marubozu and Fibo
            txComment =          "Fibo H4 timeframe USDJPY";
            MagicNumber =                              2133;
            pendingexp =                              72000;
            Slippage =                                   30; //3 Pips
            lotvolume =                                0.05;
            maxma_bum =                          2000*Point;
            long_bar_bum =                        150*Point;
            TakeProfit2_bum =                     500*Point; //50 Pips
            StopLoss_bum =                        100*Point; //10 Pips
            MinStopLossPlus_bum =                 150*Point; //15 Pips
            StopLossPlus_bum =                     50*Point; //5  Pips
            periodMA_bum =                              100;
            maxma_bem =                          2000*Point;
            long_bar_bem =                        150*Point;
            TakeProfit2_bem =                     500*Point; //50 Pips
            StopLoss_bem =                        100*Point; //10 Pips
            MinStopLossPlus_bem =                 150*Point; //15 Pips
            StopLossPlus_bem =                     50*Point; //5  Pips
            periodMA_bem =                              100;
            //Variable Initialization for SnR
            lotvolumeW =                               0.03;
            stopLossW =                          1500*Point; // 1400 profitnya lebih gede 800an dari 2 januari ke 7 april 2023 // 120 pips
            takeProfitW =                         750*Point;
            snr =                                      TRUE;
            // kalau sl nya 1000
           }
         //Timeframe H1
         else if(Period() == 60)
              {
               Comment("The Period is H1");
               //Variable Initialization for Marubozu and Fibo
               txComment =       "Fibo H1 timeframe USDJPY";
               MagicNumber =                           2122;
               pendingexp =                           18000;
               Slippage =                                30; //3 Pips
               lotvolume =                             0.05;
               maxma_bum =                       1500*Point;
               long_bar_bum =                     150*Point;
               TakeProfit2_bum =                  170*Point; //17 Pips
               StopLoss_bum =                     100*Point; //7  Pips
               MinStopLossPlus_bum =              150*Point; //15 Pips
               StopLossPlus_bum =                  30*Point; //3  Pips
               periodMA_bum =                            50;
               maxma_bem =                       1500*Point;
               long_bar_bem =                     150*Point;
               TakeProfit2_bem =                  170*Point; //17 Pips
               StopLoss_bem =                     100*Point; //7  Pips
               MinStopLossPlus_bem =              150*Point; //15 Pips
               StopLossPlus_bem =                  30*Point; //3  Pips
               periodMA_bem =                            50;
               //Variable Initialization for SnR
               lotvolumeW =                            0.02; //0.01
               stopLossW =                       1200*Point; // 100 pips     
               takeProfitW =                      600*Point; // 20 pips 300  486
               snr =                                   TRUE;         
              }
         //Timeframe M30
         else if(Period() == 30)
              {
               Comment("The Period is M30");
               //Variable Initialization for Marubozu and Fibo
               txComment =   "Fibo M30 timeframe USDJPY";
               MagicNumber =                           2111;
               pendingexp =                            9000;
               Slippage =                                30; //3 Pips
               lotvolume =                             0.01;
               maxma_bum =                        800*Point;
               long_bar_bum =                     170*Point;
               TakeProfit2_bum =                  170*Point; //17 Pips
               StopLoss_bum =                     100*Point; //10  Pips
               MinStopLossPlus_bum =              150*Point; //15 Pips
               StopLossPlus_bum =                  20*Point; //2  Pips
               periodMA_bum =                            14;
               maxma_bem =                        800*Point;
               long_bar_bem =                     170*Point;
               TakeProfit2_bem =                  170*Point; //17 Pips
               StopLoss_bem =                     100*Point; //10  Pips
               MinStopLossPlus_bem =              150*Point; //15 Pips
               StopLossPlus_bem =                  20*Point; //2  Pips
               periodMA_bem =                            14;
               //Variable Initialization for SnR
               lotvolumeW =                            0.01;
               stopLossW =                       1400*Point;
               takeProfitW =                      700*Point;
               snr =                                   TRUE;
              }
         //Timeframe except H4, H1, and M30
         else
           {
            ExpertRemove();
            Alert("Trading-Dong : Invalid Timeframe input, please select M30, H1, or H4 timeframes");
            Print(__FUNCTION__," Trading-Dong will be unloaded");
           }
        }
//=== Pair Except XAUUSD, GBPUSD, and USDJPY ===
   else
     {
      ExpertRemove();
      Alert("Trading-Dong : Invalid chart input, please select XAUUSD, GBPUSD, or USDJPY chart");
      Print(__FUNCTION__," Trading-Dong will be unloaded");
     }
     
//Start EA
   shift=iBarShift(Symbol(),0,1);
   if(shift>shift2) //For make it run percandle (Baru bisa ngerun setelah 1 candle berjalan)
     {
//=== Get Marubozu Value ===
      //== Bullish Marubozu ==
      if((Close[2]-Open[2] >= long_bar_bum) && (High[2]-Close[2] <= (Close[2]-Open[2])/2) && (Open[2]-Low[2] <= (Close[2]-Open[2])/2))
        {
         
        }

      //== Candle Bearish Marubozu ==
      if((Open[2]-Close[2] >= long_bar_bem) && (High[2]-Open[2] <= (Open[2]-Close[2])/2) && (Close[2]-Low[2] <= (Open[2]-Close[2])/2))
        {
         
        }

//=== Create Fibo ===
      //== Fibo Down Trend ==
      if(down_fibo==1) //Check Marubozu candle
        {
         double bum_closeprice = 0,bum_highprice = 0;
         bum_bar2 = shift-bum_bar;
         bum_close_bar = iLowest(NULL,0,MODE_CLOSE, bum_bar2,StartBar);
         bum_highest_bar = iHighest(NULL,0,MODE_HIGH, bum_bar2,StartBar);
         bum_highprice=High[bum_highest_bar];
         bum_closeprice=Close[bum_close_bar];

         
                  //Create Fibonacci
                  if(ObjectFind("Fibo_BUM")==-1)
                    {
                     ObjectCreate("Fibo_BUM"+bum_bar,OBJ_FIBO,0,Time[bum_close_bar],bum_closeprice,Time[bum_highest_bar],bum_highprice);
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_LEVELCOLOR,FiboLinesColors);
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIBOLEVELS,8);
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+0,Fibo_Level_0);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,0,DoubleToStr(Fibo_Level_0*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+1,Fibo_Level_1);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,1,DoubleToStr(Fibo_Level_1*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+2,Fibo_Level_2);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,2,DoubleToStr(Fibo_Level_2*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+3,Fibo_Level_3);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,3,DoubleToStr(Fibo_Level_3*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+4,Fibo_Level_4);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,4,DoubleToStr(Fibo_Level_4*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+5,Fibo_Level_5);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,5,DoubleToStr(Fibo_Level_5*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+6,Fibo_Level_6);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,6,DoubleToStr(Fibo_Level_6*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_FIRSTLEVEL+7,Fibo_Level_7);
                     ObjectSetFiboDescription("Fibo_BUM"+bum_bar,7,DoubleToStr(Fibo_Level_7*100,1));
                     ObjectSet("Fibo_BUM"+bum_bar,OBJPROP_RAY,false);
                     WindowRedraw();

                     
                     //Test Print Value Price of Fibonacci Level
                     Print("==================================");
                     Print("Fibo Level 1: ", f_1_bum);
                     Print("Fibo Level 2: ", f_2_bum);
                     Print("Fibo Level 3: ", f_3_bum);
                     Print("Fibo Level 4: ", f_4_bum);
                     Print("Fibo Level 5: ", f_5_bum);
                     Print("Fibo Level 6: ", f_6_bum);
                     Print("Fibo Level 7: ", f_7_bum);
                     Print("Fibo Level 8: ", f_8_bum);
                     Print("==================================");

                     //Entry Order Market
                     if(f_6_bum-f_7_bum>=TakeProfit2_bum) //If Fibo 161.8 - 100 more than 30 pips, do entry 2
                       {
                        OrderSend(Symbol(),OP_SELL,lotvolume,Bid,Slippage,f_1_bum+StopLoss_bum,(Bid-TakeProfit2_bum),txComment,MagicNumber+2,Red);
                       }
                    OrderSend(Symbol(),OP_SELLLIMIT,lotvolume,f_4_bum,Slippage,f_1_bum+StopLoss_bum,f_7_bum,txComment,MagicNumber+3,TimeCurrent()+pendingexp,Red);
                    OrderSend(Symbol(),OP_SELL,lotvolume,Bid,Slippage,f_1_bum+StopLoss_bum,f_7_bum,txComment,MagicNumber+1,Red);
                     down_fibo=0;
                    }
                 }
               else
                  down_fibo=0;
              }
           }
         else
            down_fibo=0;
        }

      //== Fibo Up Trend ==
      if(up_fibo==1) // Check Marubozu candle
        {
         double bem_closeprice = 0,bem_lowprice = 0;
         bem_bar2 = shift-bem_bar;
         bem_lowest_bar = iLowest(NULL,0,MODE_LOW, bem_bar2,StartBar);
         bem_close_bar = iHighest(NULL,0,MODE_CLOSE, bem_bar2,StartBar);
         bem_lowprice=Low[bem_lowest_bar];
         bem_closeprice=Close[bem_close_bar];

        
                  //Create Fibonacci
                  if(ObjectFind("Fibo_BEM")==-1)
                    {
                     ObjectCreate("Fibo_BEM"+bem_bar,OBJ_FIBO,0,Time[bem_close_bar],bem_closeprice,Time[bem_lowest_bar],bem_lowprice);
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_LEVELCOLOR,FiboLinesColors);
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIBOLEVELS,8);
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+0,Fibo_Level_0);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,0,DoubleToStr(Fibo_Level_0*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+1,Fibo_Level_1);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,1,DoubleToStr(Fibo_Level_1*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+2,Fibo_Level_2);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,2,DoubleToStr(Fibo_Level_2*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+3,Fibo_Level_3);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,3,DoubleToStr(Fibo_Level_3*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+4,Fibo_Level_4);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,4,DoubleToStr(Fibo_Level_4*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+5,Fibo_Level_5);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,5,DoubleToStr(Fibo_Level_5*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+6,Fibo_Level_6);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,6,DoubleToStr(Fibo_Level_6*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_FIRSTLEVEL+7,Fibo_Level_7);
                     ObjectSetFiboDescription("Fibo_BEM"+bem_bar,7,DoubleToStr(Fibo_Level_7*100,1));
                     ObjectSet("Fibo_BEM"+bem_bar,OBJPROP_RAY,false);
                     WindowRedraw();

                     //Test Print Value Price of Fibonacci Level
                     Print("==================================");
                     Print("Fibo Level 1: ", f_1_bem);
                     Print("Fibo Level 2: ", f_2_bem);
                     Print("Fibo Level 3: ", f_3_bem);
                     Print("Fibo Level 4: ", f_4_bem);
                     Print("Fibo Level 5: ", f_5_bem);
                     Print("Fibo Level 6: ", f_6_bem);
                     Print("Fibo Level 7: ", f_7_bem);
                     Print("Fibo Level 8: ", f_8_bem);
                     Print("==================================");

                     //Entry Order Market
                     if(f_7_bem-f_6_bem>=TakeProfit2_bem) //If Fibo 161.8 - 100 more than 30 pips, do entry 2
                       {
                        //OrderSend(Symbol(),OP_BUY,lotvolume,Ask,Slippage,f_1_bem-StopLoss_bem,Ask+TakeProfit2_bem,txComment,MagicNumber+5,Green);
                       }
                     
                     up_fibo=0;
                    }
                 }
               else
                  up_fibo=0;
              }
           }
         else
            up_fibo=0;
        }

//=== Get RSI Value ===
      string sinyal="";
      // Calculate the RSI Value
      double RSIValue = iRSI(Symbol(),PERIOD_D1,14,PRICE_CLOSE,0);
      // If the calue below 20
      if(RSIValue<20)
        {
         sinyal="buy";
        }
      if(RSIValue>75)
        {
         sinyal="sell";
        }
      Comment("RSIValue: ", RSIValue, "\n", "Signal: ", sinyal);
      
      // Kurung per row buat taruh RSI
      

//=== Create SnR ===
      
      G_price_192 = (Gd_164 + Gd_172 + Gd_180) / 3.0;             // (Pivot Point) DAY
      G_price_224 = 2.0 * G_price_192 - Gd_172;                   // (2 * PP-low  = (R1) woodie method
      G_price_200 = 2.0 * G_price_192 - Gd_164;                   // 2 * PP-high = (S1)  woodie method

      G_price_232 = G_price_192 + (G_price_224 - G_price_200);    // PP + (R1-S1) = (R2) woodie
      G_price_208 = G_price_192 - (G_price_224 - G_price_200);    // PP - (R1-S1) = (S2) woodie method

     

      G_price_248 = G_price_216 + (G_price_208 - G_price_216) / 2.0;// S3 + (R2-S3) / 2 // average (S3+(R2-S3))
      G_price_256 = G_price_208 + (G_price_200 - G_price_208) / 2.0;// R2 + (S1-R2) / 2 // average (R2+(S1-R2))
      G_price_264 = G_price_200 + (G_price_192 - G_price_200) / 2.0;// S1 + (PP-S1) / 2 // average (S1+(PP-S1))
      G_price_272 = G_price_192 + (G_price_224 - G_price_192) / 2.0;// PP + (R1-PP) / 2 // average (PP+(R1-PP))
      G_price_280 = G_price_224 + (G_price_232 - G_price_224) / 2.0;// R1 + (R2-R1) / 2 // average (R1+(R2-R1))

      G_price_288 = G_price_232 + (G_price_240 - G_price_232) / 2.0;// R2 + (R3-R2) / 2 // average (R2+(R3-R2))

      // ===awal=== tembus bawah || tembus atas
     if( ((RSIValue<=30) && ((Open[1] > G_price_200) && (Close[1] < G_price_200)) || ((RSIValue<=30) && (Open[1] < G_price_200) && (Close[1] > G_price_200))) || // 200=S1
         
                                                                                                                                            // RSI nya dibawah atau samadengan 20                                                         
        )
         // Jika harga close sebelumnya lebih rendah dari S1 
        {
         // Buka posisi buy
         sinyal="buy";
         int ticket1 = OrderSend(Symbol(), OP_BUY, lotvolumeW, Ask, 300, Bid - stopLossW, Bid + takeProfitW, "SnR Buy order D1", 0, 0, Green);
         if(ticket1 > 0)
           {
            Print("Buy order opened successfully");
           }
         else
           {
            Print("Error opening buy order: ", GetLastError());
           }
        }

     if(  ((RSIValue>=70) && ((Open[1] > G_price_200) && (Close[1] < G_price_200)) || ((RSIValue>=70) && (Open[1] < G_price_200) && (Close[1] > G_price_200))) || // 200=S1
          
                                                                                                           // RSI nya dibawah atau samadengan 20
           )   // 272=AVER; 280=AVER
            // Jika harga close sebelumnya lebih tinggi dari S1
           {
            // Buka posisi sell
            sinyal="sell";

            if(ticket2 > 0)
              {
               Print("Sell order opened successfully");
              }
            else
              {
               Print("Error opening sell order: ", GetLastError());
              }
           }
           
         // ===akhir===
         
      // ----END OF SELASA-JUMAT----







      //----MONTHLY----
      ArrayCopyRates(Gda_452, Symbol(), PERIOD_MN1); //MN = Monthly
   

      G_price_456 = (Gd_428 + Gd_436 + Gd_444) / 3.0;         // PP MN
      G_price_488 = 2.0 * G_price_456 - Gd_436;               // 2 * PP-low  = (R1)
      G_price_464 = 2.0 * G_price_456 - Gd_428;               // 2 * PP-high = (S1)

      G_price_496 = G_price_456 + (G_price_488 - G_price_464);// PP + (R1-S1) = (R2)
      G_price_472 = G_price_456 - (G_price_488 - G_price_464);// PP - (R1-S1) = (S2)

     
      G_price_512 = G_price_480 + (G_price_472 - G_price_480) / 2.0; // S3 + (R2-S3) / 2
      G_price_520 = G_price_472 + (G_price_464 - G_price_472) / 2.0; // R2 + (S1-R2) / 2
      G_price_528 = G_price_464 + (G_price_456 - G_price_464) / 2.0; // S1 + (PP-S1) / 2
      G_price_536 = G_price_456 + (G_price_488 - G_price_456) / 2.0; // PP + (R1-PP) / 2
      G_price_544 = G_price_488 + (G_price_496 - G_price_488) / 2.0; // R1 + (R2-R1) / 2
      G_price_552 = G_price_496 + (G_price_504 - G_price_496) / 2.0; // R2 + (R3-R2) / 2

      // ===awal===
     if( ((RSIValue<=30) && ((Open[1] > G_price_464) && (Close[1] < G_price_464)) || ((RSIValue<=30) && (Open[1] < G_price_464) && (Close[1] > G_price_464)) ) || // 464=S1
         ((RSIValue<=30) && ((Open[1] > G_price_488) && (Close[1] < G_price_488)) || ((RSIValue<=30) && (Open[1] < G_price_488) && (Close[1] > G_price_488)) ) || // 488=R1

         )                                                                                                              // RSI nya dibawah atau samadengan 20
         // Jika harga close sebelumnya lebih rendah dari S1
        {
         // Buka posisi buy
         sinyal="buy";
         int ticket9 = OrderSend(Symbol(), OP_BUY, lotvolumeW, Ask, 300, Bid - stopLossW, Bid + takeProfitW, "SnR Buy order MN1", 0, 0, Green);
         if(ticket9 > 0)
           {
            Print("Buy order opened successfully");
           }
          else
           {
            Print("Error opening buy order: ", GetLastError());
           }
        }

     if( ((RSIValue>=70) && ((Open[1] > G_price_464) && (Close[1] < G_price_464)) || ((RSIValue>=70) && (Open[1] < G_price_464) && (Close[1] > G_price_464)) ) || // 464=S1
         ((RSIValue>=70) && ((Open[1] > G_price_488) && (Close[1] < G_price_488)) || ((RSIValue>=70) && (Open[1] < G_price_488) && (Close[1] > G_price_488)) ) || // 488=R1
                                                                                                             // RSI nya diatas atau samadengan 75
           )
           // Jika harga close sebelumnya lebih tinggi dari S1
           {
            // Buka posisi sell
            sinyal="sell";
            int ticket10 = OrderSend(Symbol(), OP_SELL, lotvolumeW, Bid, 300, Ask + stopLossW, Ask - takeProfitW, "SnR Sell order MN1", 0, 0, Red);
            if(ticket10 > 0)
              {
               Print("Sell order opened successfully");
              }
            else
              {
               Print("Error opening sell order: ", GetLastError());
              }
           }
           
         // ===akhir=== 
 
 
 
 
 
 
 
 
      //----END OF MONTHLY----
      if(Daily == TRUE)
        {
         TimeToStr(TimeCurrent()); // buat garis, ditentukan dari timecurrent nya
         if(ObjectFind("PivotLine") != 0)                                        // Jika Pivotline bukan 0, dimana 0 adalah Minggu
           {
            ObjectCreate("PivotLine", OBJ_HLINE, 0, TimeCurrent(), G_price_192); // PP D1 // OBJ_HLINE = perintah untuk membuat garis horizontal, pada timecurrent dan di harga 192
            ObjectSet("PivotLine", OBJPROP_COLOR, Daily_Pivot);                  // objectset=mengganti value spesifik dari properti objek; objprop_color=mengatur warna, daily pivot di atas biru
            ObjectSet("PivotLine", OBJPROP_STYLE, STYLE_DASH);                   // objprop_style=digunakan untuk mengatur style line nya (garis nya)
           }
         else
            ObjectMove("PivotLine", 0, Time[20], G_price_192);               // objectmove mengganti kordinat dari specified anchor point dari objek pada chart yg ditentukan  PP D1

         if(ObjectFind("PivotLabel") != 0)    // buat tulisan ditentukan dari harga
           {
            ObjectCreate("PivotLabel", OBJ_TEXT, 0, Time[20], G_price_192);      // PP D1 // OBJ_TEXT create text
            ObjectSetText("PivotLabel", "Daily Pivot", 8, "Arial", Daily_Pivot); // PP D1 // menuliskan/mengedit objek yang udah di create
           }
         else
            ObjectMove("PivotLabel", 0, Time[20], G_price_192);              // PP D1

         WindowRedraw(); //redraws the current chart forcedly

         // HARI SENIN ONLY
         if(Daily_SR_Levels == TRUE)
           {
            if(ObjectFind("R1_Line") != 0)
              {
               ObjectCreate("R1_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_224); // R1 D1 SENIN
               ObjectSet("R1_Line", OBJPROP_COLOR, Daily_R_Levels);
               ObjectSet("R1_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("R1_Line", 0, Time[20], G_price_224);               // R1 D1 SENIN
            if(ObjectFind("R1_Label") != 0)
              {
               ObjectCreate("R1_Label", OBJ_TEXT, 0, Time[20], G_price_224);      // R1 D1 SENIN
               ObjectSetText("R1_Label", "Daily R1", 8, "Arial", Daily_R_Levels);
              }
            else
               ObjectMove("R1_Label", 0, Time[20], G_price_224);              // R1 D1 SENIN

            if(ObjectFind("R2_Line") != 0)
              {
               ObjectCreate("R2_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_232); // R2 D1 SENIN
               ObjectSet("R2_Line", OBJPROP_COLOR, Daily_R_Levels);
               ObjectSet("R2_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);             // Style penulisan nya
              }
            else
               ObjectMove("R2_Line", 0, Time[20], G_price_232);               // R2 D1 SENIN
            if(ObjectFind("R2_Label") != 0)
              {
               ObjectCreate("R2_Label", OBJ_TEXT, 0, Time[20], G_price_232);      // R2 D1 SENIN
               ObjectSetText("R2_Label", "Daily R2", 8, "Arial", Daily_R_Levels);
              }
            else
               ObjectMove("R2_Label", 0, Time[20], G_price_232);              // R2 D1 SENIN

            if(ObjectFind("R3_Line") != 0)
              {
               ObjectCreate("R3_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_240); // R3 D1 SENIN
               ObjectSet("R3_Line", OBJPROP_COLOR, Daily_R_Levels);
               ObjectSet("R3_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("R3_Line", 0, Time[20], G_price_240);               // R3 D1 SENIN
            if(ObjectFind("R3_Label") != 0)
              {
               ObjectCreate("R3_Label", OBJ_TEXT, 0, Time[20], G_price_240);      // R3 D1 SENIN
               ObjectSetText("R3_Label", "Daily R3", 8, "Arial", Daily_R_Levels);
              }
            else
               ObjectMove("R3_Label", 0, Time[20], G_price_240);              // R3 D1 SENIN

            if(ObjectFind("S1_Line") != 0)
              {
               ObjectCreate("S1_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_200); // S1 D1 SENIN
               ObjectSet("S1_Line", OBJPROP_COLOR, Daily_S_Levels);
               ObjectSet("S1_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("S1_Line", 0, Time[20], G_price_200);               // S1 D1 SENIN
            if(ObjectFind("S1_Label") != 0)
              {
               ObjectCreate("S1_Label", OBJ_TEXT, 0, Time[20], G_price_200);      // S1 D1 SENIN
               ObjectSetText("S1_Label", "Daily S1", 8, "Arial", Daily_S_Levels);
              }
            else
               ObjectMove("S1_Label", 0, Time[20], G_price_200);              // S1 D1 SENIN

            if(ObjectFind("S2_Line") != 0)
              {
               ObjectCreate("S2_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_208); // S2 D1 SENIN
               ObjectSet("S2_Line", OBJPROP_COLOR, Daily_S_Levels);
               ObjectSet("S2_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("S2_Line", 0, Time[20], G_price_208);               // S2 D1 SENIN
            if(ObjectFind("S2_Label") != 0)
              {
               ObjectCreate("S2_Label", OBJ_TEXT, 0, Time[20], G_price_208);      // S2 D1 SENIN
               ObjectSetText("S2_Label", "Daily S2", 8, "Arial", Daily_S_Levels);
              }
            else
               ObjectMove("S2_Label", 0, Time[20], G_price_208);              // S2 D1 SENIN

            if(ObjectFind("S3_Line") != 0)
              {
               ObjectCreate("S3_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_216); // S3 D1 SENIN
               ObjectSet("S3_Line", OBJPROP_COLOR, Daily_S_Levels);
               ObjectSet("S3_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("S3_Line", 0, Time[20], G_price_216);               // S3 D1 SENIN
            if(ObjectFind("S3_Label") != 0)
              {
               ObjectCreate("S3_Label", OBJ_TEXT, 0, Time[20], G_price_216);      // S3 D1 SENIN
               ObjectSetText("S3_Label", "Daily S3", 8, "Arial", Daily_S_Levels);
              }
            else
               ObjectMove("S3_Label", 0, Time[20], G_price_216);              // S3 D1 SENIN

           }
         WindowRedraw(); // Menggambar ulang grafik
        }

      // LOOPING DAILY MID
      if(Daily_Mid_Levels == TRUE)
        {
         if(ObjectFind("DM1_Line") != 0)
           {
            ObjectCreate("DM1_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_248);
            ObjectSet("DM1_Line", OBJPROP_COLOR, Daily_Mid_Level);
            ObjectSet("DM1_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("DM1_Line", 0, Time[15], G_price_248);
         if(ObjectFind("DM1_Label") != 0)
           {
            ObjectCreate("DM1_Label", OBJ_TEXT, 0, Time[15], G_price_248);
            ObjectSetText("DM1_Label", "DM1", 8, "Arial", Daily_Mid_Level);
           }
         else
            ObjectMove("DM1_Label", 0, Time[15], G_price_248);

         if(ObjectFind("DM2_Line") != 0)
           {
            ObjectCreate("DM2_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_256);
            ObjectSet("DM2_Line", OBJPROP_COLOR, Daily_Mid_Level);
            ObjectSet("DM2_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("DM2_Line", 0, Time[15], G_price_256);
         if(ObjectFind("DM2_Label") != 0)
           {
            ObjectCreate("DM2_Label", OBJ_TEXT, 0, Time[15], G_price_256);
            ObjectSetText("DM2_Label", "DM2", 8, "Arial", Daily_Mid_Level);
           }
         else
            ObjectMove("DM2_Label", 0, Time[15], G_price_256);

         if(ObjectFind("DM3_Line") != 0)
           {
            ObjectCreate("DM3_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_264);
            ObjectSet("DM3_Line", OBJPROP_COLOR, Daily_Mid_Level);
            ObjectSet("DM3_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("DM3_Line", 0, Time[15], G_price_264);
         if(ObjectFind("DM3_Label") != 0)
           {
            ObjectCreate("DM3_Label", OBJ_TEXT, 0, Time[15], G_price_264);
            ObjectSetText("DM3_Label", "DM3", 8, "Arial", Daily_Mid_Level);
           }
         else
            ObjectMove("DM3_Label", 0, Time[15], G_price_264);

         if(ObjectFind("DM4_Line") != 0)
           {
            ObjectCreate("DM4_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_272);
            ObjectSet("DM4_Line", OBJPROP_COLOR, Daily_Mid_Level);
            ObjectSet("DM4_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("DM4_Line", 0, Time[15], G_price_272);
         if(ObjectFind("DM4_Label") != 0)
           {
            ObjectCreate("DM4_Label", OBJ_TEXT, 0, Time[15], G_price_272);
            ObjectSetText("DM4_Label", "DM4", 8, "Arial", Daily_Mid_Level);
           }
         else
            ObjectMove("DM4_Label", 0, Time[15], G_price_272);

         if(ObjectFind("DM5_Line") != 0)
           {
            ObjectCreate("DM5_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_280);
            ObjectSet("DM5_Line", OBJPROP_COLOR, Daily_Mid_Level);
            ObjectSet("DM5_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("DM5_Line", 0, Time[15], G_price_280);
         if(ObjectFind("DM5_Label") != 0)
           {
            ObjectCreate("DM5_Label", OBJ_TEXT, 0, Time[15], G_price_280);
            ObjectSetText("DM5_Label", "DM5", 8, "Arial", Daily_Mid_Level);
           }
         else
            ObjectMove("DM5_Label", 0, Time[15], G_price_280);

         if(ObjectFind("DM6_Line") != 0)
           {
            ObjectCreate("DM6_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_288);
            ObjectSet("DM6_Line", OBJPROP_COLOR, Daily_Mid_Level);
            ObjectSet("DM6_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("DM6_Line", 0, Time[15], G_price_288);
         if(ObjectFind("DM6_Label") != 0)
           {
            ObjectCreate("DM6_Label", OBJ_TEXT, 0, Time[15], G_price_288);
            ObjectSetText("DM6_Label", "DM6", 8, "Arial", Daily_Mid_Level);
           }
         else
            ObjectMove("DM6_Label", 0, Time[15], G_price_288);
         WindowRedraw();
        }

      if(Monthly == TRUE)
        {
         if(ObjectFind("MonthPivotLine") != 0)
           {
            ObjectCreate("MonthPivotLine", OBJ_HLINE, 0, TimeCurrent(), G_price_456);
            ObjectSet("MonthPivotLine", OBJPROP_COLOR, Monthly_Pivot);
            ObjectSet("MonthPivotLine", OBJPROP_STYLE, STYLE_DASH);
           }
         else
            ObjectMove("MonthPivotLine", 0, Time[40], G_price_456);
         if(ObjectFind("MonthPivotLabel") != 0)
           {
            ObjectCreate("MonthPivotLabel", OBJ_TEXT, 0, Time[40], G_price_456);
            ObjectSetText("MonthPivotLabel", "MonthlyPivot", 8, "Arial", Monthly_Pivot);
           }
         else
            ObjectMove("MonthPivotLabel", 0, Time[40], G_price_456);

         if(Monthly_SR_Levels == TRUE)
           {
            if(ObjectFind("MR1_Line") != 0)
              {
               ObjectCreate("MR1_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_488);
               ObjectSet("MR1_Line", OBJPROP_COLOR, Monthly_R_Levels);
               ObjectSet("MR1_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("MR1_Line", 0, Time[40], G_price_488);
            if(ObjectFind("MR1_Label") != 0)
              {
               ObjectCreate("MR1_Label", OBJ_TEXT, 0, Time[40], G_price_488);
               ObjectSetText("MR1_Label", " Monthly R1", 8, "Arial", Monthly_R_Levels);
              }
            else
               ObjectMove("MR1_Label", 0, Time[40], G_price_488);

            if(ObjectFind("MR2_Line") != 0)
              {
               ObjectCreate("MR2_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_496);
               ObjectSet("MR2_Line", OBJPROP_COLOR, Monthly_R_Levels);
               ObjectSet("MR2_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("MR2_Line", 0, Time[40], G_price_496);
            if(ObjectFind("MR2_Label") != 0)
              {
               ObjectCreate("MR2_Label", OBJ_TEXT, 0, Time[40], G_price_496);
               ObjectSetText("MR2_Label", " Monthly R2", 8, "Arial", Monthly_R_Levels);
              }
            else
               ObjectMove("MR2_Label", 0, Time[40], G_price_496);

            if(ObjectFind("MR3_Line") != 0)
              {
               ObjectCreate("MR3_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_504);
               ObjectSet("MR3_Line", OBJPROP_COLOR, Monthly_R_Levels);
               ObjectSet("MR3_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("MR3_Line", 0, Time[40], G_price_504);
            if(ObjectFind("MR3_Label") != 0)
              {
               ObjectCreate("MR3_Label", OBJ_TEXT, 0, Time[40], G_price_504);
               ObjectSetText("MR3_Label", " Monthly R3", 8, "Arial", Monthly_R_Levels);
              }
            else
               ObjectMove("MR3_Label", 0, Time[40], G_price_504);

            if(ObjectFind("MS1_Line") != 0)
              {
               ObjectCreate("MS1_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_464);
               ObjectSet("MS1_Line", OBJPROP_COLOR, Monthly_S_Levels);
               ObjectSet("MS1_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("MS1_Line", 0, Time[40], G_price_464);
            if(ObjectFind("MS1_Label") != 0)
              {
               ObjectCreate("MS1_Label", OBJ_TEXT, 0, Time[40], G_price_464);
               ObjectSetText("MS1_Label", "Monthly S1", 8, "Arial", Monthly_S_Levels);
              }
            else
               ObjectMove("MS1_Label", 0, Time[40], G_price_464);

            if(ObjectFind("MS2_Line") != 0)
              {
               ObjectCreate("MS2_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_472);
               ObjectSet("MS2_Line", OBJPROP_COLOR, Monthly_S_Levels);
               ObjectSet("MS2_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("MS2_Line", 0, Time[40], G_price_472);
            if(ObjectFind("MS2_Label") != 0)
              {
               ObjectCreate("MS2_Label", OBJ_TEXT, 0, Time[40], G_price_472);
               ObjectSetText("MS2_Label", "Monthly S2", 8, "Arial", Monthly_S_Levels);
              }
            else
               ObjectMove("MS2_Label", 0, Time[40], G_price_472);

            if(ObjectFind("MS3_Line") != 0)
              {
               ObjectCreate("MS3_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_480);
               ObjectSet("MS3_Line", OBJPROP_COLOR, Monthly_S_Levels);
               ObjectSet("MS3_Line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
              }
            else
               ObjectMove("MS3_Line", 0, Time[40], G_price_480);
            if(ObjectFind("MS3_Label") != 0)
              {
               ObjectCreate("MS3_Label", OBJ_TEXT, 0, Time[40], G_price_480);
               ObjectSetText("MS3_Label", "Monthly S3", 8, "Arial", Monthly_S_Levels);
              }
            else
               ObjectMove("MS3_Label", 0, Time[40], G_price_480);
           }
        }

      if(Monthly_Mid_Levels == TRUE)
        {
         if(ObjectFind("MM1_Line") != 0)
           {
            ObjectCreate("MM1_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_512);
            ObjectSet("MM1_Line", OBJPROP_COLOR, Monthly_Mid_Level);
            ObjectSet("MM1_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("MM1_Line", 0, Time[35], G_price_512);
         if(ObjectFind("MM1_Label") != 0)
           {
            ObjectCreate("MM1_Label", OBJ_TEXT, 0, Time[35], G_price_512);
            ObjectSetText("MM1_Label", "MM1", 8, "Arial", Monthly_Mid_Level);
           }
         else
            ObjectMove("MM1_Label", 0, Time[35], G_price_512);

         if(ObjectFind("MM2_Line") != 0)
           {
            ObjectCreate("MM2_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_520);
            ObjectSet("MM2_Line", OBJPROP_COLOR, Monthly_Mid_Level);
            ObjectSet("MM2_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("MM2_Line", 0, Time[35], G_price_520);
         if(ObjectFind("MM2_Label") != 0)
           {
            ObjectCreate("MM2_Label", OBJ_TEXT, 0, Time[35], G_price_520);
            ObjectSetText("MM2_Label", "MM2", 8, "Arial", Monthly_Mid_Level);
           }
         else
            ObjectMove("MM2_Label", 0, Time[35], G_price_520);

         if(ObjectFind("MM3_Line") != 0)
           {
            ObjectCreate("MM3_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_528);
            ObjectSet("MM3_Line", OBJPROP_COLOR, Monthly_Mid_Level);
            ObjectSet("MM3_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("MM3_Line", 0, Time[35], G_price_528);
         if(ObjectFind("MM3_Label") != 0)
           {
            ObjectCreate("MM3_Label", OBJ_TEXT, 0, Time[35], G_price_528);
            ObjectSetText("MM3_Label", "MM3", 8, "Arial", Monthly_Mid_Level);
           }
         else
            ObjectMove("MM3_Label", 0, Time[35], G_price_528);

         if(ObjectFind("MM4_Line") != 0)
           {
            ObjectCreate("MM4_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_536);
            ObjectSet("MM4_Line", OBJPROP_COLOR, Monthly_Mid_Level);
            ObjectSet("MM4_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("MM4_Line", 0, Time[35], G_price_536);
         if(ObjectFind("MM4_Label") != 0)
           {
            ObjectCreate("MM4_Label", OBJ_TEXT, 0, Time[35], G_price_536);
            ObjectSetText("MM4_Label", "MM4", 8, "Arial", Monthly_Mid_Level);
           }
         else
            ObjectMove("MM4_Label", 0, Time[35], G_price_536);

         if(ObjectFind("MM5_Line") != 0)
           {
            ObjectCreate("MM5_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_544);
            ObjectSet("MM5_Line", OBJPROP_COLOR, Monthly_Mid_Level);
            ObjectSet("MM5_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("MM5_Line", 0, Time[25], G_price_544);
         if(ObjectFind("MM5_Label") != 0)
           {
            ObjectCreate("MM5_Label", OBJ_TEXT, 0, Time[35], G_price_544);
            ObjectSetText("MM5_Label", "MM5", 8, "Arial", Monthly_Mid_Level);
           }
         else
            ObjectMove("MM5_Label", 0, Time[35], G_price_544);

         if(ObjectFind("MM6_Line") != 0)
           {
            ObjectCreate("MM6_Line", OBJ_HLINE, 0, TimeCurrent(), G_price_552);
            ObjectSet("MM6_Line", OBJPROP_COLOR, Monthly_Mid_Level);
            ObjectSet("MM6_Line", OBJPROP_STYLE, STYLE_DOT);
           }
         else
            ObjectMove("MM6_Line", 0, Time[35], G_price_552);
         if(ObjectFind("MM6_Label") != 0)
           {
            ObjectCreate("MM6_Label", OBJ_TEXT, 0, Time[35], G_price_552);
            ObjectSetText("MM6_Label", "MM6", 8, "Arial", Monthly_Mid_Level);
           }
         else
            ObjectMove("MM6_Label", 0, Time[35], G_price_552);
         WindowRedraw();
        }
      WindowRedraw();
      shift2=shift;
     }
     


  }
//+------------------------------------------------------------------+
