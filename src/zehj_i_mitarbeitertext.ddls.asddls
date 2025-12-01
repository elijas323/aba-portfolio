@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View MitarbeiterText'

define view entity ZEHJ_I_MitarbeiterText as select from zehj_mitarbeiter
{
    key mitarbeiter_uuid,
    vorname,
    nachname,
    
    concat_with_space(vorname, nachname, 1) as Name
}
