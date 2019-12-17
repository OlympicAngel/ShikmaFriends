<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
.pro
    {
background: #F4F4F4;
    border-radius: 12px; /*/שולט על עיגול הפינות/*/
    border: 1px solid #7E7E7E; /*/ שולט על הגבולות כך: צבע ת סגנון ת עובי /*/
    padding: 50px;
    box-shadow: inset 2px 5px 8px rgba(94, 91, 91, 1);
    }
    
    .img
        {
background: rgba(0, 152, 190, 0.35);
    border-radius: 35px; /*/שולט על עיגול הפינות/*/
    border: 3px solid #D3D3D3; /*/ שולט על הגבולות כך: צבע ת סגנון ת עובי /*/
    padding: 10px;
    box-shadow: inset 2px 5px 8px rgba(94, 91, 91, 1);
    width: 265px;
    }
    
    .style1
    {
        width: 100%;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
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
<center><h2>פרופיל משתמש</h2></center>
<hr size="4px" width="70%" />
<%
    bool ifID = Request.QueryString["id"] != null;
    if (ifID)
    {
        string id = Request.QueryString["id"].ToString();
        string sql = "Select * from Users where UserID=" + id;
        DBHelper dbh = new DBHelper();
        System.Data.DataTable dt = dbh.GetData(sql);
        if (dt.Rows[0].ToString() != "0")
        {
        string name = dt.Rows[0]["UserName"].ToString();
        string sts = dt.Rows[0]["UserStuts"].ToString();
        string lastName = dt.Rows[0]["UserLastName"].ToString();
     %>
              <% string bigImg = "";
               if(Request.QueryString["img"] != null)
                   bigImg = Request.QueryString["img"].ToString();
                  if(bigImg != "")
                  { %>
                  <a href="user.aspx?id=<%=id %>"><div style="position: fixed;background-color: rgba(65, 79, 85, 0.78); height: 100%; width: 100%;  top: 0px; right: 0px;">
                     <center><img src="uploads/<%=bigImg %>" class="fly"/></center></div></a>
                      <% } %>
<div class="pro" width="80%">

    <table cellpadding="0" cellspacing="0" class="style1">
        <tr>
            <td dir="rtl">
            <div class="img">
                <img src="uploads/<%=GetUserImage(Request.QueryString["id"]) %>" class="pr" width="200px" height="200px" style="padding: 20px;"></div>
</td>
            <td width="450px">
            <center>
               <b><%=name %> <%=lastName%></b><wr>▐</wr>
               <hr width="360px" />
               <br />
                מעמד: <%=sts%>
                <wr>▐</wr>
                <hr width="120px" />
                אידי: <%=id%>(ID)
                <wr>▐</wr>
               </center>
               </td>
        </tr>
        
        <tr>
            <td width="50%">
                <hr /></wr></td>
            <td width="50%">
                <hr /></td>
        </tr>
    </table>

</div>
<%
    sql = "Select * from Images where UserID=" + id;
    DBHelper db = new DBHelper();
    System.Data.DataTable dth = dbh.GetData(sql);
    %>
    <center><br /><hr />
    <center><h2>תמונות</h2></center><hr />
    <table class="style1">
        <tr>
           <%  int xxx = 1;
               string style = "a";
               for (int i = 0; i < dth.Rows.Count; i++)
    {
                   if(i == (6*xxx))
                   {
                       xxx++;%></tr><tr><%}
        if (style == "a")
            style = "b";
        else
            style = "a"; %>
    <td align=center class="<%=style %>">
       <a href="?id=<%=id %>&img=<%=dth.Rows[i]["PicName"].ToString()%>"><img src="uploads\<%=dth.Rows[i]["PicName"].ToString()%>" height=80px width=80px title="<%=dth.Rows[i]["PicDiscraib"].ToString() %>" /></a>
       </td>
    <%}%>
        </tr>
        <tr>
            <td>
                </td>
        </tr>
        <tr>
            <td>
                </td>
        </tr>
    </table>

<%
      }
    }
    else
    {%>
    <center><p>היתרחשה טעות בטעינת העמוד</p></center>
    <%}
         %>
</asp:Content>

