-- 线上集有 85274 条记录
drop table if exists tianchi_mobile_recommendation_predict;
create table tianchi_mobile_recommendation_predict 
    as select user_id,item_id 
    from
    (
        select user_id, item_id, prediction_score 
        from t_test_result  -- gai
        order by prediction_score asc 
        limit 85274         -- gai
    ) tb1
