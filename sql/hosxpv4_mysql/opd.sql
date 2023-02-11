SELECT
	(
		SELECT
			hospitalcode
		FROM
			opdconfig
		LIMIT 1
	) AS HOSPCODE,
	o.hn AS HN,
	o.vn AS SEQ,
	o.main_dep AS CLINIC,
	DATE_FORMAT(o.vstdate, '%Y%m%d') AS DATE_SERV,
	DATE_FORMAT(o.vsttime, '%H%i%s') AS TIME_SERV,
	os.cc AS CHIEFCOMP,
	os.temperature AS BTEMP,
	os.bps AS SBP,
	os.bpd AS DBP,
	os.pulse AS PR,
	os.rr AS RR,
	o.ovstist AS TYPEIN,
	o.ovstost AS TYPEOUT,
	o.pttype AS INS_TYPE,
	o.pttypeno AS INS_NUMBER,
	o.hospmain AS INS_HOSPMAIN,
	o.hospsub AS INS_HOSPSUB,
	o.diag_text AS DIAG_TEXT,
	date_format(now(), '%Y%m%d%H%i%s') as D_UPDATE
FROM
	ovst AS o
INNER JOIN opdscreen as os on
	os.vn = o.vn
WHERE
	o.vstdate BETWEEN $1 AND $2
	AND EXISTS (
		SELECT
					vn
		FROM
					ovstdiag od
		WHERE
					od.vn = o.vn
	);
