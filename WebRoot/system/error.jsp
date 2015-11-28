<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <!-- 弹出完毕后，清除session的提示 -->
    <title>错误页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script language="javascript" type="text/javascript" src="/crm1501/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if(tip) {
		alert(tip);
	}
</script>
	<script language="javascript">
		$(function(){
		    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
			$(window).resize(function(){  
		    	$('.error').css({'position':'absolute','left':($(window).width()-490)/2});
		    })  
		});  
	</script> 

  </head>
  
  <body style="background:#edf6fa;">

		<div class="place">
		    <span>位置：</span>
		    <ul class="placeul">
			    <li><a href="#">首页</a></li>
			    <li><a href="#">404错误提示</a></li>
		    </ul>
	    </div>
	    
	    <div class="error">
	    	<h2>非常遗憾，您访问的页面不存在！</h2>
	    	<p>看到这个提示，就自认倒霉吧!</p>
	    	<div class="reindex"><a href="main.html" target="_parent">返回首页</a></div>
	    </div>

	</body>
</html>
