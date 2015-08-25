-- 连接特征集
-- TODO：添加比值类特征
-- 使用标注集进行标记
-- max to `n` 

-- 71 features
drop table if exists offline_test_set;
create table offline_test_set
    as select a.user_id, a.item_id,
			  a.f3_1, a.f3_2, a.f3_3, a.f3_4,
			  b.f3_5, b.f3_6, b.f3_7, b.f3_8,
			  c.f2_1, c.f2_2, c.f2_3, c.f2_4,
			  d.f1_1_3, d.f1_1_7, d.f1_2_3, d.f1_2_7, d.f1_3_3, d.f1_3_7,
			  e.f3_9, e.f3_10,
			  f.f2_5, f.f2_6, f.f2_7,
			  g.f1_4_3, g.f1_4_7, g.f1_5_3, g.f1_5_7, g.f1_6_3, g.f1_6_7,
			  h.f1_7_3, h.f1_7_7, h.f1_8_3, h.f1_8_7, h.f1_9_3, h.f1_9_7,
			  i.f1_10_3, i.f1_10_7, i.f1_11_3, i.f1_11_7, i.f1_12_3, i.f1_12_7,
			  a.f3_4/(c.f2_4+0.01) as f3r_1, a.f3_2/(a.f3_1+0.1) as f3r_2, a.f3_3/(a.f3_1+0.1) as f3r_3, 
			  a.f3_4/(a.f3_1+0.1) as f3r_4,
			  e.f3_9/(f.f2_6+0.01) as f3r_5, e.f3_10/(f.f2_7+0.01) as f3r_6,
			  c.f2_4/(c.f2_1+0.01) as f2c1, c.f2_4/(c.f2_2+0.01) as f2c2, c.f2_4/(c.f2_3+0.01) as f2c3,
			  f.f2_7/(f.f2_6+0.01) as f2r1, c.f2_4/(f.f2_7+0.01) as f2r2, f.f2_5/(c.f2_4+0.01) as f2r3,
			  d.f1_1_3(g.f1_4_3+0.01) as f1c3_1, d.f1_1_7/(g.f1_4_7+0.01) as f1c7_1,
			  d.f1_2_3/(g.f1_5_3+0.01) as f1c3_2, d.f1_2_7/(g.f1_5_7+0.01) as f1c7_2,
			  d.f1_1_3/(h.f1_7_3+0.1) as f1c3_3, d.f1_1_7/(h.f1_7_7+0.1) as f1c7_3,
			  d.f1_2_3/(h.f1_8_3+0.1) as f1c3_4, d.f1_2_7/(h.f1_8_7+0.1) as f1c7_4,
			  d.f1_1_3/(i.f1_10_3+0.1) as f1c3_5, d.f1_1_7/(i.f1_10_7+0.1) as f1c7_5,
			  d.f1_2_3/(i.f1_11_3+0.1) as f1c3_6, d.f1_2_7/(i.f1_11_7+0.1) as f1c7_6,
			  d.f1_3_3/(d.f1_2_3+0.01) as f1r3_1, d.f1_3_7/(d.f1_2_7+0.01) as f1r7_1,
			  g.f1_6_3/(g.f1_5_3+0.01) as f1r3_2, g.f1_6_7/(g.f1_5_7+0.01) as f1r7_2,
			  h.f1_9_3/(h.f1_8_3+0.01) as f1r3_3, h.f1_9_7/(h.f1_8_7+0.01) as f1r7_3,
			  i.f1_12_3/(i.f1_11_3+0.01) as f1r3_4, i.f1_12_7/(i.f1_11_7+0.01) as f1r7_4
    from

		offline_test_feature_ui_behavior_count a          -- 1

		left outer join
		offline_test_feature_ui_behavior_lasttime_delta b -- 2
		on a.user_id=b.user_id and a.item_id=b.item_id

		left outer join
		offline_test_feature_u_behavior_count c           -- 3  
		on a.user_id=c.user_id and a.item_id=c.item_id

		left outer join
		offline_test_feature_i_sale_count d               -- 4
		on a.user_id=d.user_id and a.item_id=d.item_id

		left outer join
		offline_test_feature_ui_base e                    -- 5
		on a.user_id=e.user_id and a.item_id=e.item_id


		left outer join
		offline_test_feature_u_base f                     -- 6
		on a.user_id=f.user_id and a.item_id=f.item_id

		left outer join
		offline_test_feature_i_click_count g              -- 7
		on a.user_id=g.user_id and a.item_id=g.item_id

		left outer join
		offline_test_feature_i_star_count h               -- 8
		on a.user_id=h.user_id and a.item_id=h.item_id

		left outer join
		offline_test_feature_i_cart_count i               -- 9
		on a.user_id=i.user_id and a.item_id=i.item_id
;
