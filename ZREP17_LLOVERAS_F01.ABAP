*&---------------------------------------------------------------------*
*& Include          ZREP17_LLOVERAS_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form F_RECUPERO_DATOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> S_PRICE[]
*&      --> P_CARRID
*&      <-- GT_SFLIGHT
*&      <-- GT_SPFLI
*&      <-- GT_FINAL
*&---------------------------------------------------------------------*
form f_recupero_datos  using    p_s_price type tt_price
                                p_p_carrid type s_carr_id
                       changing p_gt_sflight type tt_sflight
                                p_gt_spfli type  tt_spfli
                                p_gt_final type tt_final.

*-------------- Levanto datos de la sflight y la spfli con el $ y el nombre de parametros -----------------
  select carrid connid fldate price currency
  from sflight
  into table gt_sflight
  where price in p_s_price
  and carrid = p_p_carrid.

  if sy-subrc is initial.
    p_gt_sflight[] = gt_sflight[].
    sort p_gt_sflight by carrid connid.
    delete adjacent duplicates from p_gt_sflight comparing carrid connid.

    select carrid connid cityfrom cityto
    from spfli
    into table gt_spfli
    for all entries in p_gt_sflight
    where carrid = p_gt_sflight-carrid
    and connid = p_gt_sflight-connid.

    if sy-subrc is initial.
    endif.
  endif.

*---------------------- Guardo los datos en mi tabla final ------------------------
  sort p_gt_spfli by carrid connid.

  loop at gt_sflight into wa_sflight.
    wa_final-carrid = wa_sflight-carrid.
    wa_final-connid = wa_sflight-connid.
    wa_final-fldate = wa_sflight-fldate.
    wa_final-price = wa_sflight-price.
    wa_final-currency = wa_sflight-currency.

    read table gt_spfli into wa_spfli with key carrid = wa_sflight-carrid connid = wa_sflight-connid binary search.

    if sy-subrc is initial.
      wa_final-cityfrom = wa_spfli-cityfrom.
      wa_final-cityto = wa_spfli-cityto.
    endif.
    append wa_final to gt_final.
    clear: wa_sflight,
    wa_spfli,
    wa_final.
  endloop.


endform.


*&---------------------------------------------------------------------*
*& Form F_SMARTFORM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_FINAL
*&---------------------------------------------------------------------*

form f_smartform  using    p_gt_final type tt_final.


*Declaro variable local para funcion
  data lv_function type rs38l_fnam.

  data: v_name    type s_carrname,
       wa_carrid  type ty_final.

  read table gt_final into wa_carrid index 1.

  if sy-subrc is initial.
    select single carrname
    from scarr
    into v_name
    where carrid = wa_carrid-carrid.

    if sy-subrc is initial.

      call function 'SSF_FUNCTION_MODULE_NAME'
        exporting
          formname           = 'ZLLOVERAS'
        importing
          fm_name            = lv_function
        exceptions
          no_form            = 1
          no_function_module = 2
          others             = 3.
      if sy-subrc <> 0.
* Implement suitable error handling here
      else.
        call function lv_function
          exporting
            v_carrid         = wa_carrid-carrid
            v_carrname       = v_name
            v_alumno         = 'Luz Lloveras'
          tables
            gt_final         = gt_final
          exceptions
            formatting_error = 1
            internal_error   = 2
            send_error       = 3
            user_canceled    = 4
            others           = 5.
        if sy-subrc <> 0.
        endif.
      endif.
    endif.
  endif.




endform.