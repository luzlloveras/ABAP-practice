*&---------------------------------------------------------------------*
*& Report ZLLOV_4EN1.
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLLOV_4EN1.

INCLUDE ZLLOV_4EN1_TOP.
INCLUDE ZLLOV_4EN1_F01.

start-of-selection.

perform f_selecciones tables gt_scarr gt_spfli gt_sflight gt_sbook
using p_name.

end-of-selection.

perform f_lecturas tables gt_scarr gt_spfli gt_sflight gt_sbook gt_fusion.
perform f_impresion tables gt_fusion.