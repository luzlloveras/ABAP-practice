*&---------------------------------------------------------------------*
*& Include          ZREP16_LLOVERAS_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form F_SELECCIONES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_selecciones .


*---------------- 1ra seleccion para tabla clientes ----------------------------
  select kunnr razon
  from zclientes_llover
  into table gt_clientes
  where kunnr in  s_kunnr.


*---------------- 2da seleccion para tabla pedidos ----------------------------
  if sy-subrc is initial.
    if p_uno eq 'X'.

      select kunnr pedido direccion entregado
      from zpedidos_llov
      into table  gt_pedidos
      for all entries in gt_clientes
      where kunnr = gt_clientes-kunnr and entregado = 'X'.

      sort gt_pedidos by kunnr.

    else.


      select kunnr pedido direccion entregado
      from zpedidos_llov
      into table  gt_pedidos
      for all entries in gt_clientes
      where kunnr = gt_clientes-kunnr and entregado = ''.

      sort gt_pedidos by kunnr .

    endif.
  endif.
endform.

*&---------------------------------------------------------------------*
*& Form F_PROCESAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_procesar .

  sort gt_clientes by kunnr.
  loop at gt_pedidos into wa_pedidos.
    wa_alv-kunnr = wa_pedidos-kunnr.
    wa_alv-pedido = wa_pedidos-pedido.
    wa_alv-direccion = wa_pedidos-direccion.
    wa_alv-entregado = wa_pedidos-entregado.
    read table gt_clientes into wa_clientes with key kunnr = wa_pedidos-kunnr binary search.
    if sy-subrc is initial.
      wa_alv-razon = wa_clientes-razon.
    endif.
    append wa_alv to gt_alv.
    clear wa_alv.
  endloop.

endform.


*&---------------------------------------------------------------------*
*& Form F_GRABAR_ARCHIVO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

form f_grabar_archivo .

*-------------- Declaro una variable para concatenar la data -----
  data v_text type string.

*-------------- Grabo la tabla alv en el p_file -----
  open dataset p_file for output in text mode encoding default.
  loop at gt_alv into wa_alv.
    concatenate wa_alv-kunnr wa_alv-razon wa_alv-pedido wa_alv-direccion wa_alv-entregado sy-uzeit into v_text separated by ','.
    transfer v_text to p_file.
  endloop.
  close dataset p_file.


endform.