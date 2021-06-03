*&---------------------------------------------------------------------*
*& Report Z_ALV_EXT_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALV_EXT_LLOVERAS.


INCLUDE Z_ALV_EXTRA_LLOV_TOP.
INCLUDE Z_ALV_EXTRA_LLOV_F01.

*start-of-selection.

perform f_selecciones tables gt_bkpf gt_bseg
using s_bukrs[] s_belnr[] s_gjahr[].

*end-of-selection.

*perform f_lecturas tables gt_bkpf gt_bseg gt_principal.
*perform f_impresion tables gt_principal.