<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.text.DateFormat"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
    Calendar now = Calendar.getInstance();
    int dayOfWeek = now.get(Calendar.DAY_OF_WEEK);
    DateFormat df = DateFormat.getDateInstance(DateFormat.FULL, Locale.CHINA);
    String type = request.getParameter("type");
	type=EncryptUtil.htmlcode(type);
    boolean notRead = false;
    java.util.List mondayList = new java.util.ArrayList();
    if(request.getAttribute("mondayList") !=null){
	    mondayList = (java.util.List)request.getAttribute("mondayList");
    }
    java.util.List tuesdayList = new java.util.ArrayList();
    if(request.getAttribute("tuesdayList") !=null){
	    tuesdayList = (java.util.List)request.getAttribute("tuesdayList");
    }
    java.util.List wednesdayList = new java.util.ArrayList();
    if(request.getAttribute("wednesdayList") !=null){
	    wednesdayList = (java.util.List)request.getAttribute("wednesdayList");
    }
    java.util.List thursdayList = new java.util.ArrayList();
    if(request.getAttribute("thursdayList") !=null){
	    thursdayList = (java.util.List)request.getAttribute("thursdayList");
    }
    java.util.List fridayList = new java.util.ArrayList();
    if(request.getAttribute("fridayList") !=null){
	    fridayList = (java.util.List)request.getAttribute("fridayList");
    }
    java.util.List saturdayList = new java.util.ArrayList();
    if(request.getAttribute("saturdayList") !=null){
	    saturdayList = (java.util.List)request.getAttribute("saturdayList");
    }
    java.util.List sundayList = new java.util.ArrayList();
    if(request.getAttribute("sundayList") !=null){
	    sundayList = (java.util.List)request.getAttribute("sundayList");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
<title>会议通知-本周</title>

<script language="JavaScript" src="js/date0.js"></script>
</head>

<body leftmargin="0" topmargin="0">
    <div class="whir_public_movebg">
        <div class="Public_tag">
            <ul id="whir_tab_ul">
            <li id="li0" onClick="list0();" class="<%if("day".equals(type)){%>tag_aon<%}%>"  whir-options="{target:'tab0'}"><span class="tag_center">今日</span><span class="tag_right"></span></li>
            <li id="li1" onClick="list1();"class="<%if("week".equals(type)){%>tag_aon<%}%>"  whir-options="{target:'tab1'}"><span class="tag_center">本周</span><span class="tag_right"></span></li>
            <li id="li2" onClick="list2();" class="<%if("list".equals(type)){%>tag_aon<%}%>" whir-options="{target:'tab2'}"><span class="tag_center">列表</span><span class="tag_right"></span></li>
            </ul>
        </div>
    </div>

    <div class="whir_clear"></div>
    <div id="tab0" class="grayline">
        <%Object[] obj = null;
        Calendar tmpDate = Calendar.getInstance();%>
        <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
            <tr align="center">
                <td width="50%" valign="top">
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="TableBg1">
                        <tr>
                            <td width="66%" height="20" bgcolor="C9CDCF">
                            &nbsp;
                            <%
                            now.add(Calendar.DATE, 2 - dayOfWeek);
                            if(Calendar.getInstance().equals(now)){
                            out.print(df.format(now.getTime()));
                            }else{
                            out.print(df.format(now.getTime()));
                            }
                            %>
                            </td>
                            <td bgcolor="C9CDCF">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td width="50%">
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableBG1">
                        <tr>
                            <td width="66%" height="20" bgcolor="C9CDCF">
                            &nbsp;
                            <%
                            now = now.getInstance();
                            now.add(Calendar.DATE, 3 - dayOfWeek);
                            if(Calendar.getInstance().equals(now)){
                            out.print(df.format(now.getTime()));
                            }else{
                            out.print(df.format(now.getTime()));
                            }
                            %>
                            </td>
                            <td bgcolor="C9CDCF"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="120" valign="top" bgcolor="FDF7D9">
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" >
                       
                        <%
                        if(mondayList != null && mondayList.size() >0){
                            for(int i=0;i<mondayList.size();i++){
                                obj = (Object[]) mondayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);
								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                        %>
                        <tr  align="left" bgcolor="FDF7D9">
                            <%
                            java.util.Date destineDate = (java.util.Date) obj[5];
                            String year = Integer.toString(destineDate.getYear()+1900);
                            String month = Integer.toString(destineDate.getMonth()+1);
                            String day = Integer.toString(destineDate.getDate());
                            int startTime =Integer.parseInt(obj[6]+"");

                            String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                            %>
                            <td height="20" bgcolor="FDF7D9" >
								<%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                        <%}}%>
                    </table>
                </td>
                <td height="120" valign="top" bgcolor="FDF7D9">
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                       
                        <%
                           if(tuesdayList != null && tuesdayList.size() >0){
                            for(int i=0;i<tuesdayList.size();i++){
                                obj = (Object[]) tuesdayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);
								
								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                                java.util.Date destineDate = (java.util.Date) obj[5];
                                String year = Integer.toString(destineDate.getYear()+1900);
                                String month = Integer.toString(destineDate.getMonth()+1);
                                String day = Integer.toString(destineDate.getDate());
                                int startTime =Integer.parseInt(obj[6]+"");
                                String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        %>
                        <tr align="left">
                            <td height="20" bgcolor="FDF7D9">
                                
								<%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                        <%}}%>
                    </table>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="66%" height="20" bgcolor="C9CDCF">
                                &nbsp;<%
                                now = now.getInstance();
                                now.add(Calendar.DATE, 4 - dayOfWeek);
                                if(Calendar.getInstance().equals(now)){
                                out.print(df.format(now.getTime()));
                                }else{
                                out.print(df.format(now.getTime()));
                                }
                                %>
                            </td>
                            <td bgcolor="C9CDCF">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="66%" height="20" bgcolor="C9CDCF">
                                &nbsp;<%
                                now = now.getInstance();
                                now.add(Calendar.DATE, 5 - dayOfWeek);
                                if(Calendar.getInstance().equals(now)){
                                out.print(df.format(now.getTime()));
                                }else{
                                out.print(df.format(now.getTime()));
                                }
                                %>
                            </td>
                            <td bgcolor="C9CDCF">&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="120" valign="top" bgcolor="FDF7D9">
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                        
                        <%
                        if(wednesdayList != null && wednesdayList.size() >0){
                            for(int i=0;i<wednesdayList.size();i++){
                                obj = (Object[]) wednesdayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);

								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                                java.util.Date destineDate = (java.util.Date) obj[5];
                                String year = Integer.toString(destineDate.getYear()+1900);
                                String month = Integer.toString(destineDate.getMonth()+1);
                                String day = Integer.toString(destineDate.getDate());
                                int startTime =Integer.parseInt(obj[6]+"");

                                String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        %>
                        <tr align="left">
                            <td height="20" bgcolor="FDF7D9">
                                <%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                        <%}}%>
                    </table>
                </td>
                <td height="120" valign="top" bgcolor="FDF7D9">
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                       
                        <%
                         if(thursdayList != null && thursdayList.size() >0){
                            for(int i=0;i<thursdayList.size();i++){
                                obj = (Object[]) thursdayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);
								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                                java.util.Date destineDate = (java.util.Date) obj[5];
                                String year = Integer.toString(destineDate.getYear()+1900);
                                String month = Integer.toString(destineDate.getMonth()+1);
                                String day = Integer.toString(destineDate.getDate());
                                int startTime =Integer.parseInt(obj[6]+"");
                                String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        %>
                        <tr align="left">
                            <td height="20" bgcolor="FDF7D9">
                                <%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                         <%}}%>
                    </table>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="66%" height="20" bgcolor="C9CDCF">
                                &nbsp;
                                <%
                                now = now.getInstance();
                                now.add(Calendar.DATE, 6 - dayOfWeek);
                                if(Calendar.getInstance().equals(now)){
                                out.print(df.format(now.getTime()));
                                }else{
                                out.print(df.format(now.getTime()));
                                }
                                %>
                            </td>
                            <td width="34%" align="right" bgcolor="C9CDCF"></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="66%" height="20" bgcolor="C9CDCF">
                                &nbsp;
                                <%
                                now = now.getInstance();
                                now.add(Calendar.DATE, 7 - dayOfWeek);
                                if(Calendar.getInstance().equals(now)){
                                out.print(df.format(now.getTime()));
                                }else{
                                out.print(df.format(now.getTime()));
                                }
                                %>
                            </td>
                            <td bgcolor="C9CDCF"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td rowspan="3" valign="top" bgcolor="FDF7D9">
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                        
                        <%
                        if(fridayList != null && fridayList.size() >0){
                            for(int i=0;i<fridayList.size();i++){
                                obj = (Object[]) fridayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);
								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                                java.util.Date destineDate = (java.util.Date) obj[5];
                                String year = Integer.toString(destineDate.getYear()+1900);
                                String month = Integer.toString(destineDate.getMonth()+1);
                                String day = Integer.toString(destineDate.getDate());
                                int startTime =Integer.parseInt(obj[6]+"");

                                String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        %>
                        <tr align="left">
                            <td height="20" bgcolor="FDF7D9">
                                <%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                        <%}}%>
                    </table>
                </td>
                <td height="100" valign="top" bgcolor="FDF7D9">
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                        
                        <%
                         if(saturdayList != null && saturdayList.size() >0){
                            for(int i=0;i<saturdayList.size();i++){
                                obj = (Object[]) saturdayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);
								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                                java.util.Date destineDate = (java.util.Date) obj[5];
                                String year = Integer.toString(destineDate.getYear()+1900);
                                String month = Integer.toString(destineDate.getMonth()+1);
                                String day = Integer.toString(destineDate.getDate());
                                int startTime =Integer.parseInt(obj[6]+"");

                                String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        %>
                        <tr align="left">
                            <td height="20" bgcolor="FDF7D9">
                                <%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                        <%}}%>
                    </table>
                </td>
            </tr>
            <tr valign="top" bgcolor="FDF7D9">
                <td align="center">
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                        <td width="66%" height="20" bgcolor="C9CDCF">
                            &nbsp;
                            <%
                            now = now.getInstance();
                            now.add(Calendar.DATE, 8 - dayOfWeek);
                            if(Calendar.getInstance().equals(now)){
                            out.print(df.format(now.getTime()));
                            }else{
                            out.print(df.format(now.getTime()));
                            }
                            %>
                        </td>
                        <td width="34%" align="right" bgcolor="C9CDCF"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr valign="top" bgcolor="FDF7D9">
                <td height="100">
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        
                        <%
                        if(sundayList != null && sundayList.size() >0){
                            for(int i=0;i<sundayList.size();i++){
                                obj = (Object[]) sundayList.get(i);
                                String beginHours = ""; //TotalSeconds / 3600;
                                String beginMinutes = "";  //(TotalSeconds - (Hours * 3600)) / 60;
                                if(obj[6] !=null && !"".equals(obj[6].toString())){
                                beginHours = String.valueOf(Integer.parseInt(obj[6].toString())/3600);
                                beginMinutes = String.valueOf((Integer.parseInt(obj[6].toString())-(Integer.parseInt(obj[6].toString())/3600 * 3600))/60);
                                if(beginHours.length() ==1){
                                beginHours = "0"+beginHours;
                                }
                                if(beginMinutes.length() ==1){
                                beginMinutes = "0"+beginMinutes;
                                }
                                }
                                notRead = false;
                                if (obj[1].toString().indexOf("*") >= 0)
                                obj[1] = obj[1].toString().substring(0, obj[1].toString().length() - 1);

								String isNewOrOld=obj[10]==null?"":obj[10]+"";
								String directlyPublish=obj[11]==null?"":obj[11]+"";
								String formCode=obj[12]==null?"":obj[12]+"";
                                java.util.Date destineDate = (java.util.Date) obj[5];
                                String year = Integer.toString(destineDate.getYear()+1900);
                                String month = Integer.toString(destineDate.getMonth()+1);
                                String day = Integer.toString(destineDate.getDate());
                                int startTime =Integer.parseInt(obj[6]+"");

                                String meet_date = year +"年"+ month +"月" + day + "日" + " " +(startTime/3600<12?"上午":"下午")+(startTime/3600<=12?startTime/3600:startTime/3600-12)+":"+((startTime%3600)/60<10?"0"+((startTime%3600)/60):((startTime%3600)/60)+"")+"";
                        %>
                        <tr align="left">
                            <td height="20" bgcolor="FDF7D9">
                                <%if(directlyPublish.equals("1")){//直接发布  
									if(!formCode.equals("meeting") && !formCode.equals("")){
								%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailDirectly('<%=obj[0]%>','<%=obj[1]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}}else if(isNewOrOld.equals("15")){%>
									 &nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetailNewFlow('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}else{%>
									&nbsp;<a href="javascript:void(0);" title="进入查看具体的会议情况" onClick="viewDetail('<%=obj[0]%>','<%=obj[2]%>','<%=obj[8]%>');"><%=meet_date%>由<%=(obj[4]!=null?(obj[4]+"").substring(0,(obj[4]+"").length()-1):"")%>主持召开<%=obj[1]%>的通知</a>
								<%}%>
                            </td>
                        </tr>
                        <%}}%>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>

<script language="javascript">
<!--
	function viewDetailDirectly(boardroomApplyId,boardroomName,meetingId){
		 var url='<%=rootPath%>/newBoardRoom!readOldMeeting.action?directlyPublish=1&p_wf_recordId='+boardroomApplyId+'&title='+encodeURIComponent(boardroomName)+'&p_wf_openType=modifyView&p_wf_moduleId=15&isView=true&executeStatus=true&fromAdr=userList&meetingId='+meetingId;
         openWin({url:url,width:screen.width,height:screen.height,winName:'viewDetail'});
	}
	 function viewDetailNewFlow(boardroomApplyId,boardroomName,meetingId){
		 ajaxForSync('boardRoom!addBoardroomPersons.action','boardroomApplyId='+boardroomApplyId);
		 var url='<%=rootPath%>/bpmopen!updateProcess.action?p_wf_recordId='+boardroomApplyId+'&p_wf_openType=modifyView&p_wf_moduleId=15';
         openWin({url:url,width:screen.width,height:screen.height,winName:'viewDetail'});
	}
     function viewDetail(boardroomApplyId,boardroomName,meetingId){
         var url='<%=rootPath%>/boardRoom!selectBoardroomApplyView.action?boardroomApplyId='
         +boardroomApplyId+'&boardroomName='+boardroomName+'&meetingId='+meetingId
         +'&type=view&executeStatus=false'+'&p_wf_recordId='+boardroomApplyId+'&p_wf_moduleId=15&p_wf_openType=modifyView';
         openWin({url:url,width:screen.width,height:screen.height,winName:'viewDetail'});
	}
    function list0(){ 
		var url="<%=rootPath%>/boardRoom!meetingInformView.action?type=day";
        location_href(url);
	}
    function list1(){ 
		var url="<%=rootPath%>/boardRoom!meetingInformWeekView.action?type=week";
        location_href(url);
	}
    function list2(){ 
		var url="<%=rootPath%>/boardRoom!meetingInformView.action?type=list";
        location_href(url);
	}
//-->
</script>
</html>
