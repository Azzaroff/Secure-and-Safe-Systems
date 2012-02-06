error_handling continue

context 	with Ada.Text_IO, Diaries;
			use Ada.Text_IO, Diaries;
			with Redirect_Stdin;
			with Stdin;
			with Redirect_Stdout;
			with Stdout;

			with Crypto.Types;
			with Crypto.Hashfunction_SHA256;

			with Ada.Calendar;
			with Ada.Calendar.Formatting;

define
		package CT renames Crypto.Types;
		use CT;
		package SHA renames Crypto.Hashfunction_SHA256;

		package Cal renames Ada.Calendar;

		package Int_IO is new Integer_IO (Integer);
		package Month_IO is new Enumeration_IO (Month_Type);
		use Int_IO, Month_IO;

		Date: Date_Type;
		D: Day_Type;
		M: Month_Type;
		Y: Year_Type;

---------- Valid_Date ----------

***** 1
define B: Boolean;
test   D := 1; M := Jan; Y := 1901;
	   B := Valid_Date(D,M,Y);
pass   B = True

***** 2
define B: Boolean;
test   D := 31; M := Dec; Y := 2099;
	   B := Valid_Date(D,M,Y);
pass   B = True

***** 3
define B: Boolean;
test   D := 31; M := Apr; Y := 2000;
	   B := Valid_Date(D,M,Y);
pass   B = False

***** 4
define B: Boolean;
test   D := 31; M := Jun; Y := 2000;
	   B := Valid_Date(D,M,Y);
pass   B = False

***** 5
define B: Boolean;
test   D := 31; M := Sep; Y := 2000;
	   B := Valid_Date(D,M,Y);
pass   B = False

***** 6
define B: Boolean;
test   D := 31; M := Nov; Y := 2000;
	   B := Valid_Date(D,M,Y);
pass   B = False

***** 7
define B: Boolean;
test   D := 28; M := Feb; Y := 2011;
	   B := Valid_Date(D,M,Y);
pass   B = True

***** 8
define B: Boolean;
test   D := 29; M := Feb; Y := 2011; -- no leap year
	   B := Valid_Date(D,M,Y);
pass   B = False

***** 9
define B: Boolean;
test   D := 29; M := Feb; Y := 2012; -- leap year
	   B := Valid_Date(D,M,Y);
pass   B = True

***** 10
define B: Boolean;
test   D := 30; M := Feb; Y := 2012;
	   B := Valid_Date(D,M,Y);
pass   B = False

---------- Valid_Date ----------

***** 11
test	D := 01; M := Jan; Y := 1990;
		Date := Next_Date(D,M,Y);
pass	Date.Day = 02 and Date.Month = Jan and Date.Year = 1990

***** 12
test	D := 28; M := Feb; Y := 1992;
		Date := Next_Date(D,M,Y);
pass	Date.Day = 29 and Date.Month = Feb and Date.Year = 1992

***** 13
test	D := 29; M := Feb; Y := 1992;
		Date := Next_Date(D,M,Y);
pass	Date.Day = 01 and Date.Month = Mar and Date.Year = 1992

***** 14
test	D := 30; M := Jun; Y := 2012;
		Date := Next_Date(D,M,Y);
pass	Date.Day = 01 and Date.Month = Jul and Date.Year = 2012

***** 15
test	D := 31; M := Dec; Y := 2012;
		Date := Next_Date(D,M,Y);
pass	Date.Day = 01 and Date.Month = Jan and Date.Year = 2013

---------- Diary_Changed ----------

***** 16
define B: Boolean;
test   B := Diary_Changed;
pass   B = False

---------- Find_Appointment ----------

***** 17
test	Diary.Count := 0; -- to override appts
		Redirect_Stdin("add_appts.txt");
		Redirect_Stdout("stuff.txt");
		for I in 1..10 loop
			Add_Appointment;
		end loop;
		Stdout;
		Redirect_Stdin("template_1.txt");
		Redirect_Stdout("find_appts_out.txt");
		Find_Appointment;
		Stdout;
pass	SHA.F_Hash("find_appts_out.txt") = SHA.F_Hash("template_1_exp.txt")

***** 18
test	Redirect_Stdin("template_2.txt");
		Redirect_Stdout("find_appts_out.txt");
		Find_Appointment;
		Stdout;
pass	SHA.F_Hash("find_appts_out.txt") = SHA.F_Hash("template_2_exp.txt")

***** 19
test	Redirect_Stdin("template_3.txt");
		Redirect_Stdout("find_appts_out.txt");
		Find_Appointment;
		Stdout;
pass	SHA.F_Hash("find_appts_out.txt") = SHA.F_Hash("template_3_exp.txt")

---------- Next_Appointments ----------

***** 20
define	Time: Cal.Time := Cal.Formatting.Time_Of(2011,12,30);
test	Redirect_Stdout("next_apps_out.txt");
		Next_Appointments(Time);
		Stdout;
pass	SHA.F_Hash("next_apps_out.txt") = SHA.F_Hash("next_apps_exp1.txt")

***** 21
define	Time: Cal.Time := Cal.Formatting.Time_Of(2012,1,5);
		Path: constant String := "next_apps_out.txt";
test	Redirect_Stdout(Path);
		Next_Appointments(Time);
		Stdout;
		New_Line;
pass	SHA.F_Hash(Path) = SHA.F_Hash("next_apps_exp2.txt")

---------- Diary_Changed ----------

***** 22
define B: Boolean;
test   B := Diary_Changed;
pass   B = True

---------- Quit ----------

***** 23
define 	B, Changed: Boolean;
test	B := Quit('L');
		Changed := Diary_Changed;
pass	B = False and Changed = True

***** 24
define 	B, Changed: Boolean;
test	B := Quit('Y');
		Changed := Diary_Changed;
pass	B = True and Changed = False

***** 25
define 	B, Changed: Boolean;
test	Load_Diary;
		Redirect_Stdin("del.txt");
		Delete_Appointment;
		Stdin;
		B := Quit('N');
		Changed := Diary_Changed;
pass	B = True and Changed = True