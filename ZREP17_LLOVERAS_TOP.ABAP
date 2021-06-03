*&---------------------------------------------------------------------*
*& Include          ZREP17_LLOVERAS_TOP
*&---------------------------------------------------------------------*


*------------- Declaro parametro -------------
tables scarr.
parameters p_carrid like scarr-carrid default 'LH'.

*------------- Declaro select-option -------------
tables sflight.
select-options s_price for sflight-price.
types: tt_price type range of sflight-price.

*------------- Declaraciones para SFLIGHT -------------
*Declaro campos para el type
types: begin of ty_sflight,
         carrid    type s_carr_id,
         connid    type s_conn_id,
         fldate    type s_date,
         price    type s_price,
         currency    type s_currcode,
       end of ty_sflight.

*Declaro type table
types: tt_sflight type standard table of ty_sflight.

*Declaro work area
data wa_sflight type ty_sflight.

*Declaro tabla global
data gt_sflight type tt_sflight.


*------------- Declaraciones para SPFLI -------------
*Declaro campos para el type
types: begin of ty_spfli,
         carrid    type s_carr_id,
         connid    type s_conn_id,
         cityfrom    type s_from_cit,
         cityto    type s_to_city,
       end of ty_spfli.

*Declaro type table
types: tt_spfli type standard table of ty_spfli.

*Declaro work area
data wa_spfli type ty_spfli.

*Declaro tabla global
data gt_spfli type tt_spfli.

*------------- Declaraciones para FINAL ------------
*Declaro campos para el type
types: begin of ty_final,
         carrid    type s_carr_id,
         connid    type s_conn_id,
         fldate    type s_date,
         price    type s_price,
         currency    type s_currcode,
         cityfrom    type s_from_cit,
         cityto    type s_to_city,
       end of ty_final.

*Declaro type table
types: tt_final type standard table of ty_final.

*Declaro work area
data wa_final type ty_final.

*Declaro tabla global
data gt_final type tt_final.