package com.the.harbor.web.system.utils;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class XMLUtils {

	public static <T> String createXML(Class<T> entityClass, Object entity) throws JAXBException {
		StringWriter writer = new StringWriter();
		JAXBContext act = JAXBContext.newInstance(entityClass);
		Marshaller marshaller = act.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
		marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.TRUE);
		marshaller.marshal(entity, writer);
		return writer.toString();
	}

	public static String formatXML(String inputXML) throws Exception {
		SAXReader reader = new SAXReader();
		Document document = reader.read(new StringReader(inputXML));
		String requestXML = null;
		XMLWriter writer = null;
		if (document != null) {
			try {
				StringWriter stringWriter = new StringWriter();
				OutputFormat format = new OutputFormat("    ", true);
				format.setNewLineAfterDeclaration(false);
				writer = new XMLWriter(stringWriter, format);
				writer.write(document);
				writer.flush();
				requestXML = stringWriter.getBuffer().toString();
			} finally {
				if (writer != null) {
					try {
						writer.close();
					} catch (IOException e) {
					}
				}
			}
		}
		return requestXML;
	}

	public static <T> Object createObject(Class<T> entityClass, String entity) throws JAXBException {
		Object object = null;
		JAXBContext act = JAXBContext.newInstance(entityClass);
		Unmarshaller unMarshaller = act.createUnmarshaller();
		object = unMarshaller.unmarshal(new StringReader(entity));
		return object;
	}

	public static Map<String, String> xmltoMap(String xml) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			Document document = DocumentHelper.parseText(xml);
			Element nodeElement = document.getRootElement();
			List node = nodeElement.elements();
			for (Iterator it = node.iterator(); it.hasNext();) {
				Element elm = (Element) it.next();
				map.put(elm.getName(), elm.getText());
				elm = null;
			}
			node = null;
			nodeElement = null;
			document = null;
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String maptoXml(SortedMap<String, String> parameters) throws UnsupportedEncodingException {
		StringBuffer sb = new StringBuffer();
		sb.append("<xml>");
		Set es = parameters.entrySet();
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			sb.append("<" + k + ">" + v + "</" + k + ">");
		}
		sb.append("</xml>");
		return sb.toString();
	}
}