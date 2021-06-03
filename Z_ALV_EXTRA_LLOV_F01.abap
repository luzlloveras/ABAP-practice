*&---------------------------------------------------------------------*
*& Include          Z_ALV_EXTRA_LLOV_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form F_SELECCIONES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_BKPF
*&      --> GT_BSEG
*&      --> S_BUKRS[]
*&      --> S_BELNR[]
*&      --> S_GJAHR[]
*&---------------------------------------------------------------------*
FORM F_SELECCIONES  TABLES   T_BKPF TYPE TT_BKPF
                             T_BSEG TYPE TT_BSEG
                    USING    SO_BUKRS TYPE TT_BUKRS
                             SO_BELNR TYPE TT_BELNR
                             SO_GJAHR TYPE TT_GJAHR.


*EMPIEZO SELECCIONES
*----- 1ra seleccion --------------
select bukrs belnr gjahr xblnr blart
from bkpf
into table t_bkpf
where bukrs in so_bukrs
and belnr in so_belnr
and gjahr in so_gjahr.

if sy-subrc is initial.
endif.

*----- 2da seleccion --------------
select bukrs belnr gjahr buzei augdt
from bseg
into table t_bseg
where bukrs in so_bukrs
and belnr in so_belnr
and gjahr in so_gjahr.

if sy-subrc is initial.
endif.

ENDFORM.

