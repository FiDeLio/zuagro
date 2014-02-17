var Account = {
    init: function(){
        var _this = this;
        _this._bind_tab();
        _this._bind_save_profile();
    },
    _bind_tab: function(){
        $('#tab-account > li').bind('click', function(){
            var $this = $(this);
            $('#tab-account > li').removeClass('active');
            $this.addClass('active');
        });
    },
    _bind_save_profile: function(){
        var _this = this;
        $('#btn-save-profile').bind('click', function(){
            var url = '/api/v1/profile';
            $.post(url).done(function(json){
                console.log(json);
            });
        });
    }
};