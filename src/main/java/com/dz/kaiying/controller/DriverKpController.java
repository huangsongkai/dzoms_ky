package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.DriverKpDTO;
import com.dz.kaiying.DTO.DriverKpToExcelDTO;
import com.dz.kaiying.model.DriverKpParams;
import com.dz.kaiying.model.DriverKpParamsDTO;
import com.dz.kaiying.model.Electric;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.service.DriverKpService;
import com.dz.kaiying.util.ExportExcelUtil;
import com.dz.kaiying.util.Result;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    HibernateDao<Electric,Integer> wzHibernateDao;

    @RequestMapping(value = "/downloadExcel/{year}", method = RequestMethod.GET)
    public void excl(HttpServletResponse response,@PathVariable String year)throws Exception{//HttpServletRequest request, HttpServletResponse response){
        List<DriverKpDTO> driverKps=driverKpService.getDtosByYear(year);//Time("","");
        List<DriverKpToExcelDTO> dkExcelDTOList= new ArrayList<DriverKpToExcelDTO>();
        for (DriverKpDTO dkDTO:driverKps) {
            DriverKpToExcelDTO excel=new DriverKpToExcelDTO();
            BeanUtils.copyProperties(dkDTO,excel);
            dkExcelDTOList.add(excel);
        }
        ExportExcelUtil eeu=new ExportExcelUtil();
        eeu.getExcel(dkExcelDTOList,response,year);
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index () throws Exception {
        return "driverKp/index";
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
        return success("success", driverKpService.getDtosByYear(year));
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

