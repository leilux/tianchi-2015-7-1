-- |-----------|--17---|--18---|
-- |<- train ->|-label-|
-- |<-      test     ->|-validate-|

-- ##标注集 label_set
drop table if exists offline_raw_label_set;
create table offline_raw_label_set
    as select user_id, item_id, 1 as buy
    from tianchi_lbs.tianchi_mobile_recommend_train_user
    where time>="2014-12-17 00" and time<"2014-12-18 00" and behavior_type=4
    group by user_id, item_id
;
