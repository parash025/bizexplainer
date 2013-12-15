$(function(){

    $('.alert').delay(4000).hide('3000');

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

});