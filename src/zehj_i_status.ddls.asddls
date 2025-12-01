@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Status'
define view entity Zehj_I_status as select from zehj_urlantrag
{
    key urlaubsantrag_id,
    status,
    
    case
    when status = 'B' then 'Beantragt'
    when status = 'A' then 'Abgelehnt'
    when status = 'G' then 'Genehmigt'
    else ''
    end as StatusText
}
