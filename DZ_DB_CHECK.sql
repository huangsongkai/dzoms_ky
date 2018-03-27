-- 检查数据库中是否存在错误数据
SELECT (CASE WHEN
(SELECT COUNT(*)
FROM vehicle
WHERE LENGTH(TRIM(carframe_num))!=LENGTH(carframe_num))>0 THEN '未通过' 
ELSE '通过' END) as 车架号空格
, (CASE WHEN 
(SELECT COUNT(*)
FROM vehicle
WHERE UPPER(carframe_num)!=carframe_num COLLATE utf8_bin)>0 THEN '未通过' 
ELSE '通过' END) as 车架号大小写
, (CASE WHEN 
(SELECT COUNT(*)
FROM vehicle
WHERE LENGTH(TRIM(license_num))!=LENGTH(license_num))>0 THEN '未通过' 
ELSE '通过' END) as 车牌号空格
, (CASE WHEN 
(SELECT COUNT(*)
FROM vehicle
WHERE UPPER(license_num)!=license_num COLLATE utf8_bin)>0 THEN '未通过' 
ELSE '通过' END) as 车牌号大小写
, (CASE WHEN 
(SELECT COUNT(*)
FROM insurance
WHERE LENGTH(TRIM(insurance_num))!=LENGTH(insurance_num))>0 THEN '未通过' 
ELSE '通过' END) as 保险号空格
, (CASE WHEN 
(SELECT COUNT(*)
FROM insurance
WHERE UPPER(insurance_num)!=insurance_num COLLATE utf8_bin)>0 THEN '未通过' 
ELSE '通过' END) as 保险号大小写
, (CASE WHEN 
(SELECT COUNT(*)
FROM driver
WHERE LENGTH(TRIM(id_num))!=LENGTH(id_num))>0 THEN '未通过' 
ELSE '通过' END) as 身份证空格
, (CASE WHEN 
(SELECT COUNT(*)
FROM driver
WHERE UPPER(id_num)!=id_num COLLATE utf8_bin)>0 THEN '未通过' 
ELSE '通过' END) as 身份证大小写
, (CASE WHEN 
(SELECT COUNT(*)
FROM driver
WHERE LENGTH(TRIM(name))!=LENGTH(name))>0 THEN '未通过' 
ELSE '通过' END) as 姓名空格
, (CASE WHEN 
(SELECT COUNT(*) FROM bank_card WHERE LENGTH(cardNumber)!=LENGTH(TRIM(cardNumber)))>0 THEN '未通过' 
ELSE '通过' END) as 银行卡空格
, (CASE WHEN 
(SELECT COUNT(*) FROM contract WHERE carframe_num is not NULL AND state>=0 AND carframe_num not in (SELECT carframe_num FROM vehicle))>0 THEN '未通过' 
ELSE '通过' END) as 合同车架号验证
, (CASE WHEN 
(SELECT COUNT(*) FROM contract WHERE car_num is not NULL AND state>=0 AND car_num not in (SELECT license_num FROM vehicle))>0 THEN '未通过' 
ELSE '通过' END) as 合同车牌号验证;



-- 修复姓名空格问题
UPDATE driver SET `name`=TRIM(`name`);

-- 修复保险号大小写问题
UPDATE insurance SET `insurance_num`=UPPER(`insurance_num`);

-- 修复身份证号大小写问题
UPDATE driver SET `id_num`=UPPER(`id_num`);
UPDATE contract SET id_num = UPPER(id_num);
UPDATE vehicle 
SET driver_id = UPPER(driver_id),
first_driver=UPPER(first_driver),
second_driver=UPPER(second_driver),
third_driver=UPPER(third_driver),
forth_driver=UPPER(forth_driver),
temp_driver=UPPER(temp_driver);
UPDATE bank_card SET idNumber = UPPER(idNumber);
UPDATE driverincar SET id_number = UPPER(id_number);
UPDATE meeting_check SET id_num = UPPER(id_num);


-- 清除当前不在车驾驶员的指纹编号
UPDATE driver SET fingerprint_num=NULL WHERE is_in_car=0 OR is_in_car IS NULL ;



