-- 截止到最后一天，用户对商品进行过访问的次数、购买的次数、收藏的次数、购物车的次数
-- f3_1, f3_2, f3_3, f3_4
drop table if exists online_train_feature_ui_behavior_count;
create table online_train_feature_ui_behavior_count
    as select a.user_id, a.item_id, 
			  case when b.f3_1 is null then 0 else b.f3_1 end as f3_1,
			  case when c.f3_2 is null then 0 else c.f3_2 end as f3_2,
			  case when d.f3_3 is null then 0 else d.f3_3 end as f3_3,
			  case when e.f3_4 is null then 0 else e.f3_4 end as f3_4
    from 
	(
	select user_id, item_id
	from online_raw_train_set
	group by user_id, item_id
	) a
 -- ui

	left outer join
    (
    select user_id, item_id, count(*) as f3_1
    from online_raw_train_set
    where behavior_type=1
    group by user_id, item_id
    ) b
	on a.user_id=b.user_id and a.item_id=b.item_id
 -- ui + f1
	
	left outer join
    (
    select user_id, item_id, count(*) as f3_2
    from online_raw_train_set
    where behavior_type=2
    group by user_id, item_id
    ) c
    on a.user_id=c.user_id and a.item_id=c.item_id
 -- ui + f1 + f2
       
    left outer join
    (
    select user_id, item_id, count(*) as f3_3
    from online_raw_train_set
    where behavior_type=3
    group by user_id, item_id
	) d
	on a.user_id=d.user_id and a.item_id=d.item_id
 -- ui + f1 + f2 + f3

	left outer join 
    (
    select user_id, item_id, count(*) as f3_4
    from online_raw_train_set
    where behavior_type=4
    group by user_id, item_id
	) e
	on a.user_id=e.user_id and a.item_id=e.item_id
-- ui + f1 + f2 + f3 + f4
;
