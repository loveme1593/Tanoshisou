package com.itmaster.tanoshi.util;

public class Paging {

	// 전체 페이지 수 구하기
	public static int totalPage(int totalPosts, int pageCount) {
		// totalPosts: 전체 포스트의 개수
		// pageCount: 한 페이지에 표시되는 포스트의 수
		// page: 현재 페이지
		int result = 0;
		if (totalPosts != 0) {
			if (totalPosts % pageCount == 0) {
				result = totalPosts / pageCount;
			} else {
				result = (totalPosts / pageCount) + 1;
			}

		}
		if (totalPosts == 0) {
			// 게시물이 하나도 없을 때 총 페이지 수는 1
			result = 1;
		}
		return result;
	}

	// 현재 페이지 계산하기(페이지 이동 시)
	public static int currentPage(int page, int totalPages) {
		// page: 현재 페이지
		// totalPage: 총 페이지
		if (page <= 0) {
			// 페이지 이동으로 현재 페이지 값이 0보다 작거나 같을 경우 현재 페이지는 1
			page = 1;
		}
		if (page > totalPages) {
			// 페이지 이동으로 총 페이지 수보다 현재 페이지 수가 클 경우 현재 페이지=총 페이지
			page = totalPages;
		}
		return page;
	}

	// startPage 계산하기
	public static int startPage(int page, int pageCount) {
		// page:: 현재 페이지, pageCount:: 한 페이지에 표시할 페이지 수
		int result = (page - 1) * pageCount;
		return result;
	}

	// endPage 계산하기
	public static int endPage(int page, int pageCount, int totalPosts) {
		// totalPosts: 총 게시물 개수
		int result = ((page - 1) * pageCount) + pageCount - 1;
		if (result > totalPosts) {
			result = totalPosts;
		}
		return result;
	}

}