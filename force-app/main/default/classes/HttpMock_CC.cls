@isTest
public with sharing class HttpMock_CC implements HttpCalloutMock{
    
    protected Integer code;
    protected String status;
    protected String body;
    public HttpMock_CC(Integer code, String status, String body){
        this.code = code;
        this.status = status;
        this.body=body;
    }
    public HTTPResponse respond(HTTPRequest req){
        HttpResponse resp = new HttpResponse();
        resp.setStatusCode(code);
        resp.setStatus(status);
        resp.setHeader('Content-Type', 'application/json');
        resp.setBody(body);
        return resp;
    }
}