-- UI features
-- 用户访问商品的天数 f3_9
-- 用户购买商品的天数 f3_10

drop table if exists offline_train_feature_ui_base;
create table offline_train_feature_ui_base
    as select a.user_id, a.item_id, 
			  case when b.f3_9 is null then 0 else b.f3_9 end as f3_9,
			  case when c.f3_10 is null then 0 else c.f3_10 end as f3_10
	from
	(
	select user_id, item_id
	from offline_raw_train_set
	group by user_id, item_id
	) a
 -- ui
 	
	left outer join
	(
	select user_id, item_id, count(distinct to_date(time,"yyyy-mm-dd")) as f3_9
	from offline_raw_train_set
	group by user_id, item_id
	) b
	on a.user_id=b.user_id and a.item_id=b.item_id
-- ui + f3_9

	left outer join
	(
	select user_id, item_id, count(distinct to_date(time,"yyyy-mm-dd")) as f3_10
	from offline_raw_train_set
	where behavior_type=4
	group by user_id, item_id
	) c
	on a.user_id=c.user_id and a.item_id=c.item_id
-- ui + f3_9 + f3_10
;
