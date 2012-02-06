with Ada.Text_IO; use Ada.Text_IO;

procedure Stdin is
   Stdin : constant File_Type := Standard_Input;
   Current_In: File_Type := Current_Input;
begin
   Close(Current_In);
   Set_Input(Stdin);
end Stdin;
