package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.DriverKpDTO;
import com.dz.kaiying.DTO.DriverKpToExcelDTO;
import com.dz.kaiying.DTO.DriverKpToExcelDTO1;
import com.dz.kaiying.model.DriverKpParams;
import com.dz.kaiying.model.DriverKpParamsDTO;
import com.dz.kaiying.model.Electric;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.service.DriverKpService;
import com.dz.kaiying.service.DriverKpService1;
import com.dz.kaiying.util.ExportExcelUtil;
import com.dz.kaiying.util.ExportExcelUtil1;
import com.dz.kaiying.util.Result;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by song on 2017/7/5.
 */
@Controller
@RequestMapping(value = "/driverKp")
public class DriverKpController extends BaseController{

    @Resource
    DriverKpService driverKpService;
    @Resource
    DriverKpService1 driverKpService1;

    HibernateDao<Electric,Integer> wzHibernateDao;

    @RequestMapping(value = "/downloadExcel/{year}", method = RequestMethod.GET)
    public void excl(HttpServletResponse response,@PathVariable String year)throws Exception{//HttpServletRequest request, HttpServletResponse response){
        String years = year.substring(0,4);
        String month=year.substring(years.length());
        List<DriverKpDTO> driverKps=driverKpService.getDtosByYear(years,month);//Time("","");
        List<DriverKpToExcelDTO> dkExcelDTOList= new ArrayList<DriverKpToExcelDTO>();
        for (DriverKpDTO dkDTO:driverKps) {
            DriverKpToExcelDTO excel=new DriverKpToExcelDTO();
            BeanUtils.copyProperties(dkDTO,excel);
            dkExcelDTOList.add(excel);
        }
        ExportExcelUtil eeu=new ExportExcelUtil();
        eeu.getExcel(dkExcelDTOList,response,year);
    }




    @RequestMapping(value = "/downloadExcel2/{year}", method = RequestMethod.GET)
    public void excl2(HttpServletResponse response,@PathVariable String year)throws Exception{//HttpServletRequest request, HttpServletResponse response){
        System.out.println(year);
        String years = year.substring(0,4);
        String month=year.substring(years.length());
        List<DriverKpDTO> driverKps=driverKpService1.getDtosByYear(years,month);//Time("","");
        List<DriverKpToExcelDTO1> dkExcelDTOList= new ArrayList<DriverKpToExcelDTO1>();
        for (DriverKpDTO dkDTO:driverKps) {
            DriverKpToExcelDTO1 excel=new DriverKpToExcelDTO1();
            BeanUtils.copyProperties(dkDTO,excel);
            dkExcelDTOList.add(excel);
        }
        ExportExcelUtil1 eeu=new ExportExcelUtil1();
        eeu.getExcel(dkExcelDTOList,response,year);
    }









    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index () throws Exception {
        return "driverKp/index";
    }


    @RequestMapping(value = "/index1", method = RequestMethod.GET)
    public String index1 () throws Exception {
        return "driverKp/index1";
    }

    //跳转违章修改页面
    @RequestMapping(value = "getAllElectric")
    public String getAllElectric(Model model){
        List<Electric> electrics = driverKpService.findAll();
        model.addAttribute("electrics",electrics);
        return "driverKp/allElectirc";
    }


    @RequestMapping("add")
    public String add(){
        return "driverKp/add";
    }

    @RequestMapping(value = "addElectric", method = RequestMethod.POST)
    public String addElectric(Electric electric){

        driverKpService.save(electric);
        return  "redirect:/ky/driverKp/getAllElectric";
    }

    @RequestMapping(value = "delElectric",method = RequestMethod.GET)
    public String delElectric(HttpServletRequest request){
        int id=Integer.parseInt(request.getParameter("id"));
        driverKpService.deleteElectric(id);
        return "redirect:/ky/driverKp/getAllElectric";
    }

    @RequestMapping(value = "toUpdateElectric",method = RequestMethod.GET)
    public String toUpdatePerson(int id, Model model){
          Electric electric = driverKpService.getElectric(id);
        model.addAttribute("electric",electric);
        return "driverKp/updateElectric";

    }


    @RequestMapping(value = "updateElectric", method = RequestMethod.POST)
    public String updateElectric(Electric electric){
        driverKpService.updateElectric(electric);
        return "redirect:/ky/driverKp/getAllElectric";
    }





    @RequestMapping(value = "/calc", method = RequestMethod.GET)
        public String calcParams (Model model) throws Exception {
        DriverKpParams driverKpParams = driverKpService.getCalcParams();
        model.addAttribute("driverKpParams",driverKpParams);
            return "driverKp/calc1";
    }

    @ResponseBody
    @RequestMapping(value = "/dtoList/{year}", method = RequestMethod.GET)
    public Result getDtoList (@PathVariable String year) throws Exception {
        String years = year.substring(0,4);
        String month=year.substring(years.length());
//        System.out.println(years+","+month);
        return success("success", driverKpService.getDtosByYear(years,month));
    }
    @ResponseBody
    @RequestMapping(value = "/dtoList1/{year}", method = RequestMethod.GET)
    public Result getDtoList1 (@PathVariable String year) throws Exception {
        String years = year.substring(0,4);
        String month=year.substring(years.length());
        return success("success", driverKpService1.getDtosByYear(years,month));
    }

    @ResponseBody
    @RequestMapping(value = "/dtoList", method = RequestMethod.GET)
    public Result getDtoListDefault () throws Exception {
        return getDtoList("");
    }


//    @ResponseBody
//    @RequestMapping(value = "/calcParams", method = RequestMethod.POST )
//    public Result postCalcParams (@RequestBody DriverKpParamsDTO driverKpParams) throws Exception {
//        driverKpService.updateParams(driverKpParams);
//            return success("success", "");
//
//    }


    @ResponseBody
    @RequestMapping(value = "/calcParams", method = RequestMethod.POST )
    public Result postCalcParams (DriverKpParamsDTO driverKpParams) throws Exception {
        driverKpService.updateParams(driverKpParams);
        return success("success","");

    }


    @ResponseBody
    @RequestMapping(value = "/calcParams", method = RequestMethod.GET)
    public Result getCalcParams () throws Exception {
        DriverKpParams driverKpParams = driverKpService.getCalcParams();
        if(driverKpParams == null)
            return fail("null");
        return success("success", driverKpParams);
    }

}

