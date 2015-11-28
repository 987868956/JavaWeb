<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title></title>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if(tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->




  <head>
    
    <title>无标题文档</title>
	<script type="text/javascript">
		$(function(){	
			//顶部导航切换
			$(".nav li a").click(function(){
				$(".nav li a.selected").removeClass("selected")
				$(this).addClass("selected");
			})	
		})	
	</script>

  </head>
  <body style="background:url(../images/topbg.gif) repeat-x;">

	<div class="topleft">
		
		    <a href="/crm1501/pages/main.html" target="_parent"><img src="../images/logo.png"
			title="系统首页" /> </a>
		
    		
	</div>

	<ul class="nav">
		<li><a href="../market/index" target="rightFrame" class="selected"><img style="width:45px; height:45px;" src="../images/ico01.png" title="首页" />
				<p style="color:white;">
					首页
				</p></a>
		</li>
		
		
		
		
		
	</ul>
	<div class="topright">
		<ul>
			<li>
				<a href="/crm1501/login/loginAction!changeCn.action" target="_parent" class="selected">
					<h2>切换中文</h2>
				</a>
			</li>
    		<li>
    			<a href="/crm1501/login/loginAction!changeEn.action" target="_parent">
    				<h2>English</h2>
    			</a>
    		</li>
			<li><a href="login!exit" target="_parent">退出</a>
			</li>
		</ul>

		<div class="user">
			<span>${user.userName}</span>
		</div>

	</div>
</body>

</html>
