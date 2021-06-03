*&---------------------------------------------------------------------*
*& Report ZREP16_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zrep16_lloveras.

initialization.


  include zrep16_lloveras_top.
  include zrep16_lloveras_f01.

start-of-selection.

  perform f_selecciones.
  perform f_procesar.

end-of-selection.

  if p_check eq 'X'.
    perform f_grabar_archivo.
  endif.

at selection-screen output.
  if p_check eq 'X'.
    loop at screen.
      if screen-group1 = 'A'.
        screen-input = 1. "Campo no editable/grisado
        screen-invisible = 0.
        modify screen.
      endif.
    endloop.
  else.
    loop at screen.
      if screen-group1 = 'A'.
        screen-input = 0. "campo no editable/grisado
        screen-invisible = 1.
        p_file = ''.
        modify screen.
      endif.
    endloop.
endif.