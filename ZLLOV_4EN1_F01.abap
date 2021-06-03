*&---------------------------------------------------------------------*
*& Include          ZLLOV_4EN1_F01
*&---------------------------------------------------------------------*

form f_selecciones

TABLES   gt_scarr TYPE tt_scarr
                               gt_spfli TYPE tt_spfli
                               gt_sflight TYPE tt_sflight
                               gt_sbook TYPE tt_sbook
                      USING    p_name type scarr-carrname.


*Declaro tablas locales
data: lt_scarr type standard table of ty_scarr,
lt_spfli type standard table of ty_spfli,
lt_sflight type standard table of ty_sflight,
lt_sbook type standard table of ty_sbook.

*EMPIEZO SELECCIONES
*----- 1ra seleccion --------------
select carrid carrname currcode
from scarr
into table gt_scarr
where carrname = p_name.

if sy-subrc is initial.
lt_scarr[] = gt_scarr[].
sort lt_scarr by carrid.
delete adjacent duplicates from lt_scarr comparing carrid.

*----- 2da seleccion --------------
select carrid connid countryfr cityfrom countryto cityto
from spfli
into table gt_spfli
for all entries in lt_scarr
where carrid = lt_scarr-carrid.

if sy-subrc is initial.
lt_spfli[] = gt_spfli[].
sort lt_spfli by carrid connid.
delete adjacent duplicates from lt_spfli comparing carrid connid.

*----- 3ra seleccion --------------
select carrid connid fldate price planetype seatsmax seatsocc
from sflight
into table gt_sflight
for all entries in lt_spfli
where carrid = lt_spfli-carrid
and connid = lt_spfli-connid.

if sy-subrc is initial.
lt_sflight[] = gt_sflight[].
sort lt_sflight by carrid connid fldate.
delete adjacent duplicates from lt_sflight comparing carrid connid fldate.

*----- 4ta seleccion --------------
select carrid connid fldate bookid customid custtype smoker luggweight
from sbook
into table gt_sbook
for all entries in lt_sflight
where carrid = lt_sflight-carrid
and connid = lt_sflight-connid
and fldate = lt_sflight-fldate.

if sy-subrc is initial.
endif.
endif.
endif.
endif.
endform.




*&---------------------------------------------------------------------*
*& Form F_LECTURAS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_SCARR
*&      --> GT_SPFLI
*&      --> GT_SFLIGHT
*&      --> GT_SBOOK
*&      --> GT_FUSION
*&---------------------------------------------------------------------*
FORM F_LECTURAS  TABLES   GT_SCARR TYPE TT_SCARR
                          GT_SPFLI TYPE TT_SPFLI
                          GT_SFLIGHT TYPE TT_SFLIGHT
                          GT_SBOOK TYPE TT_SBOOK
                          GT_FUSION TYPE TT_FUSION.

*------------------ FUSION DE CUATRO TABLAS EN TABLA FUSION --------------------------
loop at gt_sbook into wa_sbook.

wa_fusion-carrid = wa_sbook-carrid.
wa_fusion-connid = wa_sbook-connid.
wa_fusion-fldate = wa_sbook-fldate.
wa_fusion-bookid = wa_sbook-bookid.
wa_fusion-customid = wa_sbook-customid.
wa_fusion-custtype = wa_sbook-custtype.
wa_fusion-smoker = wa_sbook-smoker.
wa_fusion-luggweight = wa_sbook-luggweight.


read table gt_sflight into wa_sflight with key carrid = wa_sbook-carrid connid = wa_sbook-connid fldate = wa_sbook-fldate.
if sy-subrc is initial.
wa_fusion-price = wa_sflight-price.
wa_fusion-planetype = wa_sflight-planetype.
wa_fusion-seatsmax = wa_sflight-seatsmax.
wa_fusion-seatsocc = wa_sflight-seatsocc.
endif.


read table gt_spfli into wa_spfli with key carrid = wa_sbook-carrid connid = wa_sbook-connid.
if sy-subrc is initial.
wa_fusion-countryfr = wa_spfli-countryfr.
wa_fusion-cityfrom = wa_spfli-cityfrom.
wa_fusion-countryto = wa_spfli-countryto.
wa_fusion-cityto = wa_spfli-cityto.
endif.


read table gt_scarr into wa_scarr with key carrid = wa_sbook-carrid.
if sy-subrc is initial.
wa_fusion-carrname = wa_scarr-carrname.
wa_fusion-currcode = wa_scarr-currcode.
endif.

append wa_fusion to gt_fusion.
clear: wa_scarr,
wa_spfli,
wa_sflight,
wa_sbook,
wa_fusion.
endloop.


ENDFORM.




*&---------------------------------------------------------------------*
*& Form F_IMPRESION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_FUSION
*&---------------------------------------------------------------------*

FORM F_IMPRESION  TABLES   GT_FUSION TYPE TT_FUSION.

*Declaraciones de tipos, estructuras y tablas propias del ALV

type-pools: slis.

*Tabla y estructura del catalogo
data: ti_catalogo type slis_t_fieldcat_alv,
st_catalogo type slis_fieldcat_alv,
*Estructura para la configuracion de la salida
st_layout type slis_layout_alv,
*Variable con el nombre del programa
v_repid like sy-repid.

*Armado del catalogo del ALV --------------------- ABAP 740 ----------------------------

ti_catalogo = value #( ( fieldname = 'Carrid' seltext_l = 'Carrid' outputlen = '15' )
( fieldname = 'Carrname' seltext_l = 'Carrname' outputlen = '15' )
( fieldname = 'Currcode' seltext_l = 'Currcode' outputlen = '15' )
( fieldname = 'Connid' seltext_l = 'Connid' outputlen = '15' )
( fieldname = 'Countryfr' seltext_l = 'Countryfr' outputlen = '15' )
( fieldname = 'Cityfrom' seltext_l = 'Cityfrom' outputlen = '15' )
( fieldname = 'Countryto' seltext_l = 'Countryto' outputlen = '15' )
( fieldname = 'Cityto' seltext_l = 'Cityto' outputlen = '15' )
( fieldname = 'Fldate' seltext_l = 'Fldate' outputlen = '15' )
( fieldname = 'Price' seltext_l = 'Price' outputlen = '15' )
( fieldname = 'Planetype' seltext_l = 'Planetype' outputlen = '15' )
( fieldname = 'Seatsmax' seltext_l = 'Seatsmax' outputlen = '15' )
( fieldname = 'Seatsocc' seltext_l = 'Seatsocc' outputlen = '15' )
( fieldname = 'Bookid' seltext_l = 'Bookid' outputlen = '15' )
( fieldname = 'Customid' seltext_l = 'Customid' outputlen = '15' )
( fieldname = 'Custtype' seltext_l = 'Custtype' outputlen = '15' )
( fieldname = 'Smoker' seltext_l = 'Smoker' outputlen = '15' )
( fieldname = 'Luggweight' seltext_l = 'Luggweight' outputlen = '15' ) ).

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
    T_OUTTAB                         = GT_FUSION
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.


ENDFORM.