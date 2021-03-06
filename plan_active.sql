@inc/input_vars_init
set termout off timing off ver off feed off head off lines 10000000 pagesize 0

define _sqlid=&1
define _plan_vh='&2'
define _fname="&_TEMPDIR\plan_&_sqlid._&_plan_vh..html"
spool &_fname

select
   dbms_xplan.display_plan(
                  table_name   => 'DBA_HIST_SQL_PLAN'
                 ,format       => 'ADVANCED'
                 --,filter_preds => q'[dbid = 3126056015 and sql_id = '&_SQLID' and plan_hash_value=1243306242]'
                 ,filter_preds => q'[dbid = &DB_ID and sql_id = '&_sqlid' and plan_hash_value='&_plan_vh']'
                 ,type         => 'ACTIVE'
                ) plan
from dual;

spool off
host &_START &_fname
undef A_SQLID
@inc/input_vars_undef