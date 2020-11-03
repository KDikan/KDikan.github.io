using Microsoft.SharePoint;
using Microsoft.SharePoint.BusinessData.Administration;
using Microsoft.SharePoint.WebControls;
using SharePointTask3.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace SharePointTask3.WebParts.NewsWebPart
{
    public partial class NewsWebPartUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;
            AddItemInRepeater("ID", true); 
        }
        protected void AddItemInRepeater(string fieldName, bool action)
        {
            UlsLogging.LogInformation("repeater_function");
            using (SPSite site = new SPSite(SPContext.Current.Site.Url))
            {
                SPWeb web = site.OpenWeb();
                SPList newsList = web.Lists["News"];

                SPQuery query = new SPQuery();

                query.Query = string.Format(@" 
                    <Where> 
                          <Eq>
                               <FieldRef Name ='IsVisible'/> 
                                   <Value Type ='Boolean'>
                                                   1 
                                    </Value>
                          </Eq>
                    </Where >
                    <OrderBy>
                        <FieldRef Name='{0}' Ascending='{1}'/>
                    </OrderBy>", fieldName, action);

                SPListItemCollection newsItemsCollection = newsList.GetItems(query);
                RepeatItems.DataSource = newsItemsCollection.GetDataTable();
                RepeatItems.DataBind();
            }
        }

        public void AddToList(object sender, EventArgs e)
        {
            try
            {
                string newsTitleToSave = newsTitle.Value;
                string newsDescriptionToSave = newsDescription.Value;
                DateTime newsDatePublishingToSave = newsDatePublishing.SelectedDate;
                List<PickerEntity> newsAssignedPersonToSave = newsAssignedPerson.AllEntities;
                bool isVisible = CheckBoxVisible.Checked;
                UlsLogging.LogInformation("Before web");

                SPWeb web = SPContext.Current.Web;
                SPList newsList = web.Lists["News"];
                SPListItem newsItem = newsList.AddItem();

                newsItem["Title"] = newsTitleToSave;
                newsItem.Update();
                newsItem["CustomDescriprtion"] = newsDescriptionToSave;
                newsItem.Update();
                newsItem["DatePublishing"] = newsDatePublishingToSave;
                newsItem.Update();
                newsItem["IsVisible"] = isVisible;
                newsItem.Update();
                foreach (PickerEntity user in newsAssignedPersonToSave)
                {
                    UlsLogging.LogInformation("Selected user {0}", user.Key);
                    SPUser spuser = web.EnsureUser(user.Key);
                    newsItem["AssignedPerson"] = new SPFieldUserValue(web, spuser.ID, spuser.Name);
                }
                newsItem.Update();
                
                AddItemInRepeater("ID", true);
     
            }


            catch (Exception ex)
            {
                UlsLogging.LogError("Error message {0} StackTrace {1}", ex.Message, ex.StackTrace);
            }
        }

        protected void SrtByDate_Click(object sender, EventArgs e)
        {
            AddItemInRepeater("DatePublishing", true);
        }

        protected void SrtByAuthor_Click(object sender, EventArgs e)
        {
            AddItemInRepeater("AssignedPerson", true);
        }

        protected void SrtByDateDesc_Click(object sender, EventArgs e)
        {
            AddItemInRepeater("DatePublishing", false);
        }

        protected void SrtByAuthorDesc_Click(object sender, EventArgs e)
        {
            AddItemInRepeater("AssignedPerson", false);
        }

    }
}
