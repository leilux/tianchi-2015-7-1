-- 线上集有 85274 条记录 169320
drop table if exists tianchi_mobile_recommendation_predict;
create table tianchi_mobile_recommendation_predict
    as select user_id, item_id 
    from
    (
        select user_id, item_id, prediction_score
        from online_f18_predict_gbdt_300  -- gai
        order by prediction_score asc
        limit 270912 -- 85274*1.7        -- gai
    ) tb1
;


-- drop table if exists ttmp_concat_ui;
-- create table ttmp_concat_ui
--     as select user_id, item_id, concat(user_id, item_id) as ui, prediction_score
--     from online_f73_predict_gbdt_400_002_u10  -- gai
--     order by prediction_score asc
--     limit 253980 
-- ;

-- drop table if exists tmp_top_recom;
-- create table tmp_top_recom
--     as select u1.user_id, u1.item_id 
--     from
--     (
--         select user_id, item_id, prediction_score
--         from online_f18_predict_gbdt_350_008  -- gai
--         order by prediction_score asc
--         limit 259453         -- gai
--     ) u1
-- ;

-- drop table if exists tianchi_mobile_recommendation_predict;
-- create table tianchi_mobile_recommendation_predict 
--     as select a.user_id as user_id, a.item_id as item_id
--     from 
--         tmp_top_recom a
--         left outer join
--         ttmp_concat_ui b
--         on a.user_id=b.user_id and a.item_id=b.item_id
--     where ui is null
-- ;
    
--     where concat(tmp_top_recom.user_id, tmp_top_recom.item_id) not in (
--         select ui from ttmp_concat_ui where ttmp_concat_ui.user_id=tmp_top_recom.user_id limit 1000
--     )
-- ;
