
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projektion View Mitarbeiter_M'

define root view entity zehj_c_mitarbeiter_m 
provider contract transactional_query
as projection on ZEHJ_R_Mitarbeiter
{
    key MitarbeiterUuid,
    Mitarbeiternummer,
    Vorname,
    Nachname,
    Eintrittsdatum,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    ConsumedVacationDays,
    PlannedVacationDays,
    AvailableVacationDays,
    MitarbeiterName,
    
    _Urlaubsantrags : redirected to composition child zehj_c_antrag_m
}
