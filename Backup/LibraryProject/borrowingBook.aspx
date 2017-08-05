<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="borrowingBook.aspx.cs" Inherits="LibraryProject.OduncVer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="divError" class="alert alert-danger" role="alert" runat="server" visible="false" align="center">
    Kitap bulunamadı. Anasayfaya gitmek için <a href="default.aspx"> buraya</a> tıklayınız.
</div>
    <div id="divMain" runat="server">
        <asp:Label ID="lblBookProperties" runat="server" Text="**Kitap bilgileri yüklemesi esnasında hata oluştu."
            CssClass="alert alert-danger" Visible="False"></asp:Label>
        <asp:Label ID="lblBookId" runat="server" Text="***There is no book here." CssClass="alert alert-danger"
            Visible="False"></asp:Label>
        <table class="table">
            <tr>
                <td class="success" rowspan="4" style="width: 310px">
                    <label for="Book Image">
                        Kitabın Resmi</label>
                    <br />
                    <asp:Image ID="BookImage" runat="server" Width="261px" BorderWidth="5px" CssClass="img-rounded"
                        Height="324px" />
                </td>
                <td class="warning">
                    <label for="BookName">
                        Kitabın Adı</label><br />
                    <asp:TextBox ID="TextBoxName" CssClass="form-control" disabled="disabled" runat="server"
                        ReadOnly="True" Font-Bold="True" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="danger">
                    <label for="BookAuthor">
                        Kitabın Yazarı</label><br />
                    <asp:TextBox ID="TextBoxAuthor" CssClass="form-control" runat="server" disabled="disabled"
                        ReadOnly="True" Font-Bold="True" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="info">
                    <label for="BookUser">
                        Alıcının İsmi</label><br />
                    <asp:TextBox placeholder="İsminizi giriniz..." ID="TextBoxUser" CssClass="form-control"
                        runat="server" MaxLength="30" Width="300px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxUser"
                        Display="Dynamic" ErrorMessage="*Yazar ismini boş geçmeyiniz." ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Lütfen yalnızca karakter giriniz."
                        ValidationExpression="^[a-zA-Z+ğ+Ğ+ı+İ+ş+Ş+ç+Ç+ü+Ü+ö+Ö+\s]*$" ControlToValidate="TextBoxUser"
                        Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="warning">
                    <label for="BookDate">
                        Kitabı Geri Vereceğiniz Tarih</label><br />

                    <asp:TextBox ID="TextBoxCalendar" placeholder="Tarih seçiniz..." runat="server"
                        CssClass="form-control" Width="300px" ReadOnly="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxCalendar"
                        Display="Dynamic" ErrorMessage="*Tarih kısmını boş geçmeyiniz." ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="info" colspan="2" style="height: 147px">
                    <p align="center">
                        <asp:Label ID="lblPromise" runat="server" CssClass="alert-danger" Text="*Geri getirmeyecek misin?"
                            Visible="False"></asp:Label>
                        <asp:CheckBox ID="CheckBoxPromise" runat="server" Text="Kitabı 30 gün içinde geri getireceğim." />
                    </p>
                    <p align="center">
                        <asp:Label ID="lblBorrowAlert" runat="server" CssClass="alert-danger" Text="Bağlantıda hata oluştu, ödünç alma işlemi başarısız..&lt;br /&gt;"
                            Visible="False"></asp:Label>
                    </p>
                    <p align="left">
                        <asp:Label ID="lblSuccess" runat="server" Visible="False" CssClass="alert alert-success">Ödünç alma işleminiz tamamlanmıştır.</asp:Label>
                    </p>
                    <p align="center">
                        <asp:Button ID="ButtonBorrow" CssClass="btn btn-primary" runat="server" Text="Ödünç Al"
                            OnClick="ButtonBorrow_Click" />
                    </p>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        $(function () {

            $("#ContentPlaceHolder1_TextBoxCalendar").datepicker($.datepicker.regional["tr"]);
        
        });
        </script>
</asp:Content>
