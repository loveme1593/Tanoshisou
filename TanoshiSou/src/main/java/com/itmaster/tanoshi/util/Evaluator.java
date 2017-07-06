package com.itmaster.tanoshi.util;

import com.itmaster.tanoshi.vo.MemberDetail;

public class Evaluator {

	public static int getPersonalScore(int[] answers) {
		System.out.println(answers[0]);
		System.out.println(answers[3]);
		System.out.println(answers[7]);
		System.out.println(answers[10]);
		System.out.println(answers[11]);
		// 개인/단체 : 1번 4번 8 11 12
		int result = (answers[0]*5 + answers[3]*5 + answers[7]*5 + answers[10]*5 + answers[11]*5);
		System.out.println(" personal score : "+result);
		return result;
	}

	public static int getActiveScore(int[] answers) {
		// 내향/외향 : 3 7 10 13 15
		int result = (answers[2]*5 + answers[6]*5 + answers[9]*5 + answers[12]*5 + answers[14]*5);
		System.out.println("active score : "+result);
		return result;
	}

	public static int getCleanScore(int[] answers) {
		// 청결도 : 2 5 6 9 14
		int result = (answers[1]*5 + answers[4]*5 + answers[5]*5 + answers[8]*5 + answers[13]*5);
		System.out.println("clean score : "+result);
		return result;
	}

	
}
