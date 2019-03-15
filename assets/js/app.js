// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(function () {
    // https://stackoverflow.com/a/10073788
    function pad(n, width, z) {
        z = z || '0';
        n = n + '';
        return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
    }


    // for deleting
    $(".timelog-deletebutton").click((ev) => {
        setTimeout(function(){
            window.location.reload();
        }, 200); 
    });
    
    // for creating
    $("#timelog-new").click((ev) => {
        let starttime = $("#timelog-new-timestart").val();
        let endtime = $("#timelog-new-timeend").val();
        let task_id = $("#timelog-new").data("task-id");

        let text = JSON.stringify({
            timelog: {
                timestart: starttime,
                timeend: endtime,
                task_id: task_id,
            },
        });

        $.ajax(timelog_path, {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                setTimeout(function(){
                    window.location.reload();
                }, 200); 
            }
        });
        setTimeout(function(){
            window.location.reload();
        }, 200); 
    });

    // for the work button
    let is_working = false;
    let starttime = null;
    $("#startwork").click((ev) => {
        if (is_working == false) {
            // log start time
            $("#startwork").text("Stop Working");
            $("#startwork").addClass("btn-success");
            $("#startwork").removeClass("btn-info");

            var currentdate = new Date(); 
            starttime = pad(currentdate.getUTCFullYear(), 4) + "-" +
                        pad(currentdate.getUTCDay(), 2) + "-" +
                        pad(currentdate.getUTCDate(), 2) + "T" +
                        pad(currentdate.getUTCHours(), 2) + ":" +
                        pad(currentdate.getUTCMinutes(), 2);
            is_working = true;
        } else {
            // log end time, post data, reset
            var enddate = new Date(); 
            let endtime = pad(enddate.getUTCFullYear(), 2) + "-" +
                          pad(enddate.getUTCDay(), 2) + "-" +
                          pad(enddate.getUTCDate(), 2) + "T" +
                          pad(enddate.getUTCHours(), 2) + ":" +
                          pad(enddate.getUTCMinutes(), 2);
            let task_id = $("#startwork").data("task-id");

            let text = JSON.stringify({
                timelog: {
                    timestart: starttime,
                    timeend: endtime,
                    task_id: task_id,
                },
            });

            $.ajax(timelog_path, {
                method: "post",
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                data: text,
                success: (resp) => {
                    setTimeout(function(){
                        window.location.reload();
                    }, 200); 
                }
            });
            setTimeout(function(){
                window.location.reload();
            }, 200); 
        }
    });
});