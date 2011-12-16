with Ada.Text_IO;
use Ada.Text_IO;
package body Diaries is

	subtype Day_Type is Integer range 1..31;
	type Month_Type is (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);

	subtype Year_Type is Integer range 1901..2099;
	subtype Hour_Type is Integer range 0..23;
	subtype Minute_Type is Integer range 0..59;

	type Date_Type is
	    record
		Day   : Day_Type;
		Month : Month_Type;
		Year  : Year_Type;
	    end record;
	type Time_Type is
	    record
		Hour   : Hour_Type;
		Minute : Minute_Type;
	    end record;

	type Appointment_Type is
	    record
		Date    : Date_Type;
		Time    : Time_Type;
		Details : String (1..50);        -- an arbitrary size
		Length  : Natural := 0;
	    end record;

	type Appointment_Array is array (Positive range <>)
		                                                    of Appointment_Type;

	type Diary_Type (Maximum : Positive) is
	    record
		Appts : Appointment_Array (1..Maximum);
		Count : Natural := 0;
	    end record;

	Diary : Diary_Type (10);

	procedure Load_Diary is
	begin
	    Put_Line ("Load_Diary called");
	end Load_Diary;

	procedure Add_Appointment is
	begin
	    Put_Line ("Add_Appointment called");
	end Add_Appointment;

	procedure Delete_Appointment is
	begin
	    Put_Line ("Delete_Appointment called");
	end Delete_Appointment;

	procedure List_Appointments is
	begin
	    Put_Line ("List_Appointments called");
	end List_Appointments;
	procedure Save_Appointments is
	begin
	    Put_Line ("Save_Appointments called");
end Save_Appointments;

    procedure Diary is
        Command : Character;
        -- any other declarations will go here
    begin
        Load_Diary;
        loop
            -- display menu
            New_Line (5);
            Put_Line ("Diary menu:");
            Put_Line (" [A]dd appointment");
            Put_Line (" [D]elete appointment");
            Put_Line (" [L]ist appointments");
            Put_Line (" [S]ave appointments");
            Put_Line (" [Q]uit");
            New_Line;
            Put ("Enter your choice: ");

            -- get a command
            Get (Command);

            -- perform selected command
            case Command is
		when 'A' | 'a' =>
		    Add_Appointment;
		when 'D' | 'd' =>
		    Delete_Appointment;
		when 'L' | 'l' =>
		    List_Appointments;
		when 'S' | 's' =>
		    Save_Appointments;
		when 'Q' | 'q' =>
		    exit;
		when others =>
		    Put_Line ("Invalid choice -- " &
		     "please enter A, D, L, S or Q");
	    end case;
        end loop;
    end Diary;
end Diaries;
