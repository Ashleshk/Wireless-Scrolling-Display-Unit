#line 1 "C:/Users/raj/Desktop/EmbeddedLab_Code/MikroC_PIC/PIC16F1847_Module/8x40LEDmatrix/LED_Matrix_With_UART.c"
#line 10 "C:/Users/raj/Desktop/EmbeddedLab_Code/MikroC_PIC/PIC16F1847_Module/8x40LEDmatrix/LED_Matrix_With_UART.c"
 sbit Serial_Data at RA0_bit;
 sbit SH_Clk at RA1_bit;
 sbit ST_Clk at RA2_bit;

 unsigned short Buffer[8][5] = {
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0},
 {0,0,0,0,0}
 };

unsigned int speed, StringLength;
unsigned short i, l, k, row, scroll, temp, shift_step=1;
unsigned short m, SerialConnect=0, UserIP = 0;
#line 31 "C:/Users/raj/Desktop/EmbeddedLab_Code/MikroC_PIC/PIC16F1847_Module/8x40LEDmatrix/LED_Matrix_With_UART.c"
const unsigned char default_message[]="THIS IS A DEMONSTRATION OF AN 8X40 LED MATRIX DISPLAY USING SHIFT REGISTERS AND PIC16F1847 MICROCONTROLLER. FOR MORE DETAILS VISIT WWW.EMBEDDED-LAB.COM.    ";

char message[250], index;

void Send_Data(unsigned short rw){
 unsigned short Mask, t, num, Flag;
 for (num = 0; num < 5; num++) {
 Mask = 0x01;
 for (t=0; t<8; t++){
 Flag = Buffer[rw][num] & Mask;
 if(Flag==0) Serial_Data = 0;
 else Serial_Data = 1;
 SH_Clk = 1;
 SH_Clk = 0;
 Mask = Mask << 1;
 }
 }


 ST_Clk = 1;
 ST_Clk = 0;

}
#line 58 "C:/Users/raj/Desktop/EmbeddedLab_Code/MikroC_PIC/PIC16F1847_Module/8x40LEDmatrix/LED_Matrix_With_UART.c"
const unsigned short CharData[][8] ={
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000100},
{0b00001010, 0b00001010, 0b00001010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00001010, 0b00011111, 0b00001010, 0b00011111, 0b00001010, 0b00011111, 0b00001010},
{0b00000111, 0b00001100, 0b00010100, 0b00001100, 0b00000110, 0b00000101, 0b00000110, 0b00011100},
{0b00011001, 0b00011010, 0b00000010, 0b00000100, 0b00000100, 0b00001000, 0b00001011, 0b00010011},
{0b00000110, 0b00001010, 0b00010010, 0b00010100, 0b00001001, 0b00010110, 0b00010110, 0b00001001},
{0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000010, 0b00000100, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00000100, 0b00000010},
{0b00001000, 0b00000100, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00000100, 0b00001000},
{0b00010101, 0b00001110, 0b00011111, 0b00001110, 0b00010101, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00011111, 0b00000100, 0b00000100, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000110, 0b00000100, 0b00001000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000100},
{0b00000001, 0b00000010, 0b00000010, 0b00000100, 0b00000100, 0b00001000, 0b00001000, 0b00010000},
{0b00001110, 0b00010001, 0b00010011, 0b00010001, 0b00010101, 0b00010001, 0b00011001, 0b00001110},
{0b00000100, 0b00001100, 0b00010100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00011111},
{0b00001110, 0b00010001, 0b00010001, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00011111},
{0b00001110, 0b00010001, 0b00000001, 0b00001110, 0b00000001, 0b00000001, 0b00010001, 0b00001110},
{0b00010000, 0b00010000, 0b00010100, 0b00010100, 0b00011111, 0b00000100, 0b00000100, 0b00000100},
{0b00011111, 0b00010000, 0b00010000, 0b00011110, 0b00000001, 0b00000001, 0b00000001, 0b00011110},
{0b00000111, 0b00001000, 0b00010000, 0b00011110, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00011111, 0b00000001, 0b00000001, 0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00010000},
{0b00001110, 0b00010001, 0b00010001, 0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00001110, 0b00010001, 0b00010001, 0b00001111, 0b00000001, 0b00000001, 0b00000001, 0b00000001},
{0b00000000, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00000000},
{0b00000000, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00001000},
{0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00001000, 0b00000100, 0b00000010, 0b00000001},
{0b00000000, 0b00000000, 0b00000000, 0b00011110, 0b00000000, 0b00011110, 0b00000000, 0b00000000},
{0b00010000, 0b00001000, 0b00000100, 0b00000010, 0b00000010, 0b00000100, 0b00001000, 0b00010000},
{0b00001110, 0b00010001, 0b00010001, 0b00000010, 0b00000100, 0b00000100, 0b00000000, 0b00000100},
{0b00001110, 0b00010001, 0b00010001, 0b00010101, 0b00010101, 0b00010001, 0b00010001, 0b00011110},
{0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00011111, 0b00010001, 0b00010001, 0b00010001},
{0b00011110, 0b00010001, 0b00010001, 0b00011110, 0b00010001, 0b00010001, 0b00010001, 0b00011110},
{0b00000111, 0b00001000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00001000, 0b00000111},
{0b00011100, 0b00010010, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010010, 0b00011100},
{0b00011111, 0b00010000, 0b00010000, 0b00011110, 0b00010000, 0b00010000, 0b00010000, 0b00011111},
{0b00011111, 0b00010000, 0b00010000, 0b00011110, 0b00010000, 0b00010000, 0b00010000, 0b00010000},
{0b00001110, 0b00010001, 0b00010000, 0b00010000, 0b00010111, 0b00010001, 0b00010001, 0b00001110},
{0b00010001, 0b00010001, 0b00010001, 0b00011111, 0b00010001, 0b00010001, 0b00010001, 0b00010001},
{0b00011111, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00011111},
{0b00011111, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00010100, 0b00001000},
{0b00010001, 0b00010010, 0b00010100, 0b00011000, 0b00010100, 0b00010010, 0b00010001, 0b00010001},
{0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00011111},
{0b00010001, 0b00011011, 0b00011111, 0b00010101, 0b00010001, 0b00010001, 0b00010001, 0b00010001},
{0b00010001, 0b00011001, 0b00011001, 0b00010101, 0b00010101, 0b00010011, 0b00010011, 0b00010001},
{0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00011110, 0b00010001, 0b00010001, 0b00011110, 0b00010000, 0b00010000, 0b00010000, 0b00010000},
{0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010101, 0b00010011, 0b00001111},
{0b00011110, 0b00010001, 0b00010001, 0b00011110, 0b00010100, 0b00010010, 0b00010001, 0b00010001},
{0b00001110, 0b00010001, 0b00010000, 0b00001000, 0b00000110, 0b00000001, 0b00010001, 0b00001110},
{0b00011111, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00001010, 0b00000100},
{0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010101, 0b00010101, 0b00001010},
{0b00010001, 0b00010001, 0b00001010, 0b00000100, 0b00000100, 0b00001010, 0b00010001, 0b00010001},
{0b00010001, 0b00010001, 0b00001010, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00011111, 0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00010000, 0b00011111},
{0b00001110, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001110},
{0b00010000, 0b00001000, 0b00001000, 0b00000100, 0b00000100, 0b00000010, 0b00000010, 0b00000001},
{0b00001110, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00001110},
{0b00000100, 0b00001010, 0b00010001, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00011111},
{0b00001000, 0b00000100, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00010010, 0b00010010, 0b00010010, 0b00001111},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00011100},
{0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00010000, 0b00010000, 0b00010000, 0b00001110},
{0b00000000, 0b00000001, 0b00000001, 0b00000001, 0b00000111, 0b00001001, 0b00001001, 0b00000111},
{0b00000000, 0b00000000, 0b00000000, 0b00011100, 0b00010010, 0b00011110, 0b00010000, 0b00001110},
{0b00000000, 0b00000011, 0b00000100, 0b00000100, 0b00000110, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00001110, 0b00001010, 0b00001010, 0b00001110, 0b00000010, 0b00000010, 0b00001100},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00000000, 0b00000100, 0b00000000, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00000010, 0b00000000, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00001100},
{0b00000000, 0b00010000, 0b00010000, 0b00010100, 0b00011000, 0b00011000, 0b00010100, 0b00010000},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00001100},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00010101, 0b00010001, 0b00010001, 0b00010001},
{0b00000000, 0b00000000, 0b00000000, 0b00010100, 0b00011010, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00011100, 0b00010010, 0b00010010, 0b00011100, 0b00010000, 0b00010000, 0b00010000},
{0b00000000, 0b00001110, 0b00010010, 0b00010010, 0b00001110, 0b00000010, 0b00000010, 0b00000001},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00001100, 0b00001000, 0b00001000, 0b00001000},
{0b00000000, 0b00000000, 0b00001110, 0b00010000, 0b00001000, 0b00000100, 0b00000010, 0b00011110},
{0b00000000, 0b00010000, 0b00010000, 0b00011100, 0b00010000, 0b00010000, 0b00010000, 0b00001100},
{0b00000000, 0b00000000, 0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00000000, 0b00000000, 0b00010001, 0b00010001, 0b00010001, 0b00001010, 0b00000100},
{0b00000000, 0b00000000, 0b00000000, 0b00010001, 0b00010001, 0b00010001, 0b00010101, 0b00001010},
{0b00000000, 0b00000000, 0b00000000, 0b00010001, 0b00001010, 0b00000100, 0b00001010, 0b00010001},
{0b00000000, 0b00000000, 0b00010001, 0b00001010, 0b00000100, 0b00001000, 0b00001000, 0b00010000},
{0b00000000, 0b00000000, 0b00000000, 0b00011111, 0b00000010, 0b00000100, 0b00001000, 0b00011111},
{0b00000010, 0b00000100, 0b00000100, 0b00000100, 0b00001000, 0b00000100, 0b00000100, 0b00000010},
{0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00001000, 0b00000100, 0b00000100, 0b00000100, 0b00000010, 0b00000100, 0b00000100, 0b00001000},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00011110, 0b00010100, 0b00000000, 0b00000000}
};

void Delay_onesec(){
 Delay_ms(1000);
}
unsigned short Find_StrLength(){
 return strlen(message);
}

void Save_Message(){
 EEPROM_Write(0x00, 1);
 EEPROM_Write(0x01, StringLength);
 for(i=0; i<StringLength; i++){
 EEPROM_Write(i+2, message[i]);
 }
 EEPROM_Write(i+2, 32);
 EEPROM_Write(i+3, 32);
 EEPROM_Write(i+4, 32);
 EEPROM_Write(i+5, 32);
 UART1_Write(13);
 UART1_Write(10);
 UART_Write_Text("MESSAGE SAVED!");
}

void ListenSerial(){
 unsigned char RxByte;
 UART_Write_Text("---- 8X40 LED Matrix Display ----");
 UART1_Write(13);
 UART1_Write(10);
 UART_Write_Text("ARE YOU READY FOR YOUR INPUT? Y/N");
 Delay_onesec();
 Delay_onesec();
 Delay_onesec();
 if (UART1_Data_Ready()) {
 RxByte = UART1_Read();
 if(RxByte == 'Y') {
 UART1_Write(13);
 UART1_Write(10);
 UART_Write_Text("Great! Always terminate your message with #");
 UART1_Write(13);
 UART1_Write(10);
 UART_Write_Text("Waiting for your input (MAX. 250 char.) ...");
 while (!UART_Data_Ready());
 UART_Read_Text(message, "#", 250);
 message[0] = ' ';
 StringLength = Find_StrLength();
 UART1_Write(13);
 UART1_Write(10);
 UART_Write_Text("Message received. Now saving into EEPROM ...");
 Save_Message();
 }
 }
}


void Load_Data(){
 for (k=0; k<StringLength+4; k++){
 message[k] = EEPROM_Read(k+2);
 }
}

void main() {
 OSCCON = 0b01110000;
 ANSELA = 0b00000000;
 ANSELB = 0b00000000;
 TRISA = 0b00100000;
 TRISB = 0b00000010;
 PORTB = 0;
 UART1_Init(115200);
 Delay_ms(100);
 ListenSerial();
 TRISB = 0b00000000;
 RCSTA = 0x00;

 UserIP = EEPROM_Read(0x00);

 if(UserIP == 1) {
 StringLength = EEPROM_Read(0x01);
 Load_Data();
 }
 else StringLength = 156;

 do {
 for (k=0; k<StringLength+4; k++){
 for (scroll=0; scroll<(8/shift_step); scroll++) {
 for (row=0; row<8; row++){
 if(UserIP == 1) index = message[k];
 else index = default_message[k];
 temp = CharData[index-32][row];
 Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
 Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
 Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
 Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
 Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
 }
 speed = 15;
 for(l=0; l<speed;l++){
 m = 1;
 for (i=0; i<8; i++) {
 Send_Data(i);
 LATB = m;
 m = m << 1;
 Delay_us(1000);
 }
 }
 }
 }

} while(1);
}
