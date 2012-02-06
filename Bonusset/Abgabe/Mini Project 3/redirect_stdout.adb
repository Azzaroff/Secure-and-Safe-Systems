with Ada.Text_IO; use Ada.Text_IO;

procedure Redirect_Stdout(Path: String) is
--     Stdout : constant File_Type := Standard_Output;
   Text_File : File_Type;
begin
   Create(Text_File, Out_File, Path);
   Set_Output(Text_File);
end Redirect_Stdout;
