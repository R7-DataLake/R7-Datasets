SELECT
  (
    SELECT
      hospitalcode
    FROM
      opdconfig
    LIMIT 1
  ) AS HOSPCODE,
  p.hn AS HN,
  p.cid AS CID,
  p.pname AS TITLE,
  p.fname AS FNAME,
  p.lname AS LNAME,
  DATE_FORMAT(p.birthday, '%Y%m%d') AS BIRTH,
  p.SEX,
  p.marrystatus AS MARRIAGE,
  p.OCCUPATION,
  p.nationality AS NATION,
  '1' AS IDTYPE,
  p.chwpart AS CHANGWAT,
  p.amppart AS AMPHUR,
  p.tmbpart AS TAMBOL,
  p.type_area AS TYPEAREA,
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') AS D_UPDATE
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
      AND o.vstdate BETWEEN $1 AND $2
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
      i.dchdate BETWEEN $3 AND $4
  );
