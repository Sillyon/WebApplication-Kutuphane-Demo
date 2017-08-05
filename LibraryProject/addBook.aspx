<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addBook.aspx.cs" Inherits="LibraryProject.KitapEkle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .style1
        {
            width: 132px;
        }
        .style2
        {
            width: 282px
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id=divAdding runat="server">
    <br />
  <table class="table">
    <tbody>
      <tr class="success">
        <td class="style1" ><label for="BookName">Kitabın Adı</label></td>
        <td class="style2" >

                 <asp:TextBox placeholder="Kitap ismini giriniz..." ID="txtBookName" CssClass="form-control" 
                     runat="server" MaxLength="30" Height="33px" 
                     Width="50%"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                     ControlToValidate="txtBookName" Display="Dynamic" 
                     ErrorMessage="*Kitabın adını boş geçmeyiniz." ForeColor="Red"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                     ErrorMessage="*Lütfen yalnızca karakter giriniz." 
                     ValidationExpression="^[a-zA-Z+ğ+Ğ+ı+İ+ş+Ş+ç+Ç+ü+Ü+ö+Ö+\s]*$" ControlToValidate="txtBookName" 
                     Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
          </td>
      </tr>
      <tr class="danger">
        <td class="style1" ><label for="BookAuthor">Kitabın Yazarı</label></td>
        <td class="style2" >

            <asp:TextBox placeholder="Yazar ismini giriniz..." ID="txtBookAuthor" 
                CssClass="form-control" Width="50%" runat="server" MaxLength="20"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtBookAuthor" Display="Dynamic" 
                ErrorMessage="*Yazar ismini boş geçmeyiniz." ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                ErrorMessage="*Lütfen yalnızca karakter giriniz." 
                ValidationExpression="^[a-zA-Z+ğ+Ğ+ı+İ+ş+Ş+ç+Ç+ü+Ü+ö+Ö+\s]*$" ControlToValidate="txtBookAuthor" 
                Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
          </td>
      </tr>
      <tr class="info">
        <td class="style1" ><label for="BookImage">Kitabın Resmi</label></td>
        <td class="style2" >
            <asp:FileUpload ID="UploadImage" Width="50%" placeholder="Resim dosyası seçiniz..." runat="server" accept="image/*" 
            CssClass="form-control" />
                
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="UploadImage" Display="Dynamic" 
                ErrorMessage="*Resim dosyasını boş geçmeyiniz." ForeColor="Red"></asp:RequiredFieldValidator>
                
            </td>
      </tr>
      <tr class="warning">
        <td colspan="2">
            <p align="center">

                <asp:Button ID="ButtonSaveBook" CssClass="btn btn-primary" runat="server" 
                    Text="Kitabı Ekle" onclick="ButtonSaveBook_Click" />
            </p>
            <p align="center">

                <asp:Label ID="LabelAdding" align="left" CssClass ="alert alert-success" 
                    runat="server" Visible="False" >Kitap Sisteme Kaydedilmiştir.</asp:Label>

                <asp:Label ID="LabelCatch" runat="server" 
                    Text="Bağlantıda hata oluştu, veri kaydedilemedi.<br />" 
                    CssClass="alert-danger" Visible="False"></asp:Label>

            </p>
          </td>
      </tr>
    </tbody>
  </table>
</div>


<br /><br /><br />
    

<div id=divWrongWithThis runat="server" visible="false" Class="alert alert-danger" align="center">Dosya türü .jpg, .jpeg ya da .png olmalıdır. Ana menüye gitmek için <a 
        href="default.aspx"> buraya</a> tıklayınız.<br /><br />
    
</div>

<br /><br /><br />
</asp:Content>
