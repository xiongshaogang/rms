/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.funds.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.common.entity.Attachment;
import com.thinkgem.jeesite.modules.common.service.AttachmentService;
import com.thinkgem.jeesite.modules.contract.enums.PaymentTransStatusEnum;
import com.thinkgem.jeesite.modules.contract.enums.PaymentTransTypeEnum;
import com.thinkgem.jeesite.modules.contract.enums.TradeDirectionEnum;
import com.thinkgem.jeesite.modules.contract.enums.TradeTypeEnum;
import com.thinkgem.jeesite.modules.contract.enums.TradingAccountsStatusEnum;
import com.thinkgem.jeesite.modules.fee.dao.ElectricFeeDao;
import com.thinkgem.jeesite.modules.fee.entity.ElectricFee;
import com.thinkgem.jeesite.modules.funds.dao.PaymentTradeDao;
import com.thinkgem.jeesite.modules.funds.dao.PaymentTransDao;
import com.thinkgem.jeesite.modules.funds.dao.TradingAccountsDao;
import com.thinkgem.jeesite.modules.funds.entity.PaymentTrade;
import com.thinkgem.jeesite.modules.funds.entity.PaymentTrans;
import com.thinkgem.jeesite.modules.funds.entity.Receipt;
import com.thinkgem.jeesite.modules.funds.entity.TradingAccounts;

/**
 * @author wangshujin
 */
@Service
@Transactional(readOnly = true)
public class PaymentTransService extends CrudService<PaymentTransDao, PaymentTrans> {
  @Autowired
  private ElectricFeeDao electricFeeDao;
  @Autowired
  private TradingAccountsDao tradingAccountsDao;
  @Autowired
  private PaymentTradeDao paymentTradeDao;
  @Autowired
  private ReceiptService receiptService;
  @Autowired
  private AttachmentService attachmentService;

  @Transactional(readOnly = false)
  public String generateAndSavePaymentTrans(String tradeType, String paymentType, String transId, String tradeDirection, Double tradeAmount, Double lastAmount, Double transAmount, String transStatus,
      Date startDate, Date expiredDate) {
    String id = "";
    if (null != tradeAmount && tradeAmount > 0) {
      PaymentTrans paymentTrans = new PaymentTrans();
      paymentTrans.setTradeType(tradeType);
      paymentTrans.setPaymentType(paymentType);
      paymentTrans.setTransId(transId);
      paymentTrans.setTradeDirection(tradeDirection);
      paymentTrans.setStartDate(startDate);
      paymentTrans.setExpiredDate(expiredDate);
      paymentTrans.setTradeAmount(tradeAmount);
      paymentTrans.setLastAmount(lastAmount);
      paymentTrans.setTransAmount(transAmount);
      paymentTrans.setTransStatus(transStatus);
      id = super.saveAndReturnId(paymentTrans);
    }
    return id;
  }

  /**
   * 删除对象下所有的款项，账务，款项账务关联关系，以及相关收据
   */
  @Transactional(readOnly = false)
  public void deletePaymentTransAndTradingAcctouns(String objectID) {
    // 删除款项记录
    PaymentTrans delPaymentTrans = new PaymentTrans();
    delPaymentTrans.setTransId(objectID);
    delPaymentTrans.preUpdate();
    dao.delete(delPaymentTrans);
    // 删除款项账务的关联关系、收据、附件
    TradingAccounts tradingAccounts = new TradingAccounts();
    tradingAccounts.setTradeId(objectID);
    tradingAccounts.setTradeStatus(TradingAccountsStatusEnum.TO_AUDIT.getValue());
    List<TradingAccounts> list = tradingAccountsDao.findList(tradingAccounts);
    if (CollectionUtils.isNotEmpty(list)) {
      for (TradingAccounts tmpTradingAccounts : list) {
        PaymentTrade pt = new PaymentTrade();
        pt.setTradeId(tmpTradingAccounts.getId());
        pt.preUpdate();
        paymentTradeDao.delete(pt);
        Receipt receipt = new Receipt();
        receipt.setTradingAccounts(tmpTradingAccounts);
        receipt.preUpdate();
        receiptService.delete(receipt);
        Attachment attachment = new Attachment();
        attachment.setTradingAccountsId(tmpTradingAccounts.getId());
        attachmentService.delete(attachment);
      }
    }
    // 删除账务交易记录
    tradingAccounts.preUpdate();
    tradingAccountsDao.delete(tradingAccounts);
    // 如果合同有同步的电费充值金额，需要把同时生成的电费充值记录删除
    ElectricFee ele = new ElectricFee();
    ele.preUpdate();
    ele.setRentContractId(objectID);
    electricFeeDao.delete(ele);
  }

  /**
   * 退租，删除未到账的款项，包括： 交易类型【新签合同、正常人工续签、逾期自动续签】；款项类型【房租金额、水费金额、燃气金额、有线电视费、宽带费、服务费】。
   */
  @Transactional(readOnly = false)
  public void deleteNotSignPaymentTrans(String rentContractId) {
    PaymentTrans p = new PaymentTrans();
    p.preUpdate();
    p.setTransId(rentContractId);
    p.setTradeDirection(TradeDirectionEnum.IN.getValue());
    p.setTransStatus(PaymentTransStatusEnum.NO_SIGN.getValue());
    p.setPaymentType(PaymentTransTypeEnum.RENT_AMOUNT.getValue());
    delete3TradeType(p);
    p.setPaymentType(PaymentTransTypeEnum.WATER_AMOUNT.getValue());
    delete3TradeType(p);
    p.setPaymentType(PaymentTransTypeEnum.GAS_AMOUNT.getValue());
    delete3TradeType(p);
    p.setPaymentType(PaymentTransTypeEnum.TV_AMOUNT.getValue());
    delete3TradeType(p);
    p.setPaymentType(PaymentTransTypeEnum.NET_AMOUNT.getValue());
    delete3TradeType(p);
    p.setPaymentType(PaymentTransTypeEnum.SERVICE_AMOUNT.getValue());
    delete3TradeType(p);
  }

  private void delete3TradeType(PaymentTrans p) {
    p.setTradeType(TradeTypeEnum.SIGN_NEW_CONTRACT.getValue());
    dao.delete(p);
    p.setTradeType(TradeTypeEnum.NORMAL_RENEW.getValue());
    dao.delete(p);
    p.setTradeType(TradeTypeEnum.OVERDUE_AUTO_RENEW.getValue());
    dao.delete(p);
  }

  /**
   * 检查退租时，合同下是否还有未到账的款项，有返回true，无返回false
   */
  @Transactional(readOnly = true)
  public boolean checkNotSignedPaymentTrans(String rentContractId) {
    boolean paymentTransFlag = false;
    PaymentTrans paymentTrans = new PaymentTrans();
    paymentTrans.setTransId(rentContractId);
    List<PaymentTrans> paymentTransList = super.findList(paymentTrans);
    if (CollectionUtils.isNotEmpty(paymentTransList)) {
      for (PaymentTrans tmpPaymentTrans : paymentTransList) {
        if (!PaymentTransStatusEnum.WHOLE_SIGN.getValue().equals(tmpPaymentTrans.getTransStatus())) {
          paymentTransFlag = true;
          break;
        }
      }
    }
    return paymentTransFlag;
  }
}
