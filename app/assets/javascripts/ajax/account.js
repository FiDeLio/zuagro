"use strict";
//= require ../utils
var Account = {
    init: function(){
        var _this = this;
        _this._bind_save_profile();
    },
    _bind_save_profile: function(){
        $('#btn-save-profile').bind('click', function(){
            var url = '/api/v1/profiles/' + sessionStorage.id;
            var params = {
                name: $('#name').val(),
                password: $('#password').val(),
                reppassword: $('#reppassword').val()
            };
            $.ajax({
                url: url,
                type: 'PUT',
                data: params,
                complete: function(json) {
                    if(json.status == 200){
                        console.log('pase');
                        $('#show-shortcut').text($('#name').val());
                        $('#show-shortcut').append('<i class="fa fa-angle-down"></i>');
                    }
                }
            });
        });
    }
};