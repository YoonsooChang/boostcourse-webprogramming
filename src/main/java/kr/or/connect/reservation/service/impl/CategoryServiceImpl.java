package kr.or.connect.reservation.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.connect.reservation.dao.CategoryDao;
import kr.or.connect.reservation.dto.Category;
import kr.or.connect.reservation.dto.CategoryResponse;
import kr.or.connect.reservation.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {
	private final CategoryDao categoryDao;

	public CategoryServiceImpl(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}

	@Override
	public CategoryResponse getCategories() {
		List<Category> list = categoryDao.selectAll();
		CategoryResponse categoryResponse = new CategoryResponse(list);

		return categoryResponse;
	}

}
