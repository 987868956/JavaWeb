/**
 * 元素移动效果
 * @param ele 所需要移动的元素的js对象
 * @return
 */
function eleMove_js(ele){
	$(ele).mousedown(function(e)//e鼠标事件 
	{ 
		$(this).css("cursor","move");//改变鼠标指针的形状 

		var offset = $(this).offset();//DIV在页面的位置 
		var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离 
		var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离 
		$(document).bind("mousemove",function(ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件 
		{ 
			$(ele).stop();//加上这个之后 

			var _x = ev.pageX - x;//获得X轴方向移动的值 
			var _y = ev.pageY - y;//获得Y轴方向移动的值 

			$(ele).animate({left:_x+"px",top:_y+"px"},10); 
		}); 

	}); 

	$(document).mouseup(function() 
	{ 
		$(ele).css("cursor","default"); 
		$(this).unbind("mousemove"); 
	}) 
}

/**
 * 元素移动效果
 * @param ele 所需要移动的元素的jquery对象
 * @return
 */
function eleMove_jquery(ele){
	ele.mousedown(function(e)//e鼠标事件 
	{ 
		$(this).css("cursor","move");//改变鼠标指针的形状 

		var offset = $(this).offset();//DIV在页面的位置 
		var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离 
		var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离 
		$(document).bind("mousemove",function(ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件 
		{ 
			ele.stop();//加上这个之后 

			var _x = ev.pageX - x;//获得X轴方向移动的值 
			var _y = ev.pageY - y;//获得Y轴方向移动的值 

			ele.animate({left:_x+"px",top:_y+"px"},10); 
		}); 

	}); 
	
	// 取消mousemove事件的绑定
	$(document).mouseup(function() 
	{ 
		ele.css("cursor","default"); 
		$(document).unbind("mousemove"); 
	}) 
}