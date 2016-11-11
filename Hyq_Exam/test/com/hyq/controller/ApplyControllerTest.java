package com.hyq.controller;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hyq.domain.ApplyInfo;
import com.hyq.service.ApplyService;
import com.hyq.service.impl.ApplyServiceImpl;

public class ApplyControllerTest {

	
	
	private ApplyService applyService = new ApplyServiceImpl();
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void testToapplyList() {
//		ModelAndView mv = applyController.toapplyList();
		 List<ApplyInfo> findAllApplyInfo = applyService.findAllApplyInfo();
		 System.out.println(findAllApplyInfo);
//		System.out.println(mv);
	}

}
