@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View Urlaubsantrag'

define view entity ZEHJ_R_Urlaubsantrag as select from zehj_urlantrag
association to parent ZEHJ_R_Mitarbeiter as _Antragsteller on $projection.Antragsteller = _Antragsteller.MitarbeiterUuid
association to ZEHJ_R_Mitarbeiter as _Genehmigender on $projection.Genehmigender = _Genehmigender.MitarbeiterUuid
//association to ZEHJ_I_Genehmigender as _Genehmigener on $projection.
{
    key urlaubsantrag_id as AntragUuid,
      antragssteller   as Antragsteller,      
     //@Consumption.valueHelpDefinition: [{ entity: { name: 'ZMD_I_EmployeeVH', element: 'EmployeeUuid' } }]
      genehmigender    as Genehmigender,
      startdatum       as Startdatum,
      enddatum         as Enddatum,
      urlaubstage      as Urlaubstage,
      kommentar        as Kommentar,
      //@ObjectModel.text.element: ['StatusText']
      status           as Status,
      /* Administrative Data */
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      
      /* Custom Data */
      //cast(substring(startdatum, 1, 4) as abap.numc(4)) as Urlaubsjahr,
      //concat_with_space(_Genehmiger.Vorname, _Genehmiger.Nachname, 1) as Name_Genehmigender,
      
     /* Transient Data */
      //_Status.StatusText as StatusText,
      
      /* Associations */
      _Antragsteller,
      _Genehmigender
    
}
