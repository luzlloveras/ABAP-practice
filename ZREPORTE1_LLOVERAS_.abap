*&---------------------------------------------------------------------*
*& Report ZREPORTE1_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREPORTE1_LLOVERAS.

include zreporte1_lloveras_top.
include zreporte1_lloveras_f01.

start-of-selection.

perform f_selecciones tables gt_destino0 gt_destino1 gt_destino2 gt_destino3
using p_name.

end-of-selection.

perform f_impre tables gt_destino0 gt_destino1 gt_destino2 gt_destino3.