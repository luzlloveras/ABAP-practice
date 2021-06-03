*&---------------------------------------------------------------------*
*& Include          ZREP11_LLOVERAS_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form F_SELECCIONES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*

form f_selecciones.

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
*& Form F_IMPRESION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_PEDIDOS
*&---------------------------------------------------------------------*

form f_impresion.

*Declaraciones de tipos, estructuras y tablas propias del ALV

  type-pools: slis.

*Tabla y estructura del catalogo
  data: ti_catalogo type slis_t_fieldcat_alv,
        st_catalogo type slis_fieldcat_alv,
*Estructura para la configuracion de la salida
        st_layout   type slis_layout_alv,
*Variable con el nombre del programa
        v_repid     like sy-repid.

*Armado del catalogo del ALV --------------------- ABAP 740 ----------------------------

  ti_catalogo = value #( ( fieldname = 'Kunnr' seltext_l = 'Kunnr' outputlen = '15' tabname = 'gt_alv' )
  ( fieldname = 'Razon' seltext_l = 'Razon' outputlen = '15' tabname = 'gt_alv' )
  ( fieldname = 'Pedido' seltext_l = 'Pedido' outputlen = '15' tabname = 'gt_alv' )
  ( fieldname = 'Direccion' seltext_l = 'Direccion' outputlen = '15' tabname = 'gt_alv' )
  ( fieldname = 'Entregado' seltext_l = 'Entregado' outputlen = '15' tabname = 'gt_alv' ) ).

*Configuracion de la salida del ALV
  clear st_layout.
  st_layout-zebra = abap_true. "Rayado de lineas
  st_layout-colwidth_optimize = abap_true.


*Ejecucion de la funcion del ALV

  call function 'REUSE_ALV_GRID_DISPLAY'
    exporting
      i_callback_program = sy-repid
      is_layout          = st_layout "slis_layout_alv
      it_fieldcat        = ti_catalogo "slis_t_fieldcat_alv
    tables
      t_outtab           = gt_alv
    exceptions
      program_error      = 1
      others             = 2.
  if sy-subrc <> 0.
* Implement suitable error handling here
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