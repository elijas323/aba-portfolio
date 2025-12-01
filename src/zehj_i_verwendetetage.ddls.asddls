
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Werthilfe für verwendete Tage'

define view entity zehj_I_verwendeteTage as select from zehj_urlantrag
{
     antragssteller as Mitarbeiter,
     sum(
        case when enddatum > $session.user_date and startdatum < $session.user_date
          then
           dats_days_between(startdatum, enddatum) 
          when enddatum< $session.user_date and startdatum < $session.user_date
          then
            urlaubstage
           else 0
        end)       
 as verwendeteTage
}
where status = 'G'
group by
antragssteller;
