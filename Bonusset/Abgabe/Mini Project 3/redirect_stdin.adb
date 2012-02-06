with Ada.Text_IO; use Ada.Text_IO;

procedure Redirect_Stdin(Path: in String) is
--     Stdin: constant File_Type := Standard_Input;
   Text_File: File_Type;
begin
   Open(Text_File, In_File, Path);
   Set_Input(Text_File);
end Redirect_Stdin;
