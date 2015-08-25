-- |-----------|--17---|--18---|
-- |<- train ->|-label-|
-- |<-      test     ->|-validate-|

drop table if exists offline_validate_set;
create table offline_validate_set
    as select a.user_id, a.item_id
    from 
        (
        select user_id, item_id
        from tianchi_lbs.tianchi_mobile_recommend_train_user
        where time>="2014-12-18 00" and behavior_type=4
        group by user_id, item_id
        ) a
        
        join
        (
        select distinct item_id
        from
            tianchi_lbs.tianchi_mobile_recommend_train_item
        ) b
        on a.item_id = b.item_id
;
