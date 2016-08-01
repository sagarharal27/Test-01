public class CampaignDemo {
	public CampaignDemo() {
		list<Campaign> campaignList =[Select ID,name,BudgetedCost 
                                      from Campaign 
                                      limit 10];
		list<Campaign> ascendingCampaignList=campaignList;
        list<Campaign> descendingCampaignList=campaignList;
        Campaign campaignInstance;
        
        // Ascending order by Budgeted Cost
        
        for(Integer i=0;i<ascendingCampaignList.size();i++)
            for(Integer j=i+1;j<ascendingCampaignList.size();j++)
                if(ascendingCampaignList[i].BudgetedCost > ascendingCampaignList[j].BudgetedCost) {
                    campaignInstance=ascendingCampaignList[i];
                    ascendingCampaignList[i]=ascendingCampaignList[j];
                    ascendingCampaignList[j]=campaignInstance;
                }
        System.debug(ascendingCampaignList);
        

        // Descending order by Budgeted Cost
        
        for(Integer i=0;i<descendingCampaignList.size();i++)
            for(Integer j=i+1;j<descendingCampaignList.size();j++)
                if(descendingCampaignList[i].BudgetedCost < descendingCampaignList[j].BudgetedCost) {
                    campaignInstance=descendingCampaignList[i];
                    descendingCampaignList[i]=descendingCampaignList[j];
                    descendingCampaignList[j]=campaignInstance;
                }
        System.debug(descendingCampaignList);
	}
}