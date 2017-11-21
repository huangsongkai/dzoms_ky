package com.dz.kaiying.controller;

//@Controller
//@RequestMapping("/ExportExcel/*")
public class ExportExcelControl {
//
//	/**
//	 * 描述：通过 jquery.form.js 插件提供的ajax方式导出Excel
//	 * @param request
//	 * @param response
//	 * @throws Exception
//	 */
//	@RequestMapping(value="ajaxExport.do",method={RequestMethod.GET,RequestMethod.POST})
//	public  String  ajaxUploadExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
//		System.out.println("通过 jquery.form.js 提供的ajax方式导出文件！");
//		OutputStream os = null;
//		Workbook wb = null;    //工作薄
//
//		try {
//			//模拟数据库取值
//			List<InfoVo> lo = new ArrayList<InfoVo>();
//			for (int i = 0; i < 8; i++) {
//				InfoVo vo = new InfoVo();
//				vo.setCode("110"+i);
//				vo.setDate("2015-11-0"+i);
//				vo.setMoney("1000"+i+".00");
//				vo.setName("北京中支0"+i);
//				lo.add(vo);
//			}
//
//			//导出Excel文件数据
//			ExportExcelUtil util = new ExportExcelUtil();
//			File file =util.getExcelDemoFile("/ExcelDemo/事故模板.xlsx");
//			String sheetName="sheet1";
//			wb = util.writeNewExcel(file, sheetName,lo);
//
//			String fileName="机构码.xlsx";
//			response.setContentType("application/vnd.ms-excel");
//			response.setHeader("Content-disposition", "attachment;filename="+ URLEncoder.encode(fileName, "utf-8"));
//			os = response.getOutputStream();
//			wb.write(os);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		finally{
//			os.flush();
//			os.close();
//			wb.close();
//		}
//		return null;
//	}


}
