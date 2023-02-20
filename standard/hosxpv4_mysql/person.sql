SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  p.fname, p.lname, p.hn, p.cid, p.sex, p.birthday, p.citizenship, p.amppart, p.chwpart, p.occupation, p.firstday
FROM
  patient AS p
WHERE
  EXISTS (
    SELECT
      hn
    FROM
      ovst AS o
    WHERE
      o.hn = p.hn
      AND o.vstdate BETWEEN '#{start_date}' AND '#{end_date}'
      AND 
      EXISTS (
        SELECT
          hn
        FROM
          ovstdiag od
        WHERE
          od.vn = o.vn
      )
  )
  OR EXISTS (
    SELECT
      i.hn
    FROM
      ipt AS i
    WHERE
      i.hn = p.hn
      AND i.dchdate BETWEEN '#{start_date}' AND '#{end_date}'
  )
  GROUP BY p.hn, p.cid;
