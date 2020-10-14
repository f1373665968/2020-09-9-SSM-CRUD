package com.f.crud.controller;

import com.f.crud.bean.Department;
import com.f.crud.bean.Msg;
import com.f.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author shkstart
 * @create 2020-09-12-10:55
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDept(){
        List<Department> list = departmentService.getDepts();
        Msg msg = Msg.success();
        msg.add("depts", list);
        return msg;
    }




}
