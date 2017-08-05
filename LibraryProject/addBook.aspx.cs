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
    public partial class KitapEkle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSaveBook_Click(object sender, EventArgs e)
        {
            if (UploadImage.HasFile)
            {
                if (UploadImage.PostedFile.ContentType.StartsWith("image/"))
                {
                    UploadImage.SaveAs(Request.PhysicalApplicationPath + "Resimler\\" + UploadImage.FileName);
                    SqlConnection Baglanti;
                    SqlCommand Komut;
                    string ConnectionString = ConfigurationManager.ConnectionStrings["ConfigurationStringApplication"].ConnectionString;
                    Baglanti = new SqlConnection(ConnectionString);
                    Komut = new SqlCommand("INSERT INTO Book (Name,Writer,ImgUrl,Status) VALUES (@Name,@Writer,@ImgUrl,@Status)", Baglanti);
                    Komut.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar);
                    Komut.Parameters["@Name"].Value = txtBookName.Text;
                    Komut.Parameters.Add("@Writer", System.Data.SqlDbType.NVarChar);
                    Komut.Parameters["@Writer"].Value = txtBookAuthor.Text;
                    Komut.Parameters.Add("@ImgUrl", System.Data.SqlDbType.NVarChar);
                    Komut.Parameters["@ImgUrl"].Value = "Resimler\\" + UploadImage.FileName;
                    Komut.Parameters.Add("@Status", System.Data.SqlDbType.Bit);
                    Komut.Parameters["@Status"].Value = false;

                    try
                    {
                        Baglanti.Open();
                        Komut.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        LabelCatch.Visible = true;
                        LabelCatch.Text += ex.Message.ToString();
                    }
                    finally
                    {
                        Baglanti.Close();
                        LabelAdding.Visible = true;
                    }
                }
                else
                {
                    divAdding.Visible = false;
                    divWrongWithThis.Visible = true;
                }
            }
        }
    }
}

