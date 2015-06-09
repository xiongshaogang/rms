/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.contract.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.inventory.entity.Building;
import com.thinkgem.jeesite.modules.inventory.entity.House;
import com.thinkgem.jeesite.modules.inventory.entity.PropertyProject;
import com.thinkgem.jeesite.modules.inventory.entity.Room;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 定金协议Entity
 * @author huangsc
 * @version 2015-06-09
 */
public class DepositAgreement extends DataEntity<DepositAgreement> {
	
	private static final long serialVersionUID = 1L;
	private PropertyProject propertyProject;		// 物业项目
	private Building building;		// 楼宇
	private House house;		// 房屋
	private Room room;		// 房间
	private String rentMode;		// 出租方式
	private User user;		// 销售
	private String agreementName;		// 定金协议名称
	private Date startDate;		// 协议开始时间
	private Date expiredDate;		// 协议结束时间
	private Date signDate;		// 协议签订时间
	private Integer renMonths;		// 首付房租月数
	private Integer depositMonths;		// 房租押金月数
	private Date agreementDate;		// 约定合同签约时间
	private Double depositAmount;		// 定金金额
	private Double housingRent;		// 房屋租金
	private String agreementStatus;		// 定金协议审核状态
	private String agreementBusiStatus;		// 定金协议业务状态
	
	public DepositAgreement() {
		super();
	}

	public DepositAgreement(String id){
		super(id);
	}

	@NotNull(message="物业项目不能为空")
	public PropertyProject getPropertyProject() {
		return propertyProject;
	}

	public void setPropertyProject(PropertyProject propertyProject) {
		this.propertyProject = propertyProject;
	}
	
	@NotNull(message="楼宇不能为空")
	public Building getBuilding() {
		return building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}
	
	@NotNull(message="房屋不能为空")
	public House getHouse() {
		return house;
	}

	public void setHouse(House house) {
		this.house = house;
	}
	
	@Length(min=1, max=64, message="房间长度必须介于 1 和 64 之间")
	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}
	
	@Length(min=1, max=64, message="出租方式长度必须介于 1 和 64 之间")
	public String getRentMode() {
		return rentMode;
	}

	public void setRentMode(String rentMode) {
		this.rentMode = rentMode;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=100, message="定金协议名称长度必须介于 1 和 100 之间")
	public String getAgreementName() {
		return agreementName;
	}

	public void setAgreementName(String agreementName) {
		this.agreementName = agreementName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="协议开始时间不能为空")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="协议结束时间不能为空")
	public Date getExpiredDate() {
		return expiredDate;
	}

	public void setExpiredDate(Date expiredDate) {
		this.expiredDate = expiredDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="协议签订时间不能为空")
	public Date getSignDate() {
		return signDate;
	}

	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}
	
	@NotNull(message="首付房租月数不能为空")
	public Integer getRenMonths() {
		return renMonths;
	}

	public void setRenMonths(Integer renMonths) {
		this.renMonths = renMonths;
	}
	
	@NotNull(message="房租押金月数不能为空")
	public Integer getDepositMonths() {
		return depositMonths;
	}

	public void setDepositMonths(Integer depositMonths) {
		this.depositMonths = depositMonths;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="约定合同签约时间不能为空")
	public Date getAgreementDate() {
		return agreementDate;
	}

	public void setAgreementDate(Date agreementDate) {
		this.agreementDate = agreementDate;
	}
	
	public Double getDepositAmount() {
		return depositAmount;
	}

	public void setDepositAmount(Double depositAmount) {
		this.depositAmount = depositAmount;
	}
	
	public Double getHousingRent() {
		return housingRent;
	}

	public void setHousingRent(Double housingRent) {
		this.housingRent = housingRent;
	}
	
	@Length(min=0, max=64, message="定金协议审核状态长度必须介于 0 和 64 之间")
	public String getAgreementStatus() {
		return agreementStatus;
	}

	public void setAgreementStatus(String agreementStatus) {
		this.agreementStatus = agreementStatus;
	}
	
	@Length(min=0, max=64, message="定金协议业务状态长度必须介于 0 和 64 之间")
	public String getAgreementBusiStatus() {
		return agreementBusiStatus;
	}

	public void setAgreementBusiStatus(String agreementBusiStatus) {
		this.agreementBusiStatus = agreementBusiStatus;
	}
	
}