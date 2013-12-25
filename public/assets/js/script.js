$(function(){

    $('.alert').delay(3000).hide('3000');

    $('div.file-row').addClass('file-row-hidden');

   var file_field = $('div.attachments div.file-row').eq(0);

   file_field.removeClass('file-row-hidden');
   file_field.find('div.remove').hide();

   $('div.attach').click(function(){
       $(this).parent().find('div.file-row:visible').last().next().removeClass('file-row-hidden');
    });

    $('div.remove').click(function(){
        $(this).parent().addClass('file-row-hidden');
    });

    var time_zone = getTimeZone();

    if(!isCookieSet()){
        setCookie("bz_time_zone",time_zone,1);
    }

});


function getTimeZone(){
    var tz = jstz.determine();
    return tz.name();
}

function setCookie(cname,cvalue,exdays)
{
    var d = new Date();
    d.setTime(d.getTime()+(exdays*24*60*60*1000));
    var expires = "expires="+d.toGMTString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname)
{
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++)
    {
        var c = ca[i].trim();
        if (c.indexOf(name)==0) return c.substring(name.length,c.length);
    }
    return "";
}

function isCookieSet()
{
    var username=getCookie("username");
    if (username!="")
    {
        return true
    }
    else
    {
        return false;
    }
}