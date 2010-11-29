$(".show_hide_body").click(function() {
  if ($(this).hasClass("hide_body")) {
    $(this).addClass("show_body");
    $(this).removeClass("hide_body");
    $(this).parent().find("#body").show();
  }
  else {
    $(this).addClass("hide_body");
    $(this).removeClass("show_body");
    $(this).parent().find("#body").hide();
  }
  return false;
});