-- 连接特征集
-- 使用标注集进行标记
drop table if exists online_test_set;
create table online_test_set
    as select a.user_id, a.item_id,
			  a.f3_1, a.f3_2, a.f3_3, a.f3_4,
			  b.f3_5, b.f3_6, b.f3_7, b.f3_8,
			  c.f2_1, c.f2_2, c.f2_3, c.f2_4,
			  d.f1_1_3, d.f1_1_7, d.f1_2_3, d.f1_2_7,
			  d.f1_3_3, d.f1_3_7
    from
		online_test_feature_ui_behavior_count a

		left outer join
		online_test_feature_ui_behavior_lasttime_delta b
		on a.user_id=b.user_id and a.item_id=b.item_id

		left outer join
		online_test_feature_u_behavior_count c
		on a.user_id=c.user_id and a.item_id=c.item_id

		left outer join
		online_test_feature_i_sale_count d
		on a.user_id=d.user_id and a.item_id=d.item_id
;
