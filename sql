$getCnt = mysqli_fetch_assoc(mysqli_query($db, "select (SELECT count(td_fm_id) FROM tbl_td_file_movement  where `td_fm_dep_active`='00' and ( `td_fm_subdpt_active`='00' OR `td_fm_subdpt_active`='01') and td_fm_status=0 ) as tot_cnt, (SELECT count(td_fm_id) FROM tbl_td_file_movement  where `td_fm_dep_active`='00' and (`td_fm_subdpt_active`='00'  OR `td_fm_subdpt_active`='01') and td_fm_status=0 and td_fm_id='".$status_check['td_fm_id']."' ) as cur_file_cnt, 
				( select m.rank from (
					SELECT t.td_fm_id, @rownum := @rownum + 1 AS rank FROM tbl_td_file_movement t, (SELECT @rownum := 0) r where t.`td_fm_dep_active`='00' and ( t.`td_fm_subdpt_active`='00' OR t.`td_fm_subdpt_active`='01') and t.td_fm_status=0 order by t.td_fm_id asc
				)m where m.td_fm_id='".$status_check['td_fm_id']."') as cur_queue_cnt 
				"));						
				$chk_queue_cnt = $getCnt['tot_cnt'];			
				$chk_cur_file_cnt = $getCnt['cur_file_cnt'];				
				$cur_queue_cnt = $getCnt['cur_queue_cnt'];	
												
				if($chk_queue_cnt>0 && $chk_cur_file_cnt>0)
				{
