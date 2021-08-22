$(() => {
    $("#watch").hide()

    window.addEventListener("message", function (event) {
        if (event.data.watch != undefined) {
            let status = event.data.watch
            if (status) {
                $("#watch").show(100)
                $(".time").show(100)
                //
                $("#passaport").hide();
                $("#music").hide();
                $("#gps").hide();
                $("#settings").hide();
            } else {
                $("#watch").hide(100)
                $("#content").hide();
                $(".time").hide()
            }
        }

        /* TIME */
        $(".time").html(+event.data.hour + "<p>" + event.data.minute);

        /* TITLE */
        $(".timev2").html(+event.data.hour + ":" + event.data.minute);

        /* ACTIVITY */
        $("#life").html("");
        var life = new ProgressBar.Circle('#life', {
            strokeWidth: 8,
            easing: 'easeInOut',
            duration: 1400,
            color: '#FD08AB',
            trailColor: '#340914',
            trailWidth: 1,
            svgStyle: null
        });
        life.animate(event.data.life / 100);

        $("#hunger").html("");
        var hunger = new ProgressBar.Circle('#hunger', {
            strokeWidth: 8,
            easing: 'easeInOut',
            duration: 1400,
            color: '#9BFF04',
            trailColor: '#2C4204',
            trailWidth: 1,
            svgStyle: null
        });
        hunger.animate(event.data.hunger);


        $("#thirst").html("");
        var thirst = new ProgressBar.Circle('#thirst', {
            strokeWidth: 8,
            easing: 'easeInOut',
            duration: 1400,
            color: '#1AD5DE',
            trailColor: '#133D3C',
            trailWidth: 1,
            svgStyle: null
        });
        thirst.animate(event.data.thirst);

        /* PASSAPORT */
        $("#li1").html("<i class='fas fa-user'></i> " + event.data.name + " " + event.data.firsname + "</li>");
        $("#li2").html("<i class='fas fa-id-card-alt'></i> ID: " + event.data.user_id + "</li>");
        $("#li3").html("<i class='far fa-id-card'></i> " + event.data.registration + "</li>");
        $("#li4").html("<i class='fas fa-briefcase'></i> " + event.data.job + "</li>");
        $("#li5").html("<i class='fas fa-car'></i> " + event.data.cnh + "</li>");
        $("#li6").html("<i class='fas fa-mobile-alt'></i> " + event.data.phone + "</li>");

        /* MUSIC */
    })
})

function time() {
    $(".time").hide()
    $("#content").show()
    $("#activity").show()
}

function activity() {
    $("#passaport").hide()
    $("#music").hide()
    $("#gps").hide()
    $("#settings").hide()
    //
    $("#activity").show()
}

function passaport() {
    $("#activity").hide()
    $("#music").hide()
    $("#gps").hide()
    $("#settings").hide()
    //
    $("#passaport").show()
}

function music() {
    $("#activity").hide()
    $("#passaport").hide()
    $("#gps").hide()
    $("#settings").hide()
    //
    $("#music").show()
}

function player() {
    $.post('https://GENESEEWatch/action', JSON.stringify({
        action: 'play'
    }));
}

function pause() {
    $.post('https://GENESEEWatch/action', JSON.stringify({
        action: 'pause'
    }));
}

function less() {
    $.post('https://GENESEEWatch/action', JSON.stringify({
        action: 'volume-'
    }));
}

function plus() {
    $.post('https://GENESEEWatch/action', JSON.stringify({
        action: 'volume+'
    }));
}

function timeplay() {
    $.post('https://GENESEEWatch/action', JSON.stringify({
        action: 'timeplay'
    }));
}



function gps() {
    $("#activity").hide()
    $("#passaport").hide()
    $("#music").hide()
    $("#settings").hide()
    //
    $("#gps").show()
}

function settings() {
    $("#activity").hide()
    $("#passaport").hide()
    $("#music").hide()
    $("#gps").hide()
    //
    $("#settings").show()
}

function changecase() {

    $("#watch").css("width", "195px")
    $("#watch").css("height", "303px")
    $("#watch").css("right", "5vh")
    $("#watch").css("bottom", "5vh")
    $("#watch").css("background", "url(img/watch_red.png)")
    $("#watch").css("background-size", "cover")
    $("#watch").css("z-index", "1000")

    //

    $(".menu").css("background", "linear-gradient(180deg, #2c0b0b 0%, rgba(49, 49, 49, 0.1) 83.33%, rgba(49, 49, 49, 0) 100%)")

    //
    
    $(".passaport").css("background", "linear-gradient(180deg, #2c0b0b 0%, rgba(49, 49, 49, 0.1) 83.33%, rgba(49, 49, 49, 0) 100%)")
    $(".navplayer").css("background", "linear-gradient(180deg, #2c0b0b 0%, rgba(49, 49, 49, 0.1) 83.33%, rgba(49, 49, 49, 0) 100%)")
}