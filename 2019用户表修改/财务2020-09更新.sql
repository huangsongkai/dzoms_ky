ALTER TABLE `charge_plan` ADD COLUMN `is_disabled`  tinyint(1) NULL DEFAULT 0 AFTER `batchPlan_id`;

ALTER TABLE `charge_plan` ADD COLUMN `balance`  decimal(10,2) NULL DEFAULT NULL AFTER `is_disabled`;

CREATE TABLE `income_divide` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`month_plan_id`  int(11) NULL DEFAULT NULL ,
`income_id`  int(11) NULL DEFAULT NULL COMMENT '收入的ID' ,
`amount`  decimal(10,2) NULL DEFAULT NULL ,
`type`  tinyint(4) NULL DEFAULT 0 COMMENT '0-支付月计划 1-支付提款' ,
PRIMARY KEY (`id`)
)
DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `month_plan` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`contract_id`  int(11) NULL DEFAULT NULL ,
`carframe_num`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL ,
`time`  date NULL DEFAULT NULL COMMENT '月份' ,
`plan_all`  decimal(10,2) NULL DEFAULT NULL ,
`arrear`  decimal(10,2) NULL DEFAULT NULL COMMENT '欠款' ,
PRIMARY KEY (`id`)
)
DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_general_ci;

--- 2020年之前的计划设为失效内容
UPDATE charge_plan SET is_disabled=1 WHERE time < '2020-01-01';
UPDATE charge_plan SET is_disabled=0 WHERE time >= '2020-01-01' and is_disabled is null;

--- 已废止合同 超过废止月的约定设为失效内容
UPDATE
charge_plan AS cp ,
contract AS c
SET cp.is_disabled=1
WHERE
cp.contract_id = c.id AND
c.state = 1
AND YEAR(cp.time)*12+MONTH(cp.time)>YEAR(c.abandoned_final_time)*12+MONTH(c.abandoned_final_time)
AND cp.isClear=1;

--- 设置balance
UPDATE charge_plan SET balance=fee WHERE fee_type LIKE 'add_%';
UPDATE charge_plan SET balance=-fee WHERE fee_type LIKE 'sub_%';

--- 转入2020-01前的余额
SELECT
ct.contractId,
ct.carNumber,
ct.dept,
ct.thisMonthTotalOwe,
ct.time
FROM
checkchargetable AS ct
WHERE
YEAR(ct.time) = 2019
AND month(ct.time) = 12
AND ct.thisMonthTotalOwe!=0;

INSERT INTO `charge_plan` 
(`contract_id`,`fee`, `balance`,`time`,
`fee_type`, `isClear`, `register`, `inTime`,`comment`,`is_disabled` )
SELECT
ct.contractId,
ct.thisMonthTotalOwe,
ct.thisMonthTotalOwe,
ct.time,
'add_other',
1,
'admin',
CURRENT_TIMESTAMP(),
'2020-01上年余额转入',
0
FROM
checkchargetable AS ct
WHERE
YEAR(ct.time) = 2019
AND month(ct.time) = 12
AND ct.thisMonthTotalOwe!=0;


--- 查询历史计划中金额为负的并修正
SELECT
id,
contract_id,
fee_type,
fee,
time,
inTime,
batchPlan_id
FROM charge_plan
WHERE
fee<0
AND time>='2020-01';

DROP TABLE charge_plan_deleted;
-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=809;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=809;
	DELETE FROM batchplan WHERE id=809;
	
	UPDATE batchplan SET fee=193 WHERE id=839;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=839;
-- END;

-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=807;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=807;
	DELETE FROM batchplan WHERE id=807;
	UPDATE batchplan SET fee=193 WHERE id=808;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=808;
-- END;

-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=823;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=823;
	DELETE FROM batchplan WHERE id=823;
	UPDATE batchplan SET fee=193 WHERE id=841;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=841;
-- END;

-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=824;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=824;
	DELETE FROM batchplan WHERE id=824;
	UPDATE batchplan SET fee=193 WHERE id=842;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=842;
-- END;


-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=826;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=826;
	DELETE FROM batchplan WHERE id=826;
	UPDATE batchplan SET fee=193 WHERE id=843;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=843;
-- END;


-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=827;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=827;
	DELETE FROM batchplan WHERE id=827;
	UPDATE batchplan SET fee=193 WHERE id=844;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=844;
-- END;


-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=828;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=828;
	DELETE FROM batchplan WHERE id=828;
	UPDATE batchplan SET fee=193 WHERE id=845;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=845;
-- END;

-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=831;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=831;
	DELETE FROM batchplan WHERE id=831;
	UPDATE batchplan SET fee=193 WHERE id=846;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=846;
-- END;


-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=836;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=836;
	DELETE FROM batchplan WHERE id=836;
	UPDATE batchplan SET fee=193 WHERE id=847;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=847;
-- END;


-- BEGIN
	DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=837;
	DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=837;
	DELETE FROM batchplan WHERE id=837;
	UPDATE batchplan SET fee=193 WHERE id=838;
	UPDATE charge_plan SET fee=fee/2.0 WHERE batchPlan_id=838;
-- END;


--- id=427 合同 有一条 简单删除
delete from charge_plan where id=259542;

delete from charge_plan where id=262801;
delete from charge_plan where id=264366;

delete from charge_plan where id=263768;
delete from charge_plan where id=264565;

DELETE FROM batchplan_contractidlist WHERE BatchPlan_id=2255;
DELETE FROM charge_plan WHERE charge_plan.batchPlan_id=2255;
DELETE FROM batchplan WHERE id=2255;
delete from charge_plan where id=264588;
delete from charge_plan where id=237920;
UPDATE charge_plan SET fee=193 WHERE id=237921;

delete from charge_plan where id=267888;
delete from charge_plan where id=267938;
delete from charge_plan where id=267939;
delete from charge_plan where id=268005;

delete from charge_plan where id=268002;
delete from charge_plan where id=268003;

delete from charge_plan where id=268006;
delete from charge_plan where id=268007;


UPDATE charge_plan
SET fee_type=CONCAT('sub',SUBSTR(fee_type FROM 4)),fee=-fee
WHERE
fee<0
AND time>='2020-01-01'
AND fee_type LIKE 'add_%';


--- 后续通过页面依次生成月计划、进行金额分配即可。



--- 处理提款
SELECT
cp.id,
cp.contract_id,
cp.time,
cp.fee_type,
cp.fee,
cp.balance
FROM
charge_plan AS cp
WHERE
cp.is_disabled=0 AND
cp.balance<0
AND cp.time>'2020-01'


--- 1.优先使用当月进行提款
SELECT
cp.id,
cp.contract_id,
cp.time,
cp.fee_type,
cp.fee,
cp2.id,
cp2.fee_type,
cp2.fee
FROM
charge_plan AS cp,charge_plan cp2
WHERE
cp.balance<0
AND cp2.balance>0
AND cp.time>'2020-01'
AND cp2.contract_id=cp.contract_id
AND MONTH(cp.time)=MONTH(cp2.time)
AND SUBSTR(cp.fee_type FROM 4)=SUBSTR(cp2.fee_type FROM 4);


BEGIN
	#Routine body goes here...
	DECLARE _mp_id int;
	DECLARE _cp_id int;
  DECLARE _fee DECIMAL(10,2);	

	DECLARE singal int default 0;
	DECLARE rs CURSOR FOR SELECT
		cp.id,
		cp2.id
		FROM
		charge_plan AS cp,charge_plan AS cp2
		WHERE
		cp.balance<0
		AND cp2.balance>0
		AND cp.time>'2020-01'
		AND cp2.contract_id=cp.contract_id
		AND MONTH(cp.time)=MONTH(cp2.time)
		AND SUBSTR(cp.fee_type FROM 4)=SUBSTR(cp2.fee_type FROM 4);


	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET singal=1;  

	OPEN rs;  
	fetch  rs into _mp_id,_cp_id;
	while singal <> 1 do 
		SELECT -balance INTO _fee FROM charge_plan WHERE id=_mp_id;
		SELECT (case WHEN balance>_fee THEN _fee ELSE balance END) INTO _fee FROM charge_plan WHERE id=_cp_id;
		INSERT INTO `income_divide` (`month_plan_id`, `income_id`, `amount`,type) VALUES (_mp_id, _cp_id, _fee,1);
		UPDATE charge_plan AS mp,charge_plan AS cp 
		SET	cp.balance = cp.balance - _fee, mp.balance=mp.balance + _fee
		WHERE mp.id=_mp_id AND cp.id = _cp_id;

		fetch  rs into _mp_id,_cp_id;
	end while;  
  CLOSE rs;    
END

--- 2.使用前几个月余额提款





