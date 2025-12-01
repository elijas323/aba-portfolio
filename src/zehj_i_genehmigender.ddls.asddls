@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Genehmigender'
define view entity ZEHJ_I_Genehmigender as select from zehj_mitarbeiter
{
     key mitarbeiter_uuid as MitarbeiterUuid ,
     mitarbeiternummer as Mitarbeiternummer,
     vorname as Vorname,
     nachname as Nachname,
     eintrittsdatum as Eintrittsdatum
}
