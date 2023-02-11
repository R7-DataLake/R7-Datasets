SELECT 
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  lh.hn AS HN,
  lh.vn AS SEQ,
  o.an AS AN,
  lo.lab_items_code AS LABTEST,
  lo.lab_order_result AS LABRESULT,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM
  lab_order AS lo
INNER JOIN lab_head AS lh ON
  lh.lab_order_number = lo.lab_order_number
INNER JOIN ovst AS o ON
  o.vn = lh.vn
  AND o.vstdate BETWEEN $1 AND $2
  AND LENGTH(TRIM(lo.lab_order_result)) > 0;
