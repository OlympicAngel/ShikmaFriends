<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    .roser
    {
background: #F4F4F4;
    border-radius: 12px; /*/שולט על עיגול הפינות/*/
    border: 0.5px solid #303E41; /*/ שולט על הגבולות כך: צבע ת סגנון ת עובי /*/
    padding: 20px;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
<%
    bool regis = true;
    if (Request.Form["UserName"] != null && Request.Form["UserName"].ToString() != "" &&
      Request.Form["Password"] != null && Request.Form["Password"].ToString() != "")
  {
      string username = Request.Form["UserName"];
      string password = Request.Form["Password"].ToString();

      string sql = string.Format("Select * from Users where UserName='{0}' and UserPassword='{1}'", username, password);
      DBHelper dbh = new DBHelper();
      System.Data.DataTable dt = dbh.GetData(sql);
      if(dt.Rows.Count > 0)
      {
          Session["id"] = dt.Rows[0]["UserID"];
          Response.Redirect("index.aspx");
      }
      else
      {
       regis = false;
      }
  }
%>
<center>
<% if (Session["id"] != null)
   {%><br /><br /><br /><br /><br /><br /><br /><br /><br />
   <p>אתה כבר מחובר, אין צורך בהיתחברות חוזרת</p>
   <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
   <%}
   else
   { %>
   <br /><br />
   <h2>:היתחברות</h2><br /><br />
<form method="post" action="login.aspx">
    <table dir="rtl" class="roser">
        <tr>
            <td>
                שם משתמש:</td>
            <td>
                <input name="UserName" type="text" /></td>
        </tr>
        <tr>
            <td>
               סיסמה:</td>
            <td>
                <input name="Password" type="password" /></td>
        </tr>
        <tr>
            <td>
                <input id="Submit1" type="submit" value="התחבר" /></td>
            <td>
                <input id="Reset1" type="reset" value="אפס" /></td>
        </tr>
    </table>
    <%if (regis == false)
      {%><p>שם המישתמש או הסיסמה אינם נכונים, אנה נסה שוב</p><%} %>
          
    </form>
    <%} %>
    </center>
    <br /><br /><br /><br /><br />
</asp:Content>

