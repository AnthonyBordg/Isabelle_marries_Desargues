theory Higher_Projective_Space_Axioms
  imports Main
begin

(* Contents:
- We introduce the types of points and lines and an incidence relation between them.
- A set of axioms for higher projective spaces, i.e. we allow models of dimension > 3. 
*)

(*** The axioms for higher projective geometry ***)

(* One has a type of points *)
typedecl "points"

(* One has a type of lines *)
typedecl "lines"

(* One has a relation of incidence between points and lines *)
consts incid :: "points \<Rightarrow> lines \<Rightarrow> bool"

(* The relation of incidence is decidable *)
axiomatization where
incid_dec: "\<forall>P l. incid P l \<or> \<not>(incid P l)"

axiomatization where
(* Ax1: Any two distinct points are incident with just one line *)
ax1_existence: "\<forall>P M.\<exists>l. (incid P l) \<and> (incid M l)"
axiomatization where
ax1_uniqueness: "\<forall>P M k l. 
(incid P k) \<longrightarrow> (incid M k) \<longrightarrow> (incid P l) \<longrightarrow> (incid M l) \<longrightarrow> (P = M) \<or> (k = l)"

definition distinct4 :: "points \<Rightarrow> points \<Rightarrow> points \<Rightarrow> points \<Rightarrow> bool" where
"distinct4 A B C D \<equiv> (A \<noteq> B) \<and> (A \<noteq> C) \<and> (A \<noteq> D)\<and> (B \<noteq> C) \<and> (B \<noteq> D) \<and> (C \<noteq> D)"

(* Ax2: If A B C D are four distinct points such that AB meets CD, then AC meets BD.
Sometimes this is called Pasch's axiom, but according to Wikipedia it is misleading
since Pasch's axiom refers to something else. *)
axiomatization where
ax2: "\<forall>A B C D lAB lCD lAC lBD. distinct4 A B C D \<longrightarrow> (incid A lAB \<and> incid B lAB) 
\<longrightarrow> (incid C lCD \<and> incid D lCD) \<longrightarrow> (incid A lAC \<and> incid C lAC) \<longrightarrow> 
(incid B lBD \<and> incid D lBD) \<longrightarrow> (\<exists>I.(incid I lAB \<and> incid I lCD)) \<longrightarrow> 
(\<exists>J.(incid J lAC \<and> incid J lBD))"

definition distinct3 :: "points => points => points => bool" where
"distinct3 A B C \<equiv> (A \<noteq> B) \<and> (A \<noteq> C) \<and> (B \<noteq> C)"

(** Dimension-related axioms **)
(* Ax3: Every line is incident with at least three points.
As I understand it, this axiom makes sure that lines are not degenerated into points
and since it asks for three distinct points, not only 2, it captures the idea that
lines have unlimited extent, i.e. there is always a point between two distinct points. *)
axiomatization where
ax3: "\<forall>l.\<exists>A B C. distinct3 A B C \<and> (incid A l) \<and> (incid B l) \<and> (incid C l)"

(* Ax4: There exists two lines that do not meet, 
hence the geometry is at least 3-dimensional *)
axiomatization where
ax4: "\<exists>l m.\<forall>P. \<not>(incid P l \<and> incid P m)"


(* 
Biblio.:
- Nicolas Magaud, Julien Narboux, Pascal Schreck; coq-projective-geometry; code available at
https://github.com/coq-contribs/projective-geometry.
*)

end
