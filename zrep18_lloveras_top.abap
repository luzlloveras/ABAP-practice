*&---------------------------------------------------------------------*
*& Include          ZREP18_LLOVERAS_TOP
*&---------------------------------------------------------------------*

*------------- Declaro parametro -------------
tables vbrk.
parameters p_vbeln like vbrk-vbeln.

*------------- Declaraciones para VBRK -------------
*Declaro campos para el type
types: begin of ty_vbrk,
         fkdat type fkdat,
         kunag type kunag,
         waerk type waerk,
       end of ty_vbrk.

*Declaro type table
types: tt_vbrk type standard table of ty_vbrk.

*Declaro work area
data wa_vbrk type ty_vbrk.

*Declaro tabla global
data gt_vbrk type tt_vbrk.


*------------- Declaraciones para KNA1 -------------
*Declaro campos para el type
types: begin of ty_kna1,
         name1 type name1_gp,
         stras type stras_gp,
         ort01 type ort01_gp,
       end of ty_kna1.

*Declaro type table
types: tt_kna1 type standard table of ty_kna1.

*Declaro work area
data wa_kna1 type ty_kna1.

*Declaro tabla global
data gt_kna1 type tt_kna1.


*------------- Declaraciones para VBRP -------------
*Declaro campos para el type
types: begin of ty_vbrp,
         meins type meins,
         fklmg type fklmg,
         netwr type netwr_fp,
         matnr type matnr,
         arktx type arktx,
         mwsbp type mwsbp,
       end of ty_vbrp.

*Declaro type table
types: tt_vbrp type standard table of ty_vbrp.

*Declaro work area
data wa_vbrp type ty_vbrp.

*Declaro tabla global
data gt_vbrp type tt_vbrp.

*------------- Declaraciones para FINAL ------------
*Declaro campos para el type
types: begin of ty_final,
         vbeln type vbeln_vf,
         fkdat type fkdat,
         kunag type kunag,
         name1 type name1_gp,
         stras type stras_gp,
         ort01 type ort01_gp,
         matnr type matnr,
         fklmg type fklmg,
         meins type meins,
         arktx type arktx,
         netwr type netwr_fp,
         mwsbp type mwsbp,
       end of ty_final.

*Declaro type table
types: tt_final type standard table of ty_final.

*Declaro work area
data wa_final type ty_final.

*Declaro tabla global
data gt_final type tt_final.