*&---------------------------------------------------------------------*
*& Report ZPUNI_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zuni_masiva3_lloveras.

include zuni_masiva3_lloveras_top.
include zuni_masiva3_lloveras_f01.




start-of-selection.

  perform f_recupero_datos using p_uni wa_string wa_alumnosuni
changing gt_alumnosuni.

end-of-selection.

  perform f_impresion using gt_alumnosuni.