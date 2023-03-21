SELECT
  o.hospcode as 'HOSPCODE',
  o.hn as 'HN',
  o.seq as 'SEQ',
  o.clinic as 'CLINIC',
  DATE_FORMAT(o.date_serv, '%Y%m%d') as 'DATE_SERV',
  DATE_FORMAT(o.time_serv, '%H%i%s') as 'TIME_SERV',
  o.chiefcomp as 'CHIEFCOMP',
  o.btemp as 'BTEMP',
  o.sbp as 'SBP',
  o.dbp as 'DBP',
  o.pr as 'PR',
  o.rr as 'RR',
  o.height as 'HEIGHT',
  o.weight as 'WEIGHT',
  o.typein as 'TYPEIN',
  o.typeout as 'TYPEOUT',
  o.ins_type as 'INS_TYPE',
  o.ins_number as 'INS_NUMBER',
  o.ins_hospmain as 'INS_HOSPMAIN',
  o.ins_hospsub as 'INS_HOSPSUB',
  o.diag_text as 'DIAG_TEXT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  r7platform_opd as o
WHERE
  o.date_serv BETWEEN '#{start_date}' AND '#{end_date}'
  AND EXISTS (
    SELECT
      odx.seq
    FROM
      r7platform_opdx as odx
    WHERE
      odx.seq = o.seq
  )
GROUP BY o.hn, o.date_serv;
