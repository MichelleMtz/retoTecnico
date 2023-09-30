@isTest
public with sharing class CovidClass_Test {
    
    @TestSetup
    static void makeData(){
        String body='[{"date":20210307,"states":56,"positive":28756489,"negative":74582825,"pending":11808,"hospitalizedCurrently":40199,"hospitalizedCumulative":776361,"inIcuCurrently":8134,"inIcuCumulative":45475,"onVentilatorCurrently":2802,"onVentilatorCumulative":4281,"dateChecked":"2021-03-07T24:00:00Z","death":515151,"hospitalized":776361,"totalTestResults":363825123,"lastModified":"2021-03-07T24:00:00Z","recovered":null,"total":0,"posNeg":0,"deathIncrease":842,"hospitalizedIncrease":726,"negativeIncrease":131835,"positiveIncrease":41835,"totalTestResultsIncrease":1170059,"hash":"a80d0063822e251249fd9a44730c49cb23defd83"}]';
        Test.setMock(HttpCalloutMock.class, new HttpMock_CC(200,'success',body));
        Test.startTest();
        CovidClass_CC.getData();
        list<covid_tracking__c> listCasosCovid= [SELECT Id FROM covid_tracking__c];
        system.assertEquals(listCasosCovid.size(), 1,'makeData');
        Test.stopTest();
    }
    @IsTest
    static void getDataCasosTest(){
        
        Test.startTest();
        list<covid_tracking__c> listCovid=CovidClass_CC.getDataCasos();
        system.assertEquals(listCovid.size(), 1,'getDataCasosTest');
        CovidClass_CC.deleteRow(listCovid[0].Id);

        list<covid_tracking__c> listCasosCovid= [SELECT Id FROM covid_tracking__c];
        system.assertEquals(listCasosCovid.size(), 0,'getDataCasosTest');
        Test.stopTest();
    }
    @IsTest
    static void getDataCasosError(){
        String body='[{"date":20210307,"states":56,"positive":28756489,"negative":74582825,"pending":11808,"hospitalizedCurrently":40199,"hospitalizedCumulative":776361,"inIcuCurrently":8134,"inIcuCumulative":45475,"onVentilatorCurrently":2802,"onVentilatorCumulative":4281,"dateChecked":"2021-03-07T24:00:00Z","death":515151,"hospitalized":776361,"totalTestResults":363825123,"lastModified":"2021-03-07T24:00:00Z","recovered":null,"total":0,"posNeg":0,"deathIncrease":842,"hospitalizedIncrease":726,"negativeIncrease":131835,"positiveIncrease":41835,"totalTestResultsIncrease":1170059,"hash":"a80d0063822e251249fd9a44730c49cb23defd83"}]';
        Test.setMock(HttpCalloutMock.class, new HttpMock_CC(500,'error',body));
        Test.startTest();
        CovidClass_CC.getData();
        list<covid_tracking__c> listCasosCovid= [SELECT Id FROM covid_tracking__c];
        system.assertEquals(listCasosCovid.size(), 1,'getDataCasosError');
        Test.stopTest();
    }
    @IsTest
    static void casosErrorData(){
        String body='[{"date":20210307,"states":56,"positive":as,"negative":as,"pending":11808,"hospitalizedCurrently":as,"hospitalizedCumulative":776361,"inIcuCurrently":8134,"inIcuCumulative":45475,"onVentilatorCurrently":2802,"onVentilatorCumulative":4281,"dateChecked":null,"death":515151,"hospitalized":776361,"totalTestResults":363825123,"lastModified":"2021-03-07T24:00:00Z","recovered":null,"total":0,"posNeg":0,"deathIncrease":842,"hospitalizedIncrease":726,"negativeIncrease":131835,"positiveIncrease":41835,"totalTestResultsIncrease":1170059,"hash":"a80d0063822e251249fd9a44730c49cb23defd83"}]';
        Test.setMock(HttpCalloutMock.class, new HttpMock_CC(200,'success',body));
        Test.startTest();
        CovidClass_CC.getData();
        list<covid_tracking__c> listCasosCovid= [SELECT Id FROM covid_tracking__c];
        system.assertEquals(listCasosCovid.size(), 1,'casosErrorData');
        Test.stopTest();
    }
}