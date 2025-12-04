@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@EndUserText.label: 'Projektion View Antag_M'
@Metadata.allowExtensions: true

define view entity zehj_c_antrag_m as projection on ZEHJ_R_Urlaubsantrag
{
    key AntragUuid,
    Antragsteller,
    Genehmigender,
    Startdatum,
    Enddatum,
    @ObjectModel.text.element:['StatusText']
    Status,
    StatusText,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Kommentar,
    Urlaubstage,
    
    
    
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    
    StatusCriticality,
    @Consumption.valueHelpDefinition: [{entity: {name: 'ZEHJ_I_MitarbeiterText', element: 'Name'} }]
    AntragstellerName,
    GenehmigenderName,
    
    
    _Antragsteller: redirected to parent zehj_c_mitarbeiter_m,
    _Genehmigender: redirected to zehj_c_mitarbeiter_m
}
