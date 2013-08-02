-- VHDL Entity r65c02_tc.fsm_intnmi.symbol
--
-- Created:
--          by - jens
--          at - 15:18:42 07/21/13
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY fsm_intnmi IS
   PORT( 
      clk_clk_i   : IN     std_logic;
      nmi_n_i     : IN     std_logic;
      rst_nmi_i   : IN     std_logic;
      rst_rst_n_i : IN     std_logic;
      nmi_o       : OUT    std_logic
   );

-- Declarations

END fsm_intnmi ;

-- (C) 2008 - 2013 Jens Gutschmidt
-- (email: scantara2003@yahoo.de)
-- 
-- Versions:
-- Revision 1.7  2013/07/21 11:11:00  jens
-- - Changing the title block and internal revision history
-- 
-- Revision 1.6  2009/01/04 10:20:47  eda
-- Changes for cosmetic issues only
-- 
-- Revision 1.5  2009/01/04 09:23:10  eda
-- - Delete unused nets and blocks (same as R6502_TC)
-- - Rename blocks
-- 
-- Revision 1.4  2009/01/03 16:53:02  eda
-- - Unused nets and blocks deleted
-- - Renamed blocks
-- 
-- Revision 1.3  2009/01/03 16:42:02  eda
-- - Unused nets and blocks deleted
-- - Renamed blocks
-- 
-- Revision 1.2  2008/12/31 19:31:24  eda
-- Production Release
--  
-- 
--
-- VHDL Architecture r65c02_tc.fsm_intnmi.fsm
--
-- Created:
--          by - jens
--          at - 15:18:42 07/21/13
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
-- COPYRIGHT (C) 2008 - 2013 by Jens Gutschmidt and OPENCORES.ORG
-- 
-- This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 
-- 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
 
ARCHITECTURE fsm OF fsm_intnmi IS

   TYPE STATE_TYPE IS (
      idle,
      idle1,
      idle2,
      IMP
   );
 
   -- State vector declaration
   ATTRIBUTE state_vector : string;
   ATTRIBUTE state_vector OF fsm : ARCHITECTURE IS "current_state";

   -- Declare current and next state signals
   SIGNAL current_state : STATE_TYPE;
   SIGNAL next_state : STATE_TYPE;

   -- Declare any pre-registered internal signals
   SIGNAL nmi_o_cld : std_logic ;

BEGIN

   -----------------------------------------------------------------
   clocked_proc : PROCESS ( 
      clk_clk_i,
      rst_rst_n_i
   )
   -----------------------------------------------------------------
   BEGIN
      IF (rst_rst_n_i = '0') THEN
         current_state <= idle;
         -- Default Reset Values
         nmi_o_cld <= '0';
      ELSIF (clk_clk_i'EVENT AND clk_clk_i = '1') THEN
         current_state <= next_state;
         -- Default Assignment To Internals
         nmi_o_cld <= '0';

         -- Combined Actions
         CASE current_state IS
            WHEN IMP => 
               nmi_o_cld <= '1';
               IF (rst_nmi_i = '1') THEN 
                  nmi_o_cld <= '0';
               END IF;
            WHEN OTHERS =>
               NULL;
         END CASE;
      END IF;
   END PROCESS clocked_proc;
 
   -----------------------------------------------------------------
   nextstate_proc : PROCESS ( 
      current_state,
      nmi_n_i,
      rst_nmi_i
   )
   -----------------------------------------------------------------
   BEGIN
      CASE current_state IS
         WHEN idle => 
            IF (nmi_n_i = '1') THEN 
               next_state <= idle1;
            ELSE
               next_state <= idle;
            END IF;
         WHEN idle1 => 
            IF (nmi_n_i = '0') THEN 
               next_state <= idle2;
            ELSE
               next_state <= idle1;
            END IF;
         WHEN idle2 => 
            IF (nmi_n_i = '0') THEN 
               next_state <= IMP;
            ELSE
               next_state <= idle;
            END IF;
         WHEN IMP => 
            IF (rst_nmi_i = '1') THEN 
               next_state <= idle;
            ELSE
               next_state <= IMP;
            END IF;
         WHEN OTHERS =>
            next_state <= idle;
      END CASE;
   END PROCESS nextstate_proc;
 
   -- Concurrent Statements
   -- Clocked output assignments
   nmi_o <= nmi_o_cld;
END fsm;
