*&---------------------------------------------------------------------*
*& Report Z_ALV_FUMADOR_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALV_FUMADOR_LLOVERAS.

INCLUDE Z_ALV_FUM_LLOVE_TOP.
INCLUDE Z_ALV_FUM_LLOVE_F01.

start-of-selection.

perform f_selecciones tables gt_sbook gt_stravelag gt_scustom gt_spfli
using s_carrid[] s_connid[] s_fldate[] s_agency[].

end-of-selection.

perform f_lecturas tables gt_sbook gt_stravelag gt_scustom gt_spfli gt_principal.
perform f_impresion tables gt_principal.