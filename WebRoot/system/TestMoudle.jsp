<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>模块管理</title>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/json2.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
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
			var chks = $(":checkbox[name='idsss']:checked");
			if (chks.size() != 1) {
			
				$("#click").html("请选择一条需要修改的数据");
				$("#myTip").fadeIn(200);
			} else {
				// 开始异步请求获取数据
				alert("chks:"+chks.val());
				ajaxMoudleById(chks.val());
					
				
			}
		});

		//删除按钮
		
		$("#deleteClick").click(function() {
		if(confirm("确定要删除吗")) {
			var chks = $(":checkbox[name='idsss']:checked");
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
			if ($("#tid").val() != "") {
			//alert("确定修改数据吗?")
				this.action = "/SeecenCRM/system/moudle!UpdataMoudle";
			} else {
				this.action = "/SeecenCRM/system/moudle!add";
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
      
	function ajaxMoudleById(id) {
	     // alert(id);
				$.ajax({
					type:"POST",
					url:"moudle!getPagemoudle",
					data:"id="+id,
					success:function(msg){
					  //alert("你确定需要修改吗sss？")
					  
						var result = JSON.parse(msg);
						var moudle = result.moudle;
						$("#tid").val(moudle.id);
						$("input[name='id']").val(moudle.id);
						$("input[name='name']").val(moudle.name);
						$("input[name='url']").val(moudle.url);
					 
					 $("select[name='parentId']").val(moudle.parentId);
						if("1"==moudle.isson){
							$("input[name='isson']").first().attr("checked","checked");
							$("#parentModuleLi").css("display","block");
						}else{
							$("input[name='isson']").last().attr("checked","checked");
							
						}
						if("0"==moudle.status){
							$("input[name='status']").first().attr("checked","checked");
						}else{
							$("input[name='status']").last().attr("checked","checked");
						}
						//$("#tresult").val(u.content);

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
			<li><a href="/crm1501/null?subUrl=null"> 模块管理 </a></li>
			
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
       			 <th><input name="" type="checkbox" value="" checked=""/></th>
       			 <th>模块编号<i class="sort"><img src="../images/px.gif" /></i></th>
        		<th>模块</th>
       			 <th>子级模块</th>
       			 <th>访问路径</th>
       			 <th>模块状态</th>
       			 <th>父类模块</th>
    			<th>操作</th>
        </tr>
        
        </thead>

			 <tbody>
		    	<c:forEach items="${moudles}" var="m">
			        <tr>
			        	<td><input name="idsss" type="checkbox" value="${m.id}"  /></td>
			            <td>${m.id }</td>
			            <td><c:if test="${m.isson=='0'}">${m.name }</c:if></td>
			            <td><c:if test="${m.isson=='1'}">${m.name }</c:if></td>
			            <td>${m.url }</td>
			            <td>
			            	<c:if test="${m.status=='1' }">已启用</c:if>
			            	<c:if test="${m.status=='0' }">
			            		<span style="color:red">已禁用</span>
			            	</c:if>
			             </td>
			            <td><span style="color:#990099">${m.parentMoudle.name}</span></td>
				        <td>
					    	 <ul class="toolbar2">
								<li class="updateBtn" value="${m.id }">
								<a class="tablelink" href="moudle!changeMoudleStatus?moudleId=${m.id}">禁用/</a>
								<a class="tablelink" href="moudle!changeMoudleStatus?moudleId=${m.id}">开启</a>
				
								</li>
						        </ul>
				        </td>
			        </tr>
			        <c:forEach items="${m.sonMoudles }" var="son">
				        <tr>
				        	<td><input name="idsss" type="checkbox" value="${son.id}" /></td>
				            <td>${son.id }</td>
				            <td><c:if test="${son.isson=='0' }">${son.name }</c:if></td>
				            <td><c:if test="${son.isson=='1' }">${son.name }</c:if></td>
				            <td>${son.url }</td>
				           <td>
			            	<c:if test="${son.status=='1' }">已启用</c:if>
			            	<c:if test="${son.status=='0' }">
			            		<span style="color:red">已禁用</span>
			            	</c:if>
			             </td>
							<td><span style="color:#990099">${son.parentMoudle.name}</span></td>
					        <td>
					        
					         <ul class="toolbar2">
								<li class="updateBtn" value="${son.id }">
								<a class="tablelink" href="moudle!changeMoudleStatus?moudleId=${son.id}">禁用/</a>
								<a class="tablelink" href="moudle!changeMoudleStatus?moudleId=${son.id}">开启</a>
				
								</li>
						        </ul>
						        
					        </td>
				        </tr>
			        </c:forEach>
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
				<span>模块信息</span><a></a>
			</div>
			<!-- 正文部分 -->
			<div id="addContent" class="formbody">
					<form  id="fm" action="" method="post">
					
				<input type="hidden" id="tid" value="" name="hiddenId"/>
				<ul class="forminfo" style="margin-top:30px;">
				    <li><label>模块名称：</label><input name="name" type="text" class="dfinput" /></li>
				    <li><label>访问URL：</label><input name="url" type="text" class="dfinput" /></li>
				    <li>
				    	<label>是否子模块：</label>
				    	<cite>
				    		<input name="isson" type="radio" value="1" checked="checked"  />是&nbsp;&nbsp;&nbsp;&nbsp;
				    		<input name="isson" type="radio" value="0" />否
				    	</cite>
				    </li>
				    <li id="parentModuleLi">
				    	<label>父模块：</label>
				    	<select name="parentId" class="dfinput">
				    		<option value="">请选择</option>
				    		<c:forEach items="${moudles}" var="m">
				    			<option value="${m.id }">${m.name }</option>
				    		</c:forEach>
				    	</select>
				    </li>
				    <li><label>启用状态：</label>
				    	<cite>
				    		<input name="status" type="radio" value="1" checked="checked" />启用&nbsp;&nbsp;&nbsp;&nbsp;
				    		<input name="status" type="radio" value="0" />禁用
				    	</cite>
					</li>
				</ul>
				<div class="tipbtn">
					<input type="submit" class="sure" value="提交" />&nbsp; 
					<input type="button" class="cancel" value="取消" />
				</div>
			</form>
			</div>
		</div>
		
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>