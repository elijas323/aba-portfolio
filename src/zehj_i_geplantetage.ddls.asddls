
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Werthilfe bei geplanten Tagen'

define view entity zehj_I_GeplanteTage as select from zehj_urlantrag
{
    antragssteller as Mitarbeiter,
sum( 
case when startdatum > $session.system_date
then urlaubstage
else 0
end) 
as geplanteTage
}
where status <> 'A'
group by
antragssteller;
