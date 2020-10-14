package com.f.crud.controller;

import com.f.crud.bean.Employee;
import com.f.crud.bean.Msg;
import com.f.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author shkstart
 * @create 2020-09-09-16:34
 */
@Controller
public class EmployeeController {


    @Autowired
    private EmployeeService employeeService;

    /**
     * 删除一个或者多个员工
     * @param empId 员工编号
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/deleteEmp/{empId}",method = RequestMethod.DELETE)
    public Msg deleteOneEmp(@PathVariable("empId") String empId){
        if (empId.contains("-")) {
            String[] empIds = empId.split("-");
            employeeService.deleteAnyEmp(Arrays.asList(empIds));
        } else {
            Integer id = Integer.parseInt(empId);
            employeeService.deleteOneEmp(id);
        }
        return Msg.success();
    }

    /**
     * 修改员工信息
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateEmp/{empId}", method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     * @param id 员工编号
     * @return
     */
    @ResponseBody
    @RequestMapping("/getEmp/{id}")
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 邮箱检测
     * @param email
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/checkEmail", method = RequestMethod.GET)
    public Msg checkEmail(@RequestParam(value = "email") String email) {

        boolean result = employeeService.checkEmail(email);
        if (result) {
            Msg msg = Msg.success().add("result", result);
            return msg;
        } else {
            Msg msg = Msg.file().add("result", result);
            return msg;
        }

    }


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getJsonEmployees(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //这里首页需要的是一个分页查询，引入PageHelper分页插件
        //在查询之前只需要调用，传入页码，一级每页的数据条目
        PageHelper.startPage(pn, 5);
        //再startPage后面的查询就是分页查询
        List<Employee> emps =  employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    @ResponseBody
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public Msg insertEmp(@Validated Employee employee , BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<>();
            map.put("empName", "undefined");
            map.put("email", "undefined");
            return Msg.file().add("errorMap", map);
        }
        employeeService.insertEmp(employee);
        Map<String, Object> map = new HashMap<>();
        map.put("empName", "success");
        map.put("email", "success");
        Msg msg = Msg.success().add("errorMap", map);
        return msg;
    }

    @ResponseBody
    @RequestMapping("/selectPage")
    public Msg selectPage(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //再startPage后面的查询就是分页查询
        PageHelper.startPage(pn, 5);
        List<Employee> emps =  employeeService.getAll();
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }


    /**
     * 查询员工数据(分页查询)
     * @return
     */
  /*  //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) {
        //这里首页需要的是一个分页查询，引入PageHelper分页插件
        //在查询之前只需要调用，传入页码，一级每页的数据条目
        PageHelper.startPage(pn, 5);
        //再startPage后面的查询就是分页查询
        List<Employee> emps =  employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }*/



}
