with Ada.Task_Termination, Ada.Task_Identification, Ada.Exceptions;

package Armageddon is
   use Ada;

   protected End_Of is

      procedure The_World
        (C: in Task_Termination.Cause_Of_Termination;
         T: in Task_Identification.Task_ID;
         X: in Exceptions.Exception_Occurrence);

      -- T: Which task?
      -- C: Why?
      -- If C=Unhandled_Exception then X: which exception

   end End_Of;

end Armageddon;
