<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if(tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>日志</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script type="text/javascript">
 $(document).ready(function(){

	  $(".click").click(function(){
	  	$(".tip").fadeIn(200);
	  });
	  
	  $(".tiptop a").click(function(){
	  	$(".tip").fadeOut(200);
	  });
	
	  $(".sure").click(function(){
	  	$(".tip").fadeOut(100);
	  });
	
	  $(".cancel").click(function(){
	  	$(".tip").fadeOut(100);
		
	  });
	
	  
	  
	
	function access(obj){
		if(obj==2){
			window.location.href="access!getAll.action";
		}else if(obj==3){
			window.location.href="log!getAllLog.action?pageIndex=1";
		}else if(obj==5){
			window.location.href="user!addUser.action";
		}else if(obj==6){
			window.location.href="test!searchUsers1.action";
		}else if(obj==4){
		}
	}
	
	// 好看的select插件
	$(".select2").uedSelect({
			width : 150 
	});
	// 添加用户按钮
	$("#addClick").click(function(){
		// 清空表单数据，主键ID，因为添加操作，不可能有主键ID
		clearForm();
		$("#addTip").fadeIn(200);
	});
	// 修改按钮
	$("#updateClick").click(function(){
		  var chks = $(":checkbox[name='ids']:checked");
		
		  if(chks.size() != 1) {
			  $("#clickTip").html("请选中一条要修改的记录！");
			  $("#myTip").fadeIn(200);
		  } else {
			  // 开始异步请求获取数据
			
			  ajaxRoleById(chks.val());
		  }
	});
	// 删除按钮
	$("#deleteClick").click(function() {
		  // 获取用户选中的复选框
		  var chks = $(":checkbox[name='ids']:checked");
		  
		  if(chks.size() == 0) {
			   $("#clickTip").html("请选中要删除的角色！");
			   $("#myTip").fadeIn(200);
		  } else if(confirm("确定要删除选定的角色?")){
			  
				  var url = "/crm1501/role/roleAction!delete.action?";
				  $(chks).each(function(){
					  url += "id="+this.value+"&";
				  });
				  url = url.substring(1,url.length - 1);
				  // 发送请求到服务器
				  location = url;
			  }
			  else
			  {
			         return;
			  }	  
	});
	
	
	// 取消按钮
	$(".cancel,#cancel,.tiptop a").click(function(){
		$(".tip").fadeOut(100);
	});
	
	$("#fm").submit(function(){
		  // 如果主键ID不为空，则做修改操作
		  if($("#rid").val() != "") {
			  if(confirm("确定修改么？"))
			  {
				  this.action = "/crm1501/role/roleAction!update.action";
			  }
			  else
			  {
			          return;
			  }
			
		  } else {
			  
			  this.action = "/crm1501/role/roleAction!add.action";
		  }
		  return true;
	});

});


 function ajaxRoleById(id) {
	
		var url = "/crm1501/ajax/ajaxAction!findRoleById.action";
		var data = "id="+id;
		$.post(url,data,function(u){
			
			//var s = eval('('+u+')');
			$("#rid").val(u.role.rid);
			$("#rnamech").val(u.role.rnameCh);
			$("#rstate").val(u.role.rstate);
		
			$("#addTip").fadeIn(200);
		},"json");
}

 
	function clearForm() {
		$("#rid").val("");
		$("#rnamech").val("");
		$("#rstate").val("");
		
	}

	// ajax根据用户来查询log
	function queryLog() {
		location = "/crm1501/interceptor/systemLogAction.action?interceptor.uaccount=" + $("#uaccount_id").val();	
	}
</script>



	<style>
		.itab{height:36px; border-bottom:solid 1px #d0dee5; position:relative; border-left:solid 1px #d3dbde;}
		.itab ul li{float:left;height:37px; line-height:37px; background:url(../images/itabbg.png) repeat-x; border-right:solid 1px #d3dbde;}
		.itab ul li a{font-size:14px; color:#000; padding-left:25px; padding-right:25px;}
		.itab ul li a.selected{ height:37px; display:block; background:url(../images/itabbg1.png) repeat-x; font-weight:bold;}
		#uaccount_id {
			border:1px solid gray;
			height:33px;
		}
	</style>
</head>


<body>
	
	
	
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">系统管理</a></li>
    <li><a href="#">系统日志</a></li>

    </ul>
    </div>
    <!-- 头部模块 -->
	<div class="itab">
		<ul>
		   		<li><a href="/crm1501/user/userAction.action?subMenu=用户管理&subUrl=user/userAction.action" target="rightFrame">用户管理</a></li>
		   	
		   		<li><a href="/crm1501/interceptor/systemLogAction.action?subMenu=系统日志&subUrl=interceptor/systemLogAction.action" target="rightFrame">系统日志</a></li>
		   	
    	
    	
		</ul>
	</div>
    <div class="rightinfo">
   
    
    <table class="tablelist">
    	<thead>
    	<tr>
        <th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
        <th>用户</th>
        <th>事件</th>
        <th>时间</th>
        </tr>
        </thead>
        <tbody>
                <c:forEach items="${logs}" var="log">
		        <tr>  
			        <td >${log.id}</td>
			        <td id="uaccount1">${log.user.userName}</td>
			        <td id="events1">${log.event}</td>
			        <td id="createTime1">${log.logDate}</td>
		        </tr> 
		        </c:forEach>
		        
        </tbody>
    </table>
    
   
    <div class="pagin">
	    	<div class="message">共<i class="blue">${count}</i>条记录，当前显示第&nbsp;<i class="blue">${currentPage}&nbsp;</i>页</div>
	        <ul class="paginList">
		        <li class="paginItem"><a href="log?currentPage=${currentPage-1}"><span class="pagepre"></span></a></li>
		        
		        	<li class="paginItem"><a href="log">1</a></li>
		        
		        <li class="paginItem"><a href="log?currentPage=${currentPage+1}"><span class="pagenxt"></span></a></li>
		        <!-- <li class="paginItem more"><a href="javascript:;">...</a></li> -->
	        </ul>
    	</div>
    
     
  
    </div>
    
    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
