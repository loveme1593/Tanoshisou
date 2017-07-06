package com.itmaster.tanoshi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itmaster.tanoshi.repository.BoardRepository;
import com.itmaster.tanoshi.repository.Board_PhotoRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.repository.ReplyRepository;
import com.itmaster.tanoshi.util.FileService;
import com.itmaster.tanoshi.util.Paging;
import com.itmaster.tanoshi.util.PhotoThumbNail;
import com.itmaster.tanoshi.vo.Board;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.Reply;

//사진첩 관리를 위한 controller
@Controller
@RequestMapping(value = "photo/")
public class Board_PhotoController {

	private static final Logger logger = LoggerFactory.getLogger(Board_PhotoController.class);

	@Autowired
	HttpSession session;

	@Autowired
	MemberRepository memberRep;

	@Autowired
	Board_PhotoRepository b_pRep;

	@Autowired
	BoardRepository boardRep;

	@Autowired
	ReplyRepository rRepository;

	/* 사진첩 메인 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String photoMain(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
		logger.info("사진첩 메인");
		// 세션에 저장되어 있는 멤버 값 가져온 후 거기서 하우스 아이디 받아옴
		Member loginInfo = (Member) session.getAttribute("loginInfo");
		String house_id = loginInfo.getMember_belongto();
		System.out.println(page+"-----------");
		// 페이징 처리를 위한 값 저장
		ArrayList<Board> photos = b_pRep.getPhotos(house_id);
		int pageCount = 5; // 한 페이지에 표시되는 포스트 수:: 일단 5개로 함
		int totalPosts = photos.size();
		int totalPage = Paging.totalPage(totalPosts, pageCount);
		page = Paging.currentPage(page, totalPage);
		photos = b_pRep.getPhotos(house_id, Paging.startPage(page, pageCount),
				Paging.endPage(page, pageCount, totalPosts));
		logger.info("사진첩 현재 페이지::" + page + " 현재 표시할 게시물 개수::" + photos.size());
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", page);
		model.addAttribute("photos", photos);

		// 사진첩 글 별로 있는 사진파일 경로값 불러오기
		PhotoThumbNail thNail = new PhotoThumbNail();
		Map<Integer, Object> getPathLists = thNail.getPaths(photos);
		logger.info("썸네일 글 개수::" + getPathLists.size());
		model.addAttribute("thumbnails", getPathLists);
		return "photo/home";
	}

	/* 사진 올리기 페이지 */
	@RequestMapping(value = "insertPhoto", method = RequestMethod.GET)
	public String insertPhoto() {
		logger.info("일상 공유 화면으로 이동");
		return "photo/insert";
	}

	/* 사진 올리기 수행 */
	@RequestMapping(value = "insertPhoto", method = RequestMethod.POST)
	public String insertPhoto(Board b, MultipartFile photo1, MultipartFile photo2, MultipartFile photo3,
			MultipartFile photo4, MultipartFile photo5, MultipartFile photo6, Model model) {
		Member loginInfo = (Member) session.getAttribute("loginInfo");
		String house_id = loginInfo.getMember_belongto();
		b.setBoard_member_id(loginInfo.getMember_id());
		b.setBoard_nickname(loginInfo.getMember_nickname());
		b.setBoard_category("photo");
		b.setHouse_id(loginInfo.getMember_belongto());
		String board_file_id = "";
		String originalFilename = "";
		int fileNum = 0; // 업로드 되는 사진 파일의 개수
		// 기본 board에만 내용 넣기
		int result = b_pRep.insertPhoto(b);
		logger.info("사진첩 입력 결과::" + result);
		PhotoThumbNail thNail = new PhotoThumbNail();
		int board_id = boardRep.getBoardId(loginInfo.getMember_belongto(), loginInfo.getMember_id());

		ArrayList<MultipartFile> fileList = new ArrayList<MultipartFile>();
		if (!photo1.isEmpty())
			fileList.add(photo1);
		if (!photo2.isEmpty())
			fileList.add(photo2);
		if (!photo3.isEmpty())
			fileList.add(photo3);
		if (!photo4.isEmpty())
			fileList.add(photo4);
		if (!photo5.isEmpty())
			fileList.add(photo5);
		if (!photo6.isEmpty())
			fileList.add(photo6);

		for (MultipartFile file : fileList) {
			fileNum++;
			if (!board_file_id.equals("")) {
				board_file_id += "/";
				originalFilename += "/";
			}
			originalFilename += file.getOriginalFilename();
			String savedFilename = FileService.saveFile(board_id, fileNum, file, Configuration.BOARDPATH);
			board_file_id += savedFilename;
			if (fileNum <= 4) {
				thNail.thumbNail(savedFilename);
			}
		}

		b.setBoard_file_id(board_file_id);
		b.setBoard_upload_file_name(originalFilename);
		logger.info("들어가는 사진 파일::" + b.toString());
		if (result == 1) {
			// files 테이블에 값 넣기
			b.setBoard_id(board_id);
			b_pRep.insertBoard_files(b);
		}
		ArrayList<Board> photos = b_pRep.getPhotos(loginInfo.getMember_belongto());

		// 사진첩 글 별로 있는 사진파일 경로값 불러오기
		int page = 1;
		int pageCount = 5;
		int totalPosts = photos.size();
		int totalPage = Paging.totalPage(totalPosts, pageCount);
		photos = b_pRep.getPhotos(house_id, Paging.startPage(page, pageCount),
				Paging.endPage(page, pageCount, totalPosts));
		Map<Integer, Object> getPathLists = thNail.getPaths(photos);
		logger.info("썸네일 글 개수::" + getPathLists.size());
		model.addAttribute("thumbnails", getPathLists);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", 1);
		model.addAttribute("photos", photos);
		return "photo/home";
	}

	/* 파일(이미지) 링크 */
	@RequestMapping(value = "download", method = RequestMethod.GET)
	public String download(@RequestParam(value = "catofposts", defaultValue = "thumbPath") String catofposts,
			String board_file_id, HttpServletResponse response) {
		logger.info("파일 불러오기::" + board_file_id);
		// 썸네일 위한 파일 불러오기
		// Board board = bRepository.getBoard(board_id);

		// String originalfile = board.getOriginalfile();

		try {
			response.setHeader("Content-Disposition",
					"attachment;filename=" + URLEncoder.encode(board_file_id, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String fullpath = "";
		if (catofposts.equals("thumbPath")) {
			fullpath = Configuration.THUMBPATH + "/" + board_file_id;
		} else {
			fullpath = Configuration.BOARDPATH + "/" + board_file_id;
		}

		ServletOutputStream fileout = null;
		FileInputStream filein = null;

		try {
			filein = new FileInputStream(fullpath);
			fileout = response.getOutputStream();
			FileCopyUtils.copy(filein, fileout);
		} catch (Exception e) {
			System.out.println("파일이 없습니다!");
			e.printStackTrace();
		} finally {
			try {
				if (filein != null) {
					filein.close();
				}
				if (fileout != null) {
					fileout.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@RequestMapping(value = "getPhoto", method = RequestMethod.GET)
	public String getPhoto(Model model, int board_id) {
		logger.info("사진첩 글읽기");
		// 게시글 조회할 때 조회수 올리기
		boardRep.upHits(board_id);

		Board board = b_pRep.getPhoto(board_id);
		model.addAttribute("getPhoto", board);
		PhotoThumbNail thNail = new PhotoThumbNail();
		String[] getPathLists = thNail.getPath(board);

		// 해당 댓글들 가져오기
		ArrayList<Reply> getReplies = rRepository.getReplies(board_id);
		model.addAttribute("getReplies", getReplies);

		// 닉네임 가져오기
		Member loginInfo = (Member) session.getAttribute("loginInfo");
		String reply_nickname = loginInfo.getMember_nickname();
		model.addAttribute("reply_nickname", reply_nickname);

		logger.info("보일 사진 개수::" + getPathLists.length);
		model.addAttribute("photoPath", getPathLists);
		return "photo/read";
	}

	@RequestMapping(value = "deletePhoto", method = RequestMethod.GET)
	public String deletePhoto(int board_id, Model model) {
		PhotoThumbNail thNail = new PhotoThumbNail();
		logger.info("사진 삭제하기");

		Board getPhoto = b_pRep.getPhoto(board_id);
		String[] paths = thNail.getPath(getPhoto);

		// 사진 파일 삭제하기
		for (int a = 0; a < paths.length; a++) {
			FileService.deleteFile(Configuration.BOARDPATH, paths[a]);
			FileService.deleteFile(Configuration.THUMBPATH, paths[a]);
		}

		// house_id 가져오기
		Member loginInfo = (Member) session.getAttribute("loginInfo");
		String house_id = loginInfo.getMember_belongto();

		// 디비 내용 지우기
		int result = b_pRep.deletePhoto(board_id);
		logger.info("삭제 결과::" + result);
		ArrayList<Board> photos = b_pRep.getPhotos(house_id);

		// 사진첩 글 별로 있는 사진파일 경로값 불러오기
		Map<Integer, Object> getPathLists = thNail.getPaths(photos);
		logger.info("썸네일 글 개수::" + getPathLists.size());
		model.addAttribute("thumbnails", getPathLists);
		int page = 1;
		int pageCount = 5;
		int totalPosts = photos.size();
		int totalPage = Paging.totalPage(totalPosts, pageCount);
		photos = b_pRep.getPhotos(house_id, Paging.startPage(page, pageCount),
				Paging.endPage(page, pageCount, totalPosts));
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", 1);
		model.addAttribute("photos", photos);
		return "photo/home";
	}

	// 댓글작업
	@RequestMapping(value = "getReplies", method = RequestMethod.GET)
	public @ResponseBody ArrayList<Reply> getReplies(int board_id) {
		logger.info("getReplies 들어옴");
		ArrayList<Reply> replyList = new ArrayList();
		replyList = rRepository.getReplies(board_id);
		return replyList;
	}

	@RequestMapping(value = "insertReply", method = RequestMethod.POST)
	public @ResponseBody int insertReply(Reply r) {
		logger.info("insertReply 들어옴");
		int result = rRepository.insertReply(r);
		if (result == 1) {
			boardRep.upReplyCount(r.getBoard_id());
		}
		return result;
	}

	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	public @ResponseBody int deleteReply(int reply_num) {
		logger.info("deleteReply 들어옴");
		int board_id = rRepository.getBoardId(reply_num);
		boardRep.downReplyCount(board_id);
		int result = rRepository.deleteReply(reply_num);
		// 댓글 삭제 시 해당 게시물의 댓글 갯수도 줄임
		return result;
	}

	@RequestMapping(value = "updateReply", method = RequestMethod.POST)
	public @ResponseBody int updateReply(Reply r) {
		logger.info("updateReply 들어옴");
		int result = rRepository.updateReply(r);
		return result;
	}

	@RequestMapping(value = "updatePhoto", method = RequestMethod.GET)
	public String updatePhoto(int board_id, Model model) {
		logger.info("updatePhoto 들어옴");
		Board getPhoto = boardRep.getBoard(board_id);
		model.addAttribute("getPhoto", getPhoto);
		return "photo/update";
	}

	@RequestMapping(value = "updatePhoto", method = RequestMethod.POST)
	public String updatePhoto(Board photo, Model model, MultipartFile photo1, MultipartFile photo2,
			MultipartFile photo3, MultipartFile photo4, MultipartFile photo5, MultipartFile photo6) {
		int board_id = photo.getBoard_id();
		Board originalPhoto = boardRep.getBoard(board_id);
		logger.info("수정전 원본파일::" + originalPhoto.toString());
		PhotoThumbNail thNail = new PhotoThumbNail();
		String[] paths = thNail.getPath(originalPhoto);
		// 사진 파일 삭제하기
		for (int a = 0; a < paths.length; a++) {
			FileService.deleteFile(Configuration.BOARDPATH, paths[a]);
			FileService.deleteFile(Configuration.THUMBPATH, paths[a]);
		}

		// 사진들 다시 넣기
		String board_file_id = "";
		String originalFilename = "";
		int fileNum = 0;
		ArrayList<MultipartFile> fileList = new ArrayList<MultipartFile>();
		if (!photo1.isEmpty())
			fileList.add(photo1);
		if (!photo2.isEmpty())
			fileList.add(photo2);
		if (!photo3.isEmpty())
			fileList.add(photo3);
		if (!photo4.isEmpty())
			fileList.add(photo4);
		if (!photo5.isEmpty())
			fileList.add(photo5);
		if (!photo6.isEmpty())
			fileList.add(photo6);

		for (MultipartFile file : fileList) {
			fileNum++;
			if (!board_file_id.equals("")) {
				board_file_id += "/";
				originalFilename += "/";
			}
			originalFilename += photo1.getOriginalFilename();
			String savedFilename = FileService.saveFile(board_id, fileNum, file, Configuration.BOARDPATH);
			board_file_id += savedFilename;
			if (fileNum <= 4) {
				thNail.thumbNail(savedFilename);
			}
		}

		// DB내용 수정하기
		originalPhoto.setBoard_title(photo.getBoard_title());
		originalPhoto.setBoard_content(photo.getBoard_content());
		originalPhoto.setBoard_file_id(board_file_id);
		originalPhoto.setBoard_upload_file_name(originalFilename);
		logger.info("수정된 파일 내용::" + originalPhoto.toString());
		int result = b_pRep.updatePhoto(originalPhoto);

		// 사진첩 글 별로 있는 사진파일 경로값 불러오기
		Member loginInfo = (Member) session.getAttribute("loginInfo");
		String house_id = loginInfo.getMember_belongto();
		ArrayList<Board> photos = b_pRep.getPhotos(house_id);
		Map<Integer, Object> getPathLists = thNail.getPaths(photos);
		logger.info("썸네일 글 개수::" + getPathLists.size());
		model.addAttribute("thumbnails", getPathLists);
		int page = 1;
		int pageCount = 5;
		int totalPosts = photos.size();
		int totalPage = Paging.totalPage(totalPosts, pageCount);
		photos = b_pRep.getPhotos(house_id, Paging.startPage(page, pageCount),
				Paging.endPage(page, pageCount, totalPosts));
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", 1);
		model.addAttribute("photos", photos);
		return "photo/home";
	}

}