@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Mitarbeiter'
define root view entity ZEHJ_R_Mitarbeiter
  as select from zehj_mitarbeiter
  composition [0..*] of ZEHJ_R_Urlaubsanspruch as _Urlaubsanspruchs
  composition [0..*] of ZEHJ_R_Urlaubsantrag   as _Urlaubsantrags
  association        to ZEHJ_I_MitarbeiterText        as _mitarbeiterText on $projection.MitarbeiterUuid = _mitarbeiterText.mitarbeiter_uuid
  association [1..1] to zehj_i_verfuegbaretage as _verfuegbareTagevd      on $projection.MitarbeiterUuid = _verfuegbareTagevd.Mitarbeiter
  association [1..1] to zehj_I_GeplanteTage    as _geplanteTagevd         on $projection.MitarbeiterUuid = _geplanteTagevd.Mitarbeiter
  association [1..1] to zehj_I_verwendeteTage  as _verwendeteTagevd       on $projection.MitarbeiterUuid = _verwendeteTagevd.Mitarbeiter
{
      @ObjectModel.text.element: [ 'MitarbeiterName' ]
  key mitarbeiter_uuid                         as MitarbeiterUuid,
      mitarbeiternummer                        as Mitarbeiternummer,
      vorname                                  as Vorname,
      nachname                                 as Nachname,
      eintrittsdatum                           as Eintrittsdatum,




      /* Administrative Data */
      created_by                               as CreatedBy,
      created_at                               as CreatedAt,
      last_changed_by                          as LastChangedBy,
      last_changed_at                          as LastChangedAt,

      // _Urlaubsantrags
      /* Associations */
      _Urlaubsanspruchs,
      _Urlaubsantrags,
      
      _mitarbeiterText.Name                    as MitarbeiterName,
      
      _verwendeteTagevd.verwendeteTage         as ConsumedVacationDays,
      _geplanteTagevd.geplanteTage             as PlannedVacationDays,
      _verfuegbareTagevd.AvailableVacationDays as AvailableVacationDays

}
