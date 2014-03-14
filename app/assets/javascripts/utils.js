var Utils = {
    set_token: function(){
        $.ajaxSetup({
            headers : {
                'Token' : document.getElementById('token').value
            }
        });
    }
};

Utils.set_token();