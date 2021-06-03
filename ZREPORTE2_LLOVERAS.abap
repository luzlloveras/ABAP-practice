*&---------------------------------------------------------------------*
*& Report ZREPORTE2_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREPORTE2_LLOVERAS.

*Declaro parametro
tables scarr.
parameters p_name like scarr-carrname.

*-------------------- 1 - SCARR ---------------------
*Declaro types para la estructura SCARR
types:  begin of ty_join,
        carrid type s_carr_id,
        carrname type s_carrname,
        currcode type s_currcode,
        end of ty_join.

*Declaro tabla y workin area SCARR
data:   gt_scarr type standard table of ty_scarr,
        wa_scarr type ty_scarr.

*-------------------- 2 - SPFLI ---------------------
*Declaro types para la estructura SPFLI
types:  begin of ty_spfli,
        carrid type s_carr_id,
        carrname type s_carrname,
        currcode type s_currcode,
        connid type s_conn_id,
        countryfr type land1,
        cityfrom type s_from_cit,
        countryto type land1,
        cityto type s_to_city,
        end of ty_spfli.

*Declaro tabla y workin area SPFLI
data:   gt_spfli type standard table of ty_spfli,
        wa_spfli type ty_spfli.

*-------------------- 3 - SFLIGHT ---------------------
*Declaro types para la estructura SFLIGHT
types:  begin of ty_sflight,
        carrid type s_carr_id,
        connid type s_conn_id,
        fldate type s_date,             "sflight
        price type s_price,             "sflight
        planetype type s_planetye,      "sflight
        seatsmax type s_seatsmax,       "sflight
        seatsocc type s_seatsocc,       "sflight
        end of ty_sflight.

*Declaro tabla y workin area SFLIGHT
data:   gt_sflight type standard table of ty_sflight,
        wa_sflight type ty_sflight.


*-------------------- 4 - SBOOK ---------------------
*Declaro types para la estructura SBOOK
types:  begin of ty_sbook,
        carrid type s_carr_id,
        connid type s_conn_id,
        fldate type s_date,
        bookid type s_book_id,
        customid type s_customer,
        custtype type s_custtype,
        smoker type s_smoker,
        luggweight type s_lugweigh,
        end of ty_sbook.

*Declaro tabla y workin area SBOOK
data:   gt_sbook type standard table of ty_sbook,
        wa_sbook type ty_sbook.

*-------------------- 1era seleccion ---------------------
select carrid carrname currcode
from scarr
into table gt_scarr
where carrname = p_name.

if sy-subrc is initial.
endif.
*-------------------- 2da seleccion join ---------------------
select scarr~carrid scarr~carrname scarr~currcode spfli~connid spfli~countryfr spfli~cityfrom spfli~countryto spfli~cityto
from scarr
inner join spfli
on scarr~carrid = spfli~carrid
into table gt_spfli
where scarr~carrname = p_name.

*-------------------- 3ra seleccion join ---------------------
select scarr~carrid spfli~connid sflight~fldate sflight~price sflight~planetype sflight~seatsmax sflight~seatsocc
from spfli
inner join sflight
on spfli~carrid = sflight~carrid
and spfli~connid = sflight~connid
into table gt_sflight
where scarr~carrname = p_name.

*-------------------- 4ta seleccion join ---------------------
select scarr~carrid spfli~connid sflight~fldate sbook~bookid sbook~customid sbook~custtype sbook~smoker sbook~luggweight
from sflight
inner join sbook
on sflight~carrid = sbook~carrid
into table gt_sbook
where scarr~carrname = p_name.