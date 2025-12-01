@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Urlaubsanspruch'
@Metadata.allowExtensions: true
define view entity ZEHJ_C_Urlaubsanspruch as projection on ZEHJ_R_Urlaubsanspruch
{
    key AnspruchUuid,
      Mitarbeiter,  
      Jahr,
      Urlaubstage,

      /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /* Associations */
      _Mitarbeiter : redirected to parent ZEHJ_C_Mitarbeiter 
}
