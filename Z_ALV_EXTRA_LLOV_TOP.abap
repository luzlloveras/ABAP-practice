*&---------------------------------------------------------------------*
*& Include          Z_ALV_EXTRA_LLOV_TOP
*&---------------------------------------------------------------------*

*---------------- Selecciones -----------------------------
tables bkpf.
select-options s_bukrs for bkpf-bukrs.
select-options s_belnr for bkpf-belnr.
select-options s_gjahr for bkpf-gjahr.


types: tt_bukrs type range of bkpf-bukrs,
tt_belnr type range of bkpf-belnr,
tt_gjahr type range of bkpf-gjahr.

*---------------- Types y Types Tables ---------------------
*Declaro campos para el tipo de tabla BKPF
types: begin of ty_bkpf,
BUKRS type bukrs,
BELNR type belnr_d,
GJAHR type gjahr,
XBLNR type xblnr1,
BLART type blart,
end of ty_bkpf.

*Declaro type para tabla BKPF
types: tt_bkpf type standard table of ty_bkpf.

*Declaro campos para el tipo de tabla BSEG
types: begin of ty_bseg,
BUKRS type bukrs,
BELNR type belnr_d,
GJAHR type gjahr,
BUZEI type buzei,
AUGDT type augdt,
end of ty_bseg.

*Declaro type para tabla BSEG
types: tt_bseg type standard table of ty_bseg.

*---------------- Workin areas y Tablas globales ------------------
*Declaro working areas para tablas globales
data wa_bkpf type ty_bkpf.
data wa_bseg type ty_bseg.


*Declaro tablas globales
data gt_bkpf type tt_bkpf.
data gt_bseg type tt_bseg.

*---------------- TABLA PRINCIPAL -------------------------------

*Declaro type para tabla PRINCIPAL
types:  begin of ty_principal,
BUKRS type bukrs,
BELNR type belnr_d,
GJAHR type gjahr,
XBLNR type xblnr1,
BLART type blart,
BUZEI type buzei,
AUGDT type augdt,
end of ty_principal.

*Declaro tipo tabla para tabla PRINCIPAL
types: tt_principal type standard table of ty_principal.

*Declaro workin area PRINCIPAL
data wa_principal type ty_principal.

*Declaro tabla global PRINCIPAL
data gt_principal type standard table of ty_principal.