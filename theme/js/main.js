$(document).ready(function(){
  $(".maleform").hide();
  $(".femaleform").hide();
  $("#resnav").hide();
  $("#register").hide();
  $(".lselector").hide();
  $(".search").hide();
  $(".upimgOpen").hide();
  $(".upInfoOpen").hide();
  $(".editInfo").hide();



  $(".editInfoBtn").click(function(){
    $(".editInfo").slideToggle('slow');
  });
  $(".usrInfo").click(function(){
    $(".upInfoOpen").slideToggle('slow');
  });
  $(".upimg").click(function(){
    $(".upimgOpen").slideToggle('slow');
  });
  $(".menu").click(function(){
      $( "#resnav" ).slideToggle('slow');
  });
  $(".warnda").click(function(){
      $( "#register" ).slideToggle('slow');
      $( "#warn" ).slideToggle('slow');
  });
  $('.malsearch').click(function(){
      $(".maleform").slideToggle('fast');
      $(".femaleform").hide();

  });

  $('.femsearch').click(function(){
    $(".femaleform").slideToggle('fast');
    $(".maleform").hide();

  });

  $('.back').click(function(){
    $(".maleform").hide();
    $(".femaleform").hide();
  });
     
  function showsearch(){
    $(".search").slideToggle('slow');
  }
  $('.mainselector').on('change', function() {
    if ( this.value == '1')
    {
      $(".lselector").show();
    }
    else
    {
      $(".lselector").hide();
    }
  });


  function last_seen() {
    $.ajax({
      type: "POST",
      url: "message_func",
      data: {last_seen: 'last_seen'}
    });
  }

  last_seen();
  setInterval(last_seen, 10000);

});



