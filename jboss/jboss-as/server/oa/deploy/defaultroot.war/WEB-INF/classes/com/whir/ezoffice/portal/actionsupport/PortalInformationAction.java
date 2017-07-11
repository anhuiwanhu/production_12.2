package com.whir.ezoffice.portal.actionsupport;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.whir.component.actionsupport.BaseActionSupport;
import com.whir.component.page.Page;
import com.whir.component.page.PageFactory;
import com.whir.component.util.JacksonUtil;
import com.whir.ezoffice.customdb.common.util.DbOpt;
import com.whir.ezoffice.information.channelmanager.bd.ChannelBD;
import com.whir.ezoffice.information.channelmanager.po.InformationChannelPO;
import com.whir.ezoffice.portal.bd.PortalBD;
import com.whir.ezoffice.portal.bd.PortletBD;

/**
 * 登录前门户信息
 * 
 */
public class PortalInformationAction extends BaseActionSupport {

    private static final long serialVersionUID = 1L;
    private static Logger logger = Logger
            .getLogger(PortalHeaderFooterAction.class.getName());
    public static final String MODULE_CODE = "PortalInformationAction";

    private String channelId;
    private String channelName;

    private String id;
    private String title;

    public String informationList() throws Exception {
        ChannelBD bd = new ChannelBD();
        Object[] obj = (Object[]) bd.getSingleChannel(channelId).get(0);
        String channelName = (String) obj[0];

        request.setAttribute("channelName", channelName);

        return "informationList";
    }

    /**
     * 取某栏目下的信息List
     * 
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public String getInformationList() throws Exception {
        String channelId = request.getParameter("channelId");

        String _sql = " and 1=1 ";
//        if (checkRightsWithChannelId(channelId, request) == false) {
//            _sql = " and 1<>1 ";
//            // return null;
//        }

        ChannelBD bd = new ChannelBD();
        Object[] obj = (Object[]) bd.getSingleChannel(channelId).get(0);
        String channelName = (String) obj[0];

        /*
         * pageSize每页显示记录数，即list.jsp中分页部分select中的值
         */
        int pageSize = com.whir.common.util.CommonUtils
                .getUserPageSize(request);

        /*
         * currentPage，当前页数
         */
        int currentPage = 0;
        if (request.getParameter("startPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("startPage"));
        }

        String viewSQL = " po.informationId, po.informationTitle, po.informationIssueTime, o.channelName," +
        		"o.channelId,o.channelType,po.informationType,o.userDefine ";
        String fromSQL = " from com.whir.ezoffice.information.infomanager.po.InformationPO po join po.informationChannel o ";
        String whereSQL = " where ";
        InformationChannelPO po = new ChannelBD().loadChannel(channelId);
        //20160324 -by jqq 安全性漏洞sql注入改造
        Map varMap = new HashMap();
        if(po.getIncludeChild()==1){
        	whereSQL += " o.channelIdString like :channelId ";
        	varMap.put("channelId", "%$" + channelId + "$%");
        }else{
        	whereSQL += " o.channelId =:channelId "; 
        	varMap.put("channelId", channelId);
        }
        whereSQL += _sql;
        whereSQL += " and ((po.informationReader is null or po.informationReader='' or po.informationReader=' ') " +
        		"and (po.informationReaderOrg is null or po.informationReaderOrg='' or po.informationReaderOrg=' ') " +
        		"and (po.informationReaderGroup is null or po.informationReaderGroup='' or po.informationReaderGroup=' ') " +
        		"and (o.channelReader is null or o.channelReader='' or o.channelReader=' ')" +
        		"and (o.channelReaderOrg is null or o.channelReaderOrg='' or o.channelReaderOrg=' ')" +
        		"and (o.channelReaderGroup is null or o.channelReaderGroup='' or o.channelReaderGroup=' '))" +
        		"and po.informationStatus = 0 ";

        // 排序
        String orderBy = " order by po.orderCode desc, case when po.informationModifyTime is null then po.informationIssueTime else po.informationModifyTime end desc";
        /*
         * PageFactory.getHibernatePage，分页查询，如果不排序，传入空字符串
         */
        Page page = PageFactory.getHibernatePage(viewSQL, fromSQL, whereSQL,
                orderBy);
        page.setPageSize(pageSize);
        page.setCurrentPage(currentPage);
        /*
         * page.setVarMap(varMap);若没有查询条件，可略去此行
         */
        page.setVarMap(varMap);
        /*
         * list，数据结果
         */
        List<Object[]> list = page.getResultList();
        /*
         * pageCount，总页数
         */
        int pageCount = page.getPageCount();
        /*
         * recordCount，总记录数
         */
        int recordCount = page.getRecordCount();
        //-------------------------------------------------------------
       
        //-------------------------------------------------------------
        /*
         * 异步刷新页面，不返回任何页面，将数据结果封装成json格式返回
         */
        String[] arr = { "id", "informationTitle", "informationIssueTime",
                "channelName",
                "channelId","channelType","informationType","userDefine" };//20170705
        JacksonUtil util = new JacksonUtil();
        String json = util.writeArrayJSON(arr, list, "id", MODULE_CODE);
        json = "{pager:{pageCount:" + pageCount + ",recordCount:" + recordCount
                + "},data:" + json + "}";

        printResult(G_SUCCESS, json);

        logger.debug("查询列表结束");

        return null;
    }

    /**
     * 根据ID取信息
     * 
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public String getInformation() throws Exception {
        String id = request.getParameter("id");
        
        logger.debug("id:"+id);

        if (checkRightsWithInfoId(id, request)) {
            PortalBD bd = new PortalBD();
            Object[] obj = null;
            if (id != null && !"".equals(id)) {
                List list = bd.getInformation(id);
                obj = (Object[]) list.get(0);
            }
            request.setAttribute("po", obj);

            return "getInformation";

        }
        
        logger.debug("getInformation:null");

        return null;
    }

    /**
     * 判断该栏目是否有相应的查看权限
     * 
     * @param channelId
     *            String
     * @param request
     *            HttpServletRequest
     * @return boolean
     */
    public boolean checkRightsWithChannelId(String channelId,
            HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String domainId = session.getAttribute("domainId") != null ? session
                .getAttribute("domainId").toString() : "0";

        String wherePara = " where aaa.domainId="
                + domainId
                + " and (aaa.afficheChannelStatus is null or aaa.afficheChannelStatus='0')";
        if (session.getAttribute("userName") == null) {
            wherePara += " and (aaa.channelReaderName is null or aaa.channelReaderName='' or aaa.channelReaderName=' ') ";

        } else {
            String userId = session.getAttribute("userId") != null ? session
                    .getAttribute("userId").toString() : "";
            String orgId = session.getAttribute("orgId") != null ? session
                    .getAttribute("orgId").toString() : "";
            String orgIdString = session.getAttribute("orgIdString") != null ? session
                    .getAttribute("orgIdString").toString()
                    : "";

            wherePara += " and (";
            wherePara += new PortletBD().getInformationCategoryWhereSQL(userId,
                    orgId, orgIdString, domainId);
            wherePara += " ) ";
        }
        
        wherePara += " and aaa.channelId=" + channelId;

        /*
         * PageFactory.getHibernatePage，分页查询，如果不排序，传入空字符串
         */
        Page page = PageFactory
                .getHibernatePage(
                        "aaa.channelId,aaa.channelName,aaa.channelIdString,aaa.channelType,aaa.userDefine,aaa.channelShowType",
                        "com.whir.ezoffice.information.channelmanager.po.InformationChannelPO aaa",
                        wherePara, "");
        page.setPageSize(1);
        page.setCurrentPage(1);
        /*
         * page.setVarMap(varMap);若没有查询条件，可略去此行
         */
        // page.setVarMap(varMap);
        /*
         * list，数据结果
         */
        List<Object[]> list = page.getResultList();

        /*
         * pageCount，总页数
         */
        int pageCount = page.getPageCount();
        /*
         * recordCount，总记录数
         */
        int recordCount = page.getRecordCount();

        return recordCount > 0 ? true : false;
    }

    /**
     * 判断该信息是否有相应的查看权限
     * 
     * @param infoId
     *            String
     * @param request
     *            HttpServletRequest
     * @return boolean
     */
    public boolean checkRightsWithInfoId(String infoId,
            HttpServletRequest request) {
        HttpSession session = request.getSession(true);

        StringBuffer buffer = new StringBuffer();
        buffer.append(" where ((1<>1 ");

        if (session.getAttribute("userName") != null) {//已登录用户
            String domainId = session.getAttribute("domainId").toString();
            String userId = session.getAttribute("userId").toString();
            String orgIdString = session.getAttribute("orgIdString").toString();

            // 取当前用户的所有上级组织ID
            orgIdString = "$" + orgIdString + "$";
            toString();
            String[] orgIdArray = orgIdString.split("\\$\\$");

            // 判断用户是否在可查看组织范围内(单条信息)
            for (int i = 0; i < orgIdArray.length; i++) {
                if (!"".equals(orgIdArray[i])) {
                    buffer.append(" or  bbb.informationReaderOrg like '%*")
                            .append(orgIdArray[i]).append("*%' ");
                }
            }

            String sidelineorg = "";
            String[] sarr = null;
            String[] groupIdArr = null;
            DbOpt dbopt = new DbOpt();
            try {
                sidelineorg = dbopt
                        .executeQueryToStr("select a.sidelineorg from org_employee a where a.emp_id="
                                + userId);

                if (sidelineorg != null && !"".equals(sidelineorg)
                        && !"null".equals(sidelineorg)) {
                    sidelineorg = sidelineorg.substring(1,
                            sidelineorg.length() - 1);
                    sarr = sidelineorg.split("\\*\\*");
                }

                groupIdArr = dbopt
                        .executeQueryToStrArr1("select group_id from org_user_group where emp_id="
                                + userId);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbopt.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // 加兼职组织的判断
            if (sarr != null && sarr.length > 0) {
                for (int i = 0; i < sarr.length; i++) {
                    buffer.append(" or  bbb.informationReaderOrg like '%*")
                            .append(sarr[i]).append("*%'");
                }
            }

            if (groupIdArr != null) {
                // 判断用户是否在可查看组内(单条信息)
                for (int i = 0; i < groupIdArr.length; i++) {
                    buffer.append(" or bbb.informationReaderGroup like '%@")
                            .append(groupIdArr[i]).append("@%' ");
                }
            }
            // 断用户是否在可查看人范围内(单条信息)
            buffer.append(" or bbb.informationReader like '%$").append(userId)
                    .append("$%' ");

        }

        buffer
                .append(") or ((bbb.informationReader is null or bbb.informationReader='' or bbb.informationReader=' ') and (bbb.informationReaderOrg is null or bbb.informationReaderOrg='' or bbb.informationReaderOrg=' ') and (bbb.informationReaderGroup is null or bbb.informationReaderGroup='' or bbb.informationReaderGroup=' ')))");
        //20160324 -by jqq 安全性漏洞sql注入改造
        buffer.append(" and bbb.informationId=:infoId");
        Map varMap = new HashMap();
        varMap.put("infoId", infoId);
        logger.debug("where:"+buffer.toString());

        /*
         * PageFactory.getHibernatePage，分页查询，如果不排序，传入空字符串
         */
        Page page = PageFactory
                .getHibernatePage(
                        "bbb.informationId",
                        "com.whir.ezoffice.information.infomanager.po.InformationPO bbb",
                        buffer.toString(), "");
        page.setPageSize(1);
        page.setCurrentPage(1);
        /*
         * page.setVarMap(varMap);若没有查询条件，可略去此行
         */
        page.setVarMap(varMap);
        /*
         * list，数据结果
         */
        List<Object[]> list = page.getResultList();

        /*
         * pageCount，总页数
         */
        int pageCount = page.getPageCount();
        /*
         * recordCount，总记录数
         */
        int recordCount = page.getRecordCount();

        return recordCount > 0 ? true : false;
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
}
