public with sharing class CovidClass_CC {
    public static void getData()
    {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.covidtracking.com/v1/us/daily.json');
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        req.setTimeout(20000);
        Http http = new Http();
        try
        {
            HTTPResponse res = http.send(req);
           list<CovidClass_CC> listCov = (list<CovidClass_CC>)JSON.deserialize(res.getBody(), list<CovidClass_CC>.class);
           List<covid_tracking__c> listCasos = new List<covid_tracking__c>();
           for (CovidClass_CC cov : listCov) {
            listCasos.add(new covid_tracking__c(
                XC_Fecha__c=Date.valueOf(cov.dateChecked),
                XC_Positive__c=cov.positive,
                XC_Negative__c=cov.negative,
                XC_HospitalizedCurrently__c=cov.hospitalizedCurrently,
                XC_IdExterno__c=cov.hash
            ));
           }
           Database.UpsertResult[] srList = Database.upsert(listCasos,covid_tracking__c.XC_IdExterno__c, false);
           for (Database.UpsertResult sr : srList) {
                if(sr.isSuccess()) {
                   System.debug('Successfully inserted case covid. Id' + sr.getId());
                }
                else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    }
                }
           }
        } catch(Exception e) {
            system.debug('ERROR SERVICIO--'+e.getMessage()+'---'+e.getLineNumber());
        }
    }
    @AuraEnabled
    public static list<covid_tracking__c> getDataCasos() {
        return [SELECT Id,XC_Fecha__c,XC_Positive__c,XC_Negative__c,XC_HospitalizedCurrently__c FROM covid_tracking__c ORDER BY XC_Fecha__c DESC];
    }
    @AuraEnabled
    public static void deleteRow(Id rowId) {
        delete [SELECT ID FROM covid_tracking__c WHERE Id=:rowId];
    }
    public String dateChecked;
    public Integer positive;
    public Integer negative;
    public Integer hospitalizedCurrently;
    public String hash;
}