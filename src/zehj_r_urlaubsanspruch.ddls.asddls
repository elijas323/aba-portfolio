@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Urlaubsanspruch'
define view entity ZEHJ_R_Urlaubsanspruch as select from zehj_urlansp
  association to parent ZEHJ_R_Mitarbeiter as _Mitarbeiter on $projection.Mitarbeiter = _Mitarbeiter.MitarbeiterUuid
{
 key urlaubsanpruch_id  as AnspruchUuid,
      mitarbeiter   as Mitarbeiter,
      jahr            as Jahr,
      urlaubstage     as Urlaubstage,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      
      
      _Mitarbeiter
}
