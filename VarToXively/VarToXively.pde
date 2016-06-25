import processing.serial.*;
import java.util.*;
import java.text.*;
Serial port; // 宣告Serial物件
float val=0, pval=0; // 承接來自Serial Port的資料
final int feedId=1167753345;//宣告變數存放Feed ID
void setup()
{  
  size(400, 300);
  String arduinoPort = Serial.list()[1]; //將與Arduino連接的COM port名稱放在變數
  port = new Serial(this, arduinoPort, 9600); //對COM port進行初始化
  textSize(80);//設定視窗尺寸
  background(102); //背景顏色設為灰
}
void draw()
{
  if (port.available() > 0) { // 當COM port收到資料時
    val = port.read(); // 讀取並放在變數中
  }
  if (val!=pval)  //若資料的值有改變
  {
    background(102);  //將畫面清空
    text(val, 10, 150); //繪製數字
    setDataPoint(val); //傳資料到Xively
  }
  pval=val;  //將目前的數值記錄在"pval"變數
}

void setDataPoint(float val) {
  String v1, v2;
  Date dNow = new Date( );//宣告Date物件並實體化
  SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS000Z"); //將欲上傳之時間資訊格式化(年月日時分秒)
  System.out.println("Current Date: " + ft.format(dNow));//在console印出目前時間
  try {
    Datapoint dp1 = new Datapoint();//宣告Datapoint物件並實體化(Xively Library中的類別)
    dp1.setAt(ft.format(dNow));//設定Datapoint的時間
    v1=String.valueOf(val);
    dp1.setValue(v1);//設定Datapoint的值
    DatapointRequester requester = XivelyService.instance().datapoint(feedId, "AnalogValue11");//宣告DatapointRequester物件並實體化
    requester.create(dp1);//將datapoint資料透過HTTP POST傳到Xively
  }
  catch (Exception e) {
    System.out.println("Sth. wrong!"+e.toString());
  }
}


