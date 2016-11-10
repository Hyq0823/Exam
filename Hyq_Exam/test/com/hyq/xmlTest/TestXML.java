package com.hyq.xmlTest;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.ibatis.io.Resources;
import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class TestXML {
	
	public static void main(String[] args) throws IOException {
		String str = "Hyq_Exam/foreground/main.action";
		InputStream in = Resources.getResourceAsStream("public.xml");
		System.out.println(in);
	}
	
	
	@Test
	public void testReadXml() throws ParserConfigurationException, Exception, Exception
	{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		InputStream in = this.getClass().getClassLoader().getResourceAsStream("public.xml");
//		 Document doc = builder.parse(new File("/config/public.xml"));
		Document doc =  builder.parse(in);
		  Element root = doc.getDocumentElement();
//		  System.out.println(element);
		  
		  NodeList nodeList = root.getElementsByTagName("node");
		  System.out.println(nodeList);
		  for(int i=0;i<nodeList.getLength();i++)
		  {
			   Node node = nodeList.item(i);
			   //System.out.println(node.getNodeName());
			   //System.out.println(node.getNodeValue());
			   System.out.println(node.getTextContent());
		  }
		  
		 
		
		
//		File 
		
	}

}
