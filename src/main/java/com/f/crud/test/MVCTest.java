package com.f.crud.test;

import com.f.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring模块提供的测试请求功能，测试CRUD请求的正确性
 *
 * @author shkstart
 * @create 2020-09-09-16:52
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml", "classpath:dispatcherServlet.xml"})
public class MVCTest {
    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "6")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo attribute = (PageInfo) request.getAttribute("pageInfo");
        System.out.println(attribute);
        System.out.println("当前页面" + attribute.getPageNum());
        System.out.println("总页码" + attribute.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = attribute.getNavigatepageNums();
        for (int num : nums) {
            System.out.println("" + num);
        }

        List<Employee> list = attribute.getList();
        for (Employee employee : list) {
            System.out.println("ID:" + employee.getEmpId() + "===>  NAME:" + employee.getEmpName());
        }
    }
}
