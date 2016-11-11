package com.hyq.treeTest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.hyq.domain.Privilege;
import com.hyq.mapper.PrivilegeMapper;

public class TreeTest {
	private static PrivilegeMapper mapper =null;
	private static JSONArray totalArray = new JSONArray();
	private static Privilege topPrivilege;
	private static JSONObject o  = null;
	
	
	public static void main(String[] args) throws IOException {
		
		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
		SqlSessionFactory factory = builder.build(Resources.getResourceAsStream("mybatis/SqlMapConfig.xml"));
		SqlSession sqlSession = factory.openSession();
		 mapper = sqlSession.getMapper(PrivilegeMapper.class);
		
		List<Privilege> topPrivilegeList = mapper.findTopPrivilege();
		JSONArray array = findArray(topPrivilegeList,null);
		System.out.println(array);
		System.out.println(totalArray);
		
		
	
	}
	



private static JSONArray findArray(List<Privilege> topPrivilegeList,Privilege now) {
	JSONObject value = new JSONObject();;
	for(Privilege p :topPrivilegeList)
	{
		System.out.println(p.getName());
		List<Privilege> childList = mapper.finChildPrivilegeList(p.getId());
		if(childList.size()>0)
		{
			JSONArray arr = findArray(childList,p);
			System.out.println("p："+p);
			value.put("text", p.getName());
			value.put("children",arr);
			if(p.getParentId() == null)
			{
				totalArray.add(value);
			}
			
		}else
		{
				value.put("text", p.getName());
		}
	}
	return JSONArray.fromObject(value);
}




private static JSONArray getJsonById(Privilege privilege,JSONArray a,JSONObject v){
	JSONObject value  = new JSONObject();
	
	List<Privilege> list = mapper.finChildPrivilegeList(privilege.getId());
	if(list.size()<1) //说明上面这个就是叶子了
	{
		value.put("text",privilege.getName());
//		value.put("children",a);
		v.put("children",value);
		a.add(v);
		return a;
	}else //说明下面还有节点,一直存储
	{
		value.put("text",privilege.getName());
		for(int i=0;i<list.size();i++){
			JSONArray nodeArry = getJsonById(list.get(i), a,value);
			System.out.println("在else中坐标"+i+" 值"+nodeArry);
		}
	} 
	return a;
}
























//返回界面需要的jsonArray
	private static JSONArray Get(List<Privilege> topPrivilegeList,JSONArray a,JSONArray top) {
		
			for(Privilege p : topPrivilegeList){
			JSONObject value = new JSONObject();
			value.put("text",p.getName());
			
			
			List<Privilege> childList = mapper.finChildPrivilegeList(p.getId());
			if(childList.size()<1)
			{
				JSONObject result = new JSONObject();
				result.put("children",top);
				a.add(result);
				return a;
			}else
			{
				//有下级
				a.add(value);//可能是一级   也可能是孩子
				System.out.println("有下级，此时top  "+top);
				JSONArray childArr = new JSONArray();
				for(int j=0;j<childList.size();j++)
				{
					JSONObject result = new JSONObject();
					result.put("text",childList.get(j).getName());
					childArr.add(result);
				}
				 Get(childList,a,childArr);
			}
		}
		//返回二级菜单的array
		return a;
	}
	
	
	







	private static void GetJsonArray(List<Privilege> topPrivilegeList) {
		for(int i=0;i<topPrivilegeList.size();i++)
		{
			//封装顶级的权限
			Privilege one = topPrivilegeList.get(i);
			System.out.print("顶级:"+one.getName()+":");
			JSONObject o = new JSONObject();
			o.put("text", one.getName());
			
			//返回次级的所有arry
		getChildArray(one.getId(),o,totalArray);
		}
	}







	private static void getChildArray(int id,JSONObject before,JSONArray totalArray) {
		//封装同级
		JSONArray arr  = new JSONArray();
		
		List<Privilege> list = mapper.finChildPrivilegeList(id);
		if(list.size()<1) return ;
		
		for(int i =0;i<list.size();i++)
		{
			//封装同级的一个
			Privilege pchild = list.get(i);
			System.out.print("次级"+pchild.getName()+"  它的上级是"+before.toString());
			JSONObject j1 = new JSONObject();
			j1.put("text",pchild.getName());
			
			
			getChildArray(pchild.getId(),j1,totalArray);
			
			//继续深入
		}
	}







	//产生权限树
	private static void GetPrivilegeTreeList(List<Privilege> topPrivilegeList,int level,JSONArray parent) {
		
		//遍历所有
		for(int index=0;index<topPrivilegeList.size();index++)
		{
			Privilege p = topPrivilegeList.get(index);
			for(int i=0;i<level;i++)
			{
				System.out.print("-");
			}
			System.out.print(p.getName()+"\r\n");
			
			//创建一个节点 封装数据
			JSONObject one = new JSONObject(); 
			one.put("name",p.getName());
		
			
			//找这个权限的子权限   如果没有,就完了，如果有，one就作为现在的父亲
			List<Privilege> childrens = mapper.finChildPrivilegeList(p.getId());
			
			JSONArray childreJsons = new JSONArray();
			for(int i =0;i<childrens.size();i++)
			{
				Privilege pchild = childrens.get(i);
				JSONObject o = new JSONObject();
				o.put("text",pchild.getName());
				//添加一条到孩子集合
				childreJsons.add(o);
			}
			//遍历完孩子后,添加孩子到 one
			if(childrens.size()>0){
				one.put("children",childreJsons);
			}
			
			
			if(parent ==null)//如果没有父亲,就加入最外层
			{
				totalArray.add(one);
			}else //否则加入父亲的集团
			{
				parent.add(one);
			}
			
			
			level++;
			GetPrivilegeTreeList(childrens, level,JSONArray.fromObject(one));
			
		}
	
	
	}
	
	private static List<Privilege> childTree(String prefix,Collection<Privilege> c,List<Privilege> list)
	{
		for(Privilege d : c)
		{
			Privilege temp = new Privilege();
			temp.setId(d.getId());
			temp.setName(prefix + d.getName());
			//从session中取出的top带着事务，定义我自己的list来实现操作
			list.add(temp);
			//继续遍历子节点
			
			System.out.println(prefix+d.getName());
			
			List<Privilege> childrens = mapper.finChildPrivilegeList(d.getId());
			childTree("-------"+prefix , childrens , list); //遍历着的节点，肯定知道自己的子节点的---横线数量
		}
		return list;   
		
	}
	
	
	
	
}
