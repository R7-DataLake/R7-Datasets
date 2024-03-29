SELECT 
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) as 'HOSPCODE',
  lh.hn as 'HN',
  lh.vn as 'SEQ',
  o.an as 'AN',
  lo.lab_items_code as 'LABTEST',
  lo.lab_order_result as 'LABRESULT',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM
  lab_order as lo
INNER JOIN lab_head as lh ON
  lh.lab_order_number = lo.lab_order_number
INNER JOIN ovst as o ON
  o.vn = lh.vn
  AND o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
  AND LENGTH(TRIM(lo.lab_order_result)) > 0
  AND o.an is null
GROUP BY lh.hn, lh.vn, lo.lab_items_code;
