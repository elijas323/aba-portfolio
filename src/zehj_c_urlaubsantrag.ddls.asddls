@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Urlaubsantrag'
@Metadata.allowExtensions: true
define view entity ZEHJ_C_Urlaubsantrag as projection on ZEHJ_R_Urlaubsantrag
{
     key AntragUuid,
      Antragsteller,
      AntragstellerName,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEHJ_I_GENEHMIGENDER', element: 'MitarbeiterUuid' } }]
      Genehmigender,
      GenehmigenderName,
      Startdatum,
      Enddatum,
      Urlaubstage,
      Kommentar,
      @ObjectModel.text.element: [ 'StatusText' ]
      Status,
      StatusText,

      /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

     

      /* Associations */
      _Genehmigender : redirected to ZEHJ_C_Mitarbeiter,
      _Antragsteller : redirected to parent ZEHJ_C_Mitarbeiter
}
