CLASS lhc_Mitarbeiter DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

     METHODS get_global_authorization FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorization FOR ZEHJ_R_MITARBEITER RESULT result.
      METHODS get_global_authorization_i FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorization FOR ZEHJ_R_Urlaubsantrag RESULT result.

    METHODS ApproveVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION ZEHJ_R_Urlaubsantrag~ApproveVacationRequest RESULT result.

    METHODS DeclineVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION ZEHJ_R_Urlaubsantrag~DeclineVacationRequest RESULT result.

    METHODS DetermineStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZEHJ_R_Urlaubsantrag~DetermineStatus.

    METHODS DetermineVacationDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZEHJ_R_Urlaubsantrag~DetermineVacationDays.

    METHODS ValidateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZEHJ_R_Urlaubsantrag~ValidateDates.

    METHODS ValidateVacDays FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZEHJ_R_Urlaubsantrag~ValidateVacDays.

ENDCLASS.

CLASS lhc_Mitarbeiter IMPLEMENTATION.

  METHOD get_global_authorization.
  ENDMETHOD.
  METHOD get_global_authorization_i.
  Endmethod.
  METHOD ApproveVacationRequest.
    DATA message TYPE REF TO zehj_cm_urlaubsantrag.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
         FIELDS ( Status Kommentar )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Process Inquiry
    LOOP AT vacrequests REFERENCE INTO DATA(vacrequest).

      " Validate State and Create Error Message
      IF vacrequest->Status = 'A'.
        message = NEW zehj_cm_urlaubsantrag( textid   = zehj_cm_urlaubsantrag=>vacrequest_already_declined
                                          severity = if_abap_behv_message=>severity-error
                                          Comment  = vacrequest->Kommentar ).
        APPEND VALUE #( %tky = vacrequest->%tky
                        %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-urlaubsantrag.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF vacrequest->Status = 'G'.
        message = NEW zehj_cm_urlaubsantrag( textid   = zehj_cm_urlaubsantrag=>vacrequest_already_approved
                                          severity = if_abap_behv_message=>severity-error
                                          comment  = vacrequest->Kommentar ).
        APPEND VALUE #( %tky = vacrequest->%tky
                        %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-urlaubsantrag.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to G und Create Success Message
      vacrequest->Status = 'G'.
      message = NEW zehj_cm_urlaubsantrag(
           textid = zehj_cm_urlaubsantrag=>vacrequest_approved
          severity = if_abap_behv_message=>severity-success
         comment = vacrequest->Kommentar
    ).
      APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-urlaubsantrag.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR lr IN vacrequests
                         ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN vacrequests
                      ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.

  METHOD DeclineVacationRequest.
    DATA message TYPE REF TO zehj_cm_urlaubsantrag.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
        FIELDS ( Status Kommentar )
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacrequests).

    " Process Inquiry
    LOOP AT vacrequests REFERENCE INTO DATA(vacrequest).

      " Validate State and Create Error Message
      IF vacrequest->Status = 'A'.
        message = NEW zehj_cm_urlaubsantrag(
            textid = zehj_cm_urlaubsantrag=>vacrequest_already_declined
             severity = if_abap_behv_message=>severity-error
             comment  = vacrequest->Kommentar
         ).
        APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-urlaubsantrag.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF vacrequest->Status = 'G'.
        message = NEW zehj_cm_urlaubsantrag(
            textid = zehj_cm_urlaubsantrag=>vacrequest_already_approved
            severity = if_abap_behv_message=>severity-error
            comment  = vacrequest->Kommentar
        ).
        APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-urlaubsantrag.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to A und Create Success Message
      vacrequest->Status = 'A'.
      message = NEW zehj_cm_urlaubsantrag(
         textid = zehj_cm_urlaubsantrag=>vacrequest_decline
         severity = if_abap_behv_message=>severity-success
         comment = vacrequest->Kommentar
      ).
      APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-urlaubsantrag.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR lr IN vacrequests ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN vacrequests ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.

  METHOD DetermineStatus.
    " Read Inquiries
    READ ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
         FIELDS ( Status )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Modify Inquiries
    MODIFY ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR vr IN vacrequests
                         ( %tky   = vr-%tky
                           Status = 'B' ) ).
  ENDMETHOD.

  METHOD DetermineVacationDays.
    " Read Inquiries
    READ ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
         FIELDS ( Startdatum Enddatum )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    LOOP AT vacrequests INTO DATA(vacrequest).

      DATA(startdatum) = vacrequest-Startdatum.
      startdatum = startdatum - 1.
      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = startdatum iv_end = vacrequest-Enddatum ).
        CATCH cx_fhc_runtime.
      ENDTRY.

      MODIFY ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
             UPDATE FIELDS ( Urlaubstage )
             WITH VALUE #( FOR vr IN vacrequests
                           ( %tky   = vr-%tky
                             Urlaubstage = working_days ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateDates.
    DATA message TYPE REF TO zehj_cm_urlaubsantrag.
    DATA(lo_context_info) = NEW cl_abap_context_info( ).
    DATA(lv_current_date) = lo_context_info->get_system_date( ).

    " Read Travels
    READ ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
         FIELDS ( Startdatum Enddatum )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Process Travels
    LOOP AT vacrequests INTO DATA(vacrequest).
      " Validate Dates and Create Error Message
      IF vacrequest-Enddatum < vacrequest-Startdatum.
        message = NEW zehj_cm_urlaubsantrag( textid = zehj_cm_urlaubsantrag=>vacrequest_endbeforestart
        severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = vacrequest-%tky
                        %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest-%tky ) TO failed-urlaubsantrag.
      ENDIF.

      IF vacrequest-Startdatum < lv_current_date.
        message = NEW zehj_cm_urlaubsantrag( textid = zehj_cm_urlaubsantrag=>vacrequest_startdatepast
        severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = vacrequest-%tky
                        %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest-%tky ) TO failed-urlaubsantrag.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateVacDays.
    DATA message TYPE REF TO zehj_cm_urlaubsantrag.

    " Read Travels
    READ ENTITY IN LOCAL MODE ZEHJ_R_Urlaubsantrag
         FIELDS ( Startdatum Enddatum Antragsteller )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Process Travels
    LOOP AT vacrequests INTO DATA(vacrequest).
      TRY.
          DATA(startdate) = vacrequest-Startdatum.
          startdate -= 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = startdate
                                                                         iv_end   = vacrequest-Enddatum ).
        CATCH cx_fhc_runtime.
      ENDTRY.

      SELECT FROM zehj_r_mitarbeiter
           FIELDS  AvailableVacationDays
           WHERE MitarbeiterUuid = @vacrequest-Antragsteller
           INTO @DATA(availablevacationdays).
      ENDSELECT.

      IF AvailableVacationDays < working_days.
        message = NEW zehj_cm_urlaubsantrag( textid   = zehj_cm_urlaubsantrag=>vacrequest_novacationleft
                                          severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = vacrequest-%tky
                        %msg = message ) TO reported-urlaubsantrag.
        APPEND VALUE #( %tky = vacrequest-%tky ) TO failed-urlaubsantrag.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
