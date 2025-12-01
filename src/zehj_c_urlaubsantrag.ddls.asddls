@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Urlaubsantrag'
@Metadata.allowExtensions: true
define view entity ZEHJ_C_Urlaubsantrag as projection on ZEHJ_R_Urlaubsantrag
{
     key AntragUuid,
      Antragsteller,
      Genehmigender,
      Startdatum,
      Enddatum,
      Urlaubstage,
      Kommentar,
      Status,

      /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

     

      /* Associations */
      _Genehmigender : redirected to ZEHJ_C_Mitarbeiter,
      _Antragsteller : redirected to parent ZEHJ_C_Mitarbeiter
}
