*&---------------------------------------------------------------------*
*& Include          ZLLOV_4EN1_TOP
*&---------------------------------------------------------------------*



*Declaro parametro
tables scarr.
parameters p_name like scarr-carrname.


*Declaro campos para el tipo de tabla SCARR
types: begin of ty_scarr,
carrid type s_carr_id,
carrname type s_carrname,
currcode type s_currcode,
end of ty_scarr.

*Declaro type para tabla SCARR
types: tt_scarr type standard table of ty_scarr.

*Declaro campos para el tipo de tabla SPFLI
types: begin of ty_spfli,
carrid type s_carr_id,
connid type s_conn_id,
countryfr type land1,
cityfrom type s_from_cit,
countryto type land1,
cityto type s_to_city,
end of ty_spfli.

*Declaro type para tabla SPFLI
types: tt_spfli type standard table of ty_spfli.

*Declaro campos para el tipo de tabla SFLIGHT
types: begin of ty_sflight,
carrid type s_carr_id,
connid type s_conn_id,
fldate type s_date,
price type s_price,
planetype type s_planetye,
seatsmax type s_seatsmax,
seatsocc type s_seatsocc,
end of ty_sflight.

*Declaro type para tabla SFLIGHT
types: tt_sflight type standard table of ty_sflight.

*Declaro campos para el tipo de tabla SBOOK
types: begin of ty_sbook,
carrid type s_carr_id,
connid type s_conn_id,
fldate type s_date,
bookid type s_book_id,
customid type s_customer,
custtype type s_custtype,
smoker type s_smoker,
luggweight type s_lugweigh,
end of ty_sbook.

*Declaro type para tabla SBOOK
types: tt_sbook type standard table of ty_sbook.

*Declaro tablas globales
data gt_scarr type standard table of ty_scarr.
data gt_spfli type standard table of ty_spfli.
data gt_sflight type standard table of ty_sflight.
data gt_sbook type standard table of ty_sbook.

*Declaro working areas para tablas globales
data wa_scarr type ty_scarr.
data wa_spfli type ty_spfli.
data wa_sflight type ty_sflight.
data wa_sbook type ty_sbook.

*Declaro type para tabla FUSION
types:  begin of ty_fusion,
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
        end of ty_fusion.

*Declaro tipo tabla para tabla fusion
types: tt_fusion type standard table of ty_fusion.

*Declaro tabla FUSION
data gt_fusion type standard table of ty_fusion.

*Declaro workin area FUSION
data wa_fusion type ty_fusion.