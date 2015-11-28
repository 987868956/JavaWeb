<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>用户管理</title>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script type="text/javaScript" src="../js/json2.js"></script>
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
				ajaxUserById(chks.val());
					
				
			}
		});

		//删除按钮
		
		$("#deleteClick").click(function() {
		
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() == 0) {
				$("#click").html("请选择要删除的数据");
				$("#myTip").fadeIn(200);
			} else {
				var url = "/user!delUser?";
				alert("确定删除吗？");
				
				$(chks).each(function() {
				
					url += "ids=" + this.value + "&";
					
				});
				url = url.substring(1, url.length - 1);
				//alert("url是"+url);
				
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
			alert("确定修改数据吗?")
			var chks = $(":checkbox[name='ids']:checked");
			var url=1;
			$(chks).each(function() {
				
					url =this.value;
					
				});
				this.action = "/SeecenCRM/system/user!updataUser?userId="+url;
				//alert("updata")
			} else {
				this.action = "/SeecenCRM/system/user!addUser";
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
      
	function ajaxUserById(id) {
	      //alert(id);
				$.ajax({
					type:"POST",
					url:"user!getpageUserById",
					data:"userid="+id,
					success:function(msg){
						$("#tid").val("oym");
						var result = JSON.parse(msg);
						var user = result.user;
						alert("确定要修改的是"+user.userName+"吗？");	
						$("input[name='userName']").val(user.userName);
						$("input[name='pass']").val(user.pass);
						$("input[name='userTel']").val(user.userTel);
						$("input[name='qq']").val(user.qq);
						$("input[name='email']").val(user.email);
						$("input[name='name']").val(user.userName);
						$("select[name='roleId']").val(user.roleId);
						$("select[name='deptId']").val(user.deptId);
						$("select[name='centerId']").val(user.centerId);

						if("0"==user.sex){
							$("input[name='sex']").first().attr("checked","checked");
						}else{
							$("input[name='sex']").last().attr("checked","checked");
						}
						if("0"==user.status){
							$("input[name='status']").first().attr("checked","checked");
						}else{
							$("input[name='status']").last().attr("checked","checked");
						}
					//	$("#tresult").val(u.content);

			             $("#addTip").fadeIn(200); 
					}
				}); 
	}

	/*
	    $("#updateClick").click(function(){
				var id = this.value;
				
				$.ajax({
					type:"POST",
					url:"role!getPageRole",
					
					data:"id="+id,
					success:function(msg){
						var result = JSON.parse(msg);
						
						var role = result.roles;
						
						
						$("input[name='name']").val(role.name);
						if("0"==role.status){
							$("input[name='status']").first().attr("checked","checked");
						}else{
							$("input[name='status']").last().attr("checked","checked");
						}
						$("#tresult").val(u.content);

			             $("#addTip").fadeIn(200); 
					}
				}); 
			});
			*/
</script>
</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="/crm1501/null?subUrl=null"> 用户管理 </a></li>
			
		</ul>
	</div>

	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li id="addClick" class="click"><span><img
						src="..//images/t01.png" /></span>增加</li>
				<li id="updateClick" class="click"><span><img
						src="../images/t02.png" /></span>修改</li>
				<li id="deleteClick"><span><img
						src="../images/t03.png" /></span>删除</li>
				
			</ul>
		</div>
		
		<table class="tablelist">
		
		
			<thead>
	    	
	    	<tr>
        <th><input name="" type="checkbox" value="" checked="checked"/></th>
        <th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
        <th>账户名</th>
        <th>密码</th>
        <th>性别</th>
        <th>联系方式</th>
        <th>qq</th>
        <th>email</th>
        <th>是否可用</th>
         <th >角色</th>
         <th>所属部门</th>
         <th>所属中心</th>
        <th>操作</th>
        </tr>       
		    </thead>

					    <tbody>
        	<c:forEach items="${users}" var="u">
       		 <tr>
        	<td><input name="ids" type="checkbox" value="${u.id}" /></td>
        	<td>${u.id}</td>
        	<td>${u.userName}</td>
        	<td>${u.pass}</td>
        	<td>
        	${u.sex }
       		 </td>
        	<td>${u.userTel}</td>
        	<td>${u.qq}</td>
        	<td>${u.email}</td>
        	 <td>
			            	<c:if test="${u.status=='1' }">已启用</c:if>
			            	<c:if test="${u.status=='0' }">
			            		<span style="color:red">已禁用</span>
			            	</c:if>
			</td>
        	<td>${u.role.name}</td>
        	 <td>
        	${u.depts.deptname}
        	</td>
        	 <td>
       		 ${u.centers.cname}	
       		 </td>
        	 <td>
		      <ul class="toolbar2">
				<li class="updateBtn" value="${u.id }">
				<a class="tablelink" href="user!changeUserStatus?userId=${u.id }">禁用/</a>
				<a class="tablelink" href="user!changeUserStatus?userId=${u.id }">开启</a>
				
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

		<!-- 添加用户 -->
		<div id="addTip" class="tip addUser" style="width:530px; height:300px; ">
			<!-- 提示部分 -->
			<div class="tiptop">
				<span>用户信息</span><a></a>
			</div>
			<!-- 正文部分 -->
			<div id="addContent" class="formbody" >
				<form id="fm" action="" method="post">
					<input type="hidden" id="tid" value=""/>
				<table class="addTab" cellpadding="5">
					<tr>
			    		<td class="td_lable"><label class="asterisk"></label>用户名</td>
			    		<td><input name="userName" type="text" class="scinput" /></td>
			    		<td class="td_lable"><label class="asterisk"></label>密码</td>
			    		<td><input name="pass" type="text" class="scinput" /></td>
					</tr>
					<tr>
			    		
			    		<td class="td_lable">所在部门</td>
			    		<td>
			    			<select name="deptId" class="scinput">
								<option value="">请选择</option>
								<c:forEach items="${deparetments}" var="deparetments">
    					     <option value="${deparetments.deptid}">${deparetments.deptname}</option>
    					      </c:forEach>
							</select>
						</td>
			    		
			    		<td class="td_lable"><label class="asterisk"></label>性别</td>
			    		<td>
							<cite>
								<input name="sex" type="radio" value="男" checked="checked" />男&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="sex" type="radio" value="女" />女
							</cite>
						</td>
					</tr>
					<tr>
			    		<td class="td_lable">角色</td>
			    		<td>
			    			<select name="roleId" class="scinput">
								<option value="">请选择</option>
								<c:forEach items="${roles }" var="r">
									<option value="${r.id }">${r.name }</option>
								</c:forEach>
							</select>
			    		</td>
			    		<td class="td_lable">启用状态</td>
			    		<td>
							<cite>
								<input name="status" type="radio" value="1" checked="checked" />启用&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="status" type="radio" value="0" />禁用
							</cite>
						</td>
					</tr>
					<tr>
			    		<td class="td_lable">联系电话</td>
			    		<td><input name="userTel" type="text" class="scinput" /></td>
			    		<td class="td_lable">QQ</td>
			    		<td><input name="qq" type="text" class="scinput" /></td>
					</tr>
					<tr>
			    		<td class="td_lable">E-mail</td>
			    		<td><input name="email" type="text" class="scinput" /></td>
			    		<td class="td_lable">所在中心</td>
			    		<td>
			    			<select name="centerId" class="scinput">
								<option value="">请选择</option>
								<c:forEach items="${centres}" var="centres">
                              <option value="${centres.cid}">${centres.cname}</option>
                          
 					 </c:forEach>
							</select>
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