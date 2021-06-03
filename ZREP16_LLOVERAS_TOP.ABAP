*&---------------------------------------------------------------------*
*& Include          ZREP16_LLOVERAS_TOP
*&---------------------------------------------------------------------*

*---------------  Select option ---------------
tables: zclientes_llover,
zpedidos_llov.

select-options s_kunnr for zclientes_llover-kunnr.
types: tt_kunnr type range of zclientes_llover-kunnr.

*---------------  Parametros ---------------
parameters: p_uno radiobutton group rb1, "Radio buttom
            p_dos radiobutton group rb1, "Radio buttom
            p_check as checkbox user-command chk, "Check box
            p_file type string modif id A. "Caja para completar el file


*---------------- Declaraciones PEDIDOS -----------------------------
*Declaro campos para el tipo de tabla pedidos
types: begin of ty_pedidos,
         kunnr     type kunnr,
         pedido    type zpedido_llov,
         direccion type zdireccion_llov,
         entregado type zentregado_llov,
       end of ty_pedidos.

*Declaro type para tabla pedidos
types: tt_pedidos type standard table of ty_pedidos.

*Declaro tablas global
data : gt_pedidos type tt_pedidos,
       wa_pedidos type ty_pedidos.


*---------------- Declaraciones CLIENTES -----------------------------
*Declaro campos para el tipo de tabla pedidos
types: begin of ty_clientes,
         kunnr type kunnr,
         razon type zrazon_llov,
       end of ty_clientes.

*Declaro type para tabla pedidos
types: tt_clientes type standard table of ty_clientes.

*Declaro tablas global
data : gt_clientes type tt_clientes,
       wa_clientes type ty_clientes.

*---------------- Declaraciones ALV -----------------------------
*Declaro campos para el tipo de tabla pedidos
types: begin of ty_alv,
         kunnr     type kunnr,
         pedido    type zpedido_llov,
         direccion type zdireccion_llov,
         entregado type zentregado_llov,
         razon     type zrazon_llov,
       end of ty_alv.

*Declaro type para tabla pedidos
types: tt_alv type standard table of ty_alv.

*Declaro tablas global
data : gt_alv type tt_alv,
       wa_alv type ty_alv.