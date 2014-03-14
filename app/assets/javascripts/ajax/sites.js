//= require ../utils
var Sites = {
    map: null,
    google: null,
    canvas: null,
    interval: [],
    flight_path: [],
    flight_plan_coordinates: [],
    json_coo: {},
    init: function(){
        var _this = this;
        _this.google = google;
        _this.canvas = document.getElementById('map-canvas');
        $("#btn-line").button("toggle");
        _this.set_sites();
        _this.google.maps.event.addDomListener(window, 'load', _this.initialize());
        _this.bind_radio();
        _this.bind_accuracy();
        _this.bind_update();
    },
    bind_update: function(){
        var _this = this;
        $('#btn-update').bind('click', function(){
            var url = '/api/v1/sites/' + $('#object').val();
            var params = {
                "comments": $('#sites-comments').val(),
                "accuracy": $('#sites-accuracy').val(),
                "name": $('#sites-name').val()
            };
            $.ajax({
                url: url,
                type: 'PUT',
                data: params,
                complete: function(response) {
                    if(response.status == 200){
                        $('#alert-success').text('registro actualizado.');
                        $('#alert-success').parent().show();
                        setTimeout(function(){
                            $('#alert-success').parent().fadeOut();
                        },3000);
                    }else{
                        $('#alert-danger').text('en estos momentos no es posible actualizar el registro.');
                        $('#alert-danger').parent().show();
                        setTimeout(function(){
                            $('#alert-danger').parent().fadeOut();
                        },3000);
                    }
                }
            });
        });
    },
    bind_accuracy: function(){
        var _this = this;
        $('#sites-accuracy').bind('change', function(){
            _this.stop_animate();
            _this.reset_polyline();
            if ($('input[name=options]:checked').attr('id') == "1"){
                _this.poly_lines(_this.json_coo);
            }else{
                _this.polygon(_this.json_coo);
            }
        });
    },
    bind_radio: function(){
        var _this = this;
        $('input[name=options]').parent().bind('click', function(){
            _this.stop_animate();
            _this.reset_polyline();
            if ($('input[name=options]:checked').attr('id') == "1"){
                _this.polygon(_this.json_coo);
            }else{
                _this.poly_lines(_this.json_coo);
            }
        });
    },
    initialize: function(){
        var _this = this;
        var map_options = {
            zoom: 3,
            center: new _this.google.maps.LatLng(-23, -25)
        };
        _this.map = new _this.google.maps.Map(_this.canvas, map_options);
    },
    set_sites: function(){
        var _this = this;
        var url = '/api/v1/sites/list';
        var $sites = $('#sel-predios');
        $sites.empty().append('<option>- Seleccione -</option>');
        $.getJSON(url).complete(function(response){
            if(response.status == 200){
                var json = response.responseJSON;
                var sites = json.list;
                for(var i=0; i < sites.length; i++){
                    $('#table-sites > tbody').append('<tr data-object="'+ sites[i].id +'"  data-comments="'+ sites[i].comments +'"></tr>');
                    $('#table-sites > tbody > tr:last').append('<td>'+ sites[i].name +'</td> <td>'+ sites[i].created_at +'</td> <td class="text-center"><i class="fa fa-map-marker"></i></td><td class="text-center"><i class="fa fa-times"></i></td>');
                }
                _this.bind_sites();
                _this.bind_delete();
            }
        });
    },
    bind_delete: function(){
        var _this = this;
        var $delete = $('#table-sites > tbody > tr > td > .fa.fa-times');
        $delete.bind('click', function(){
            var $this = $(this);
            var object = $this.parents('tr').data('object');
            var url = '/api/v1/sites/' + object;
            $.SmartMessageBox({
                title : "<i class='fa fa-times txt-color-red'></i> ¿ Desea eliminar este registro ?",
                content : "Nombre: <span class='txt-color-orangeDark'><strong>" + $this.parents('tr').children('td').first().text() + "</strong></span>",
                buttons : '[No][Si]'
            }, function(ButtonPressed) {
                if (ButtonPressed == "Si") {
                    $.ajax({
                        url: url,
                        type: 'DELETE',
                        complete: function(response) {
                            if(response.status == 200){
                                $('#alert-success').text('registro eliminado.');
                                $('#alert-success').parent().show();
                                setTimeout(function(){
                                    $('#alert-success').parent().fadeOut();
                                },3000);
                                $this.parents('tr').remove();
                            }else{
                                $('#alert-danger').text('en estos momentos no es posible eliminar el registro.');
                                $('#alert-danger').parent().show();
                                setTimeout(function(){
                                    $('#alert-danger').parent().fadeOut();
                                },3000);
                            }
                        }
                    });
                }

            });
        });
    },
    bind_sites: function(){
        var _this = this;
        var $show = $('#table-sites > tbody > tr > td > .fa.fa-map-marker');
        $show.bind('click', function(e){
            var $this = $(this);
            var object = $this.parents('tr').data('object');
            var comments = $this.parents('tr').data('comments');
            var url = '/api/v1/sites/coordenates?site_id=' + object; //+ '&accuracy=' + $('#sites-accuracy').val();
            var d = new Date($this.parents('tr').children('td').next().first().text());
            var curr_date = d.getDate();
            var curr_month = d.getMonth() + 1; //Months are zero based
            var curr_year = d.getFullYear();
            var curr_hour = d.getHours();
            var curr_minutes = d.getMinutes();
            $('#object').val(object);
            $('#lbl-sites-date').text(curr_date + "-" + curr_month + "-" + curr_year + " " + curr_hour + ":" + curr_minutes);
            $('#sites-name').val($this.parents('tr').children('td').first().text());
            $('#sites-comments').val(comments);
            _this.stop_animate();
            _this.reset_polyline();
            $.getJSON(url).complete(function(response){
                if(response.status == 200){
                    var json = response.responseJSON;
                    _this.json_coo = json.list;
                    if ($('input[name=options]:checked').attr('id') == "1"){
                        _this.poly_lines(json.list);
                    }else{
                        _this.polygon(json.list);
                    }
                }
            });
        });
    },
    polygon: function(coordinates){
        var _this = this;
        _this.flight_path = [];
        _this.flight_plan_coordinates = [];
        $.each(coordinates, function(k, v){
            if (v.accuracy <= parseInt($('#sites-accuracy').val())){
                _this.flight_plan_coordinates.push(new _this.google.maps.LatLng(parseFloat(v.lat), parseFloat(v.lng)));
            }
        });
        _this.flight_path.push(new _this.google.maps.Polygon({
            path: _this.flight_plan_coordinates,
            geodesic: true,
            strokeColor: '#5a73ea',
            strokeOpacity: 1.0,
            strokeWeight: 4,
            map: _this.map
        }));
        _this.fit_to_markers(_this.flight_plan_coordinates);
    },
    poly_lines: function(coordinates){
        var _this = this;
        _this.flight_path = [];
        _this.flight_plan_coordinates = [];
        var line_symbol = {
            path: _this.google.maps.SymbolPath.CIRCLE,
            scale: 2,
            strokeColor: 'red',
            fillColor: 'red',
            fillOpacity: 1
        };
        $.each(coordinates, function(k, v){
            if (v.accuracy <= parseInt($('#sites-accuracy').val())){
                _this.flight_plan_coordinates.push(new _this.google.maps.LatLng(parseFloat(v.lat), parseFloat(v.lng)));
            }
        });
        _this.flight_path.push(new _this.google.maps.Polyline({
            path: _this.flight_plan_coordinates,
            geodesic: true,
            strokeColor: '#5a73ea',
            strokeOpacity: 1.0,
            strokeWeight: 4,
            icons: [{
                icon: line_symbol,
                offset: '100%'
            }],
            map: _this.map
        }));
        _this.fit_to_markers(_this.flight_plan_coordinates);
        _this.animate_circle(_this.flight_path[_this.flight_path.length-1]);
    },
    animate_circle: function(line) {
        var count = 0;
        var _this = this;
        _this.interval.push(window.setInterval(function() {
            count = (count + 1) % 200;
            var icons = line.get('icons');
            icons[0].offset = (count / 2) + '%';
            line.set('icons', icons);
        }, 200));
    },
    fit_to_markers: function(markers){
        var _this = this;
        if(markers.length>0){
            var bounds = new _this.google.maps.LatLngBounds();
            for( var index in markers ) {
                var latlng = markers[index];
                bounds.extend(latlng);
            }
            if (bounds.getNorthEast().equals(bounds.getSouthWest())) {
                var extendPoint1 = new google.maps.LatLng(bounds.getNorthEast().lat() + 0.01, bounds.getNorthEast().lng() + 0.01);
                var extendPoint2 = new google.maps.LatLng(bounds.getNorthEast().lat() - 0.01, bounds.getNorthEast().lng() - 0.01);
                bounds.extend(extendPoint1);
                bounds.extend(extendPoint2);
            }
            _this.map.fitBounds(bounds);
        }
    },
    stop_animate: function(){
        var _this = this;
        for(var k = 0; k < _this.interval.length; k++){
            clearInterval(_this.interval[k]);
        }
    },
    reset_polyline: function(){
        var _this = this;
        for (var i = 0; i < _this.flight_path.length; i++ ) {
            _this.flight_path[i].setMap(null);
        }
        _this.flight_path.length = 0;
        _this.flight_path = [];
    },
};

Sites.init();
