drop table if exists offline_train_set_u10_order;
create table offline_train_set_u10_order
	as select *
	from offline_train_set_u10
	order by user_id
	limit 5400747
	;
	-- 4907980 492767
