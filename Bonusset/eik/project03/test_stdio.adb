with Ada.Text_IO; use Ada.Text_IO;

package body Test_StdIO is
   procedure Redirect_To_File is
      Text_File : File_Type;
   begin
      Create(Text_File, Out_File, "std_out.txt");
      Set_Output(Text_File);
   end Redirect_To_File;

   procedure Redirect_To_StdOut is
      Stdout : constant File_Type := Standard_Output;
      Current_Out : File_Type := Current_Output;
   begin
      Close(Current_Out);
      Set_Output(Stdout);
   end Redirect_To_StdOut;

   procedure Redirect_From_File(Path: in String) is
      Text_File: File_Type;
   begin
      Open(Text_File, In_File, Path);
      Set_Input(Text_File);
   end Redirect_From_File;

   procedure Redirect_From_StdIn is
      Stdin : constant File_Type := Standard_Input;
      Current_In: File_Type := Current_Input;
   begin
      Close(Current_In);
      Set_Input(Stdin);
   end Redirect_From_StdIn;

end Test_StdIO;
