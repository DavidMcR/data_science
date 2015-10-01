set heading off
  set arraysize 1
  set newpage 0
  set pages 0
  set feedback off
  set echo off
  set verify off
spool 'c:\Code\List.csv'
select  o.id ||','|| o.marketid  ||','|| c.lineid ||','|| o.markettypeid from markets m  , outcomes o, currentprices c where  o.marketid=m.id and o.id=c.outcomeid and o.markettypeid !='28' and c.lineid ='2'  and m.id in 
(select distinct m2.id from 
(select m.id from outcomes o join markets m ON (o.marketid = m.id ) where o.marketid IN 
(select distinct id from markets where statusid = 
     (select id from status where description = 'Open')
    )) m2 join
(select m1.id from markets m1, marketlineconfig ml where m1.id=ml.marketid and ml.allowsinglebetsyn = 1) m3
on m2.id=m3.id 
join (select marketid from outcomes where id in (SELECT OUTCOMEID FROM PRICES WHERE DECIMALPRICE > 1) ) m4 on m3.id=m4.marketid);
spool off
/*THIS VERSION HAS AN ADDED LINE FOR PUBLISHEDDYN
last clause pulls out marketid not outcomesid*/