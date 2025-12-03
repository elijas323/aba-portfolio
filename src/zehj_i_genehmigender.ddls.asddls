@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Genehmigender'
define view entity ZEHJ_I_Genehmigender as select from zehj_mitarbeiter
{
     @EndUserText: { label: 'Mitarbeiter Uuid', quickInfo: 'Mitarbeiter Uuid' }
  key mitarbeiter_uuid                                        as MitarbeiterUuid,
  
      @EndUserText: { label: 'Mitarbeiternummer', quickInfo: 'Mitarbeiternummer' }
      mitarbeiternummer as Mitarbeiternummer,
      
      @EndUserText: { label: 'Vorname', quickInfo: 'Vorname' }
      vorname                                         as Vorname,
      
      @EndUserText: { label: 'Nachname', quickInfo: 'Nachname' }
      nachname                                          as NachName
}
