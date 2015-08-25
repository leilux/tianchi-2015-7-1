-- U features
-- 浏览量, 收藏量, 加购物车量, 购买量
-- f2_1, f2_2, f2_3, f2_4

drop table if exists offline_test_feature_u_behavior_count;
create table offline_test_feature_u_behavior_count
	as select a.user_id, a.item_id,
			  case when b.f2_1 is null then 0 else b.f2_1 end as f2_1,
			  case when c.f2_2 is null then 0 else c.f2_2 end as f2_2,
			  case when d.f2_3 is null then 0 else d.f2_3 end as f2_3,
			  case when e.f2_4 is null then 0 else e.f2_4 end as f2_4
	from
	(
	select user_id, item_id
	from offline_raw_test_set
	group by user_id, item_id
	) a
 -- ui

	left outer join
	(
	select user_id, count(*) as f2_1
	from offline_raw_test_set
	where behavior_type=1
	group by user_id
	) b
	on a.user_id=b.user_id
 -- ui + f1

	left outer join
	(
	select user_id, count(*) as f2_2
	from offline_raw_test_set
	where behavior_type=2
	group by user_id
	) c
	on a.user_id=c.user_id
 -- ui + f1 + f2

	left outer join
	(
	select user_id, count(*) as f2_3
	from offline_raw_test_set
	where behavior_type=3
	group by user_id
	) d
	on a.user_id=d.user_id
 -- ui + f1 + f2 + f3

	left outer join
	(
	select user_id, count(*) as f2_4
	from offline_raw_test_set
	where behavior_type=4
	group by user_id
	) e
	on a.user_id=e.user_id
 -- ui + f4
;
