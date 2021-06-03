*&---------------------------------------------------------------------*
*& Report Z_BI_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report z_bi_lloveras.

include z_bi_lloveras_top.
include z_bi_lloveras_f01.

start-of-selection.

  perform f_llamado tables gt_clientes
  using p_arch wa_clientes.

end-of-selection.