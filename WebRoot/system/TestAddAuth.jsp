<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>权限管理</title>

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


<script type="text/javascript">
	$(document).ready(function() {
		//增加按钮
		$("#addClick").click(function() {
			//清空表单
			
			clearForm();
			$("#addTip").fadeIn(200);
		});


     // 添加模块时，下拉框显示
			$("input[name='isson']").change(function(){
				if($("input[name='isson']:checked").val()==0){
					$("#parentModuleLi").css("display","none");
				}else{
					$("#parentModuleLi").css("display","block");
				}
			});



		//修改按钮
		$("#updateClick").click(function() {
			
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() != 1) {
				$("#click").html("请选择一条需要修改的数据");
				$("#myTip").fadeIn(200);
			} else {
				// 开始异步请求获取数据
			
				ajaxAuth(chks.val());
					
				
			}
		});

		//删除按钮
		
		$("#deleteClick").click(function() {
		if(confirm("确定要删除吗")) {
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() == 0) {
				$("#click").html("请选择要删除的数据");
				$("#myTip").fadeIn(200);
			} else {
				var url = "/moudle!DelMoudle?";
				$(chks).each(function() {
				
					url += "id=" + this.value + "&";
					//alert(url);
					
				});
				url = url.substring(1, url.length - 1);
				// 发送请求到服务器
				location = url;
		}
			
				//alert(${moudle.name}+"这是一个父模块");
			}
		});

		// 取消按钮
		$(".cancel,#cancel,.tiptop a").click(function() {
			$(".tip").fadeOut(100);
		});

		$("#fm").submit(function() {
			// 如果主键ID不为空，则做修改操作
			alert($("#tid").val() )
			if ($("#tid").val() != "") {
			  alert("确定修改数据吗?")
				this.action = "/SeecenCRM/system/auth!UpdataRoleAuth";
				alert("updata")
			} else {
				this.action = "/SeecenCRM/system/auth!AddRoleAuth";
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
      
	function ajaxAuth(id){
	      alert("需要查看/修改的ID是"+id);
				$.ajax({
			type:"POST",
			url:"auth!getRole",
			data:"rolesId="+id,
			success:function(msg){
				var result = JSON.parse(msg);
				 var role=result.role;
				var moudle = result.moudle;	
				$("input[name='name']").val(role.name);
				$("#tid").val(1) 
				for ( var i = 0; i < moudle.length; i++) {
				 //alert(moudle.name);
				$(":checkbox[name='moudlesId']:checkbox[value='"+moudle[i].id+"']").attr("checked",true);	
			       }
			     $("#addTip1").fadeIn(200); 
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
        <li id="addClick" ><span><img src="../images/t01.png" /></span>添加授权</li>
        <li id="updateClick" ><span><img src="../images/t02.png" /></span>查看/修改授权</li>
        
        </ul>
    </div>
		<table class="tablelist">
			<thead>
    			<tr>
       			 <th><input name="" type="checkbox" value="" checked=""/></th>
       			 <th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
				 <th>角色名称</th>
				 <th>角色状态</th>
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
					
					
				</tr>
				</c:forEach>
			</tbody>
		</table>


		

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

		<!-- 添加模块 -->
		<div id="addTip" class="tip addUser" style="width:530px; height:400px;">
			<!-- 提示部分 -->
			<div class="tiptop">
				<span>授权操作</span><a></a>
			</div>
			<!-- 正文部分 -->
			<div id="addContent" class="formbody">
					<form  id="fm" action="" method="post">
					
				<input type="hidden" id="tid" value=""/>
		    <table class="addTab" cellpadding="5">
		    	<tr>
		    		<td class="td_lable" width="70" ><b>角色名称</b></td>
		    		<td>
		    		     <select name="roles" class="dfinput" id="roleChangeClick" >
				    		<c:forEach items="${roles}" var="r">
				    		
				    			<option value="${r.id }">${r.name} </option>
				    		
				    		</c:forEach>
				    	</select>
				    	</td>
		    	</tr>
		    	<!-- 查询所有角色 模块遍历...................................................-->
				<tr>
					<td colspan="6"> 
						<br/><b style="font-size:16px;">添加模块权限</b>
						<br/><br/>
							 <c:forEach items="${moudles}" var="m">   
							<input id="${m.id }" name="moudlesId" type="checkbox" value="${m.id }" /><label style="font-size:16px;">${m.name }</label>
							</c:forEach>
						   <br/><br/>
					  </td>
				  </tr>
		    	<tr>
		    		<td style="height:100px;"></td>
		    	</tr>
		    	<tr>
		    		<td align="center" colspan="6">
		    		<input type="hidden" name="role.rid" value="" id="rid"/>
		    		<input name="" type="submit" class="btn" value="确认保存"/>
		    		<input name="" type="button" class="cancel" value="取消"/>
		    		</td>
		    	</tr>
		     </table>
		    </form>
			</div>
		</div>
<!-- 修改权限开始 -->
<div id="addTip1" class="tip addUser" style="width:530px; height:400px;">
			<!-- 提示部分 -->
			<div class="tiptop">
				<span>授权操作</span><a></a>
			</div>
			<!-- 正文部分 -->
			<div id="addContent" class="formbody">
					<form  id="fm" action="" method="post">
					
				<input type="hidden" id="tid" value=""/>
		    <table class="addTab" cellpadding="5">
		    	<tr>
		    		<td class="td_lable" width="70" ><b>角色名称</b></td>
		    		<td>
		    		     <input name="name" type="text" class="dfinput" />
				    	
				    	</td>
		    	</tr>
		    	<!-- 查询所有角色 模块遍历...................................................-->
				<tr>
					<td colspan="6"> 
						<br/><b style="font-size:16px;">添加模块权限</b>
						<br/><br/>
							 <c:forEach items="${moudles}" var="m">   
							<input id="${m.id }" name="moudlesId" type="checkbox" value="${m.id }" /><label style="font-size:16px;">${m.name }</label>
							</c:forEach>
						   <br/><br/>
					  </td>
				  </tr>
		    	<tr>
		    		<td style="height:100px;"></td>
		    	</tr>
		    	<tr>
		    		<td align="center" colspan="6">
		    		<input type="hidden" name="role.rid" value="" id="rid"/>
		    		<input name="" type="submit" class="btn" value="确认保存"/>
		    		<input name="" type="button" class="cancel" value="取消"/>
		    		</td>
		    	</tr>
		     </table>
		    </form>
			</div>
		</div>
<!-- 修改权限结束 -->
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>