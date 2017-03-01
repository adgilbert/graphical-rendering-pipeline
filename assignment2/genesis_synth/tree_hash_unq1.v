//
//---------------------------------------------------------------------------
//  THIS FILE WAS AUTOMATICALLY GENERATED BY THE STANFORD GENESIS2 ENGINE
//  FOR MORE INFORMATION, CONTACT OFER SHACHAM FROM THE STANFORD VLSI GROUP
//  THIS VERSION OF GENESIS2 IS NOT TO BE USED FOR ANY COMMERCIAL USE
//---------------------------------------------------------------------------
//
//  
//	-----------------------------------------------
//	|            Genesis Release Info             |
//	|  $Change: 11012 $ --- $Date: 2012/09/13 $   |
//	-----------------------------------------------
//	
//
//  Source file: /afs/.ir.stanford.edu/users/a/d/adgil/EE271/EE271_project/assignment2/rtl/tree_hash.vp
//  Source template: tree_hash
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter InWidth 	= 40
// Parameter OutWidth 	= 8
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Command Line input (priority=4):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From XML input (priority=3):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Config File input (priority=2):
//
// ---------------- End Pre-Generation Pramameters Status Report ----------------

/*
 *  Hashing Function
 * 
 *  Inputs:
 *    N-Wide Signal
 * 
 *  Outputs:
 *    M-Bit Hashed signal
 * 
 *  Function:
 *    Calc a simple hash value useing an xor tree
 * 
 * 
 * 
 *   Author: John Brunhaver
 *   Created:      Thu 10/01/10
 *   Last Updated: Tue 10/16/10
 *
 *   Copyright 2010 <jbrunhaver@gmail.com>   
 *  
 */

/* ***************************************************************************
 * Change bar:
 * -----------
 * Date           Author    Description
 * Sep 19, 2012   jingpu    ported from John's original code to Genesis
 *                          
 * ***************************************************************************/

/******************************************************************************
 * PARAMETERIZATION
 * ***************************************************************************/
// InWidth (_GENESIS2_INHERITANCE_PRIORITY_) = 40
//
// OutWidth (_GENESIS2_INHERITANCE_PRIORITY_) = 8
//





/* A Note on Signal Names:
 *
 * Most signals have a suffix of the form _RxxN 
 * where R indicates that it is a Raster Block signal
 * xx indicates the clock slice that it belongs to
 * and N indicates the type of signal that it is.
 * H indicates logic high, L indicates logic low,
 * U indicates unsigned fixed point, and S indicates
 * signed fixed point.
 * 
 */



module tree_hash_unq1
  (
   // Input Signals
   input logic 	unsigned [40-1:0] in_RnnH, //Input signal to derive hash from
   input logic 	unsigned [8-1:0] mask_RnnH, //A mask to apply to the hashed output
   // Output Signals
   output logic unsigned [8-1:0] out_RnnH   //Output signal that has been hashed and masked

   );
   
   logic 	unsigned [31:0] 	arr32_RnnH ;
   logic 	unsigned [15:0] 	arr16_RnnH ;
   
   //40ot that this is brittle and will break for any config that isn't 40:8
   assign  arr32_RnnH[7:0]   = in_RnnH[7:0]   ^ in_RnnH[15:8]  ; // 0 = 0 ^ 1 
   assign   arr32_RnnH[15:8]  = in_RnnH[15:8]  ^ in_RnnH[23:16] ; // 1 = 1 ^ 2  
   assign   arr32_RnnH[23:16] = in_RnnH[23:16] ^ in_RnnH[31:24] ; // 2 = 2 ^ 3 
   assign   arr32_RnnH[31:24] = in_RnnH[31:24] ^ in_RnnH[39:32] ; // 3 = 3 ^ 4

   assign   arr16_RnnH[7:0] = arr32_RnnH[7:0] ^ arr32_RnnH[23:16] ; // 0 = 0 ^ 2 
   assign   arr16_RnnH[15:8] = arr32_RnnH[15:8] ^ arr32_RnnH[31:24] ; // 1 ^ 3
   
   assign   out_RnnH[8-1:0] = ( arr16_RnnH[7:0] ^ arr16_RnnH[15:8] ) & mask_RnnH[7:0] ;
   
endmodule 



