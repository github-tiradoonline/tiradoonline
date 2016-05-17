<script type="text/javascript">
$(document).ready(
	function () 
	{
		function sticky() 
		{
	    	//var y = $(window).scrollTop();
    	  	//if( y > (60) )
			//{
    	     	$('#Menu').css({'position': 'fixed', 'top': '0', 'left': $navwidth});
	      	//} 
			//else 
			//{
    	     // $('#Menu').removeAttr('style');
	      	//}
    	 }

		/*
		$( document ).tooltip
		(
			{
				position: 
				{
					my: "center bottom-20",
					//at: "center top",
					at: "center bottom-20",
					using: function( position, feedback ) 
					{
						$( this ).css( position );
						$( "<div>" )
						.addClass( "arrow" )
						.addClass( feedback.vertical )
						.addClass( feedback.horizontal )
						.appendTo( this );
					}
				}
			}
		);
	 	*/
		
		$(document).on('beforeunload', 
			function(evt) {
				console.log('test');
				//$('#divModal').show();
	    	}
		);
		
		$("input, select, textarea").css('opacity', '.75');

		$('div').hover(
			function()
			{
				var $navID = $(this).attr('id')
				if($navID != null)
					$navID = $navID.substring(0,4);
					
				if($navID == 'nav_' || $(this).attr('class') == 'BankingSubElement')
				{
					$(this).css('opacity', '1');
					$(this).css('border-color', '#ff0000');
				}
			},
			function()
			{
				var $navID = $(this).attr('id')
				if($navID != null)
					$navID = $navID.substring(0,4);

				if($navID == 'nav_' || $(this).attr('class') == 'BankingSubElement')
				{
					$(this).css('opacity', '0.5');
					$(this).css('border-color', '#000000');
				}
			}
		);
		
		$('a').click
		(
			function()
			{
				if( ($(this).attr('href').indexOf('#tabs') == -1) && $(this).attr('target') != '_blank')
				{
					$('#divModal').show();
				}
			}
		);

        $('#LoginBoxSite').fadeIn(2000);

        $(':submit, :button').hover(
			function() 
			{
				$(this).removeClass().addClass("Button_HOVER");
			},
			function() 
			{
				$(this).removeClass("Button_HOVER").addClass('Button');
			}
		);
		
		$("input, select, textarea").focus(
			function() {

				if($(this).attr('type') == 'text' || $(this).attr('type') == 'textarea')
				{
					$(this).css('opacity', '1');
					$(this).addClass('textFocus');
				}
				else if($(this).attr('type') == 'button' || $(this).attr('type') == 'submit')
				{
					$(this).removeClass().addClass('Button_HOVER');
				}
			}
		);

		$("input:text, select, textarea").blur(
			function() {

				$(this).css('opacity', '.75');
					if($(this).next().attr('class') == 'ErrorMessage')
					{
					//alert('blur');
						$(this).next().fadeOut(1000);
						//$(this).removeClass("AdministrationElement");
					}
						$newclass = "<%= pageTheme %>";
						$newclass = $newclass.replace('Theme', 'Element');
						$(this).removeClass('textFocus').addClass($newclass);
			}
		);

        $('.icon').hover(
			function() 
			{
				var $imagefile = $(this).attr('src').replace('_off', '_on');
				$(this).attr('src', $imagefile)
			},
			function() 
			{
				var $imagefile = $(this).attr('src').replace('_on', '_off');
				$(this).attr('src', $imagefile)
			}
		);

		$('#NavigationTable TR').mouseenter(
			function() 
			{
				$("#" + $(this).attr("id")).addClass("NavigationHover");
				//alert($($(this).attr("class")).css("opacity"));
				
			}
		);
		
		$('.GridViewRow').mouseenter (
			function() {
				if($(this).css("color") != "#ffffff")
					$(this).addClass("GridViewRowHover");
			}
		);
		
		$('.GridViewRow').mouseleave (
			function() {	
				if($(this).css("color") != "#ffffff")
					$(this).removeClass("GridViewRowHover");
			}
		);
		
		/************************/		
		/*  TEXTAREA RESIZES */
		/************************/
		// changeTextAreaHeight IS IN /INCLUDES/GLOBALS.CSS
		
		$('#Snippet, #sqlStatement, #ObjectText, #CreateAccountEmail, #ForgotPasswordEmail, #MedicineDescription, #JobCoverLetterText').focus(
			function () {
				thisWidth = parseInt($(this).css('width').replace('px', ''))
				thisWidth += <%= changeTextAreaWidth %>;
				thisWidth = thisWidth.toString() + 'px';

				thisHeight = parseInt($(this).css('height').replace('px', ''))
				thisHeight += <%= changeTextAreaHeight %>;
				thisHeight = thisHeight.toString() + 'px';

				$(this).animate({width: thisWidth, height: thisHeight});
			}
		);
		
		$('#Snippet, #sqlStatement, #ObjectText, #CreateAccountEmail, #ForgotPasswordEmail, #MedicineDescription, #JobCoverLetterText').blur(
			function () {
				thisWidth = parseInt($(this).css('width').replace('px', ''))
				thisWidth -= <%= changeTextAreaWidth %>;
				thisWidth = thisWidth.toString() + 'px';

				thisHeight = parseInt($(this).css('height').replace('px', ''))
				thisHeight -= <%= changeTextAreaHeight %>;
				thisHeight = thisHeight.toString() + 'px';

				$(this).animate({width: thisWidth, height: thisHeight});
			}
		);

    });

</script>

