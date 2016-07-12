--t_rent_contract
ALTER TABLE `rms`.`t_rent_contract` 
  ADD INDEX `CONTRACT_ID_INX` (`CONTRACT_ID`),
  ADD INDEX `AGREEMENT_ID_INX` (`AGREEMENT_ID`),
  ADD INDEX `RENT_MODE_INX` (`RENT_MODE`),
  ADD INDEX `PROPERTY_PROJECT_ID_INX` (`PROPERTY_PROJECT_ID`),
  ADD INDEX `BUILDING_ID_INX` (`BUILDING_ID`),
  ADD INDEX `HOUSE_ID_INX` (`HOUSE_ID`),
  ADD INDEX `ROOM_ID_INX` (`ROOM_ID`),
  ADD INDEX `CONTRACT_STATUS_INX` (`CONTRACT_STATUS`),
  ADD INDEX `CONTRACT_BUSI_STATUS_INX` (`CONTRACT_BUSI_STATUS`),
  ADD INDEX `DEL_FLAG_INX` (`DEL_FLAG`) ,
  ADD INDEX `CONTRACT_CODE_INX` (`CONTRACT_CODE`),
  ADD INDEX `CONTRACT_NAME_INX` (`CONTRACT_NAME`),
  ADD INDEX `START_DATE_INX` (`START_DATE`),
  ADD INDEX `EXPIRED_DATE_INX` (`EXPIRED_DATE`);

--t_trading_accounts
ALTER TABLE `rms`.`t_trading_accounts` 
  ADD INDEX `TRADE_ID_INX` (`TRADE_ID`),
  ADD INDEX `TRADE_TYPE_INX` (`TRADE_TYPE`),
  ADD INDEX `TRADE_DIRECTION_INX` (`TRADE_DIRECTION`),
  ADD INDEX `TRADE_STATUS_INX` (`TRADE_STATUS`),
  ADD INDEX `DEL_FLAG_INX` (`DEL_FLAG`) ;
 
--t_payment_trans
ALTER TABLE `rms`.`t_payment_trans` 
  ADD INDEX `TRADE_TYPE_INX` (`TRADE_TYPE`),
  ADD INDEX `PAYMENT_TYPE_INX` (`PAYMENT_TYPE`),
  ADD INDEX `TRANS_ID_INX` (`TRANS_ID`),
  ADD INDEX `TRADE_DIRECTION_INX` (`TRADE_DIRECTION`),
  ADD INDEX `TRANS_STATUS_INX` (`TRANS_STATUS`),
  ADD INDEX `DEL_FLAG_INX` (`DEL_FLAG`),
  ADD INDEX `START_DATE_INX` (`START_DATE`),
  ADD INDEX `EXPIRED_DATE_INX` (`EXPIRED_DATE`) ;

--t_payment_trade
ALTER TABLE `rms`.`t_payment_trade` 
  ADD INDEX `TRANS_ID_INX` (`TRANS_ID`),
  ADD INDEX `TRADE_ID_INX` (`TRADE_ID`),
  ADD INDEX `DEL_FLAG_INX` (`DEL_FLAG`);

--t_tenant
ALTER TABLE `rms`.`t_tenant` 
  ADD INDEX `USER_ID_INX` (`USER_ID`),
  ADD INDEX `COMPANY_ID_INX` (`COMPANY_ID`),
  ADD INDEX `TENANT_NAME_INX` (`TENANT_NAME`),
  ADD INDEX `GENDER_INX` (`GENDER`),
  ADD INDEX `TENANT_TYPE_INX` (`TENANT_TYPE`),
  ADD INDEX `DEL_FLAG_INX` (`DEL_FLAG`) ;