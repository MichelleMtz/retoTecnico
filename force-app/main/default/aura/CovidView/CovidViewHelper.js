({
    initData : function (component, event) {
        var action = component.get("c.getDataCasos");
        action.setCallback(this, function (response) {
            var state = response.getState();
            component.set("v.isLoading", false);
            if (state === 'SUCCESS') {
                var result = response.getReturnValue();
                component.set("v.data", result);
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                        console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    deleteHelper : function (component, row) {
        var action = component.get("c.deleteRow");
        action.setParams({'rowId':row.Id});
        action.setCallback(this, function (response) {
            var state = response.getState();
            component.set('v.isLoading', false);
            if (state === 'SUCCESS') {
                var result = response.getReturnValue();
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type":"success",
                    "title": "",
                    "message": "Se eliminó correctamente"
                });
                toastEvent.fire();
                this.initData(component);
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                        console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.data");
        var reverse = sortDirection !== 'asc';

        data = Object.assign([],
            data.sort(this.sortBy(fieldName, reverse ? -1 : 1))
        );
        cmp.set("v.data", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer
            ? function(x) {
        return primer(x[field]);
        }
                    : function(x) {
        return x[field];
        };

        return function (a, b) {
            var A = key(a);
            var B = key(b);
            return reverse * ((A > B) - (B > A));
        };
    },
})
