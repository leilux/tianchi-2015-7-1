-- |-----------|--17---|--18---|
-- |<- train ->|-label-|
-- |<-      test     ->|-validate-|

-- UI features
-- 用户最后一次对商品访问（收藏、购物车、购买）距离分隔日期（如62）的时间间隔，
-- 如果没有发生动作，默认间隔60天 
-- f3_5, f3_6, f3_7, f3_8

-- seperator 2014-12-18 00
drop table if exists offline_test_feature_ui_behavior_lasttime_delta;
create table offline_test_feature_ui_behavior_lasttime_delta
	as select a.user_id, a.item_id,
		 	  case when b.f3_5 is null then 60 else b.f3_5 end as f3_5,
		 	  case when c.f3_6 is null then 60 else c.f3_6 end as f3_6,
		 	  case when d.f3_7 is null then 60 else d.f3_7 end as f3_7,
		 	  case when e.f3_8 is null then 60 else e.f3_8 end as f3_8
	from
	(
	select user_id, item_id
	from offline_raw_test_sub_set
	group by user_id, item_id
	) a
 -- ui
 	
	left outer join
	(
	select user_id, item_id, datediff("2014-12-18 00:00:00", to_date(max(time),"yyyy-mm-dd hh"), "dd") as f3_5
	from offline_raw_test_sub_set
	where behavior_type=1
	group by user_id, item_id
	) b
	on a.user_id=b.user_id and a.item_id=b.item_id
-- ui + f5

	left outer join
	(
	select user_id, item_id, datediff("2014-12-18 00:00:00", to_date(max(time),"yyyy-mm-dd hh"), "dd") as f3_6
	from offline_raw_test_sub_set
	where behavior_type=2
	group by user_id, item_id
	) c
	on a.user_id=c.user_id and a.item_id=c.item_id
-- ui + f5 + f6

	left outer join
	(
	select user_id, item_id, datediff("2014-12-18 00:00:00", to_date(max(time),"yyyy-mm-dd hh"), "dd") as f3_7
	from offline_raw_test_sub_set
	where behavior_type=3
	group by user_id, item_id
	) d
	on a.user_id=d.user_id and a.item_id=d.item_id
-- ui + f5 + f6 + f7

	left outer join
	(
	select user_id, item_id, datediff("2014-12-18 00:00:00", to_date(max(time),"yyyy-mm-dd hh"), "dd") as f3_8
	from offline_raw_test_sub_set
	where behavior_type=4
	group by user_id, item_id
	) e
	on a.user_id=e.user_id and a.item_id=e.item_id
-- ui + f5 + f6 + f7 + f8
;
