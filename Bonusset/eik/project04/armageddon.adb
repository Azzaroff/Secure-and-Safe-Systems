with Ada.Text_IO;

package body Armageddon is

   protected body End_Of is

      procedure The_World
        (C: in Task_Termination.Cause_Of_Termination;
         T: in Task_Identification.Task_ID;
         X: in Exceptions.Exception_Occurrence) is

         use Text_IO, Task_Termination;
         T_Img: String renames Task_Identification.Image(T);

      begin
         case C is
            when Normal => null;
            when Abnormal =>
               Put_Line("Abnormal termination of task " & T_Img);
            when Unhandled_Exception =>
               Put_Line("Unhandled exception in task " & T_Img);
               Put_Line(Exceptions.Exception_Information(X));
         end case;
      end The_World;

   end End_Of;

begin
   Task_Termination.Set_Dependents_Fallback_Handler
     (End_Of.The_World'Access);
end Armageddon;
