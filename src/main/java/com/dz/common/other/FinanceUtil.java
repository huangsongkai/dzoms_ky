package com.dz.common.other;

import java.util.HashMap;
import java.util.InputMismatchException;
import java.util.Map;

public class FinanceUtil {
	private static final int ACCOUNT_DAY = 27;
	private static final int PERIOD = 30;
	private static double initMonFee = 4500;
	private static double maxMonFeeTroughput = 450;
	private static Map<String, Double> monFeeGrowthRate = new HashMap<String, Double>();

	public FinanceUtil() {

	}

	/**
	 * 初始化不同年份月租金增长率hash映射
	 */
	public static void setMonFeeGrowthRate() {
		monFeeGrowthRate.put("2010", 0.23);
		monFeeGrowthRate.put("2011", 0.15);
		monFeeGrowthRate.put("2012", 0.10);
		monFeeGrowthRate.put("2013", 0.10);
	}

	/**
	 * 获取租金增长率hash map
	 * 
	 * @return monFeeGrowthRate
	 */
	public static Map<String, Double> getMonFeeGrowthRate() {
		return monFeeGrowthRate;
	}

	public static double getInitMonFee() {
		return initMonFee;
	}

	public static void setInitMonFee(double initMonFee) {
		FinanceUtil.initMonFee = initMonFee;
	}

	public static double getMaxMonFeeTroughput() {
		return maxMonFeeTroughput;
	}

	public static void setMaxMonFeeTroughput(double maxMonFeeTroughput) {
		FinanceUtil.maxMonFeeTroughput = maxMonFeeTroughput;
	}

	/**
	 * 计算废业剩余租金
	 * 
	 * @param pRent
	 *            计划租金
	 * @param aMon
	 *            废业月份
	 * @return 剩余缴纳月租金
	 */
	public static double getAbandonFee(double pRent, int aMon) {
		String[] dateStr = TimeComm.getDateOfMon().split("-");
		int cMon = Integer.parseInt(dateStr[0]);
		int cDate = Integer.parseInt(dateStr[1]);
		// int cMon = 2;
		// int cDate = 28;

		int days = 0;
		double restRent = 0;

		if (cDate < ACCOUNT_DAY) {
			days = cDate + 4;
		} else {
			days = cDate - ACCOUNT_DAY + 1;
		}

		if (cDate == 31) {
			days--;
		}

		restRent += (pRent / PERIOD) * days;
		// 判断是否是提前废业
		if (((aMon - cMon == 1) && (cDate < ACCOUNT_DAY)) || (aMon - cMon > 1)) {
			if (cDate < ACCOUNT_DAY) {
				restRent += (aMon - cMon) * (pRent - 360 - 25);
			} else {
				restRent += (aMon - cMon - 1) * (pRent - 360 - 25);
			}
		}

		return restRent;
	}

	/**
	 * 计算车辆转包的月租金费用
	 * 
	 * @param origMonRent
	 *            转包前月租金
	 * @param subcontractMonRent
	 *            转包后月租金
	 * @return 转包月租金费用
	 */
	public static double getSubcontractFee(double origMonRent,
			double subcontractMonRent) {
		String[] dateStr = TimeComm.getDateOfMon().split("-");
		int cDate = Integer.parseInt(dateStr[1]);
		int days = 0;

		if (cDate < ACCOUNT_DAY) {
			days = cDate + 4;
		} else {
			days = cDate - ACCOUNT_DAY + 1;
		}

		double subcontractFee = (origMonRent / PERIOD) * days
				+ (subcontractMonRent / PERIOD) * (PERIOD - days);

		return subcontractFee;
	}

	/**
	 * 计算车辆转包后的月租金
	 * 
	 * @param origMonRent
	 *            转包前的月租金
	 * @param vehicleApprovalYear
	 *            车辆开业年限
	 * @return 转包后月租金
	 */
	public static double getSubcontractMonFee(double origMonRent,
			int vehicleApprovalYear) {
		double subcontractMonFee = initMonFee;

		if (vehicleApprovalYear < 2014) {
			if (getMonFeeGrowthRate().size() == 0) {
				setMonFeeGrowthRate();
			}

			double troughput = origMonRent
					* getMonFeeGrowthRate().get(vehicleApprovalYear + "");
			// 判断是否超过最大增长额
			if (troughput > maxMonFeeTroughput) {
				troughput = maxMonFeeTroughput;
			}

			subcontractMonFee = origMonRent + troughput;
		}

		return subcontractMonFee;
	}

	public static String convert2Chinese(double number) {
		StringBuffer chineseNumber = new StringBuffer();
		String[] num = { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
		String[] unit = { "分", "角", "圆", "拾", "佰", "仟", "万", "拾", "佰", "仟",
				"亿", "拾", "佰", "仟", "万" };
		String tempNumber = String.valueOf(Math.round((number * 100)));
		int tempNumberLength = tempNumber.length();
		if ("0".equals(tempNumber)) {
			return "零圆整";
		}
		if (tempNumberLength > 15) {
			throw new InputMismatchException("超出转化范围");
		}
		boolean preReadZero = true; // 前面的字符是否读零
		for (int i = tempNumberLength; i > 0; i--) {
			if ((tempNumberLength - i + 2) % 4 == 0) {
				// 如果在（圆，万，亿，万）位上的四个数都为零,如果标志为未读零，则只读零，如果标志为已读零，则略过这四位
				if (i - 4 >= 0 && "0000".equals(tempNumber.substring(i - 4, i))) {
					if (!preReadZero) {
						chineseNumber.insert(0, "零");
						preReadZero = true;
					}
					i -= 3; // 下面还有一个i--
					continue;
				}
				// 如果当前位在（圆，万，亿，万）位上，则设置标志为已读零（即重置读零标志）
				preReadZero = true;
			}
			Integer digit = Integer.parseInt(tempNumber.substring(i - 1, i));
			if (digit == 0) {
				// 如果当前位是零并且标志为未读零，则读零，并设置标志为已读零
				if (!preReadZero) {
					chineseNumber.insert(0, "零");
					preReadZero = true;
				}
				// 如果当前位是零并且在（圆，万，亿，万）位上，则读出（圆，万，亿，万）
				if ((tempNumberLength - i + 2) % 4 == 0) {
					chineseNumber.insert(0, unit[tempNumberLength - i]);
				}
			}
			// 如果当前位不为零，则读出此位，并且设置标志为未读零
			else {
				chineseNumber
						.insert(0, num[digit] + unit[tempNumberLength - i]);
				preReadZero = false;
			}
		}
		// 如果分角两位上的值都为零，则添加一个“整”字
		if (tempNumberLength - 2 >= 0
				&& "00".equals(tempNumber.substring(tempNumberLength - 2,
						tempNumberLength))) {
			chineseNumber.append("整");
		}
		return chineseNumber.toString();
	}

	public static void main(String[] args) {
		FinanceUtil.getSubcontractFee(4800, 5000);
		String res = FinanceUtil.convert2Chinese(56);
		System.out.println(res);
	}
}
