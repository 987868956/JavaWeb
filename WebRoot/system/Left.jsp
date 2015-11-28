<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/jquery.js"></script>

<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})	
</script>


</head>

   <body style="background:#f0f9fd;">
	 <div class="lefttop"><span></span>后台管理</div>
    
     <dl class="leftmenu">
     <c:forEach items="${parentMoudles}" var="m">  
    <dd>
    <div class="title">
    <span><img src="../images/leftico01.png" /></span>
    ${m.name}
    </div><ul class="menuson">
         <c:forEach  items="${m.sonMoudles}" var="son">
        <li class="active"><cite></cite><a href="${son.url}" target="rightFrame">
		<c:if test="${son.isson=='1'}">${son.name }</c:if>
        </a></li>
        </c:forEach>   
        </ul> 
    </dd>
    </c:forEach>
    </dl>
    
</body>
</html>
