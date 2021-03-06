/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.app.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.app.entity.Repairs;

/**
 * 报修DAO接口
 * @author huangsc
 * @version 2015-12-14
 */
@MyBatisDao
public interface RepairsDao extends CrudDao<Repairs> {
	
}