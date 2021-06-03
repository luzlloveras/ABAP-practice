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

form f_recupero_datos  tables   t_alumnosuni type tt_alumnosuni
                       using    p_universidad type zuniversidad_lloveras
                                w_alumnosuni type ty_alumnosuni.


*---------------------------- Completo tabla con ABAP 740 ------------------------------
gt_alumnosuni = VALUE #( ( alumno = 'Amaia MONTERO' universidad = 'UTN' edad = '22' )
( alumno = 'Cristian CASTRO' universidad = 'CATOLICA' edad = '38' )
( alumno = 'Luis MIGUEL' universidad = 'UTN' edad = '30' )
( alumno = 'Marta SANCHES' universidad = 'UBA' edad = '25' )
( alumno = 'Ricardo ARJONA' universidad = 'SIGLO 21' edad = '22' )
( alumno = 'Ricardo MONTANER' universidad = 'UTN' edad = '19' ) ).

loop at gt_alumnosuni into w_alumnosuni.
refresh bdc_tab.

perform zfill_alumnos_tab using :   "Relleno campo a campo
    'X' 'SAPMSVMA' '0100',
    ' ' 'BDC_OKCODE' '=UPD',
    ' ' 'VIEWNAME' 'ZTUNI_LLOVERAS',
    ' ' 'VIMDYNFLDS-LTD_DTA_NO' 'X',
    'X' 'SAPLZLLOVERAS' '0002',
    ' ' 'BDC_OKCODE' '=NEWL',
    'X' 'SAPLZLLOVERAS' '0002',
    ' ' 'BDC_OKCODE' '/00',
    ' ' 'ZTUNI_LLOVERAS-ALUMNO(01)' w_alumnosuni-alumno,
    ' ' 'ZTUNI_LLOVERAS-UNIVERSIDAD(01)' w_alumnosuni-universidad,
    ' ' 'ZTUNI_LLOVERAS-EDAD(01)' w_alumnosuni-edad,
    'X' 'SAPLZLLOVERAS' '0002',
    ' ' 'BDC_OKCODE' '=SAVE',
    'X' 'SAPLZLLOVERAS' '0002',
    ' ' 'BDC_OKCODE' '=SAVE',
    'X' 'SAPLZLLOVERAS' '0002',
    ' ' 'BDC_OKCODE' '=BACK',
    'X' 'SAPLZLLOVERAS' '0002',
    ' ' 'BDC_OKCODE' '=BACK',
    'X' 'SAPMSVMA' '0100',
    ' ' 'BDC_OKCODE' '/EBACK'.

    call transaction 'SM30' using bdc_tab mode 'N' . "Lo guardo en el registro
endloop.




*-------- Seleccion ----------------

select alumno universidad edad
from ztuni_lloveras
into table t_alumnosuni
where universidad = p_universidad
order by edad.

if sy-subrc is initial.
endif.

*-------- Lecturas de tabla y appends ----------------

loop at t_alumnosuni into w_alumnosuni.
data(v_nacimiento) = sy-datum(4) -  w_alumnosuni-edad. "declaro variable y saco el año en que nacio el alumno por su edad
w_alumnosuni-nacimiento = v_nacimiento. "copio el dato de la variable en el campo de mi workin area
modify t_alumnosuni from w_alumnosuni. "agrego el año de nacimiento a mi campo nacimiento de mi workin area
endloop.

endform.



*&---------------------------------------------------------------------*
*& Form F_IMPRESION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_ALUMNOSUNI
*&---------------------------------------------------------------------*


form f_impresion  tables   t_alumnosuni type tt_alumnosuni.

*----------- Declaraciones de tipos, estructuras y tablas propias del ALV

type-pools: slis.
data: ti_catalogo type slis_t_fieldcat_alv,   "Tabla y estructura del catalogo
st_catalogo type slis_fieldcat_alv,
st_layout type slis_layout_alv,               "Estructura para la configuración de la salida
v_repid like sy-repid.                        "Variable con el nombre del programa

*Armado del catalogo del ALV --------------------- ABAP 740 ----------------------------

ti_catalogo = value #( ( fieldname = 'Alumno' seltext_l = 'Alumno' outputlen = '15' )
( fieldname = 'Universidad' seltext_l = 'Universidad' outputlen = '15' )
( fieldname = 'Edad' seltext_l = 'Edad' outputlen = '15' )
( fieldname = 'Nacimiento' seltext_l = 'Nacimiento' outputlen = '15' ) ).

*Configuracion de la salida del ALV
clear st_layout.
st_layout-zebra = abap_true. "Rayado de lineas
st_layout-colwidth_optimize = abap_true.


*Ejecucion de la funcion del ALV

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = SY-REPID
   IS_LAYOUT                         = ST_LAYOUT "slis_layout_alv
   IT_FIELDCAT                       = TI_CATALOGO "slis_t_fieldcat_alv

 TABLES
    T_OUTTAB                         = T_ALUMNOSUNI
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

endform.


FORM ZFILL_ALUMNOS_TAB USING dynbegin name value .

CLEAR wa_bdc_tab.
*SE REALIZA LA LOGICA INTERNA PARA PODER LLENAR EL ARCHIVO*
IF dynbegin = 'X' .

MOVE : name TO wa_bdc_tab-program ,
       value TO wa_bdc_tab-dynpro ,
       'X' TO wa_bdc_tab-dynbegin .
APPEND wa_bdc_tab TO bdc_tab.
ELSE .
MOVE : name TO wa_bdc_tab-fnam ,
       value TO wa_bdc_tab-fval.
APPEND wa_bdc_tab TO bdc_tab.
ENDIF.



ENDFORM.