-- 将正样本与采样后的负样本合并

drop table if exists offline_train_set_undersample_14;
create table offline_train_set_undersample_14
	as select *
	from
	(
	select * from offline_train_set where buy=1
	union all
	select * from offline_train_set_buy_0_sample_14
	) t
;
