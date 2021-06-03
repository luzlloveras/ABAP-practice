*&---------------------------------------------------------------------*
*& Include          ZREPORTE1_LLOVERAS_TOP
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
data gt_destino0 type standard table of ty_scarr.
data gt_destino1 type standard table of ty_spfli.
data gt_destino2 type standard table of ty_sflight.
data gt_destino3 type standard table of ty_sbook.