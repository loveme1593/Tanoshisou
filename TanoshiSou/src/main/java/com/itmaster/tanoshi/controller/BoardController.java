package com.itmaster.tanoshi.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itmaster.tanoshi.repository.BoardRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.repository.ReplyRepository;
import com.itmaster.tanoshi.util.Paging;
import com.itmaster.tanoshi.vo.Board;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.Reply;

@Controller
@RequestMapping(value = "/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	BoardRepository boardRep;

	@Autowired
	MemberRepository memberRep;

	@Autowired
	ReplyRepository replyRep;

	@Autowired
	HttpSession session;

	/*
	 * 蹂��닔紐� �쟾諛섏쟻�쑝濡� 怨좎묠 - �씠��濡� �뵲瑜� 寃� board/?id={house_id} > �씠 二쇱냼�뿉�꽌 寃뚯떆�뙋�씠 �굹���빞 �븿 媛��옣 湲곕낯�쟻�씤
	 * 留ㅺ컻蹂��닔�뒗 �뎽�뼱�븯�슦�뒪�쓽 id�씠�굹 移댄뀒怨좊━ / 寃��깋�쑀�삎 / 寃��깋�뼱 �벑�쓽 留ㅺ컻蹂��닔媛� 異붽��맆 �닔 �엳�쓬 �럹�씠吏뺤� util �뙣�궎吏��쓽
	 * Paging �겢�옒�뒪�뿉�꽌 �쟾遺� 愿�由ы븳�떎 *
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String getBoards(@RequestParam(value = "category", defaultValue = "notice") String category,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model,
			@RequestParam(value = "searchType", defaultValue = "") String searchType,
			@RequestParam(value = "searchText", defaultValue = "") String searchText) {
		Member member = (Member) session.getAttribute("loginInfo");

		// 寃뚯떆�뙋 紐⑸줉�쓣 媛��졇�삩�떎.->���엯�뿉 留욌뒗 寃뚯떆湲� �궡�슜�쓣 媛��졇�삤寃� �맂�떎
		logger.info("searchCombo::" + searchType + ", searchText::" + searchText);
		ArrayList<Board> boards = new ArrayList<Board>();

		// �럹�씠吏� 泥섎━瑜� �쐞�븳 媛� ���옣
		Member loginInfo = (Member) session.getAttribute("loginInfo");
		String house_id = loginInfo.getMember_belongto();
		int totalPosts = boardRep.getTotalPosts(house_id, category, searchType, searchText);
		int totalPages = Paging.totalPage(totalPosts, Configuration.PAGECOUNT);
		page = Paging.currentPage(page, totalPages);
		logger.info(category + " �쓽 �쟾泥� �럹�씠吏� �닔 ::" + totalPages);
		boards = boardRep.getBoards(house_id, category, Paging.startPage(page, Configuration.PAGECOUNT),
				Paging.endPage(page, Configuration.PAGECOUNT, totalPosts), searchType, searchText);
		model.addAttribute("category", category);
		model.addAttribute("page", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("boards", boards);
		if (!searchType.equals("null")) {
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchText", searchText);
		}
		logger.info(category + "�쓽 寃뚯떆臾� 洹쒕え: " + boards.size());
		logger.info(category + " �쓽 寃뚯떆�뙋 " + "�쁽�옱�럹�씠吏�::" + page + " �쟾泥� �럹�씠吏��닔::" + totalPages);
		logger.info("searchCombo�쓽 媛�::" + searchType);
		// 怨듭�寃뚯떆�뙋�꽌 Host留� 湲� �벝�닔 �엳�룄濡� 泥섎━
		model.addAttribute("member_type", loginInfo.getMember_type());
		return "board/list";
	}

	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insertBoard(Model model, String category) {
		Member member = (Member) session.getAttribute("loginInfo");
		logger.info("湲��벐湲�");
		String member_type = member.getMember_type();
		model.addAttribute("member_type", member_type);
		// nav bar �몴�떆瑜� �쐞�븳 泥섎━
		model.addAttribute("category", category);
		return "board/insert";
	}

	@RequestMapping(value = "insertBoard", method = RequestMethod.POST)
	public @ResponseBody int insertBoard(Board board, Model model) {
		Member member = (Member) session.getAttribute("loginInfo");
		String loginId = member.getMember_id();
		String house_id = member.getMember_belongto();
		String board_nickname = member.getMember_nickname();
		board.setBoard_member_id(loginId);
		board.setHouse_id(house_id);
		board.setBoard_nickname(board_nickname);
		boardRep.insertBoard(board);
		int board_id = boardRep.getBoardId(house_id, board.getBoard_member_id());
		String board_inputdate = boardRep.getInputDate(board_id);
		logger.info("�엯�젰�씪:" + board_inputdate);
		// vote 湲곕뒫 �꽔湲� �쐞�븿..->寃뚯떆湲� �벑濡� �떆 ajax濡� board_id �꽆寃⑥＜�룄濡�
		return board_id;
	}

	@RequestMapping(value = "getBoard", method = RequestMethod.GET)
	public String getBoard(Model model, int board_id, String category) {
		logger.info("寃뚯떆湲� �씫湲�:" + board_id + " category:: " + category);
		Member member = (Member) session.getAttribute("loginInfo");
		String loginId = member.getMember_id();
		// 寃뚯떆湲� �씫�쓣 �븣 議고쉶�닔 �삱由ш린
		boardRep.upHits(board_id);
		// 寃뚯떆湲� �씫湲�
		Board board = boardRep.getBoard(board_id);
		ArrayList<Reply> getReplies = replyRep.getReplies(board_id);
		// �빐�떦 寃뚯떆湲��쓽 �뙎湲� 遺덈윭�삤湲�
		model.addAttribute("getReplies", getReplies);
		// �뙎湲� �옉�꽦 �떆 �븘�슂�븳 �땳�꽕�엫 紐⑤뜽�뿉 ���옣
		String reply_nickname = member.getMember_nickname();
		model.addAttribute("reply_nickname", reply_nickname);
		model.addAttribute("boards", board);
		// 移댄뀒怨좊━ �젙蹂� 異붽�
		model.addAttribute("category", category);
		logger.info("�빐�떦 寃뚯떆湲�::" + board.toString());
		return "board/read";
	}

	@RequestMapping(value = "deleteBoard", method = RequestMethod.POST)
	public String deleteBoard(int board_id, String category) {
		// 寃뚯떆湲� �궘�젣
		// �뙎湲� �궘�젣
		int resultR = replyRep.deleteReplies(board_id);
		logger.info("�뙎湲� �궘�젣 寃곌낵:: " + resultR);
		int resultD = 0;
		resultD = boardRep.deleteBoard(board_id);
		logger.info(board_id + " �궘�젣 寃곌낵:: " + resultD);
		return "redirect:/board?category=" + category;
	}

	@RequestMapping(value = "updateBoard", method = RequestMethod.GET)
	public String updateBoard(int board_id, Model model) {
		Board board = boardRep.getBoard(board_id);
		model.addAttribute("boards", board);
		// nav bar�뿉 移댄뀒怨좊━ �몴�떆瑜� �쐞�븳 泥섎━
		model.addAttribute("category", board.getBoard_category());
		return "board/update";
	}

	@RequestMapping(value = "updateBoard", method = RequestMethod.POST)
	public String updateBoard(int board_id, String board_title, String board_content, Model model) {
		Board board = boardRep.getBoard(board_id);
		board.setBoard_title(board_title);
		board.setBoard_content(board_content);
		int result = boardRep.updateBoard(board);
		return "redirect:/board";
	}

	@RequestMapping(value = "getReplies", method = RequestMethod.GET)
	public @ResponseBody ArrayList<Reply> getReplies(int board_id) {
		logger.info("getReplies �뱾�뼱�샂");
		ArrayList<Reply> replyList = new ArrayList();
		replyList = replyRep.getReplies(board_id);
		return replyList;
	}

	@RequestMapping(value = "insertReply", method = RequestMethod.POST)
	public @ResponseBody int insertReply(Reply reply) {
		logger.info("�뙎湲� 異붽� �슂泥�");
		int result = replyRep.insertReply(reply);
		if (result == 1) {
			boardRep.upReplyCount(reply.getBoard_id());
		}
		return result;
	}

	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	public @ResponseBody int deleteReply(int reply_num) {
		logger.info("�뙎湲� �궘�젣 �슂泥�");
		int board_id = replyRep.getBoardId(reply_num);
		boardRep.downReplyCount(board_id);
		int result = replyRep.deleteReply(reply_num);
		// �뙎湲� �궘�젣 �떆 �빐�떦 寃뚯떆臾쇱쓽 �뙎湲� 媛��닔�룄 以꾩엫
		return result;
	}

	@RequestMapping(value = "updateReply", method = RequestMethod.POST)
	public @ResponseBody int updateReply(Reply reply) {
		logger.info("�뙎湲� �닔�젙");
		int result = replyRep.updateReply(reply);
		return result;
	}
	
	// 수정을 위한 댓글 하나만 가져오기
	@RequestMapping(value="getReply", method=RequestMethod.POST)
	public @ResponseBody String getReply(int reply_num){
		String reply=replyRep.getReply(reply_num);
		logger.info("댓글::"+reply);
		return reply;
	}
}