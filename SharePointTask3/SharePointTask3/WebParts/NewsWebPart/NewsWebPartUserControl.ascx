<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsWebPartUserControl.ascx.cs" Inherits="SharePointTask3.WebParts.NewsWebPart.NewsWebPartUserControl" %>


<asp:UpdatePanel ID="Update" runat="server" UpdateMode="Conditional">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="Btn" EventName="Click" />
    </Triggers>
    <ContentTemplate>
        <form>
            <asp:Label Text="Title" runat="server" for="newsTitle" />
            <input runat="server" type="text" name="newsTitle" id="newsTitle" />
            <br />
            <asp:Label Text="Description" runat="server" for="newsDescription" />
            <input runat="server" type="text" name="newsDescription" id="newsDescription" />
            <br />
            <asp:Label Text="Date" runat="server" for="newsDatePublishing" />
            <SharePoint:DateTimeControl runat="server" ID="newsDatePublishing" />
            <br />
            <asp:Label Text="Author" runat="server" for="newsAssignedPerson" />
            <SharePoint:ClientPeoplePicker ID="newsAssignedPerson" runat="server" AllowMultipleEntities="false" />

            <asp:CheckBox runat="server" ID="CheckBoxVisible" />
            <asp:Button ID="Btn" runat="server" OnClick="AddToList" Text="ADD" />
        </form>

        <div class="grid">
            <ul style="list-style: none;">
                <li>
                    <asp:Button ID="SrtByDateAsc" runat="server" Text="Sort by Date Ascending" OnClick="SrtByDate_Click" />
                    <asp:Button ID="SrtByDateDesc" runat="server" Text="Sort by Date Descending" OnClick="SrtByDateDesc_Click" />
                </li>
                <li>
                    <asp:Button ID="SrtByAuthorAsc" runat="server" Text="Sort by Author Ascending" OnClick="SrtByAuthor_Click" />
                    <asp:Button ID="SrtByAuthorDesc" runat="server" Text="Sort by Author Descending" OnClick="SrtByAuthorDesc_Click" />
                </li>
            </ul>
        </div>

        <asp:Repeater ID="RepeatItems" runat="server">
            <HeaderTemplate>
                <div class="grid">
                    <h1>Items:</h1>
                </div>
            </HeaderTemplate>

            <ItemTemplate>
                <div class="grid">
                    <ul class="news">
                        <li class="news__item"><strong>Title:</strong><%#DataBinder.Eval(Container.DataItem,"Title") %></li>
                        <li class="news__item"><strong>Description:</strong><%#DataBinder.Eval(Container.DataItem,"CustomDescriprtion") %></li>
                        <li class="news__item"><strong>Publishing Date:</strong><%#DataBinder.Eval(Container.DataItem,"DatePublishing") %></li>
                        <li class="news__item"><strong>Author:</strong><%#DataBinder.Eval(Container.DataItem,"AssignedPerson") %></li>
                    </ul>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </ContentTemplate>
</asp:UpdatePanel>
