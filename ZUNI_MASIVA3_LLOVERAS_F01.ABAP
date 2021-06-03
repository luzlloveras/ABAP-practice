*&---------------------------------------------------------------------*
*& Include          ZPUNI_LLOVERAS_F01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Form F_RECUPERO_DATOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_ALUMNOSUNI
*&      --> P_UNI
*&      --> WA_ALUMNOSUNI
*&---------------------------------------------------------------------*

form f_recupero_datos   using    p_universidad type localfile
                                w_string type string
                                w_alumnosuni type ty_alumnosuni
changing   t_alumnosuni type tt_alumnosuni.

*---------------------------- Levanto archivo  ------------------------------

  open dataset p_universidad for input in text mode encoding default. "Abro el archivo para poder copiarlo en la wa
  read dataset p_universidad into w_string. "Leo el primer registro y lo guardo en la wa
  clear w_string.
  if sy-subrc is initial.
    do.
      read dataset p_universidad into w_string. "Leo el primer registro y lo guardo en la wa
      if sy-subrc = 0. "Si esto da okey

        split w_string at ',' into w_alumnosuni-alumno w_alumnosuni-universidad w_alumnosuni-edad w_alumnosuni-turno w_alumnosuni-trabaja. "separo los campos del string archivo con comas y las guardo en la wa
        "shift wa_alumnosuni-turno by 1 places. "Desplazo un lugar del campo de la workin area
        case: wa_alumnosuni-trabaja.
          when '0'.
            wa_alumnosuni-turno = 'Full-time'.
          when '1'.
            wa_alumnosuni-turno = 'Night-time'.
          when '2'.
            wa_alumnosuni-turno = 'Part-time'.
        endcase.
        append w_alumnosuni to t_alumnosuni. "Guardo el primer registro en la tabla
        clear w_alumnosuni. "inicializo la wa para reutilizarla en el siguiente registro
      else. "Sino da okey
        exit. "Salir
      endif. "Termina la condicion
    enddo.  "Termina la vuelta
    close dataset p_universidad. "Cierro el archivo que ya termine de copiar a la wa
  endif.


  loop at t_alumnosuni into w_alumnosuni.
    refresh bdc_tab.

    perform zfill_alumnos_tab using :   "Relleno campo a campo
        'X' 'SAPMSVMA' '0100',
        ' ' 'BDC_OKCODE' '=UPD',
        ' ' 'VIEWNAME' 'ZTUNI_LLOVERAS',
        ' ' 'VIMDYNFLDS-LTD_DTA_NO' 'X',
        'X' 'SAPLZLLOVERAS' '0002',
        ' ' 'BDC_OKCODE' '=NEWL',
        'X' 'SAPLZLLOVERAS' '0002',
        ' ' 'BDC_OKCODE' '=SAVE',
        ' ' 'ZTUNI_LLOVERAS-ALUMNO(01)' w_alumnosuni-alumno,
        ' ' 'ZTUNI_LLOVERAS-UNIVERSIDAD(01)' w_alumnosuni-universidad,
        ' ' 'ZTUNI_LLOVERAS-EDAD(01)' w_alumnosuni-edad,
        ' ' 'ZTUNI_LLOVERAS-TURNO(01)' w_alumnosuni-turno,
        'X' 'SAPLZLLOVERAS' '0002',
        ' ' 'BDC_OKCODE' '=BACK',
        'X' 'SAPLZLLOVERAS' '0002',
        ' ' 'BDC_OKCODE' '=BACK',
        'X' 'SAPMSVMA' '0100',
        ' ' 'BDC_OKCODE' '/EBACK'.

    call transaction 'SM30' using bdc_tab mode 'N' . "Lo guardo en el registro
  endloop.

endform.



*&---------------------------------------------------------------------*
*& Form F_IMPRESION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_ALUMNOSUNI
*&---------------------------------------------------------------------*


form f_impresion  using   t_alumnosuni type tt_alumnosuni.

*----------- Declaraciones de tipos, estructuras y tablas propias del ALV

  type-pools: slis.
  data: ti_catalogo type slis_t_fieldcat_alv,   "Tabla y estructura del catalogo
        st_catalogo type slis_fieldcat_alv,
        st_layout   type slis_layout_alv,               "Estructura para la configuración de la salida
        v_repid     like sy-repid.                        "Variable con el nombre del programa

*Armado del catalogo del ALV --------------------- ABAP 740 ----------------------------

  ti_catalogo = value #( ( fieldname = 'Alumno' seltext_l = 'Alumno' outputlen = '15' )
  ( fieldname = 'Universidad' seltext_l = 'Universidad' outputlen = '15' )
  ( fieldname = 'Edad' seltext_l = 'Edad' outputlen = '15' )
  ( fieldname = 'Turno' seltext_l = 'Turno' outputlen = '15' ) ).

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
      t_outtab           = t_alumnosuni
    exceptions
      program_error      = 1
      others             = 2.
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.

endform.

*--------------------- BATCH INPUT ----------------------------

form zfill_alumnos_tab using dynbegin name value.

  clear wa_bdc_tab.

*Condicion para completar el archivo
  if dynbegin = 'X' .

    move : name to wa_bdc_tab-program ,
           value to wa_bdc_tab-dynpro ,
           'X' to wa_bdc_tab-dynbegin .
    append wa_bdc_tab to bdc_tab.
  else .
    move : name to wa_bdc_tab-fnam ,
           value to wa_bdc_tab-fval.
    append wa_bdc_tab to bdc_tab.
  endif.



endform.