<%@ page import="java.util.*,java.sql.*,com.whir.common.util.DataSourceBase,java.io.*" %>
<%
    DataSourceBase dsb = new DataSourceBase();
    Connection conn = null;
    try {
        conn = dsb.getDataSource().getConnection();
        PreparedStatement pstmt = conn.prepareStatement("select marktype,markbody from signature where signatureid=?");
        pstmt.setString(1, request.getParameter("id"));
        ResultSet rs = pstmt.executeQuery();
        long marksize = 0;
        String marktype = "jpg";

        if (rs.next()) {
            marktype = rs.getString("marktype");
            if (marktype != null && !marktype.equals("")) {
                marktype = marktype.substring(1, marktype.length());
            }
            InputStream picstream = rs.getBinaryStream("markbody");

            response.reset();
            response.setContentType("image/" + marktype);
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            OutputStream os = response.getOutputStream();
            byte[] buff = new byte[1024];
            int bytes = 0;
            while ((bytes = picstream.read(buff)) != -1) {
                os.write(buff, 0, bytes);
            }
            picstream.close();
            os.flush();
            os.close();
        }
        rs.close();
        pstmt.close();
        out.clear();
        out = pageContext.pushBody();
    } catch (Exception e) {
        e.printStackTrace();
    }
    try {
        conn.close();
    } catch (Exception e) {

    }
%>
