package com.itmaster.tanoshi.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.HouseFile;

public interface HouseDAO {

	// public ArrayList<House> getHouses() throws Exception;

	// 타입별로 맞는 하우스 정보 불러오기
	public ArrayList<House> getHouses() throws Exception;

	public String checkHouseID(String house_id) throws Exception;

	public int insertHouse(House house) throws Exception;

	public void acceptHouse(String house_id) throws Exception;

	public void deleteHouse(String house_id) throws Exception;

	public House getHouse(String house_id) throws Exception;

	public void updateHouse(House house) throws Exception;

	// 일반 검색
	public ArrayList<House> searchHouses(String keyword) throws Exception;

	// 상세 검색
	public ArrayList<House> searchDetailedHouses(House house) throws Exception;

	public ArrayList<House> getAcceptedHouses() throws Exception;

	public int insertFile(String house_id, String originalFilename, String savedFile) throws Exception;

	public int deleteFile(String house_id) throws Exception;

	// 소속 하우스 정보 불러오기
	public House getHouseByUserId(String member_belongto) throws Exception;

	// 하우스 사진 파일 불러오기
	public ArrayList<HouseFile> getHouseImageFile(String house_id) throws Exception;

	// 회원 수정에 보여줄 하우스 정보 가져오기
	public ArrayList<House> getHouseListAtUpdate() throws Exception;

	// 쉐어하우스 평균 점수 부여
	public int setHouseScore(String house_id) throws Exception;

	// 쉐어하우스 평균 나이 부여
	public int setHouseAge(String house_id) throws Exception;

	// 활동성 점수로 하우스 가져오기
	public ArrayList<House> getActiveResult(@Param("score") int score) throws Exception;

	// 개인성 점수로 하우스 가져오기
	public ArrayList<House> getPersonalResult(@Param("score") int score) throws Exception;

	// 청결도 점수로 하우스 가져오기
	public ArrayList<House> getCleanResult(@Param("score") int score) throws Exception;
}
