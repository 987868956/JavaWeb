<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>角色管理</title>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if (tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//增加按钮
		$("#addClick").click(function() {
			//清空表单
			
			clearForm();
			$("#addTip").fadeIn(200);
		});

		//修改按钮
		$("#updateClick").click(function() {
			
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() != 1) {
				$("#click").html("请选择一条需要修改的数据");
				$("#myTip").fadeIn(200);
			} else {
				// 开始异步请求获取数据
			
				ajaxRoleById(chks.val());
					
				
			}
		});

		//删除按钮
		
		$("#deleteClick").click(function() {
		
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() == 0) {
				$("#click").html("请选择要删除的数据");
				$("#myTip").fadeIn(200);
			} else {
				var url = "/role!delRole?";
				$(chks).each(function() {
				
					url += "id=" + this.value + "&";
					//alert(url);
				});
				url = url.substring(1, url.length - 1);
				
				//alert(url);
				// 发送请求到服务器
				location = url;
				
			}
		});

		// 取消按钮
		$(".cancel,#cancel,.tiptop a").click(function() {
			$(".tip").fadeOut(100);
		});

		$("#fm").submit(function() {
			// 如果主键ID不为空，则做修改操作
			if ($("#tid").val() != "") {
			//alert("确定修改数据吗?")
			var chks = $(":checkbox[name='ids']:checked");
			var url = 1;
				$(chks).each(function() {
				
					url = this.value ;
					
				});
				//alert("updata");
				this.action = "/SeecenCRM/system/role!updataRole?id="+url;
				//alert("进入update");
			} else {
				this.action = "/SeecenCRM/system/role!add";
				alert("确定添加?")
			}
			return true;
		});

		$("#stuid").val("");
	});

	function clearForm() {
		$("#tid").val("");
		$("#sname>option:first").attr("selected", true);

		$("#tname>option:first").attr("selected", true);
		$("#ttime").val("");
		$("#ttime").click(function() {
			WdatePicker();
		});

		$("#tresult").val("");
	}
      
	function ajaxRoleById(id) {
	      //alert(id);
				$.ajax({
					type:"POST",
					url:"role!getPageRole",
					data:"cid="+id,
					success:function(msg){
						var result = JSON.parse(msg);
						var role = result.role;	
						$("input[name='name']").val(role.name);
						if("0"==role.status){
							$("input[name='status']").first().attr("checked","checked");
						}else{
							$("input[name='status']").last().attr("checked","checked");
						}
						//$("#tresult").val(u.content);
						$("#tid").val("oym");

			             $("#addTip").fadeIn(200); 
					}
				}); 
	
	}

	
</script>
</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="/crm1501/null?subUrl=null"> 角色管理 </a></li>
			
		</ul>
	</div>

	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li id="addClick" class="click"><span><img
						src="../images/t01.png" /></span>增加</li>
				<li id="updateClick" class="click"><span><img
						src="../images/t02.png" /></span>修改</li>
				<li id="deleteClick"><span><img
						src="../images/t03.png" /></span>删除</li>
				<li><span><img src="../images/t01.png" /></span><a href="/SeecenCRM/system/auth">授权</a></li>
			</ul>
		</div>
		
		<table class="tablelist">
			<thead>
				<tr>
					<th></th>
					<th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
					<th>角色名称</th>
					<th>角色状态</th>
					<th>角色操作</th>
					
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${roles}" var="roles">
				<tr>
					<td><input name="ids" type="checkbox" value="${roles.id}"/></td>
					<td>${roles.id}</td>
					<td>${roles.name}</td>
					<td>
			            <c:if test="${roles.status=='0' }"><span style="color:red">已禁用</span></c:if>
			             <c:if test="${roles.status=='1' }">已启用</c:if>		
			            	
					</td>
					<td>
					 <ul class="toolbar2">
				    <li class="updateBtn" value="${u.id }">
				    <a class="tablelink" href="role!changeRoleStatus?id=${roles.id}">禁用/</a>
				    <a class="tablelink" href="role!changeRoleStatus?id=${roles.id}">开启</a>
				    </li>
			       </ul>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>


		<div class="pagin">
			<div class="message">
				共<i class="blue">${count}</i>条记录，当前显示第&nbsp;<i class="blue">${currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<li class="paginItem"><a
					href="/crm1501/talk/talkAction.action?pageResults.currentPage=0"><span
						class="pagepre"></span></a></li>

				<li class="paginItem"><a
					href="/crm1501/talk/talkAction.action?pageResults.currentPage=1">1</a></li>

				<li class="paginItem"><a
					href="/crm1501/talk/talkAction.action?pageResults.currentPage=1"><span
						class="pagenxt"></span></a></li>
				<!-- <li class="paginItem more"><a href="javascript:;">...</a></li> -->
			</ul>
		</div>

		<div class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>
			<div class="tipinfo">
				<span><img src="../images/ticon.png" /></span>
				<div class="tipright">
					<p>是否确认对信息的修改 ？</p>
					<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
				</div>
			</div>
			<div class="tipbtn">
				<input name="" type="button" class="sure" value="确定" />&nbsp; <input
					name="" type="button" class="cancel" value="取消" />
			</div>
		</div>

		<div id="myTip" class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>
			<div class="tipinfo">
				<span><img src="../images/ticon.png" /></span>
				<div id="click" class="tipright"></div>
			</div>
			<div class="tipbtn">
				<input id="cancel" name="" type="button" class="sure" value="确定" />
			</div>
		</div>

		<!-- 添加角色 -->
		<div id="addTip" class="tip addUser">
			<!-- 提示部分 -->
			<div class="tiptop">
				<span>角色信息</span><a></a>
			</div>
			<!-- 正文部分 -->
			<div id="addContent" class="formbody">
				<form id="fm" action="" method="post">
				
				<input type="hidden" id="tid" value=""/>
				
					<table class="addTab" cellpadding="5">
						<tr>
						<td>
							<ul class="forminfo" style="margin-top:30px;">
				  		 <li><label>角色名称：</label><input name="name" type="text" class="dfinput" /></li>
				    		<li><label>启用状态：</label>
				    		<cite>
				    		<input name="status" type="radio" value="1" checked="checked" />启用&nbsp;&nbsp;&nbsp;&nbsp;
				    		<input name="status" type="radio" value="0" />禁用
				    		</cite>
							</li>
							</ul>
						</td>
						</tr>
						
						<tr>
							<td>						
                        	
		      				</td>
		      			</tr>
		      			
		      			<tr>
							<td align="center" colspan="6"><input name="" type="submit"
								class="btn" value="确认保存" /> <input name="" type="button"
								class="cancel" value="取消" /></td>
						</tr>
		      				
							
				 
						
					</table>
				</form>
			</div>
		</div>
		
		
		
		
		
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>