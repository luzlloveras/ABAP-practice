*&---------------------------------------------------------------------*
*& Report ZPUNI_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zuni_masiva_lloveras.

INCLUDE ZUNI_MASIVA_LLOVERAS_TOP.
INCLUDE ZUNI_MASIVA_LLOVERAS_F01.


start-of-selection.

  perform f_recupero_datos tables gt_alumnosuni
  using p_uni wa_alumnosuni.

end-of-selection.

perform f_impresion tables gt_alumnosuni.