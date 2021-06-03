*&---------------------------------------------------------------------*
*& Report ZPUNI_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zpuni_lloveras.

include: zpuni_lloveras_top,
         zpuni_lloveras_f01.


start-of-selection.

  perform f_recupero_datos tables gt_alumnosuni
  using p_uni wa_alumnosuni.

end-of-selection.

  perform f_impresion tables gt_alumnosuni.