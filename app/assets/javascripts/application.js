// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui


     $(function () {
          
          $('div.show_description').expander({
                slicePoint: 600,
                expandText: 'Read More',
                userCollapseText: 'Hide'
            }); 


  $('#feedback').click(function() { 
      if($('#feedback').css("right") == '0px'){

        $('#feedbackForm').css("display","block");             
        $('#feedbackForm').stop().animate({
          right: '0px'
        }, 300);

    $('#feedback').stop().animate({
    right: '400px'
    }, 300);

  }

  else{

        $('#feedbackForm').stop().animate({
    right: '-400px'    
  }, 300,  function() {
    $('#feedbackForm').css("display","none");
  });

    $('#feedback').stop().animate({
    right: '0px'

  }, 300);

  }


});


  $('#sendFeedback').click(function() { 
         
  $('#feedbackForm').stop().animate({
    right: '-400px'    
  }, 300,  function() {
    $('#feedbackForm').css("display","none");
  });

    $('#feedback').stop().animate({
    right: '0px'

  }, 300);
});
        });
