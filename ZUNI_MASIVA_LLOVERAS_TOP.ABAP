*&---------------------------------------------------------------------*
*& Include          ZPUNI_LLOVERAS_TOP
*&---------------------------------------------------------------------*

*------------------------ Parametro --------------------------------

tables ztuni_lloveras.
parameters: p_uni type zuniversidad_lloveras.
*parameters: p_uni type local file.
*select-options: s_uni for  spfli_wa-carrid.


*------------------------ Mi tabla alumnos de universidad --------------------------------
*Declaro type
types: begin of ty_alumnosuni,
         alumno         type zalumno_lloveras,
         universidad         type zuniversidad_lloveras,
         edad type zedad_lloveras,
         nacimiento type char4,
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