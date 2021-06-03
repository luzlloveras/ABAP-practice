*&---------------------------------------------------------------------*
*& Include          Z_ALV_FUM_LLOVE_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form F_SELECCIONES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_SBOOK
*&      --> GT_STRAVELAG
*&      --> GT_SCUSTOM
*&      --> GT_SPFLI
*&      --> S_CARRID
*&      --> S_CONNID
*&      --> S_FLDATE
*&      --> S_AGENCY
*&---------------------------------------------------------------------*
FORM F_SELECCIONES  TABLES   T_SBOOK TYPE TT_SBOOK
                             T_STRAVELAG TYPE TT_STRAVELAG
                             T_SCUSTOM TYPE TT_SCUSTOM
                             T_SPFLI TYPE TT_SPFLI
                    USING    SO_CARRID TYPE TT_CARRID
                             SO_CONNID TYPE TT_CONNID
                             SO_FLDATE TYPE TT_FLDATE
                             SO_AGENCY TYPE TT_AGENCY.

*EMPIEZO SELECCIONES
*----- 1ra seleccion --------------
select carrid connid fldate bookid customid smoker agencynum
from sbook
into table t_sbook
where carrid in so_carrid
and connid in so_connid
and fldate in so_fldate
and agencynum in so_agency.

if sy-subrc is initial.
sort t_sbook by agencynum.
delete adjacent duplicates from t_sbook comparing agencynum.
endif.

*----- 2da seleccion --------------
select agencynum street city country telephone
from stravelag
into table t_stravelag
for all entries in t_sbook
where agencynum = t_sbook-agencynum.

if sy-subrc is initial.
endif.

*----- 3ra seleccion --------------
select id name telephone
from scustom
into table t_scustom
for all entries in t_sbook
where id = t_sbook-customid.

if sy-subrc is initial.
endif.

*----- 4ta seleccion --------------
select carrid connid cityfrom cityto
from spfli
into table t_spfli
for all entries in t_sbook
where carrid = t_sbook-carrid
and connid = t_sbook-connid.


if sy-subrc is initial.
endif.


ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_LECTURAS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_SBOOK
*&      --> GT_STRAVELAG
*&      --> GT_SCUSTOM
*&      --> GT_SPFLI
*&      --> GT_PRINCIPAL
*&---------------------------------------------------------------------*
FORM F_LECTURAS  TABLES   T_SBOOK TYPE TT_SBOOK
                          T_STRAVELAG TYPE TT_STRAVELAG
                          T_SCUSTOM TYPE TT_SCUSTOM
                          T_SPFLI TYPE TT_SPFLI
                          T_PRINCIPAL TYPE TT_PRINCIPAL.


loop at t_sbook into wa_sbook.

wa_principal-carrid = wa_sbook-carrid.
wa_principal-connid = wa_sbook-connid.
wa_principal-fldate = wa_sbook-fldate.
wa_principal-bookid = wa_sbook-bookid.
wa_principal-customid = wa_sbook-customid.
wa_principal-smoker = wa_sbook-smoker.
wa_principal-agencynum = wa_sbook-agencynum.

read table t_stravelag into wa_stravelag with key agencynum = wa_sbook-agencynum.
if sy-subrc is initial.
wa_principal-street = wa_stravelag-street.
wa_principal-city = wa_stravelag-city.
wa_principal-country = wa_stravelag-country.
wa_principal-telephone = wa_stravelag-telephone.
endif.


read table t_scustom into wa_scustom with key id = wa_sbook-customid.
if sy-subrc is initial.
wa_principal-id = wa_scustom-id.
wa_principal-name = wa_scustom-name.
endif.

read table t_spfli into wa_spfli with key carrid = wa_sbook-carrid connid = wa_sbook-connid.
if sy-subrc is initial.
wa_principal-cityfrom = wa_spfli-cityfrom.
wa_principal-cityto = wa_spfli-cityto.
endif.

append wa_principal to t_principal.
clear: wa_sbook,
wa_stravelag,
wa_scustom,
wa_spfli,
wa_principal.
endloop.



ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_IMPRESION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_PRINCIPAL
*&---------------------------------------------------------------------*
FORM F_IMPRESION  TABLES   T_PRINCIPAL TYPE TT_PRINCIPAL.

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
( fieldname = 'Connid' seltext_l = 'Connid' outputlen = '15' )
( fieldname = 'Fldate' seltext_l = 'Fldate' outputlen = '15' )
( fieldname = 'Bookid' seltext_l = 'Bookid' outputlen = '15' )
( fieldname = 'Customid' seltext_l = 'Customid' outputlen = '15' )
( fieldname = 'Smoker' seltext_l = 'Smoker' outputlen = '15' )
( fieldname = 'Agencynum' seltext_l = 'Agencynum' outputlen = '15' )
( fieldname = 'Street' seltext_l = 'Street' outputlen = '15' )
( fieldname = 'Country' seltext_l = 'Country' outputlen = '15' )
( fieldname = 'Telephone' seltext_l = 'Telephone' outputlen = '15' )
( fieldname = 'Id' seltext_l = 'Id' outputlen = '15' )
( fieldname = 'Name' seltext_l = 'Name' outputlen = '15' )
( fieldname = 'Cityfrom' seltext_l = 'Cityfrom' outputlen = '15' )
( fieldname = 'Cityto' seltext_l = 'Cityto' outputlen = '15' ) ).

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
    T_OUTTAB                         = T_PRINCIPAL
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

ENDFORM.