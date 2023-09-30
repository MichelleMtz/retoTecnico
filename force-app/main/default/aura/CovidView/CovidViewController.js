({
    doInit : function (component, event, helper) {
        var columns = [
            {label: 'Date', fieldName: 'XC_Fecha__c', type: 'string', sortable: true},
            {label: 'Positive', fieldName: 'XC_Positive__c', type: 'number'},
            {label: 'Negative', fieldName: 'XC_Negative__c', type: 'number'},
            {label: 'Hospitalized Currently', fieldName: 'XC_HospitalizedCurrently__c', type: 'number'},
            {label: '', type: 'button',typeAttributes:{ name: 'delete', iconName: 'utility:delete'}},
        ];
        component.set("v.columns", columns);
        helper.initData(component);
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        console.log(row);
        cmp.set('v.isLoading', true);
        helper.deleteHelper(cmp,row);
    },
    updateColumnSorting: function (cmp, event, helper) {
        cmp.set('v.isLoading', true);
        setTimeout($A.getCallback(function() {
            var fieldName = event.getParam('fieldName');
            var sortDirection = event.getParam('sortDirection');
            cmp.set("v.sortedBy", fieldName);
            cmp.set("v.sortedDirection", sortDirection);
            helper.sortData(cmp, fieldName, sortDirection);
            cmp.set('v.isLoading', false);
        }), 0);
    },
})
