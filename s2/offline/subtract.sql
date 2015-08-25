--     select count(*) as numOfs
--     from
--     (
--         select user_id, item_id, prediction_score
--         from offline_f18_predict_gbdt_300  -- gai
--         order by prediction_score asc
--         limit 259453         -- gai
--     ) u1
--     where concat(u1.user_id, u1.item_id) not in (
--         select concat(u2.user_id, u2.item_id) 
--         from
--         (
--             select user_id, item_id, prediction_score
--             from offline_f73_predict_gbdt_400_002_u10  -- gai
--             order by prediction_score asc
--             limit 253980         -- gai
--         ) u2
--     )
-- ;

-- drop table if exists off_ttmp_concat_ui;
-- create table off_ttmp_concat_ui
--     as select user_id, item_id, concat(user_id, item_id) as ui, prediction_score
--     from offline_f73_predict_gbdt_400_002_u10  -- gai
--     order by prediction_score asc
--     limit 253980 
-- ;
    
-- drop table if exists off_tmp_top_recom;
-- create table off_tmp_top_recom
--     as select u1.user_id, u1.item_id 
--     from
--     (
--         select user_id, item_id, prediction_score
--         from offline_f18_predict_gbdt_300  -- gai
--         order by prediction_score asc
--         limit 259453         -- gai
--     ) u1
-- ;

select count(*) as hits
from
    (
    select a.user_id, a.item_id 
    from         
        off_tmp_top_recom a
        left outer join
        off_ttmp_concat_ui b
        on a.user_id=b.user_id and a.item_id=b.item_id
    where ui is null
    ) u1
    
    join
    offline_validate_set b
    on u1.user_id=b.user_id and u1.item_id=b.item_id
;
