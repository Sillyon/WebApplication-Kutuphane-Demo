<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="default.aspx.cs" Inherits="LibraryProject.Anasayfa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">   
    
    <style>
        .div1 
              {
                  margin-left: +300px;
  
                  }
        .transbox
              {
                  background-color: #ffffff;
                  opacity:0.75;
                  font-size:small;
              }
         .grid
              {
                  opacity:0.95;
              }
    </style>

    <div class="div1 col-lg-6">
        <div class="input-group">
            <asp:TextBox ID="txtBoxSearch"  placeholder="Arama" runat="server" 
                CssClass="transbox form-control" BorderColor="LightBlue" 
                AutoCompleteType="Search"/>
            <span class="input-group-btn">
                <asp:ImageButton ID="btnSearch" runat="server" CssClass="btn btn-default" 
                onclick="btnSearch_Click" ImageUrl="~/img/glyphicon search.png" Height="34px" 
                Width="45px" BorderColor="LightBlue"/>
            </span>
        </div>
    </div>

<div id="divDisplay" runat="server">
    <asp:GridView ID="GridViewID" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
        OnRowDataBound="GridView1_RowDataBound" CssClass="table" OnDataBound="GridView1_DataBound"
        OnRowCommand="GridView1_RowCommand" DataKeyNames="ID" AllowPaging="True" 
        PageSize="5" >
        <Columns>

            <asp:TemplateField HeaderText="Kitap Bilgileri" SortExpression="BookExpression">
                <ItemTemplate>
                    <table ID="tableBook" runat="server">
                    <tr>
                        <td>
                            <asp:Image ID="ImageBook" runat="server" ImageUrl='<%# Eval("ImgUrl") %>' CssClass="img-rounded" Height="200px" Width="150px" />
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;
                            <asp:Label ID="lvlPreName" runat="server" Text="Adı = " Font-Italic="True" Font-Size="16pt" CssClass="text-danger"></asp:Label>
                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' Font-Bold="True" Font-Size="16pt"></asp:Label>
                            <br />&nbsp;&nbsp;&nbsp;
                            <asp:Label ID="lblPreAuthor" runat="server" Text="Yazarı = " Font-Italic="True" CssClass="text-danger"></asp:Label>
                            <asp:Label ID="lblAuthor" runat="server" Text='<%# Bind("Writer") %>' Font-Bold="True"  Font-Italic="True" ></asp:Label>
                        </td>
                    </tr>
                    </table>
                </ItemTemplate>
                <ItemStyle CssClass="grid info"/>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Raf Bilgisi" SortExpression="BorrowExpression" ConvertEmptyStringToNull="False">
                <ItemTemplate>
                    <asp:Label ID="lblDate" runat="server" Font-Bold="True" Text='<%# Bind("Date", "{0:dd.MM.yyyy} tarihine kadar") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblPerson" runat="server" Font-Bold="True" Text='<%# Bind("Person", "{0} kullanıcısında bulunacak.") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="grid success"/>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Ödünç Alma İşlemi">
                <ItemTemplate>
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:Button ID="btnBorrow"  runat="server"  
                        CommandName="BorrowCommand" CommandArgument='<%# Container.DataItemIndex %>' Text="Ödünç Ver" CausesValidation="False" CssClass="btn btn-primary" /> 
                </ItemTemplate>
                <ItemStyle CssClass="grid warning"/>
            </asp:TemplateField>

        </Columns>
        <HeaderStyle Font-Bold="True" Font-Overline="False" Font-Strikeout="False"
            Font-Names="Arial Unicode MS" Font-Size="Larger" ForeColor = "BlanchedAlmond"  BackColor="Teal" />
        <PagerSettings FirstPageImageUrl="~/img/first-Page.png"
            LastPageImageUrl="~/img/last-Page.png" Mode="NextPreviousFirstLast" 
            NextPageImageUrl="~/img/next-Page.png"
            PreviousPageImageUrl="~/img/previous-Page.png" />
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConfigurationStringApplication %>"
        SelectCommand="SELECT Book.ID, Book.Name, Book.Writer, Book.ImgUrl, Borrowed.Date, Borrowed.Person, Book.Status FROM Borrowed FULL OUTER JOIN Book ON Book.ID = Borrowed.BookID ORDER BY Book.Status, Book.Name" 
        ProviderName="<%$ ConnectionStrings:ConfigurationStringApplication.ProviderName %>">
    </asp:SqlDataSource>
</div>

<div id="divSearch" runat="server" Class="alert alert-danger" visible="False" align="center">
<br /><br /><br />
   Kitap bulmada hata. Anasayfaya gitmek için <a 
        href="default.aspx"> buraya</a> tıklayınız.<br /><br />
    
</div>

<br /><br /><br /><br /><br /><br />

<div id="divNull" runat="server" visible="False" Class="alert alert-danger" align="center">
Kitap bulunamadı. Anasayfaya gitmek için <a href="default.aspx"> buraya</a> tıklayınız.
    
</div>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#ContentPlaceHolder1_txtBoxSearch").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "default.aspx/result",
                        data: "{'Text':'" + document.getElementById('ContentPlaceHolder1_txtBoxSearch').value + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);

                        },
                        error: function (result) {
                            alert("Error......"+result);
                        }
                    });
                }
            });
        });
   </script>



</asp:Content>