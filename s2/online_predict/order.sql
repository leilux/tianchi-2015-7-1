drop table if exists online_train_set_u10_order;
create table online_train_set_u10_order
	as select *
	from online_train_set_u10
	order by user_id
	limit 5398778
	;
	-- 490798 4907980
