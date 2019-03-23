select osr.*,vv.CURRENCY from CUSTOM_ONL_SAV_ACCT_TYPES osr
left join (
select
       ACCOUNT_TYPE_ID
     , (
                select
                         listagg(column_value, ',') within group (order by column_value desc)
                from
                         table(CURRENCY)
       )
       as CURRENCY
from
       (
                select
                         ACCOUNT_TYPE_ID
                       , collect(distinct CURRENCY) as CURRENCY
                from
                         (
                                   select
                                             osr.*
                                           , savRate.CURRENCY
                                   from
                                             CUSTOM_ONL_SAV_ACCT_TYPES osr
                                             left join
                                                       CUSTOM_ONLINE_SAV_RATES savRate
                                                       on
                                                                 savRate.ACCOUNT_TYPE_ID = osr.ACCOUNT_TYPE_ID
                                   ORDER BY
                                             osr.ACCOUNT_TYPE_ID
                         )
                group by
                         ACCOUNT_TYPE_ID
       )
       ) vv
       on vv.ACCOUNT_TYPE_ID = osr.ACCOUNT_TYPE_ID
;

select DISTINCT CURRENCY from CUSTOM_ONLINE_SAV_RATES where ACCOUNT_TYPE_ID = 2;