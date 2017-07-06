package com.itmaster.tanoshi.repository;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import com.itmaster.tanoshi.controller.MainController;
import com.itmaster.tanoshi.dao.HouseDAO;
import com.itmaster.tanoshi.util.Location2GPS;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.HouseFile;
import com.itmaster.tanoshi.vo.MemberDetail;
import com.itmaster.tanoshi.util.FileService;

@Repository
public class HouseRepository {

	@Autowired
	SqlSession sql;

	HouseDAO dao;
	private static final Logger logger = LoggerFactory.getLogger(HouseRepository.class);
	private final String path = "D:/project/houseImage";

	/* 쉐어하우스 id의 중복여부를 검사하는 메소드 */
	public boolean checkID(String house_id) {
		dao = sql.getMapper(HouseDAO.class);
		String result = null;
		try {
			result = dao.checkHouseID(house_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != null)
			return false;
		else
			return true;
	}

	/* 검색어로 쉐어하우스를 검색하는 메소드 */
	public ArrayList<House> searchHouses(String keyword) {
		dao = sql.getMapper(HouseDAO.class);
		ArrayList<House> list = null;
		try {
			list = dao.searchHouses(keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	/* 검색어로 쉐어하우스를 검색하는 메소드 */
	public ArrayList<House> searchDetailedHouses(House house) {
		dao = sql.getMapper(HouseDAO.class);
		ArrayList<House> list = null;
		ArrayList<House> result = new ArrayList<House>();
		try {
			list = dao.searchDetailedHouses(house);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String[] querys = house.getOptionArray();
		if (querys == null)
			return list;

		houseLoop: for (House h : list) {
			String[] array = h.getOptionArray();
			if (array == null)
				continue;
			queryLoop: for (String query : querys) {
				for (String option : array) {
					if (query.equals(option)) {
						{
							logger.info(h.getHouse_name() + " 발견!");
							result.add(h);
							break queryLoop; 
						}
					}
				}

			}

		}
		return result;
	}

	/* (관리자용) 모든 쉐어하우스의 데이터를 가져오는 메소드 */
	public ArrayList<House> getHouses() {
		dao = sql.getMapper(HouseDAO.class);
		ArrayList<House> list = null;
		try {
			list = dao.getHouses();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/* 쉐어하우스를 생성하는 메소드 */
	public int insertHouse(House house) {
		int result = 0;
		dao = sql.getMapper(HouseDAO.class);
		setGPS(house);
		try {
			result = dao.insertHouse(house);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/* (사이트 운영자용) 쉐어하우스 신청을 승인하는 메소드 */
	public void acceptHouse(String house_id) {
		dao = sql.getMapper(HouseDAO.class);
		try {
			dao.acceptHouse(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/* (사이트 운영자용) 쉐어하우스를 삭제하는 메소드 */
	public void deleteHouse(String house_id) {
		dao = sql.getMapper(HouseDAO.class);
		try {
			dao.deleteHouse(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/* 아이디로 해당 쉐어하우스의 데이터를 가져오는 메소드 */
	public House getHouse(String house_id) {
		dao = sql.getMapper(HouseDAO.class);
		House house = null;
		try {
			house = dao.getHouse(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return house;
	}

	/* 쉐어하우스의 정보를 수정하는 메소드 */
	public void updateHouse(House house) {
		dao = sql.getMapper(HouseDAO.class);
		setGPS(house);
		try {
			dao.updateHouse(house);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/* 등록/수정시 쉐어하우스의 GPS를 설정하는 메소드 */
	public void setGPS(House house) {
		String address = house.getHouse_address();
		Map<String, Double> geocode = Location2GPS.getGeocode(address);
		// 에러 또는 보안상의 이유로 geocode가 없을 때에는
		// 코엑스의 GPS로 설정한다
		if (geocode == null) {
			house.setHouse_GPS_X(127.0591591);
			house.setHouse_GPS_Y(37.5118239);
		} else {
			logger.info("\nGPS (x: " + geocode.get("x") + ", y: " + geocode.get("y") + ")");
			house.setHouse_GPS_X(geocode.get("x"));
			house.setHouse_GPS_Y(geocode.get("y"));
		}

	}

	/* 승인된 쉐어하우스의 데이터만 가져오는 메소드 */
	public ArrayList<House> getAcceptedHouses() {
		dao = sql.getMapper(HouseDAO.class);
		ArrayList<House> list = null;
		try {
			list = dao.getAcceptedHouses();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public void insertFile(ArrayList<MultipartFile> files, String house_id) {
		String uploadPath = path; // 파일이 업로드되는 경로
		dao = sql.getMapper(HouseDAO.class);
		for (MultipartFile file : files) {
			if (file.getOriginalFilename().length() != 0) {
				String SaveName = FileService.saveFile(house_id, file, uploadPath);
				try {
					dao.insertFile(house_id, file.getOriginalFilename(), SaveName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void deleteFile(String house_id) {
		dao = sql.getMapper(HouseDAO.class);
		try {
			dao.deleteFile(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 회원 정보로 집 정보 가져오기
	public House getHouseByUserId(String member_belongto) {
		dao = sql.getMapper(HouseDAO.class);
		House houseResultById = null;
		try {
			houseResultById = dao.getHouseByUserId(member_belongto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return houseResultById;
	}

	// 하우스 이미지 파일 이름 불러오기
	public ArrayList<HouseFile> getHouseImageFile(String house_id) {
		ArrayList<HouseFile> resultHouseFile = new ArrayList<HouseFile>();
		dao = sql.getMapper(HouseDAO.class);
		try {
			resultHouseFile = dao.getHouseImageFile(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}   
		if(resultHouseFile.size()==0){
			resultHouseFile.add(new HouseFile(house_id, "noimage.jpg", "noimage.jpg"));
		}
		return resultHouseFile;
	}

	public ArrayList<House> showHouseListAtUpdate() {
		ArrayList<House> resultHouseList = new ArrayList<House>();
		dao = sql.getMapper(HouseDAO.class);
		try {
			resultHouseList = dao.getHouseListAtUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultHouseList;
	}

	public boolean setHouseScore(String house_id) {
		int result = 0;
		dao = sql.getMapper(HouseDAO.class);
		try {
			result = dao.setHouseScore(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	public boolean setHouseAge(String house_id) {
		int result = 0;
		dao = sql.getMapper(HouseDAO.class);
		try {
			result = dao.setHouseAge(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	public ArrayList<House> getPersonalResult(MemberDetail detail) {
		dao = sql.getMapper(HouseDAO.class);
		int score = detail.getScore_personal();
		ArrayList<House> list = null;
		try {
			list = dao.getPersonalResult(score);
		} catch (Exception e) {
			e.printStackTrace();
		}
		cutAddress(list);
		return list;
	}

	public ArrayList<House> getActiveResult(MemberDetail detail) {
		dao = sql.getMapper(HouseDAO.class);
		int score = detail.getScore_personal();
		ArrayList<House> list = null;
		try {
			list = dao.getActiveResult(score);
		} catch (Exception e) {
			e.printStackTrace();
		}
		cutAddress(list);
		return list;
	}

	public ArrayList<House> getCleanResult(MemberDetail detail) {
		dao = sql.getMapper(HouseDAO.class);
		int score = detail.getScore_personal();
		ArrayList<House> list = null;
		try {
			list = dao.getCleanResult(score);
		} catch (Exception e) {
			e.printStackTrace();
		}
		cutAddress(list);
		return list;
	}
	private void cutAddress(ArrayList<House> result) {
		if (result==null)
			return;
		for(House h : result)
		{
			String add = h.getHouse_address();
			String[] addHeader = add.split(" ");
			h.setHouse_address(addHeader[0]);
		}
	}

}