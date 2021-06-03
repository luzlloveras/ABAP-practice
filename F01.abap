*&---------------------------------------------------------------------*
*& Include          Z_BI_LLOVERAS_F01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Form F_LLAMADO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_CLIENTES
*&      --> WA_CLIENTES
*&      --> P_ARCH
*&---------------------------------------------------------------------*
form f_llamado  tables   t_clientes type tt_clientes

                using    p_archivo type localfile
                         w_clientes type ty_clientes.


*---------- Leo el archivo guardado en el Servidor ----------------------
  data : w_string type string .

  open dataset p_archivo for input in text mode encoding default.
  if sy-subrc is initial.
    do.
      read dataset p_archivo into w_string. "Leo el primer registro y lo guardo en la wa
      if sy-subrc = 0. "Si esto da okey

        split w_string at '|' into w_clientes-kunnr w_clientes-razon w_clientes-observaciones. "separo los campos del string archivo con pipes y las guardo en la wa

        append w_clientes to t_clientes. "Guardo el primer registro en la tabla
        clear w_clientes. "inicializo la wa para reutilizarla en el siguiente registro
      else. "Sino da okey
        exit. "Salir
      endif. "Termina la condicion
    enddo.  "Termina la vuelta
    close dataset p_archivo. "Cierro el archivo que ya termine de copiar a la wa
  endif.



*---------- Cambio los campos por los de mi wa para dsp llenar la tabla con los datos del archivo que cargo ivan

  loop at t_clientes into w_clientes.
    refresh bdc_tab.

    perform zfill_clientes using :   "Relleno campo a campo
    'X' 'SAPMSVMA' '0100',
    ' ' 'BDC_OKCODE' '=UPD',
    ' ' 'VIEWNAME' 'ZCLIENTES_LLOVER',
    ' ' 'VIMDYNFLDS-LTD_DTA_NO' 'X',
    'X' 'SAPLZLLOVERAS' '0001',
    ' ' 'BDC_OKCODE' '=NEWL',
    'X' 'SAPLZLLOVERAS' '0001',
    ' ' 'BDC_OKCODE' '/00',
    ' ' 'ZCLIENTES_LLOVER-KUNNR(01)' w_clientes-kunnr,
    ' ' 'ZCLIENTES_LLOVER-RAZON(01)' w_clientes-razon,
    ' ' 'ZCLIENTES_LLOVER-OBSERVACIONES(01)' w_clientes-observaciones,
    'X' 'SAPLZLLOVERAS' '0001',
    ' ' 'BDC_OKCODE' '=SAVE',
    'X' 'SAPLZLLOVERAS' '0001',
    ' ' 'BDC_OKCODE' '=BACK',
    'X' 'SAPLZLLOVERAS' '0001',
    ' ' 'BDC_OKCODE' '=BACK',
    'X' 'SAPMSVMA' '0100',
    ' ' 'BDC_OKCODE' '/EBACK'.

    call transaction 'SM30' using bdc_tab mode 'N' . "Lo guardo en el registro

  endloop.

endform.

form zfill_clientes using dynbegin name value.
  clear wa_bdc_tab.
  if dynbegin = 'X'.
    move: name to wa_bdc_tab-program,
    value to wa_bdc_tab-dynpro,
    'X' to wa_bdc_tab-dynbegin.
    append wa_bdc_tab to bdc_tab.
  else.
    clear wa_bdc_tab.
    move: name to wa_bdc_tab-fnam,
    value to wa_bdc_tab-fval.
    append wa_bdc_tab to bdc_tab.
  endif.



endform.