*&---------------------------------------------------------------------*
*& Include          ZPUNI_LLOVERAS_TOP
*&---------------------------------------------------------------------*

*------------------------ Parametro --------------------------------

parameters: p_uni type localfile obligatory.
data: v_uni     type string,
      wa_string type string.

*------------------------ Mi tabla alumnos de universidad --------------------------------
*Declaro type
types: begin of ty_alumnosuni,
         alumno      type zalumno_lloveras,
         universidad type zuniversidad_lloveras,
         edad        type zedad_lloveras,
         turno  type zturno_lloveras,
         trabaja  type zturno_lloveras,
       end of ty_alumnosuni.

*Declaro type table
types: tt_alumnosuni type standard table of ty_alumnosuni.

data gt_alumnosuni type tt_alumnosuni.
data wa_alumnosuni type ty_alumnosuni.

*------------------------ Estructura con los datos del programa --------------------------------
data: bdc_tab    type table of bdcdata,
      wa_bdc_tab type bdcdata.

*Mensajes de error
data: itab type table of bdcmsgcoll.