select
	(
		select
			hospitalcode
		from
			opdconfig
		limit 1
	) as HOSPCODE,
	p.hn as HN,
	p.cid as CID,
	p.pname as TITLE,
	p.fname as FNAME,
	p.lname as LNAME,
	date_format(p.birthday, '%Y%m%d') as BIRTH,
	p.SEX,
	p.marrystatus as MARRIAGE,
	p.OCCUPATION,
	p.nationality as NATION,
	'1' as IDTYPE,
	p.chwpart as CHANGWAT,
	p.amppart as AMPHUR,
	p.tmbpart as TAMBOL,
	p.type_area as TYPEAREA,
	date_format(now(), '%Y%m%d%H%i%s') as DUPDATE
from
	patient as p
where
	EXISTS (
		select
			hn
		from
			ovst as o
		where
			o.hn = p.hn
			and o.vstdate between $1 and $2
			and EXISTS (
				select
					vn
				from
					ovstdiag od
				where
					od.vn = o.vn
			)
	);
