@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Mitarbeiter'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZEHJ_C_Mitarbeiter
provider contract transactional_query
 as projection on ZEHJ_R_Mitarbeiter
{
//@Consumption.valueHelpDefinition: [{entity: {name: 'ZEHJ_I_MitarbeiterText', element: 'MitarbeiterUuid'}}]
    key MitarbeiterUuid,
      Mitarbeiternummer,
      
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Vorname,
      
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Nachname,
      Eintrittsdatum,
      MitarbeiterName,
      AvailableVacationDays,
      PlannedVacationDays,
      ConsumedVacationDays,
      /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      _Urlaubsanspruchs : redirected to composition child ZEHJ_C_Urlaubsanspruch,
      _Urlaubsantrags : redirected to composition child ZEHJ_C_Urlaubsantrag
}
