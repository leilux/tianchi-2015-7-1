-- |-----------|--18---|
-- |<- train ->|-label-|
-- |--|16|17|18|--19---|
--    |<- p3 ->|
-- |--|12|13|14|15|16|17|18|--19---|
--    |<-       p7       ->|
-- |<-      test     ->|-validate-|

-- I features
-- 点击量 f1_4_3, f1_4_7
-- 点击人数（周期内经过去重的人数）f1_5_3, f1_5_7
-- 某一周期内多次点击的用户数 f1_6_3, f1_6_7

-- p3 [2014-12-16 00 ~ 2014-12-19 00)
-- p7 [2014-12-12 00 ~ 2014-12-19 00)

drop table if exists online_test_feature_i_click_count;
create table online_test_feature_i_click_count
	as select a.user_id, a.item_id,
			  case when b.f1_4_3 is null then 0 else b.f1_4_3 end as f1_4_3,
			  case when c.f1_4_7 is null then 0 else c.f1_4_7 end as f1_4_7,
			  case when d.f1_5_3 is null then 0 else d.f1_5_3 end as f1_5_3,
			  case when e.f1_5_7 is null then 0 else e.f1_5_7 end as f1_5_7,
			  case when f.f1_6_3 is null then 0 else f.f1_6_3 end as f1_6_3,
			  case when g.f1_6_7 is null then 0 else g.f1_6_7 end as f1_6_7
	from
	(
	select user_id, item_id
	from online_raw_test_set
	group by user_id, item_id
	) a
 -- ui
	
	left outer join
	(
	select item_id, count(*) as f1_4_3
	from online_raw_test_set
	where behavior_type=1 and time>="2014-12-16 00" and time<"2014-12-19 00" -- p3
	group by item_id
	) b
	on a.item_id=b.item_id
 -- ui + f1_1_3

	left outer join
	(
	select item_id, count(*) as f1_4_7
	from online_raw_test_set
	where behavior_type=1 and time>="2014-12-12 00" and time<"2014-12-19 00" -- p7
	group by item_id
	) c
	on a.item_id=c.item_id
 -- ui + f1_1_3 + f1_1_7

	left outer join
	(
	select item_id, count(distinct user_id) as f1_5_3
	from online_raw_test_set
	where behavior_type=1 and time>="2014-12-16 00" and time<"2014-12-19 00" -- p3
	group by item_id
	) d
	on a.item_id=d.item_id
 -- ui + f1_1_3 + f1_1_7 + f1_2_3

	left outer join
	(
	select item_id, count(distinct user_id) as f1_5_7
	from online_raw_test_set
	where behavior_type=1 and time>="2014-12-12 00" and time<"2014-12-19 00" -- p7
	group by item_id
	) e
	on a.item_id=e.item_id
 -- ui + f1_1_3 + f1_1_7 + f1_2_3 + f1_2_7

	left outer join
	(
	select ofl.item_id, count(distinct ofl.user_id) as f1_6_3
	from 
		online_raw_test_set ofl

		join  -- filter duplicated in p3
		(
		select user_id, item_id
		from online_raw_test_set
		where behavior_type=1 and time>="2014-12-16 00" and time<"2014-12-19 00" -- p3
		group by user_id, item_id
		having count(user_id)>1
		) dup_p3 
		on 
			ofl.user_id=dup_p3.user_id 
			and ofl.item_id=dup_p3.item_id

	group by ofl.item_id
	) f
	on a.item_id=f.item_id
 -- ui + f1_1_3 + f1_1_7 + f1_2_3 + f1_2_7 + f1_3_3

	left outer join
	(
	select oflp7.item_id, count(distinct oflp7.user_id) as f1_6_7
	from 
		online_raw_test_set oflp7

		join  -- filter duplicated in p7
		(
		select user_id, item_id
		from online_raw_test_set
		where behavior_type=1 and time>="2014-12-12 00" and time<"2014-12-19 00" -- p7
		group by user_id, item_id
		having count(user_id)>1
		) dup_p7
		on 
			oflp7.user_id=dup_p7.user_id 
			and oflp7.item_id=dup_p7.item_id
	group by oflp7.item_id
	) g
	on a.item_id=g.item_id
 -- ui + f1_1_3 + f1_1_7 + f1_2_3 + f1_2_7 + f1_3_3 + f1_3_7
;
