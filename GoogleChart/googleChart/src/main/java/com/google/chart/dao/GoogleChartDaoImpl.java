package com.google.chart.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.chart.dto.GoogleChartDto;

@Repository
public class GoogleChartDaoImpl implements GoogleChartDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<GoogleChartDto> chartData(String chartId) {
		
		List<GoogleChartDto> list = new ArrayList<GoogleChartDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "chartData", chartId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	
	@Override
	public int insert(GoogleChartDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}



}
