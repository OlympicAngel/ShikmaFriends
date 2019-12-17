using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;
using System.Data;
using System.Threading;

/// <summary>
/// Summary description for DBHelper
/// </summary>
public class DBHelper
{
    OleDbConnection conn; //אחראי ליצור קשר עם ממסד נתונים
    OleDbCommand command; //אחראי להעביר פקודות לממסד נתונים
    //Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\h\SkyDrive\ShikmaFriends\MyDB.accdb
    //Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\student\SkyDrive\ShikmaFriends\MyDB.accdb


    public DBHelper()
    {
        this.conn = new OleDbConnection();
        string path = System.Web.HttpContext.Current.Server.MapPath("/").Replace("//",@"\");
        this.conn.ConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source="+ path + "MyDB.accdb";
        this.command = new OleDbCommand();
        this.command.Connection = this.conn;
    }

    public int ChangDB(string sql)
    {
        this.command.CommandText = sql;
        this.conn.Open();
        int row = this.command.ExecuteNonQuery();
        this.conn.Close();
        return row;
    }

    public DataTable GetData(string sql)
    {
        DataTable dt = new DataTable();//יצירת עצם שמסוגל לשמור טבלאות
        this.conn = new OleDbConnection();//יצירת עצם שמסוגל ליצור קשר אם המסד נתונים
        string path = System.Web.HttpContext.Current.Server.MapPath("/").Replace("//", @"\");
        this.conn.ConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + "MyDB.accdb";

        OleDbDataAdapter da = new OleDbDataAdapter();//יצירת עצם מסוג OleDBDataAdpter
        da.SelectCommand = new OleDbCommand();//יצירת קישור שדרכו אפשר לשלוף נתונים
        da.SelectCommand.CommandText = sql;//אומרים לעצם מה לשלוף
        da.SelectCommand.Connection = this.conn;//
        this.conn.Open();//תפתח משד נתונים
         da.Fill(dt); //ממלא  dt בנתונים
        this.conn.Close();// תסגור מסד נתונים
        return (dt);//מחזיר את הטבלה
    }

}