select count(*)
from
(
    select user_id, item_id, prediction_score
    from online_f18_predict_gbdt_350_008  -- gai
    order by prediction_score asc
    limit 137800 -- 85274*1.5        -- gai
) u1

join
(
    select user_id, item_id, prediction_score
    from online_f18_predict_gbdt_300  -- gai
    order by prediction_score asc
    limit 137800 -- 85274*1.5        -- gai
) u2
on u1.user_id=u2.user_id and u1.item_id=u2.item_id
;

-- online_f18_predict_gbdt_350_008 ∩ online_f18_predict_gbdt_300
-- 127911 125946 1965
-- 132174 130485 1689
-- 137000 135461 1539
-- 137800 136344 1456
-- 138000 136507 1493
-- 139000 137603 1397
