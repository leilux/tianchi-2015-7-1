-- U features
-- 不在初次访问品牌时进行购买的量 f2_5
-- 活跃天数 f2_6
-- 购买天数 f2_7

drop table if exists offline_test_feature_u_base;
create table offline_test_feature_u_base
	as select a.user_id, a.item_id,
			  case when b.tmp_f2_5 is null then a.f2_4 else a.f2_4-b.tmp_f2_5 end as f2_5,
			  case when c.f2_6 is null then 0 else c.f2_6 end as f2_6,
			  case when d.f2_7 is null then 0 else d.f2_7 end as f2_7
	from
	(
	select user_id, item_id, f2_4
	from offline_test_feature_u_behavior_count
	group by user_id, item_id, f2_4
	) a
 -- ui

	left outer join
	(
	select ofl.user_id, count(*) as tmp_f2_5  -- 不在初次访问品牌时进行购买的量 f2_5
	from 
	    offline_raw_test_set ofl
	    
	    join
	    ( -- 过滤出在初次访问的购买
	    select user_id, item_id, substr(min(time), 6, 5) as first_time_visit
	    from offline_raw_test_set
	    group by user_id, item_id
	    ) flt
	    on 
	      ofl.user_id=flt.user_id 
	      and ofl.item_id=flt.item_id
	      and flt.first_time_visit=substr(ofl.time, 6, 5)
	where ofl.behavior_type=4
	group by ofl.user_id
	) b
	on a.user_id=b.user_id
 -- ui + f2_5

	left outer join
	(
	select user_id, count(distinct substr(time,6,5)) as f2_6
	from offline_raw_test_set
	group by user_id
	) c
	on a.user_id=c.user_id
 -- ui + f2_5 + f2_6

	left outer join
	(
	select user_id, count(distinct substr(time,6,5)) as f2_7
	from offline_raw_test_set
	where behavior_type=4
	group by user_id
	) d
	on a.user_id=d.user_id
 -- ui + f2_5 + f2_6 + f2_7
 ;
