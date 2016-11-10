package com.hyq.common.test;

public class TestSb {

	public static void main(String[] args) {
		String str = "1,2,3,4,,";
		String[] s = str.split(",");
		for(String sb : s)
		{
			System.out.println(sb);
		}
		
	}

}
