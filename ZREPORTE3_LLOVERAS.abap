*&---------------------------------------------------------------------*
*& Report ZREPORTE3_LLOVERAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREPORTE3_LLOVERAS.

*Declaro parametro
tables scarr.
parameters p_name like scarr-carrname.

types:  begin of ty_join,
        carrid type s_carr_id,          "scarr
        carrname type s_carrname,       "scarr
        currcode type s_currcode,       "scarr
        connid type s_conn_id,          "spfli
        countryfr type land1,           "spfli
        cityfrom type s_from_cit,       "spfli
        countryto type land1,           "spfli
        cityto type s_to_city,          "spfli
        fldate type s_date,             "sflight
        price type s_price,             "sflight
        planetype type s_planetye,      "sflight
        seatsmax type s_seatsmax,       "sflight
        seatsocc type s_seatsocc,       "sflight
        bookid type s_book_id,          "sbook
        customid type s_customer,       "sbook
        custtype type s_custtype,       "sbook
        smoker type s_smoker,           "sbook
        luggweight type s_lugweigh,     "sbook
        end of ty_join.

data:   gt_join type standard table of ty_join,
        wa_join type ty_join.

select scarr~carrid scarr~carrname scarr~currcode
spfli~connid spfli~countryfr spfli~cityfrom spfli~countryto spfli~cityto
sflight~fldate sflight~price sflight~planetype sflight~seatsmax sflight~seatsocc
sbook~bookid sbook~customid sbook~custtype sbook~smoker sbook~luggweight
from scarr

inner join spfli
on scarr~carrid = spfli~carrid

inner join sflight
on spfli~carrid = sflight~carrid
and spfli~connid = sflight~connid

inner join sbook
on sflight~fldate = sbook~fldate

into table gt_join
where scarr~carrname = p_name.


*---------- IMPRESIONES ---------------
loop at gt_join into wa_join.
write:/ wa_join-carrid,
wa_join-carrname,
wa_join-currcode,
wa_join-connid,
wa_join-countryfr,
wa_join-cityfrom,
wa_join-countryto,
wa_join-cityto,
wa_join-fldate,
wa_join-price,
wa_join-planetype,
wa_join-seatsmax,
wa_join-seatsocc,
wa_join-bookid,
wa_join-customid,
wa_join-custtype,
wa_join-smoker,
wa_join-luggweight.
endloop.

