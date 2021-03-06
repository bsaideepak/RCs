(*
    Example proof script for HOL Proof General.

    example.ml,v 11.0 2010/10/10 22:57:06 da Exp
*)    

g `A /\ B ==> B /\ A`;;
e DISCH_TAC;;
e CONJ_TAC;;
e (IMP_RES_TAC AND_INTRO_THM);;
e (IMP_RES_TAC AND_INTRO_THM);;

goal `A && B ==> B && A`;
val and_comms = pg_top_thm_and_drop();;

(* Hints about HOL Proof General:
 
   Proof General needs to work with top-level declarations throughout,
   and with "interactive" rather than "batch" versions of proofs.

   For best results, theorems should be saved in the way that they are
   saved above, with pg_top_thm_and_drop.  The function isn't
   mysterious, it is defined as:

    fun pg_top_thm_and_drop () = let val t = top_thm(); in (drop(); t) end;
*)

(* this simple proof is not quite like proofs in the other systems,
   can anyone tell me a more similar proof in HOL? I want to split 
   the IMP_RES_TAC into two steps.  
*)

