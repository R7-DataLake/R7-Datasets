
select
	(
		select
			hospitalcode
		from
			opdconfig
		limit 1
	) as hospcode,
	p.hn,
	p.cid,
	p.pname as title,
	p.fname,
	p.lname,
	date_format(p.birthday, '%Y%m%d') as birth,
	p.sex,
	p.marrystatus as marriage,
	p.occupation,
	p.nationality as nation,
	'1' as idtype,
	p.chwpart as changwat,
	p.amppart as amphur,
	p.tmbpart as tambol,
	p.type_area as typearea,
	date_format(now(), '%Y%m%d%H%i%s') as dUpdate
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
