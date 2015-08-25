-- offline_validate_set有168476条记录
select count(*) as hits,
	   count(*)*2.0/(168476.0+168476) as F1, -- gai
	   count(*)/168476.0 as percision,       -- gai
	   count(*)/168476.0 as recall
from 
(
	select distinct a.user_id, a.item_id
	from 
	(
	select user_id, item_id, prediction_score
    -- from offline_f18_predict_gbdt_300_undersample_14  -- gai
    -- from offline_f18_predict_gbdt_600_undersample_14
    -- from offline_f18_predict_gbdt_300  -- hits:9037
    -- from offline_f18_predict_gbdt_1000_undersample_14
    -- from offline_f18_predict_rf
    -- from offline_f18_predict_gbdt_300_01_c
    -- from offline_f18_predict_gbdt_600_undersample_14
    -- from offline_f73_predict_gbdt_400_002_u10 -- hits:486
    -- from off_predict_gbdt300_002_20_8_9_200_u10 -- hits:579
    from off_predict_gbdt300_002_20_8_9_200_u10  -- hits:459

	order by prediction_score asc
	limit 168476 -- 252714--168476*2                       -- gai
	) a
	
	join
	offline_validate_set b
	on a.user_id=b.user_id and a.item_id=b.item_id
) z

-- F1与推荐条数的关系: offline_f18_predict_gbdt_300
-- scale   hits   F1
-- -------------------
-- 0.7     7137   4.983
-- 1       9037   5.363  +1900
-- 1.5     11588  5.502* +2552
-- 1.6     12020  5.490
-- 2       13447  5.321  +1859

--                     offline_f18_predict_gbdt_400
-- 1       8981   5.330
-- 1.5     11532  5.476  +2551
-- 1.6     11997  5.477*
-- 2       13410  5.306  +1878

-- offline_f18_predict_gbdt_300 交 offline_f18_predict_gbdt_400
-- scale        hits   recom   F1
-- 1.50=252714  11463  249319  5.480
-- 1.53=257762  11609  254544  5.4886
-- 1.54=259453  11663  256190  5.49278
-- 1.55=261137  11719  257647  5.50028
-- 1.6=269561   11955  267089  5.489
