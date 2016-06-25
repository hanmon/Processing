import processing.serial.*;
Serial port; // 宣告Serial類別的物件
float val, pval; // 用來接收及儲存串列埠傳來的資料
void settings(){
  size(400, 300);
}
void setup() {
  String arduinoPort = Serial.list()[1]; //請依照您電腦Arduino所在Port設定，起始port索引為0
  port = new Serial(this, arduinoPort, 9600); //實體化Serial類別的物件
  textSize(80);//設定字型大小
  background(102);//設定背景
}
void draw() {
  if (port.available() > 0) { // If data is available,
    val = port.read(); // read it and store it in val
  }
  if (val!=pval)
  {
    background(102); //清除畫面
    text(val, 10, 150);//將val值顯示並定位在畫面上
  }
  pval=val;//把目前的val值存起來
}