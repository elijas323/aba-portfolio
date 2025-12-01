
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Available Vacation Days'
define view entity zehj_i_verfuegbaretage as select from zehj_urlansp
    association [1..1] to zehj_I_GeplanteTage as _geplanteTagevd on $projection.Mitarbeiter = _geplanteTagevd.Mitarbeiter
    association [1..1] to zehj_I_verwendeteTage as _verwendeteTagevd on $projection.Mitarbeiter = _verwendeteTagevd.Mitarbeiter
    

{
  key mitarbeiter as Mitarbeiter,
  sum(urlaubstage) - coalesce(_verwendeteTagevd.verwendeteTage, 0) - coalesce(_geplanteTagevd.geplanteTage, 0) as AvailableVacationDays
}

group by
mitarbeiter, 
urlaubstage,
_verwendeteTagevd.verwendeteTage,
_geplanteTagevd.geplanteTage;
