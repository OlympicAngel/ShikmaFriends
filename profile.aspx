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
    padding: 30px;
    margin: 25px 90px 10px 90px;
    box-shadow: inset 2px 5px 8px rgba(94, 91, 91, 1);
    width: 500px;
    }
    
    .style1
    {
        width: 100%;
    }
    
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <% string bigImg = "";
               if(Request.QueryString["img"] != null)
                   bigImg = Request.QueryString["img"].ToString();
                  if(bigImg != "")
                  { %>
                  <a href=profile.aspx><div style="position: fixed;background-color: rgba(65, 79, 85, 0.78); height: 100%; width: 100%;  top: 0px; right: 0px;">
                     <center><img src="uploads/<%=bigImg %>" class="fly"/></center></div></a>
                      <% } %>
<center><h2>פרופיל</h2></center><hr />
<% if (Session["id"] == null)
       Response.Redirect("login.aspx");

   if (Request.QueryString["action"] != null && Request.QueryString["action"].ToString() == "dell")
   {
       string dellUserSql = "Update Users set UserName='', UserEmail='', UserLastName='', UserPassword='', UserStuts='', Dell=" + true +" where UserID=" + Session["id"];
       string dellImgSql = "Delete from Images where UserID=" + Session["id"];
       DBHelper DellDBH = new DBHelper();
       DellDBH.ChangDB(dellImgSql);
       DellDBH.ChangDB(dellUserSql);
       Session["id"] = null;
       Response.Redirect("http://i.imgur.com/cypR1wa.gif");
   }
       
       
       %>
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
    <%
    if (Request.Form["email"] != null && Request.Form["name"] != null)
   {
       string email1 = Request.Form["email"].ToString();
       string name1 = Request.Form["name"].ToString();
       string pic;
       if (Request.Form["profile"] != null)
       {
            pic = Request.Form["profile"].ToString();
       }
       else
       {
            pic = "";
       }
       string sql1 = string.Format("Update Users set UserName='{0}', UserEmail='{1}' where UserID={2}", name1, email1, Session["id"]);
       DBHelper dbhm = new DBHelper();
       System.Data.DataTable dtm = dbhm.GetData(sql1);
       bool a11 = true, b11 = false;
       sql1 = string.Format("Update Images set IsProfile={0} where PicName='{1}'", b11, GetUserImage(Session["id"].ToString()));
       dbhm.GetData(sql1);
       sql1 = string.Format("Update Images set IsProfile={0} where PicName='{1}'", a11, pic);
       dbhm.GetData(sql1);
   }
       
       
       string id = Session["id"].ToString();
       string sql = "Select * from Users where UserID=" + id;
       DBHelper dbh = new DBHelper();
       System.Data.DataTable dt = dbh.GetData(sql);
       string name = dt.Rows[0]["UserName"].ToString();
       string email = dt.Rows[0]["UserEmail"].ToString();
       string sts = dt.Rows[0]["UserStuts"].ToString();
       string lastName = dt.Rows[0]["UserLastName"].ToString();
       bool ifEdit = Request.QueryString["action"] != null && Request.QueryString["action"] == "edit";
   
   
   if (ifEdit)
   {
       %>
       <form action="profile.aspx" method=post>
       <%}
         %>
<div class="pro" width="80%">

    <table cellpadding="0" cellspacing="0" class="style1">
        <tr>
            <td dir="rtl" width="50%">
                <wr>▐</wr>אידי: <%=id %> (ID)</td>
            <td width="50%">
            <% if(ifEdit)
               { %>
               <input name="email" type=text value=<%=email %> />
               <%}
                 else
                 { %>
               <%=email %>
               <%} %> :email<wr>▐</wr></td>
        </tr>
        <tr>
            <td width="50%">
                <hr /></td>
            <td width="50%">
                <hr /></td>
        </tr>
        <tr>
            <td width="50%">
                שם משפחה: <%=lastName%><wr>▐</wr></td>
            <td width="50%">
            <% if(ifEdit)
               { %>
               <input name="name" type=text value=<%=name %> />:שם
               <%}
                 else
                 { %>
                 שם:
               <%=name%>
               <%} %>
               <wr>▐</wr></td>
        </tr>
        <tr>
            <td width="50%">
                <hr /></wr></td>
            <td width="50%">
                <hr /></td>
        </tr>
        <tr>
            <td width="50%" colspan="2" style="width: 100%">
                :תמונת פרופיל<wr>▐</wr>
                <center>
                <div class="img">
                <img src="uploads\<%=GetUserImage(id) %>" class="pr" width="350px" height="350px" style="padding: 20px;"></div>
                </center>
                <center>
                <%
                    if (ifEdit)
                    {
       %>
       <a href="profile.aspx?">ביטול</a>
       <%}
                    else
                    {%>
                <a href="profile.aspx?action=edit">ערוך פרופיל</a><%} %></center>
                </td>
        </tr>
    </table>

</div>
<%
    
    if (ifEdit)
    {
       %>
       <center>
       <input type="reset" value="חזור למקור" /><input type="submit"
           value="עדכן" /></center>
       <%}
    else
    {
         %><center>
         <div class="dell"><a href="?action=dell">מחק משתמש</a></div>
         <form id="form1" runat="server">
      <asp:FileUpload ID="FileUpload1" runat="server" />
      <asp:Button ID="UploadButton" runat="server" OnClick="UploadButton_Click" Text="Upload file"/>
</form>
<script runat="server">
    string savePath = @"uploads\";
    string fileName = "";
   
protected void UploadButton_Click(object sender, EventArgs e)
{
    if (FileUpload1.HasFile)
    {
        fileName = FileUpload1.FileName;
        savePath += fileName;
        string ext = fileName.Substring(fileName.Length - 3, 3);
        if(ext == "gif" || ext=="jpg" || ext=="png")
           FileUpload1.SaveAs(Server.MapPath(savePath));

        string sql1 = string.Format(@"Insert into Images(UserID,PicName,PicDiscraib)
        values('{0}','{1}','{2}')", Session["id"], fileName, "");
        DBHelper dbhm = new DBHelper();
        dbhm.GetData(sql1);
    }
}
 </script>
 </center>

         <%}

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
       <a href="?img=<%=dth.Rows[i]["PicName"].ToString()%>"><img src="uploads\<%=dth.Rows[i]["PicName"].ToString()%>" height=80px width=80px title="<%=dth.Rows[i]["PicDiscraib"].ToString() %>" /></a>
       <% if (ifEdit)
    { %><br />
       <input name="profile" type="radio" value="<%=dth.Rows[i]["PicName"].ToString()%>" <%if(GetUserImage(id) == dth.Rows[i]["PicName"].ToString()){%>checked="checked"<%} %> />-הפוך לתמונת פרופיל
       <%}%>
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
 </center><%
  if (ifEdit)
    { %>
</form>
       <%}%>
</asp:Content>

