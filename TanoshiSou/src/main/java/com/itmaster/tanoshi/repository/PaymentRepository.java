package com.itmaster.tanoshi.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.PaymentDAO;
import com.itmaster.tanoshi.vo.Payment;

@Repository
public class PaymentRepository {
	@Autowired
	SqlSession sql;

	PaymentDAO dao;

	/* (관리자용) 쉐어하우스의 id로 해당되는 관리비 내역을 '모두' 가져온다 */
	public ArrayList<Payment> getPaymentsforHost(Payment payment) {
		dao = sql.getMapper(PaymentDAO.class);
		ArrayList<Payment> list = null;
		try {
			list = dao.getPaymentsforHost(payment);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<Payment> getPaymentsforResident(Payment payment) {
		dao = sql.getMapper(PaymentDAO.class);
		ArrayList<Payment> list = null;
		try {
			list = dao.getPaymentsforResident(payment);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public boolean insertPayment(Payment payment) {
		dao = sql.getMapper(PaymentDAO.class);
		int result = 0;
		try {
			result = dao.insertPayment(payment);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	public boolean deletePayment(int pay_id) {
		dao = sql.getMapper(PaymentDAO.class);
		int result = 0;
		try {
			result = dao.deletePayment(pay_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	public boolean updatePayment(Payment payment) {
		dao = sql.getMapper(PaymentDAO.class);
		int result = 0;
		try {
			result = dao.updatePayment(payment);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}
	public ArrayList<String> getInsertedCategory(Payment payment)
	{
		ArrayList<String> list = null;
		dao = sql.getMapper(PaymentDAO.class);
		try {
			list = dao.getInsertedCategory(payment);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<Payment> getPaymentsforReport(Payment payment) {
		ArrayList<Payment> list = null;
		dao = sql.getMapper(PaymentDAO.class);
		try {
			list = dao.getPaymentsforReport(payment);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean clearPayment(String member_id) {
		dao = sql.getMapper(PaymentDAO.class);
		int result = 0;
		try {
			result = dao.clearPayment(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}
}
