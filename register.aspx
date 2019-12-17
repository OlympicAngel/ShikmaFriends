<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>

</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server"><center>
    <center>
     <h2>:הרשמה</h2><hr /><br />
        <%if (Request.Form["UserName"] != null && Request.Form["UserName"].ToString() != "" &&
      Request.Form["UserPassword"] != null && Request.Form["UserPassword"].ToString() != "" &&
      Request.Form["UserFaName"] != null && Request.Form["UserFaName"].ToString() != "" &&
      Request.Form["UserEmail"] != "" && Request.Form["UserEmail"].ToString() != "" &&
      Request.Form["UserIsStudent"] != null && Request.Form["UserIsStudent"].ToString() != "")
          {
              string userName = Request.Form["UserName"].ToString();
              string userPassword = Request.Form["UserPassword"].ToString();
              string userFaName = Request.Form["UserFaName"].ToString();
              string userEmail = Request.Form["UserEmail"].ToString();
              string status = Request.Form["UserIsStudent"].ToString();
              //צריך לישמור בממסד נתונים

              string sql = string.Format(@"Insert into Users(UserName,UserLastName,UserPassword,UserEmail,UserStuts,Dell)
values('{0}','{1}','{2}','{3}','{4}',{5})", userName, userFaName,userPassword, userEmail, status,false);
              DBHelper DBH = new DBHelper();
              int rows = DBH.ChangDB(sql);
              if (rows != 0)
              { 
        %>
        נרשמתה בהצלחה!<br />
        שלום,
        <%=userName%> <%=userFaName%>
        <h3>
            <b>
                <%=userName%></b> אתה צריך לאשר את המשתמש<br />
                <b>
                <%=userEmail%>  :דרך המייל</b></h3>
        <%
      }

  }
          else
          {      
        %>
        <form action="register.aspx" method="post">
        <table align="center" width="420" dir="rtl" border="1px" style="border: 0px;" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center"><center>
                    שם:
                </td><center>
                <td align="center" class="noB"><center>
                    <input name="UserName" type="text" />
                </td><center>
            </tr>
            <tr>
                <td align="center"><center>
                     שם מישפחה:
                </td><center>
                <td align="center" class="noB"><center>
                    <input name="UserFaName" type="text" />
                </td><center>
            </tr>
            <tr>
                <td align="center"><center>
                    סיסמה:
                </td><center>
                <td align="center" class="noB"><center>
                    <input name="UserPassword" type="password" />
                </td><center>
            </tr>
            <tr>
                <td align="center"><center>
                    אימייל:
                </td><center>
                <td align="center" class="noB"><center>
                    <input name="UserEmail" type="text" />
                </td><center>
            </tr>
            <tr>
                <td><center>
                    את/ה:
                </td><center>
                <td align=right class="noB">
                    <p align=right><input checked="checked" name="UserIsStudent" type="radio" value="תלמיד" />תלמיד
                    <br />
                    <input name="UserIsStudent" type="radio" value="מורה" />מורה</p>
                    
                    <input name="UserIsStudent" type="radio" value="הורה" />הורה</p>
                </td><center>
            </tr>
            <tr>
                <td>
                </td><center>
                <td class="noB">
                    <center><input id="Reset1" type="reset" value="אפס" /><input id="Submit1" type="submit" value="שלח" /></center>
                </td><center>
            </tr>
        </table>
        </form>
        <% 
            if (Request.Form["UserName"] != null && Request.Form["UserName"].ToString() == "")
            {
              %><p style="color: Red;">!אנה הזן שם✘</p><%
            }
            else
               %><p style="color: green;">!שם הוזן✔</p><%
                
                
                if (Request.Form["UserFaName"] != null && Request.Form["UserFaName"].ToString() == "")
            {
              %><p style="color: Red;">!אנה הזן שם משפחה✘</p><%
            }
            else
                {
               %><p style="color: green;">!שם משפחה הוזנה✔</p><%
                }   
           if (Request.Form["UserPassword"] != null && Request.Form["UserPassword"].ToString() == "")
            {
              %><p style="color: Red;">!אנה הזן סיסמה✘</p><%
            }
            else
           {
               %><p style="color: green;">!סיסמה הוזנה✔</p><%
           }
              
              if (Request.Form["imageURL"] != null && Request.Form["imageURL"].ToString() == "")
            {
              %><p style="color: Red;">!אנה הזן כתובת תמונה✘</p><%
            }
            else
           {
               %><p style="color: green;">!תמונה הוזנה✔</p><%
           }
              
              
                if (Request.Form["UserEmail"] != null && Request.Form["UserEmail"].ToString() == "")
            {
              %><p style="color: Red;">!אנה הזן כתובת אימייל✘</p><%
            }
            else
           {
               %><p style="color: green;">!אימייל הוזן✔</p><%
           }
                                       
          } %>
        <br /><hr /><br />
</asp:Content>


