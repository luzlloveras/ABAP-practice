*&---------------------------------------------------------------------*
*& Include          ZREPORTE1_LLOVERAS_F01
*&---------------------------------------------------------------------*

form f_selecciones

TABLES   t_DESTINO0 TYPE tt_scarr
                               t_destino1 TYPE tt_spfli
                               t_destino2 TYPE tt_sflight
                               t_destino3 TYPE tt_sbook
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
into table t_destino0
where carrname = p_name.

if sy-subrc is initial.
lt_scarr[] = t_destino0[].
sort lt_scarr by carrid.
delete adjacent duplicates from lt_scarr comparing carrid.

*----- 2da seleccion --------------
select carrid connid countryfr cityfrom countryto cityto
from spfli
into table t_destino1
for all entries in lt_scarr
where carrid = lt_scarr-carrid.

if sy-subrc is initial.
lt_spfli[] = t_destino1[].
sort lt_spfli by carrid connid.
delete adjacent duplicates from lt_spfli comparing carrid connid.

*----- 3ra seleccion --------------
select carrid connid fldate price planetype seatsmax seatsocc
from sflight
into table t_destino2
for all entries in lt_spfli
where carrid = lt_spfli-carrid
and connid = lt_spfli-connid.

if sy-subrc is initial.
lt_sflight[] = t_destino2[].
sort lt_sflight by carrid connid fldate.
delete adjacent duplicates from lt_sflight comparing carrid connid fldate.

*----- 4ta seleccion --------------
select carrid connid fldate bookid customid custtype smoker luggweight
from sbook
into table t_destino3
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
*& Form F_IMPRE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_DESTINO0
*&      --> GT_DESTINO1
*&      --> GT_DESTINO2
*&      --> GT_DESTINO3
*&---------------------------------------------------------------------*
FORM F_IMPRE  TABLES   T_DESTINO0 TYPE TT_SCARR
                       T_DESTINO1 TYPE TT_SPFLI
                       T_DESTINO2 TYPE TT_SFLIGHT
                       T_DESTINO3 TYPE TT_SBOOK.

data: wa_scarr type ty_scarr,
wa_spfli type ty_spfli,
wa_sflight type ty_sflight,
wa_sbook type ty_sbook.


WRITE '----- 1er loop --------------'.
loop at t_destino0 into wa_scarr.
write:/ wa_scarr-carrid, "Escribo campos
wa_scarr-carrname,
wa_scarr-currcode.
clear wa_scarr.   "Limpio workin areas
endloop.

skip 2.
WRITE '----- 2er loop --------------'.
loop at t_destino1 into wa_spfli.
write:/ wa_spfli-connid, "Escribo campos
wa_spfli-countryfr,
wa_spfli-cityfrom,
wa_spfli-countryto,
wa_spfli-cityto.
clear wa_spfli.   "Limpio workin areas
endloop.

skip 2.
WRITE '----- 3er loop --------------'.
loop at t_destino2 into wa_sflight.
write:/ wa_sflight-fldate, "Escribo campos
wa_sflight-price,
wa_sflight-planetype,
wa_sflight-seatsmax,
wa_sflight-seatsocc.
clear wa_sflight.   "Limpio workin areas
endloop.

skip 2.
WRITE '----- 4to loop --------------'.
loop at t_destino3 into wa_sbook.
write:/ wa_sbook-bookid, "Escribo campos
wa_sbook-customid,
wa_sbook-custtype,
wa_sbook-smoker,
wa_sbook-luggweight.
clear wa_sbook.   "Limpio workin areas
endloop.


ENDFORM.