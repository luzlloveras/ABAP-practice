*&---------------------------------------------------------------------*
*& Report ZREP11_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zrep11_lloveras.

initialization.

include zrep11_lloveras_top.
include zrep11_lloveras_f01.

start-of-selection.

  perform f_selecciones.
  perform f_procesar.

end-of-selection.

  perform f_impresion.