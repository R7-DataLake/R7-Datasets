SELECT
  c.hospcode as 'HOSPCODE',
  c.hn as 'HN',
  DATE_FORMAT(c.date_diag, "%Y%m%d") as 'DATE_DIAG',
  c.chronic as 'CHRONIC',
  c.hosp_dx as 'HOSP_DX',
  c.hosp_rx as 'HOSP_RX',
  DATE_FORMAT(c.date_disch, "%Y%m%d") as 'DATE_DISCH',
  DATE_FORMAT(now(), '%Y%m%d%H%i%s') as 'D_UPDATE'
FROM r7platform_chronic as c
GROUP BY c.hn, c.chronic;
