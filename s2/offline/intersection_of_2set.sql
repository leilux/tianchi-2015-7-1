select count(*) as numOFi
from
(
    select user_id, item_id, prediction_score
    from offline_f18_predict_gbdt_300  -- gai
    order by prediction_score asc
    limit 267089         -- gai
) u1

join
(
    select user_id, item_id, prediction_score
    from off_predict_gbdt300_002_20_8_9_200_u10  -- gai
    order by prediction_score asc
    limit 267089         -- gai
) u2
on u1.user_id=u2.user_id and u1.item_id=u2.item_id
;

select count(*) as hits
from 
(
	select distinct u1.user_id, u1.item_id
	from 
    (
        select user_id, item_id, prediction_score
        from offline_f18_predict_gbdt_300  -- gai
        order by prediction_score asc
        limit 267089        -- gai
    ) u1
        
    join
    (
        select user_id, item_id, prediction_score
        from off_predict_gbdt300_002_20_8_9_200_u10  -- gai
        order by prediction_score asc
        limit 267089         -- gai
    ) u2
    on u1.user_id=u2.user_id and u1.item_id=u2.item_id
	
	join
	offline_validate_set b
	on u1.user_id=b.user_id and u1.item_id=b.item_id
) z
;
