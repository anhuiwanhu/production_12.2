<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.io.*,jxl.*,jxl.write.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%	
	response.reset();
	String fileNameTemp = "考勤-考勤人员模板.xls";//此为默认名称
	//导出xls文件的命名规则修改
	String title = request.getParameter("exportTitle") != null ?  request.getParameter("exportTitle").toString() : "";
	if(StringUtils.isNotBlank(title)){
		fileNameTemp = title + ".xls";
	}
	boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);
	if(!isCOSClient){//if("zh".equals( request.getLocale().getLanguage() )){//en
		fileNameTemp = new String(fileNameTemp.getBytes("GBK"), "ISO8859-1");
	}else{
		fileNameTemp = new String(fileNameTemp.getBytes("UTF-8"), "ISO8859-1");
	}
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-disposition", "attachment;filename="+fileNameTemp);

	List mylist = (List) request.getAttribute("userAccountList");
	//System.out.println(mylist.size()+"+++++++++++++++++++++");
	java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("[0-9]*");
	OutputStream os = response.getOutputStream();
	try {
		WritableWorkbook wwb = Workbook.createWorkbook(os);
		String[] exportFieldsName = { "考勤编号", "人员账号", "考勤类别","人员名称"};
		int cols = 0;
		if (exportFieldsName != null) {
			cols = exportFieldsName.length;
		}
		Label label = null;
		WritableSheet sheet = null;
		int sheetnum = mylist.size() / 10000 + 1;

		if (mylist.isEmpty()) {
			sheet = wwb.createSheet(title, 0);
			label = new Label(0, 1, "无数据");
			sheet.addCell(label);
		}
		for (int i = 0; i < sheetnum; i++) {
			sheet = wwb.createSheet("第" + (i + 1) + "页", i);
			sheet.setColumnView(0, 40);   
			sheet.setColumnView(1, 40); 
			sheet.setColumnView(2, 20);
			sheet.setColumnView(3, 40);
			for (int j = 0; j < cols; j++) {
				label = new Label(j, 0, exportFieldsName[j]);
				sheet.addCell(label);
				label = null;
			}

			int curRow = 1;

			for (int k = 10000 * i; k < 10000 * (i + 1)
					&& k < mylist.size(); k++) {
				Object[] obj = (Object[]) mylist.get(k);
				label = new Label(0, curRow, obj[2] == null ? ""
						: obj[2].toString());
				sheet.addCell(label);
				
				//String userAccount = 
				label = new Label(1, curRow, obj[1] == null ? ""
						: obj[1].toString());
				sheet.addCell(label);
				
				label = new Label(2, curRow, "有考勤");
				sheet.addCell(label);
				
				label = new Label(3, curRow, obj[0] == null ? ""
						: obj[0].toString());
				sheet.addCell(label);
				
				curRow++;
			}
		}
		sheet = wwb.createSheet("说明", sheetnum+1);
		label = new Label(0, 1, "导入说明：1、“考勤编号”字段，请填写字母、数字或者字母与数字的组合，不要填写中文。2、填写“考勤类别”字段时，请与系统中“考勤类别”下拉框中的字段一致。");
		sheet.addCell(label);
		wwb.write();
		wwb.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>