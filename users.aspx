<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<%
    bool ifID = Request.QueryString["id"] != null;
    if (ifID)
    {
        string to = Request.QueryString["id"].ToString();
        Response.Redirect("user.aspx?id=" + to);
    }
           %>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            height: 25px;
        }
        
        .a
        {
            border-radius: 8px; /*/שולט על עיגול הפינות/*/
            border: 1px solid #54BED3; /*/ שולט על הגבולות כך: צבע ת סגנון ת עובי /*/
            background-color: #E9E9E9;
        }
        
        .b
        {
            border-radius: 8px; /*/שולט על עיגול הפינות/*/
            border: 1px solid #54BED3; /*/ שולט על הגבולות כך: צבע ת סגנון ת עובי /*/
            background-color: #F7F7F7;
            
        }
        
        .a:hover,.b:hover
        {
            background-color: rgba(194, 245, 255, 0.69);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
<center><h2>משתמשים</h2></center>
<hr size="4px" width="70%" />

<script runat=server>
             string GetUserImage(string idUser)
             {
                 string sql = "Select * from Images where UserID=" + idUser;
                 DBHelper dbh = new DBHelper();
                 System.Data.DataTable dt = dbh.GetData(sql);
                 for(int k = 0; k < dt.Rows.Count; k++)
                 {
                     if (bool.Parse(dt.Rows[k]["IsProfile"].ToString()) == true)
                     {
                         return dt.Rows[k]["PicName"].ToString();
                     }
                 }
                 return "noPic.png";
             }
         </script>

    <table border="0px" class="style1" dir="rtl" cellspacing="3px">
    <%
        string sql = "Select * from Users";
        DBHelper db = new DBHelper();
        System.Data.DataTable dt = db.GetData(sql);
        System.Data.DataTable dtb = db.GetData(sql);
        string style = "a";
        for (int i = 1; i <= dt.Rows.Count; i++)
        {

            sql = "Select * from Users where UserID=" + i;
            dtb = db.GetData(sql);
            if (bool.Parse(dtb.Rows[0]["Dell"].ToString()) == false)
            {
                string name = dtb.Rows[0]["UserName"].ToString();
                string sts = dtb.Rows[0]["UserStuts"].ToString();
                string lastName = dtb.Rows[0]["UserLastName"].ToString();
                string img = i.ToString();
                if (style == "a")
                    style = "b";
                else
                    style = "a";
          %>
        <tr class="style2">
            <td width="40px" class="<%=style %>"><a href="user.aspx?id=<%=i %>">
                <center><wr>▐</wr><%=i%>.</center></a></td>
            <td align="center" width="50px" class="<%=style %>"><a href="user.aspx?id=<%=i %>">
                <img src="uploads\<%=GetUserImage(img)%>" height="30px" width="30px" /><p><%=sts%>.</p></a></td>
            <td class="<%=style %>" align="center"><a href="user.aspx?id=<%=i %>">
                <b><%=name%> <%=lastName%></b></a></td>
        </tr>
        <%}
        } %>
    </table>
</asp:Content>

