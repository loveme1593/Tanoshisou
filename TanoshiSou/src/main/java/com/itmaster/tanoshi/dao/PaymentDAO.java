package com.itmaster.tanoshi.dao;

import java.util.ArrayList;
import java.util.List;

import com.itmaster.tanoshi.vo.Payment;

public interface PaymentDAO {

	public ArrayList<Payment> getPaymentsforHost(Payment payment) throws Exception;
	
	public ArrayList<Payment> getPaymentsforResident(Payment payment) throws Exception;

	public int insertPayment(Payment payment) throws Exception;

	public int deletePayment(int pay_id) throws Exception;

	public int updatePayment(Payment payment) throws Exception;
	
	public ArrayList<String> getInsertedCategory(Payment payment) throws Exception;
	
	public ArrayList<Payment> getPaymentsforReport(Payment payment) throws Exception;

	public int clearPayment(String member_id) throws Exception;
}
