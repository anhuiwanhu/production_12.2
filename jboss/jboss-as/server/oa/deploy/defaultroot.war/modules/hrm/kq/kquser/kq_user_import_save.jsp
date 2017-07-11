<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="jxl.Workbook"%>
<%@ page import="jxl.Sheet"%>
<%@ page import="jxl.Cell"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt"%>
<%@ page import="com.whir.ezoffice.hrm.kq.*"%>
<%@ page import="com.whir.ezoffice.hrm.kq.po.*"%>
<%@ page import="com.whir.ezoffice.hrm.kq.bd.*"%>
<%@ page import="com.whir.org.vo.usermanager.EmployeeVO"%>
<%
String domainId = session.getAttribute("domainId")!=null?session.getAttribute("domainId").toString():"0";
String userName = session.getAttribute("userName")!=null?session.getAttribute("userName").toString():"";
//excel导入
String action = request.getParameter("action");
String message = "failure";
String path = request.getParameter("path");
String filename = request.getParameter("fileName");
String year_month = filename.substring(0,6);
File file = null;
try {
	String filePath = request.getRealPath("/upload/fileimport")+ "/" + year_month+"/"+filename ;
	file = new File(filePath);
	if (file != null && file.isFile()) {
		InputStream in = new FileInputStream(file);
		jxl.Workbook rwb = Workbook.getWorkbook(in);
		
		Sheet sheet = rwb.getSheet(0);
		//列数
		int colCount = sheet.getColumns();
		//行数
		int rowCount = sheet.getRows();
        List list = new ArrayList();
       	//System.out.println("行："+rowCount+"列："+colCount);
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.getDefault());
		String[] arr = new String[4];
		arr[0] = ((Cell) sheet.getCell(0, 0)).getContents();
		arr[1] = ((Cell) sheet.getCell(1, 0)).getContents();
		arr[2] = ((Cell) sheet.getCell(2, 0)).getContents();
		arr[3] = ((Cell) sheet.getCell(3, 0)).getContents();
		if(!arr[0].trim().equals("考勤编号")||!arr[1].trim().equals("人员账号")  || !arr[2].trim().equals("考勤类别") ||  !arr[3].trim().equals("人员名称")){
			out.print("文件格式不正确！");
			return ;
		}
		
		for (int row = 1; row < rowCount; row++) {
        	String[] valArr = new String[43];
           	int k=0;
			int j=0;
			valArr[j++] = ((Cell) sheet.getCell(k++, row)).getContents();//考勤编号
           	valArr[j++] = ((Cell) sheet.getCell(k++, row)).getContents();//人员账号
			valArr[j++] = ((Cell) sheet.getCell(k++, row)).getContents();//考勤类别
			valArr[j++] = ((Cell) sheet.getCell(k++, row)).getContents();//人员名称
            
			/**if(sheet.getCell(2,row).getType() == jxl.CellType.DATE){
                jxl.DateCell datec11 = (jxl.DateCell)sheet.getCell(2, row);
                Date date = datec11.getDate();
				long  Time=(date.getTime()/1000)-60*60*8;
				date.setTime(Time*1000);
                sdf.setTimeZone(TimeZone.getTimeZone("GMT+8"));
				String str = sdf.format(date);
            	valArr[j++] = str;
            }else{
            	valArr[j++] = ((Cell) sheet.getCell(k++, row)).getContents();//日期时间
            }*/
			
            list.add(valArr);
		}
		rwb.close();
		in.close();
		
       	//保存数据
       	String flag = saveData(list, session.getAttribute("userId").toString(), session.getAttribute("orgId").toString(), domainId,userName);
       	if(!"0".equals(flag)){
	        if("-1".equals(flag)){
				//flag =flag.substring(0,flag.lastIndexOf(","));
				out.print("导入为空！");
			}else{
				out.print("success");
			}
		}else{
		    out.print("导入失败");
		}
	}
} catch (Exception e) {
	e.printStackTrace();
} finally{
	if(file!=null){
		file.delete();
	}
}
%>
<%!
public String saveData(List list, String userId, String orgId, String domainId,String userName){
    String result="";
    if(list==null||list.size()==0){
    	return "0";
    }
	KQBD kqbd = new KQBD();
    List pList = new ArrayList();
    String notimpdata ="";
    for(int i=0; i<list.size(); i++){
        String[] valArr = (String[])list.get(i);
        if("".equals(valArr[0].trim())){
        	continue;
        }
        //KQRecordImpPO po = new KQRecordImpPO();
		KQUserPO po = new KQUserPO();
        //po.setKqCode(valArr[3].trim());
		List list_ = kqbd.getEmpIdAndOrgidByKqcode(valArr[0].trim());
		if(list_ !=null &&  list_.size()>0){
			//if(notimpdata.indexOf(valArr[2].trim()) <0){
			//	notimpdata +=valArr[2].trim() +",";
			//}
			continue;
		}
		List userList = kqbd.getUserOrgInfoByUserAccount(valArr[1].trim());
		if(userList != null && userList.size() >0){
			Object[] arr = (Object[])userList.get(0);
			String kqType  = getKqType(valArr[2].trim());     
	        po.setEmpId(new Long(arr[1].toString()));
			po.setEmpName(arr[2].toString().trim());
			po.setOrgName(arr[3].toString().trim());
	        po.setKqType(Integer.valueOf(kqType));
			po.setKqCode(valArr[0].trim());
	        pList.add(po);
		}
    }
    if(pList !=null && pList.size()>0){
    	result = String.valueOf(kqbd.saveKQUser(pList));
    }else{
    	result = "-1";
    }
    return result;
}

public Float toFloat(String val){
    try{
        return new Float(val);
    }catch(Exception e){
    }
    return null;
}

//获取
public String getKqType(String type){
	    String result = "";
        if("有考勤".equals(type)){
            result = "0";
        } else if("无考勤".equals(type)){
            result = "1";
        } else if("手工汇总".equals(type)){
            result = "2";
        } else if("其它".equals(type)){
            result = "-1";
        }else {
            result = "-2";
        }
        return result;
}

//日期
public Date getDate(String date){
	//System.out.println(date);
    if(date==null||"".equals(date)||"null".equals(date))return null;
    try{
        date = date.replaceAll("-","/");
        return new Date(date);
    }catch(Exception e){
    	e.printStackTrace();
    }
    return null;
}

//格式化日期yyyy-MM-dd
public String formatDate(String date){
    if(date==null||"".equals(date)||"null".equals(date)){
    	return null;
    }
    try{
        date = date.replaceAll("-","/");
        java.util.Date dd = new java.util.Date(date);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	return sdf.format(dd);
    }catch(Exception e){
    	e.printStackTrace();
    }
    return null;
}
%>