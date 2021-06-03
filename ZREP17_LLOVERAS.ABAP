*&---------------------------------------------------------------------*
*& Report ZREP17_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREP17_LLOVERAS.


include: zrep17_lloveras_top,
zrep17_lloveras_f01.

start-of-selection.

  perform f_recupero_datos using s_price[] p_carrid
  changing gt_sflight gt_spfli gt_final.

end-of-selection.

perform f_smartform using gt_final.