using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace LibraryProject
{
    public partial class OduncVer : System.Web.UI.Page
    {
        public int? BorrowedBookId
        {
            get
            {
                var borrowingBookInString = Request.QueryString["bookId"];
                int borrowingBook = 0;

                bool converted = int.TryParse(borrowingBookInString, out borrowingBook);

                if (converted)
                {
                    return borrowingBook;
                }
                else
                {
                    return null;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (BorrowedBookId != null)
                {
                    KitapBilgileriniYukle(BorrowedBookId.Value);
                }
                else
                {
                    divError.Visible = true;
                    divMain.Visible = false;
                    lblBookId.Visible = true;
                }
            }
        }

        private void KitapBilgileriniYukle(int borrowingBook)
        {
            SqlConnection Baglanti;
            SqlCommand Komut;
            SqlDataReader Okuyucu;
            string ConnectionString = ConfigurationManager.ConnectionStrings["LibraryDatabase"].ConnectionString;
            Baglanti = new SqlConnection(ConnectionString);
            Komut = new SqlCommand("SELECT Name,Writer,ImgUrl,Status,Person,Date FROM Book,Borrowed WHERE Book.ID = @borrowingBook", Baglanti);
            var borrowingBookIdParam = new SqlParameter("@BorrowingBook", borrowingBook);
            Komut.Parameters.Add(borrowingBookIdParam);

            try
            {
                Baglanti.Open();
                Okuyucu = Komut.ExecuteReader();
                if (Okuyucu.Read())
                {
                    TextBoxName.Text = Okuyucu["Name"].ToString();
                    TextBoxAuthor.Text = Okuyucu["Writer"].ToString();
                    BookImage.ImageUrl = Okuyucu["ImgUrl"].ToString();
                    if (Convert.ToBoolean(Okuyucu["Status"]))
                    {
                        ButtonBorrow.Enabled = false;
                        TextBoxUser.Text = Okuyucu["Person"].ToString();
                        TextBoxUser.Enabled = false;
                        TextBoxCalendar.Text = Convert.ToDateTime(Okuyucu["Date"]).ToShortDateString();
                        TextBoxCalendar.Enabled = false;
                    }
                }
                Okuyucu.Close();
            }
            catch
            {
                lblBookProperties.Visible = true;
            }
            finally
            {
                Baglanti.Close();
            }
        }

        protected void ButtonBorrow_Click(object sender, EventArgs e)
        {
            if (CheckBoxPromise.Checked)
            {
                SqlConnection Baglanti;
                SqlCommand Komut_Update, Komut_Insert;
                string ConnectionString = ConfigurationManager.ConnectionStrings["LibraryDatabase"].ConnectionString;
                Baglanti = new SqlConnection(ConnectionString);

                Komut_Insert = new SqlCommand("INSERT INTO Borrowed (BookID, Date, Person) VALUES (@BookID,@Date,@Person)", Baglanti);
                Komut_Insert.Parameters.Add("@BookID", System.Data.SqlDbType.Int);
                Komut_Insert.Parameters["@BookID"].Value = BorrowedBookId.Value;
                Komut_Insert.Parameters.Add("@Date", System.Data.SqlDbType.Date);
                Komut_Insert.Parameters["@Date"].Value = Convert.ToDateTime(TextBoxCalendar.Text);
                Komut_Insert.Parameters.Add("@Person", System.Data.SqlDbType.NVarChar);
                Komut_Insert.Parameters["@Person"].Value = TextBoxUser.Text;

                Komut_Update = new SqlCommand("UPDATE Book SET Status=@Status WHERE ID=" + BorrowedBookId.Value, Baglanti);
                Komut_Update.Parameters.Add("@Status", System.Data.SqlDbType.Bit);
                Komut_Update.Parameters["@Status"].Value = true;

                bool success = false;
                try
                {
                    Baglanti.Open();
                    Komut_Insert.ExecuteNonQuery();
                    Komut_Update.ExecuteNonQuery();
                    success = true;
                }
                catch (Exception ex)
                {
                    lblBorrowAlert.Text += ex.Message.ToString();
                    lblBorrowAlert.Visible = true;
                    success = false;
                }
                finally
                {
                    Baglanti.Close();
                    if (success)
                    {
                        lblSuccess.Visible = true;
                    }
                }
            }
            else
            {
                lblPromise.Visible = true;
            }
        }
    }
}