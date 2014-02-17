$(function() {
    // Validation
    $("#login-form").validate({
        rules : {
            email : {
                required : true,
                email : true
            },
            password : {
                required : true,
                minlength : 3,
                maxlength : 20
            }
        },
        messages : {
            email : {
                required : 'Introduzca su dirección de correo electrónico',
                email : 'Por favor, introduce una dirección de correo electrónico válida'
            },
        password : {
            required : 'Por favor, introduzca su contraseña'
            }
        },
        errorPlacement : function(error, element) {
            error.insertAfter(element.parent());
        }
    });
    $("#i-agree").click(function(){
        var $this = $("#terms");
        if($this.checked) {
            $('#myModal').modal('toggle');
        } else {
            $this.prop('checked', true);
            $('#myModal').modal('toggle');
        }
    });


});
