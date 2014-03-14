"use strict";
//= require ../utils
var Fertilizers = {
    init: function(){
        var _this = this;
        _this.list();
    },
    list: function(){
        var url = '/api/v1/fertilizers';
        $.getJSON(url).complete(function(response){
            if(response.status == 200){
                var json = response.responseJSON;
                var fertilizers = json.list;
                var sw = true;
                $('#table-fertilizers > thead').append('<tr></tr>');
                $.each(fertilizers, function(k, v){
                    $('#table-fertilizers > tbody').append('<tr></tr>');
                    $.each(v, function(key, value){
                        if (sw){
                            $('#table-fertilizers > thead > tr').append("<th>" + key + "</th>");
                        }
                        $('#table-fertilizers > tbody > tr:last').append("<th>" + value + "</th>");
                    });
                    sw = false;
                });
            }
        });
    }
};

Fertilizers.init();