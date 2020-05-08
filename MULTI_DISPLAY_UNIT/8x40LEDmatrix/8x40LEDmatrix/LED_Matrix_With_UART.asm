
_Send_Data:

;LED_Matrix_With_UART.c,35 :: 		void Send_Data(unsigned short rw){
;LED_Matrix_With_UART.c,37 :: 		for (num = 0; num < 5; num++) {
	CLRF       Send_Data_num_L0+0
L_Send_Data0:
	MOVLW      5
	SUBWF      Send_Data_num_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data1
;LED_Matrix_With_UART.c,38 :: 		Mask = 0x01;
	MOVLW      1
	MOVWF      Send_Data_Mask_L0+0
;LED_Matrix_With_UART.c,39 :: 		for (t=0; t<8; t++){
	CLRF       Send_Data_t_L0+0
L_Send_Data3:
	MOVLW      8
	SUBWF      Send_Data_t_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Send_Data4
;LED_Matrix_With_UART.c,40 :: 		Flag = Buffer[rw][num] & Mask;
	MOVLW      5
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	MOVF       FARG_Send_Data_rw+0, 0
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      _Buffer+0
	ADDWF      R0, 1
	MOVLW      hi_addr(_Buffer+0)
	ADDWFC     R1, 1
	MOVF       Send_Data_num_L0+0, 0
	ADDWF      R0, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R1, 0
	MOVWF      FSR0H
	MOVF       Send_Data_Mask_L0+0, 0
	ANDWF      INDF0+0, 0
	MOVWF      R1
;LED_Matrix_With_UART.c,41 :: 		if(Flag==0) Serial_Data = 0;
	MOVF       R1, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Send_Data6
	BCF        RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_Send_Data7
L_Send_Data6:
;LED_Matrix_With_UART.c,42 :: 		else Serial_Data = 1;
	BSF        RA0_bit+0, BitPos(RA0_bit+0)
L_Send_Data7:
;LED_Matrix_With_UART.c,43 :: 		SH_Clk = 1;
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
;LED_Matrix_With_UART.c,44 :: 		SH_Clk = 0;
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
;LED_Matrix_With_UART.c,45 :: 		Mask = Mask << 1;
	LSLF       Send_Data_Mask_L0+0, 1
;LED_Matrix_With_UART.c,39 :: 		for (t=0; t<8; t++){
	INCF       Send_Data_t_L0+0, 1
;LED_Matrix_With_UART.c,46 :: 		}
	GOTO       L_Send_Data3
L_Send_Data4:
;LED_Matrix_With_UART.c,37 :: 		for (num = 0; num < 5; num++) {
	INCF       Send_Data_num_L0+0, 1
;LED_Matrix_With_UART.c,47 :: 		}
	GOTO       L_Send_Data0
L_Send_Data1:
;LED_Matrix_With_UART.c,50 :: 		ST_Clk = 1;
	BSF        RA2_bit+0, BitPos(RA2_bit+0)
;LED_Matrix_With_UART.c,51 :: 		ST_Clk = 0;
	BCF        RA2_bit+0, BitPos(RA2_bit+0)
;LED_Matrix_With_UART.c,53 :: 		}
L_end_Send_Data:
	RETURN
; end of _Send_Data

_Delay_onesec:

;LED_Matrix_With_UART.c,156 :: 		void Delay_onesec(){
;LED_Matrix_With_UART.c,157 :: 		Delay_ms(1000);
	MOVLW      41
	MOVWF      R11
	MOVLW      150
	MOVWF      R12
	MOVLW      127
	MOVWF      R13
L_Delay_onesec8:
	DECFSZ     R13, 1
	GOTO       L_Delay_onesec8
	DECFSZ     R12, 1
	GOTO       L_Delay_onesec8
	DECFSZ     R11, 1
	GOTO       L_Delay_onesec8
;LED_Matrix_With_UART.c,158 :: 		}
L_end_Delay_onesec:
	RETURN
; end of _Delay_onesec

_Find_StrLength:

;LED_Matrix_With_UART.c,159 :: 		unsigned short Find_StrLength(){
;LED_Matrix_With_UART.c,160 :: 		return strlen(message);
	MOVLW      _message+0
	MOVWF      FARG_strlen_s+0
	MOVLW      hi_addr(_message+0)
	MOVWF      FARG_strlen_s+1
	CALL       _strlen+0
;LED_Matrix_With_UART.c,161 :: 		}
L_end_Find_StrLength:
	RETURN
; end of _Find_StrLength

_Save_Message:

;LED_Matrix_With_UART.c,163 :: 		void Save_Message(){
;LED_Matrix_With_UART.c,164 :: 		EEPROM_Write(0x00, 1);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,165 :: 		EEPROM_Write(0x01, StringLength);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _StringLength+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,166 :: 		for(i=0; i<StringLength; i++){
	CLRF       _i+0
L_Save_Message9:
	MOVF       _StringLength+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Save_Message47
	MOVF       _StringLength+0, 0
	SUBWF      _i+0, 0
L__Save_Message47:
	BTFSC      STATUS+0, 0
	GOTO       L_Save_Message10
;LED_Matrix_With_UART.c,167 :: 		EEPROM_Write(i+2, message[i]);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      _message+0
	MOVWF      R0
	MOVLW      hi_addr(_message+0)
	MOVWF      R1
	MOVF       _i+0, 0
	ADDWF      R0, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,166 :: 		for(i=0; i<StringLength; i++){
	INCF       _i+0, 1
;LED_Matrix_With_UART.c,168 :: 		}
	GOTO       L_Save_Message9
L_Save_Message10:
;LED_Matrix_With_UART.c,169 :: 		EEPROM_Write(i+2, 32);
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,170 :: 		EEPROM_Write(i+3, 32);
	MOVLW      3
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,171 :: 		EEPROM_Write(i+4, 32);
	MOVLW      4
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,172 :: 		EEPROM_Write(i+5, 32);
	MOVLW      5
	ADDWF      _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;LED_Matrix_With_UART.c,173 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,174 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,175 :: 		UART_Write_Text("MESSAGE SAVED!");
	MOVLW      ?lstr1_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;LED_Matrix_With_UART.c,176 :: 		}
L_end_Save_Message:
	RETURN
; end of _Save_Message

_ListenSerial:

;LED_Matrix_With_UART.c,178 :: 		void ListenSerial(){
;LED_Matrix_With_UART.c,180 :: 		UART_Write_Text("---- 8X40 LED Matrix Display ----");
	MOVLW      ?lstr2_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;LED_Matrix_With_UART.c,181 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,182 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,183 :: 		UART_Write_Text("ARE YOU READY FOR YOUR INPUT? Y/N");
	MOVLW      ?lstr3_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;LED_Matrix_With_UART.c,184 :: 		Delay_onesec();
	CALL       _Delay_onesec+0
;LED_Matrix_With_UART.c,185 :: 		Delay_onesec();
	CALL       _Delay_onesec+0
;LED_Matrix_With_UART.c,186 :: 		Delay_onesec();
	CALL       _Delay_onesec+0
;LED_Matrix_With_UART.c,187 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ListenSerial12
;LED_Matrix_With_UART.c,188 :: 		RxByte = UART1_Read();
	CALL       _UART1_Read+0
;LED_Matrix_With_UART.c,189 :: 		if(RxByte == 'Y') {
	MOVF       R0, 0
	XORLW      89
	BTFSS      STATUS+0, 2
	GOTO       L_ListenSerial13
;LED_Matrix_With_UART.c,190 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,191 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,192 :: 		UART_Write_Text("Great! Always terminate your message with #");
	MOVLW      ?lstr4_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;LED_Matrix_With_UART.c,193 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,194 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,195 :: 		UART_Write_Text("Waiting for your input (MAX. 250 char.) ...");
	MOVLW      ?lstr5_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;LED_Matrix_With_UART.c,196 :: 		while (!UART_Data_Ready());          // if data is received
L_ListenSerial14:
	CALL       _UART_Data_Ready+0
	MOVF       R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_ListenSerial15
	GOTO       L_ListenSerial14
L_ListenSerial15:
;LED_Matrix_With_UART.c,197 :: 		UART_Read_Text(message, "#", 250);    // reads text until '#' is found
	MOVLW      _message+0
	MOVWF      FARG_UART_Read_Text_Output+0
	MOVLW      hi_addr(_message+0)
	MOVWF      FARG_UART_Read_Text_Output+1
	MOVLW      ?lstr6_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Read_Text_Delimiter+0
	MOVLW      hi_addr(?lstr6_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Read_Text_Delimiter+1
	MOVLW      250
	MOVWF      FARG_UART_Read_Text_Attempts+0
	CALL       _UART_Read_Text+0
;LED_Matrix_With_UART.c,198 :: 		message[0] = ' ';
	MOVLW      _message+0
	MOVWF      FSR1L
	MOVLW      hi_addr(_message+0)
	MOVWF      FSR1H
	MOVLW      32
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,199 :: 		StringLength = Find_StrLength();
	CALL       _Find_StrLength+0
	MOVF       R0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;LED_Matrix_With_UART.c,200 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,201 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;LED_Matrix_With_UART.c,202 :: 		UART_Write_Text("Message received. Now saving into EEPROM ...");
	MOVLW      ?lstr7_LED_Matrix_With_UART+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_LED_Matrix_With_UART+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;LED_Matrix_With_UART.c,203 :: 		Save_Message();
	CALL       _Save_Message+0
;LED_Matrix_With_UART.c,204 :: 		}
L_ListenSerial13:
;LED_Matrix_With_UART.c,205 :: 		}
L_ListenSerial12:
;LED_Matrix_With_UART.c,206 :: 		}
L_end_ListenSerial:
	RETURN
; end of _ListenSerial

_Load_Data:

;LED_Matrix_With_UART.c,209 :: 		void Load_Data(){
;LED_Matrix_With_UART.c,210 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_Load_Data16:
	MOVLW      4
	ADDWF      _StringLength+0, 0
	MOVWF      R1
	MOVLW      0
	ADDWFC     _StringLength+1, 0
	MOVWF      R2
	MOVF       R2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Load_Data50
	MOVF       R1, 0
	SUBWF      _k+0, 0
L__Load_Data50:
	BTFSC      STATUS+0, 0
	GOTO       L_Load_Data17
;LED_Matrix_With_UART.c,211 :: 		message[k] = EEPROM_Read(k+2);
	MOVLW      _message+0
	MOVWF      R0
	MOVLW      hi_addr(_message+0)
	MOVWF      R1
	MOVF       _k+0, 0
	ADDWF      R0, 0
	MOVWF      FLOC__Load_Data+0
	MOVLW      0
	ADDWFC     R1, 0
	MOVWF      FLOC__Load_Data+1
	MOVLW      2
	ADDWF      _k+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__Load_Data+0, 0
	MOVWF      FSR1L
	MOVF       FLOC__Load_Data+1, 0
	MOVWF      FSR1H
	MOVF       R0, 0
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,210 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;LED_Matrix_With_UART.c,212 :: 		}
	GOTO       L_Load_Data16
L_Load_Data17:
;LED_Matrix_With_UART.c,213 :: 		}
L_end_Load_Data:
	RETURN
; end of _Load_Data

_main:

;LED_Matrix_With_UART.c,215 :: 		void main() {
;LED_Matrix_With_UART.c,216 :: 		OSCCON = 0b01110000;  // 32 MHz internal
	MOVLW      112
	MOVWF      OSCCON+0
;LED_Matrix_With_UART.c,217 :: 		ANSELA = 0b00000000;  // PORTA all digital pins
	CLRF       ANSELA+0
;LED_Matrix_With_UART.c,218 :: 		ANSELB = 0b00000000;  // PORTB all digital pins
	CLRF       ANSELB+0
;LED_Matrix_With_UART.c,219 :: 		TRISA  = 0b00100000;  // RA5 is input only
	MOVLW      32
	MOVWF      TRISA+0
;LED_Matrix_With_UART.c,220 :: 		TRISB  = 0b00000010;  // RB1 is UART Rx
	MOVLW      2
	MOVWF      TRISB+0
;LED_Matrix_With_UART.c,221 :: 		PORTB  = 0;
	CLRF       PORTB+0
;LED_Matrix_With_UART.c,222 :: 		UART1_Init(115200);
	BSF        BAUDCON+0, 3
	MOVLW      68
	MOVWF      SPBRG+0
	MOVLW      0
	MOVWF      SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;LED_Matrix_With_UART.c,223 :: 		Delay_ms(100);
	MOVLW      5
	MOVWF      R11
	MOVLW      15
	MOVWF      R12
	MOVLW      241
	MOVWF      R13
L_main19:
	DECFSZ     R13, 1
	GOTO       L_main19
	DECFSZ     R12, 1
	GOTO       L_main19
	DECFSZ     R11, 1
	GOTO       L_main19
;LED_Matrix_With_UART.c,224 :: 		ListenSerial();       // Check for serial data receive
	CALL       _ListenSerial+0
;LED_Matrix_With_UART.c,225 :: 		TRISB  = 0b00000000;  // PORTB is now all output
	CLRF       TRISB+0
;LED_Matrix_With_UART.c,226 :: 		RCSTA  = 0x00;
	CLRF       RCSTA+0
;LED_Matrix_With_UART.c,228 :: 		UserIP = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _UserIP+0
;LED_Matrix_With_UART.c,230 :: 		if(UserIP == 1) {
	MOVF       R0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;LED_Matrix_With_UART.c,231 :: 		StringLength = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
;LED_Matrix_With_UART.c,232 :: 		Load_Data();  // Read stored data and save into RAM
	CALL       _Load_Data+0
;LED_Matrix_With_UART.c,233 :: 		}
	GOTO       L_main21
L_main20:
;LED_Matrix_With_UART.c,234 :: 		else  StringLength = 156;
	MOVLW      156
	MOVWF      _StringLength+0
	CLRF       _StringLength+1
L_main21:
;LED_Matrix_With_UART.c,236 :: 		do {
L_main22:
;LED_Matrix_With_UART.c,237 :: 		for (k=0; k<StringLength+4; k++){
	CLRF       _k+0
L_main25:
	MOVLW      4
	ADDWF      _StringLength+0, 0
	MOVWF      R1
	MOVLW      0
	ADDWFC     _StringLength+1, 0
	MOVWF      R2
	MOVF       R2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       R1, 0
	SUBWF      _k+0, 0
L__main52:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;LED_Matrix_With_UART.c,238 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	CLRF       _scroll+0
L_main28:
	MOVF       _shift_step+0, 0
	MOVWF      R4
	MOVLW      8
	MOVWF      R0
	CALL       _Div_8x8_U+0
	MOVF       R0, 0
	SUBWF      _scroll+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;LED_Matrix_With_UART.c,239 :: 		for (row=0; row<8; row++){
	CLRF       _row+0
L_main31:
	MOVLW      8
	SUBWF      _row+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main32
;LED_Matrix_With_UART.c,240 :: 		if(UserIP == 1) index = message[k];
	MOVF       _UserIP+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main34
	MOVLW      _message+0
	MOVWF      R0
	MOVLW      hi_addr(_message+0)
	MOVWF      R1
	MOVF       _k+0, 0
	ADDWF      R0, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      _index+0
	GOTO       L_main35
L_main34:
;LED_Matrix_With_UART.c,241 :: 		else index = default_message[k];
	MOVLW      _default_message+0
	MOVWF      FSR0L
	MOVLW      hi_addr(_default_message+0)
	MOVWF      FSR0H
	MOVF       _k+0, 0
	ADDWF      FSR0L, 1
	BTFSC      STATUS+0, 0
	INCF       FSR0H, 1
	MOVF       INDF0+0, 0
	MOVWF      _index+0
L_main35:
;LED_Matrix_With_UART.c,242 :: 		temp = CharData[index-32][row];
	MOVLW      32
	SUBWF      _index+0, 0
	MOVWF      R3
	CLRF       R4
	MOVLW      0
	SUBWFB     R4, 1
	MOVLW      3
	MOVWF      R2
	MOVF       R3, 0
	MOVWF      R0
	MOVF       R4, 0
	MOVWF      R1
	MOVF       R2, 0
L__main53:
	BTFSC      STATUS+0, 2
	GOTO       L__main54
	LSLF       R0, 1
	RLF        R1, 1
	ADDLW      255
	GOTO       L__main53
L__main54:
	MOVLW      _CharData+0
	ADDWF      R0, 1
	MOVLW      hi_addr(_CharData+0)
	ADDWFC     R1, 1
	MOVF       _row+0, 0
	ADDWF      R0, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      _temp+0
;LED_Matrix_With_UART.c,243 :: 		Buffer[row][4] = (Buffer[row][4] << Shift_Step) | (Buffer[row][3] >> (8-Shift_Step));
	MOVLW      5
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	MOVF       _row+0, 0
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      _Buffer+0
	ADDWF      R0, 0
	MOVWF      R2
	MOVLW      hi_addr(_Buffer+0)
	ADDWFC     R1, 0
	MOVWF      R3
	MOVLW      4
	ADDWF      R2, 0
	MOVWF      R5
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      R6
	MOVF       R5, 0
	MOVWF      FSR0L
	MOVF       R6, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       _shift_step+0, 0
	MOVWF      R0
	MOVF       R1, 0
	MOVWF      R4
	MOVF       R0, 0
L__main55:
	BTFSC      STATUS+0, 2
	GOTO       L__main56
	LSLF       R4, 1
	ADDLW      255
	GOTO       L__main55
L__main56:
	MOVLW      3
	ADDWF      R2, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R2
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0
	CLRF       R1
	MOVLW      0
	SUBWFB     R1, 1
	MOVF       R0, 0
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__main57:
	BTFSC      STATUS+0, 2
	GOTO       L__main58
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__main57
L__main58:
	MOVF       R4, 0
	IORWF       R0, 1
	MOVF       R5, 0
	MOVWF      FSR1L
	MOVF       R6, 0
	MOVWF      FSR1H
	MOVF       R0, 0
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,244 :: 		Buffer[row][3] = (Buffer[row][3] << Shift_Step) | (Buffer[row][2] >> (8-Shift_Step));
	MOVLW      5
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	MOVF       _row+0, 0
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      _Buffer+0
	ADDWF      R0, 0
	MOVWF      R2
	MOVLW      hi_addr(_Buffer+0)
	ADDWFC     R1, 0
	MOVWF      R3
	MOVLW      3
	ADDWF      R2, 0
	MOVWF      R5
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      R6
	MOVF       R5, 0
	MOVWF      FSR0L
	MOVF       R6, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       _shift_step+0, 0
	MOVWF      R0
	MOVF       R1, 0
	MOVWF      R4
	MOVF       R0, 0
L__main59:
	BTFSC      STATUS+0, 2
	GOTO       L__main60
	LSLF       R4, 1
	ADDLW      255
	GOTO       L__main59
L__main60:
	MOVLW      2
	ADDWF      R2, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R2
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0
	CLRF       R1
	MOVLW      0
	SUBWFB     R1, 1
	MOVF       R0, 0
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__main61:
	BTFSC      STATUS+0, 2
	GOTO       L__main62
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__main61
L__main62:
	MOVF       R4, 0
	IORWF       R0, 1
	MOVF       R5, 0
	MOVWF      FSR1L
	MOVF       R6, 0
	MOVWF      FSR1H
	MOVF       R0, 0
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,245 :: 		Buffer[row][2] = (Buffer[row][2] << Shift_Step) | (Buffer[row][1] >> (8-Shift_Step));
	MOVLW      5
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	MOVF       _row+0, 0
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      _Buffer+0
	ADDWF      R0, 0
	MOVWF      R2
	MOVLW      hi_addr(_Buffer+0)
	ADDWFC     R1, 0
	MOVWF      R3
	MOVLW      2
	ADDWF      R2, 0
	MOVWF      R5
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      R6
	MOVF       R5, 0
	MOVWF      FSR0L
	MOVF       R6, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       _shift_step+0, 0
	MOVWF      R0
	MOVF       R1, 0
	MOVWF      R4
	MOVF       R0, 0
L__main63:
	BTFSC      STATUS+0, 2
	GOTO       L__main64
	LSLF       R4, 1
	ADDLW      255
	GOTO       L__main63
L__main64:
	MOVLW      1
	ADDWF      R2, 0
	MOVWF      FSR0L
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R2
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0
	CLRF       R1
	MOVLW      0
	SUBWFB     R1, 1
	MOVF       R0, 0
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__main65:
	BTFSC      STATUS+0, 2
	GOTO       L__main66
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__main65
L__main66:
	MOVF       R4, 0
	IORWF       R0, 1
	MOVF       R5, 0
	MOVWF      FSR1L
	MOVF       R6, 0
	MOVWF      FSR1H
	MOVF       R0, 0
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,246 :: 		Buffer[row][1] = (Buffer[row][1] << Shift_Step) | (Buffer[row][0] >> (8-Shift_Step));
	MOVLW      5
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	MOVF       _row+0, 0
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      _Buffer+0
	ADDWF      R0, 0
	MOVWF      R2
	MOVLW      hi_addr(_Buffer+0)
	ADDWFC     R1, 0
	MOVWF      R3
	MOVLW      1
	ADDWF      R2, 0
	MOVWF      R5
	MOVLW      0
	ADDWFC     R3, 0
	MOVWF      R6
	MOVF       R5, 0
	MOVWF      FSR0L
	MOVF       R6, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       _shift_step+0, 0
	MOVWF      R0
	MOVF       R1, 0
	MOVWF      R4
	MOVF       R0, 0
L__main67:
	BTFSC      STATUS+0, 2
	GOTO       L__main68
	LSLF       R4, 1
	ADDLW      255
	GOTO       L__main67
L__main68:
	MOVF       R2, 0
	MOVWF      FSR0L
	MOVF       R3, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R2
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      R0
	CLRF       R1
	MOVLW      0
	SUBWFB     R1, 1
	MOVF       R0, 0
	MOVWF      R1
	MOVF       R2, 0
	MOVWF      R0
	MOVF       R1, 0
L__main69:
	BTFSC      STATUS+0, 2
	GOTO       L__main70
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__main69
L__main70:
	MOVF       R4, 0
	IORWF       R0, 1
	MOVF       R5, 0
	MOVWF      FSR1L
	MOVF       R6, 0
	MOVWF      FSR1H
	MOVF       R0, 0
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,247 :: 		Buffer[row][0] = (Buffer[row][0] << Shift_Step)| (temp >> ((8-shift_step)-scroll*shift_step));
	MOVLW      5
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	MOVF       _row+0, 0
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      _Buffer+0
	ADDWF      R0, 1
	MOVLW      hi_addr(_Buffer+0)
	ADDWFC     R1, 1
	MOVF       R0, 0
	MOVWF      FLOC__main+3
	MOVF       R1, 0
	MOVWF      FLOC__main+4
	MOVF       R0, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       _shift_step+0, 0
	MOVWF      R0
	MOVF       R1, 0
	MOVWF      FLOC__main+2
	MOVF       R0, 0
L__main71:
	BTFSC      STATUS+0, 2
	GOTO       L__main72
	LSLF       FLOC__main+2, 1
	ADDLW      255
	GOTO       L__main71
L__main72:
	MOVF       _shift_step+0, 0
	SUBLW      8
	MOVWF      FLOC__main+0
	CLRF       FLOC__main+1
	MOVLW      0
	SUBWFB     FLOC__main+1, 1
	MOVF       _scroll+0, 0
	MOVWF      R0
	MOVF       _shift_step+0, 0
	MOVWF      R4
	CALL       _Mul_8x8_U+0
	MOVF       R0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0
	MOVF       R1, 0
	SUBWFB     FLOC__main+1, 0
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      R1
	MOVF       _temp+0, 0
	MOVWF      R0
	MOVF       R1, 0
L__main73:
	BTFSC      STATUS+0, 2
	GOTO       L__main74
	LSRF       R0, 1
	ADDLW      255
	GOTO       L__main73
L__main74:
	MOVF       FLOC__main+2, 0
	IORWF       R0, 1
	MOVF       FLOC__main+3, 0
	MOVWF      FSR1L
	MOVF       FLOC__main+4, 0
	MOVWF      FSR1H
	MOVF       R0, 0
	MOVWF      INDF1+0
;LED_Matrix_With_UART.c,239 :: 		for (row=0; row<8; row++){
	INCF       _row+0, 1
;LED_Matrix_With_UART.c,248 :: 		}
	GOTO       L_main31
L_main32:
;LED_Matrix_With_UART.c,249 :: 		speed = 15;
	MOVLW      15
	MOVWF      _speed+0
	MOVLW      0
	MOVWF      _speed+1
;LED_Matrix_With_UART.c,250 :: 		for(l=0; l<speed;l++){
	CLRF       _l+0
L_main36:
	MOVF       _speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVF       _speed+0, 0
	SUBWF      _l+0, 0
L__main75:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;LED_Matrix_With_UART.c,251 :: 		m = 1;
	MOVLW      1
	MOVWF      _m+0
;LED_Matrix_With_UART.c,252 :: 		for (i=0; i<8; i++) {
	CLRF       _i+0
L_main39:
	MOVLW      8
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main40
;LED_Matrix_With_UART.c,253 :: 		Send_Data(i);
	MOVF       _i+0, 0
	MOVWF      FARG_Send_Data_rw+0
	CALL       _Send_Data+0
;LED_Matrix_With_UART.c,254 :: 		LATB = m;
	MOVF       _m+0, 0
	MOVWF      LATB+0
;LED_Matrix_With_UART.c,255 :: 		m = m << 1;
	LSLF       _m+0, 1
;LED_Matrix_With_UART.c,256 :: 		Delay_us(1000);
	MOVLW      11
	MOVWF      R12
	MOVLW      98
	MOVWF      R13
L_main42:
	DECFSZ     R13, 1
	GOTO       L_main42
	DECFSZ     R12, 1
	GOTO       L_main42
	NOP
;LED_Matrix_With_UART.c,252 :: 		for (i=0; i<8; i++) {
	INCF       _i+0, 1
;LED_Matrix_With_UART.c,257 :: 		}  // i
	GOTO       L_main39
L_main40:
;LED_Matrix_With_UART.c,250 :: 		for(l=0; l<speed;l++){
	INCF       _l+0, 1
;LED_Matrix_With_UART.c,258 :: 		} // l
	GOTO       L_main36
L_main37:
;LED_Matrix_With_UART.c,238 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	INCF       _scroll+0, 1
;LED_Matrix_With_UART.c,259 :: 		} // scroll
	GOTO       L_main28
L_main29:
;LED_Matrix_With_UART.c,237 :: 		for (k=0; k<StringLength+4; k++){
	INCF       _k+0, 1
;LED_Matrix_With_UART.c,260 :: 		} // k
	GOTO       L_main25
L_main26:
;LED_Matrix_With_UART.c,262 :: 		} while(1);
	GOTO       L_main22
;LED_Matrix_With_UART.c,263 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
