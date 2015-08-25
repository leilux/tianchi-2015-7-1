-- |-----------|--17---|--18---|
-- |<- train ->|-label-|
-- |<-      test     ->|-validate-|

-- ## 训练集 train_set
-- 1. 过滤出 time<分割点的所有记录, 分割点为 2014-12-17 00
-- 2. 存入offline_raw_train_set表中
drop table if exists offline_raw_train_set;
create table offline_raw_train_set
    as select user_id, item_id, behavior_type, user_geohash, item_category, time
    from tianchi_lbs.tianchi_mobile_recommend_train_user
    where time<"2014-12-17 00"
;
