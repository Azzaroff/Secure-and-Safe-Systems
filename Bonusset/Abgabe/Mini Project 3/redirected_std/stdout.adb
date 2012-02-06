with Ada.Text_IO; use Ada.Text_IO;

procedure Stdout is
   Stdout : constant File_Type := Standard_Output;
   Current_Out: File_Type := Current_Output;
begin
   Close(Current_Out);
   Set_Output(Stdout);
end Stdout;
