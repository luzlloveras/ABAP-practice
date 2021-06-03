*&---------------------------------------------------------------------*
*& Include          Z_BI_LLOVERAS_TOP
*&---------------------------------------------------------------------*

*------------------------ Parametro --------------------------------
*Declaro parametro
parameters: p_arch type localfile obligatory.
data: v_arch type string.

*------------------------ Mi tabla clientes --------------------------------
*Declaro type
types: begin of ty_clientes,
         kunnr         type kunnr,
         razon         type char10,
         observaciones type zobservcli_llov,
       end of ty_clientes.

*Declaro type table
types: tt_clientes type standard table of ty_clientes.

data gt_clientes type tt_clientes.
data wa_clientes type ty_clientes.

*------------------------ Estructura con los datos del programa --------------------------------
data: bdc_tab    type table of bdcdata,
      wa_bdc_tab type bdcdata.

*Mensajes de error
data: itab type table of bdcmsgcoll.