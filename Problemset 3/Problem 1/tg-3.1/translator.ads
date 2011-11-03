-------------------------------------------------------------------------------

  -- Copyright (C) 1996 by Andre Spiegel.

  -- File:           translator.ads

  -- Description:    Performs translation of the script file into
  --                 the code of the driver.

  -- Author:         Andre Spiegel
  -- Creation Date:  Wed Jul 14 08:40:12 1993

  -- RCS: $Id: translator.ads,v 1.1 1996/05/09 12:14:27 spiegel Exp $

  -- This file is part of `tg'.

  -- `tg' is free software; you can redistribute it and/or modify
  -- it under the terms of the GNU General Public License as published by
  -- the Free Software Foundation; either version 2, or (at your option)
  -- any later version.

  -- `tg' is distributed in the hope that it will be useful,
  -- but WITHOUT ANY WARRANTY; without even the implied warranty of
  -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  -- GNU General Public License for more details.

  -- You should have received a copy of the GNU General Public License
  -- along with `tg'; see the file COPYING.  If not, write to
  -- the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
  -- Boston, MA 02111-1307, USA.

-------------------------------------------------------------------------------

with Text_IO;

package Translator is

  File_Error, Syntax_Error, Semantic_Error : exception;
  
  type Output_Mode is (Off, Numbers, Titles, Full);

  procedure Translate (Input_File   : in Text_IO.File_Type;  ------------------
                       Output_File  : in Text_IO.File_Type;
                       Error_Stream : in Text_IO.File_Type;
                       Unit_Name    : in String;
                       Fail_Output  : in Output_Mode;
                       Pass_Output  : in Output_Mode);
                       
    -- Description.
    --   This procedure does the whole job.

    -- Preconditions.
    --   1. Files are open and of correct mode.
    --   2. Input_File does not contain any syntactic errors.
    --   3. Input_File does not contain any semantic errors.
    
    -- Postconditions.
    --   1. The compilable testdriver is written to Output_File.
    
    -- Error Handling.
    --   1. File_Error is raised.
    --   2. An error message is written to Error_Stream, Syntax_Error raised.
    --   3. An error message is written to Error_Stream, Semantic_Error raised.
        
end Translator;
