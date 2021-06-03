*&---------------------------------------------------------------------*
*& Include          Z_ALV_FUM_LLOVE_TOP
*&---------------------------------------------------------------------*

*---------------- Selecciones -----------------------------
tables sbook.
select-options s_carrid for sbook-carrid.
select-options s_connid for sbook-connid.
select-options s_fldate for sbook-fldate.
select-options s_agency for sbook-agencynum.

types: tt_carrid type range of sbook-carrid,
tt_connid type range of sbook-connid,
tt_fldate type range of sbook-fldate,
tt_agency type range of sbook-agencynum.

*---------------- Types y Types Tables ---------------------
*Declaro campos para el tipo de tabla SBOOK
types: begin of ty_sbook,
CARRID type s_carr_id,
CONNID type s_conn_id,
FLDATE type s_date,
BOOKID type s_book_id,
CUSTOMID type s_customer,
SMOKER type s_smoker,
AGENCYNUM type s_agncynum,
end of ty_sbook.

*Declaro type para tabla SBOOK
types: tt_sbook type standard table of ty_sbook.

*Declaro campos para el tipo de tabla STRAVELAG
types: begin of ty_stravelag,
AGENCYNUM type s_agncynum,
STREET type s_street,
CITY type city,
COUNTRY type s_country,
TELEPHONE type s_phoneno,
end of ty_stravelag.

*Declaro type para tabla STRAVELAG
types: tt_stravelag type standard table of ty_stravelag.

*Declaro campos para el tipo de tabla SCUSTOM
types: begin of ty_scustom,
ID type s_customer,
NAME type s_custname,
TELEPHONE type s_phoneno,
end of ty_scustom.

*Declaro type para tabla SCUSTOM
types: tt_scustom type standard table of ty_scustom.

*Declaro campos para el tipo de tabla SPFLI
types: begin of ty_spfli,
CARRID type s_carr_id,
CONNID type s_conn_id,
CITYFROM type s_from_cit,
CITYTO type s_to_city,
end of ty_spfli.

*Declaro type para tabla SPFLI
types: tt_spfli type standard table of ty_spfli.

*---------------- Workin areas y Tablas globales ------------------
*Declaro working areas para tablas globales
data wa_sbook type ty_sbook.
data wa_stravelag type ty_stravelag.
data wa_scustom type ty_scustom.
data wa_spfli type ty_spfli.

*Declaro tablas globales
data gt_sbook type tt_sbook.
data gt_stravelag type tt_stravelag.
data gt_scustom type tt_scustom.
data gt_spfli type tt_spfli.

*---------------- TABLA PRINCIPAL -------------------------------

*Declaro type para tabla PRINCIPAL
types:  begin of ty_principal,
CARRID type s_carr_id,
CONNID type s_conn_id,
FLDATE type s_date,
BOOKID type s_book_id,
CUSTOMID type s_customer,
SMOKER type s_smoker,
AGENCYNUM type s_agncynum,
STREET type s_street,
CITY type city,
COUNTRY type s_country,
TELEPHONE type s_phoneno,
ID type s_customer,
NAME type s_custname,
CITYFROM type s_from_cit,
CITYTO type s_to_city,
end of ty_principal.

*Declaro tipo tabla para tabla PRINCIPAL
types: tt_principal type standard table of ty_principal.

*Declaro workin area PRINCIPAL
data wa_principal type ty_principal.

*Declaro tabla global PRINCIPAL
data gt_principal type standard table of ty_principal.