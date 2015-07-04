/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.fee.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.fee.entity.NormalFee;
import com.thinkgem.jeesite.modules.fee.service.NormalFeeService;

/**
 * 一般费用结算Controller
 * @author huangsc
 * @version 2015-07-04
 */
@Controller
@RequestMapping(value = "${adminPath}/fee/normalFee")
public class NormalFeeController extends BaseController {

	@Autowired
	private NormalFeeService normalFeeService;
	
	@ModelAttribute
	public NormalFee get(@RequestParam(required=false) String id) {
		NormalFee entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = normalFeeService.get(id);
		}
		if (entity == null){
			entity = new NormalFee();
		}
		return entity;
	}
	
	@RequiresPermissions("fee:normalFee:view")
	@RequestMapping(value = {"list", ""})
	public String list(NormalFee normalFee, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<NormalFee> page = normalFeeService.findPage(new Page<NormalFee>(request, response), normalFee); 
		model.addAttribute("page", page);
		return "modules/fee/normalFeeList";
	}

	@RequiresPermissions("fee:normalFee:view")
	@RequestMapping(value = "form")
	public String form(NormalFee normalFee, Model model) {
		model.addAttribute("normalFee", normalFee);
		return "modules/fee/normalFeeForm";
	}

	@RequiresPermissions("fee:normalFee:edit")
	@RequestMapping(value = "save")
	public String save(NormalFee normalFee, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, normalFee)){
			return form(normalFee, model);
		}
		normalFeeService.save(normalFee);
		addMessage(redirectAttributes, "保存一般费用结算成功");
		return "redirect:"+Global.getAdminPath()+"/fee/normalFee/?repage";
	}
	
	@RequiresPermissions("fee:normalFee:edit")
	@RequestMapping(value = "delete")
	public String delete(NormalFee normalFee, RedirectAttributes redirectAttributes) {
		normalFeeService.delete(normalFee);
		addMessage(redirectAttributes, "删除一般费用结算成功");
		return "redirect:"+Global.getAdminPath()+"/fee/normalFee/?repage";
	}

}