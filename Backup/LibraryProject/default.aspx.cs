using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;

namespace LibraryProject
{
    public partial class Anasayfa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Book bookObject = new Book();

            //bookObject.Id = Guid.NewGuid();
            //bookObject.Author = "";
            //bookObject.Name = "";
            //bookObject.InLibrary = false;

            //BookHelper.Books.Add(bookObject);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRow drv = ((DataRowView)e.Row.DataItem).Row;

                //e.Row.Cells[5].Visible = !Convert.ToBoolean(drv["Status"]);

                Button borrow = e.Row.FindControl("btnBorrow") as Button;
                borrow.Enabled = !Convert.ToBoolean(drv["Status"]);
            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            if (GridViewID.Rows.Count == 0)
            {
                divDisplay.Visible = false;
                divNull.Visible = true;
            }
        }

        protected void GridView1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "BorrowCommand")
            {
                int rowindex = Convert.ToInt32(e.CommandArgument);
                string id = GridViewID.DataKeys[rowindex].Value.ToString();
                //Session["bookId"] = id;
                Response.Redirect("borrowingBook.aspx?bookId=" + id);
                //Response.Redirect() ile URLmizin sonuna istediğimiz değerleri ekleyebilir
                //ve üstte link olarak görebiliriz.
            }
        }

        protected void btnSearch_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT  Book.ID,Book.Name, Book.Writer, Book.ImgUrl, Borrowed.Date, Borrowed.Person, Book.Status FROM Borrowed FULL OUTER JOIN Book ON Book.ID = Borrowed.BookID WHERE (Book.Name LIKE '%" + txtBoxSearch.Text + "%') OR (Book.Writer LIKE '%" + txtBoxSearch.Text + "%') OR (Borrowed.Person LIKE '%" + txtBoxSearch.Text + "%')";
        }

        [WebMethod]
        public static List<string> result(string Text)
        {
            List<string> result = new List<string>();
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["LibraryDatabase"].ConnectionString;
              //using (SqlCommand cmd = new SqlCommand("SELECT  Book.ID,Book.Name, Book.Writer, Book.ImgUrl, Borrowed.Date, Borrowed.Person, Book.Status FROM Borrowed FULL OUTER JOIN Book ON Book.ID = Borrowed.BookID WHERE (Book.Name LIKE '%" + Text + "%') OR (Book.Writer LIKE '%" + Text + "%') OR (Borrowed.Person LIKE '%" + Text + "%')", con))
                using (SqlCommand cmd = new SqlCommand("SELECT ID,Name,Writer,ImgUrl FROM Book WHERE (Name LIKE '%" + Text + "%') OR (Writer LIKE '%" + Text + "%')", con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@Text", Text);
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        result.Add(string.Format("{0} - {1}-{2}",dr["ImgUrl"], dr["Name"], dr["Writer"]));
                        //result.Add(string.Format("{0}", dr.["<img height=18 width=30 src=" + ImgUrl "+ />"]));
                    }
                }
            }
            return result;
        }
    }
}