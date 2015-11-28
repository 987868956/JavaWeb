<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>中心管理</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/json2.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script language="javascript" type="text/javascript"
	src="../js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if (tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->


<script type="text/javascript">
	// 页面加载后进行一些初始化
	$(document).ready(function() {
		// 设置form表单的action为添加的action

		// 提示框的移动效果
		eleMove_jquery($(".tip"));

		// 点击添加弹出添加的form表单
		$(".clicks").click(function() {
			//alert("dfasdfs");
			if($("#tiptop_id").html()=="修改中心"){
			$("#agName_id").val("");
			$("#agAddr_id").val("");
			$("#agTel_id").val("");
			$("#agWebSite_id").val("");
			
			}
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

	});

	// 检查添加的中心名称是否已经存在
	function checkAgName(val) {
		// 没有输入中心名称
	
		if (0 == val.length) {
			$("#agNameTips_id").html("请输入中心名称！");
			$("#agName_id").focus();
			return;
		}

		// 发送的action的地址
		var url = "market/centre!getByName";
		// 参数
		var param = "cname=" + val;
		// 使用ajax发送
		$.ajax({
			url : url,
			data : param,
			type : "post",
			success : function(result) {
			
				var results =JSON.parse(result);
				 if($("#tiptop_id").html()=="添加中心"){
				 	$("#agNameTips_id").html(results.tips);
				}
					
			}
		});
	}

	// 修改中心数据前，查询该中心的信息
	function updateAgency(centreID) {
		// 确认修改后
		if (confirm("是否确定修改该中心信息？")) {
		
			$("#tiptop_id").html("修改中心");
			$("#agNameTips_id").html("");
			$("#agName_id").attr({readonly:"readonly"});
			// 查询该中心的数据的action
			var url = "market/centre!getByID";
			
			// 中心id
			var param = "cid=" + centreID;
			// 使用ajax更新
			$.ajax({
						url : url,
						data : param,
						type : "post",
						success : function(results) {

							// 如果有json数据返回
							var result  = JSON.parse(results);
								// 设置form表单的地址
								$("#agency_frm_id")[0].action = "market/centre!update";
								// 显示查询到的数据
								$("#agName_id").val(result.cen.cname);
								
								$("#agAddr_id").val(result.cen.caddress);
								$("#agTel_id").val(result.cen.ctelephone);
								$("#agWebSite_id").val(result.cen.homePage);
								$("#agId_id").val(result.cen.cid);
								$("#status_sel_id").val(result.cen.status);
								$("#sel_li_id").removeClass("hidden");
								// 显示修改的form表单
								$(".tip").fadeIn(200);
							
							$("#tiptop_id").html("添加中心");
							
						}
					});
					
		}
	}

	function deleteAgency(agId) {
		if (confirm("是否确定删除该中心？")) {
			//location = "market/centre!delete"+agId;
		window.location.href="market/centre!delete?cid="+agId;			
		}
	}

	function checkForm() {
		if (0 == $("#agName_id").val().length) {
			alert("中心名称不能为空！");
			$("#agName_id").focus();
			return false;
		}
	
		

		if (0 == $("#agAddr_id").val().length) {
			alert("中心地址不能为空！");
			$("#agAddr_id").focus();
			return false;
		}

		if (0 == $("#agTel_id").val().length) {
			alert("座机电话不能为空！");
			$("#agTel_id").focus();
			return false;
		}

	
		if (0 == $("#agWebSite_id").val().length) {
			alert("中心主页不能为空！");
			$("#agWebSite_id").focus();
			return false;
		}

		return true;
	}
</script>

<style type="text/css">
.agency_input {
	width: 180px;
	height: 25px;
	border: 1px solid #CED9DF;
	margin-left: 10px;
}

.tipinfo li {
	height: 30px;
}

.show {
	display: "";
}

.hidden {
	display: none;
}

#agNameTips_id {
	color: red;
}

#status_sel_id {
	border: 1px solid #CED9DF;
	margin-left: 10px;
}
</style>
</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">营销管理</a></li>
			<li><a href="#">中心管理</a></li>
		</ul>
	</div>

	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="clicks"><span><img src="images/t01.png" /></span>添加
				</li>
				</ul>
				<ul class="toolbar"	>
				<form action="centre" method="post">
				<li>中心名称<input style="height:25px;" type="text" name="CName" class="agency_input"/></li>
				<li>中心地址<input  style="height:25px;" type="text" name="CAddress" class="agency_input"/></li>
				<input type="submit"  style="height:36px;width:40px" value="查询"/>
				</form>
			</ul>
		</div>


		<table class="tablelist">
			<thead>
				<tr>
					<th>编号<i class="sort"> <img src="images/px.gif" />
					</i>
					</th>
					<th>中心名称</th>
					<th>中心地址</th>
					<th>座机</th>
					
					<th>网站</th>
					<th>当前状态</th>
					<th>操作</th>
				</tr>
			</thead>

			<tbody>

	<c:forEach items="${centres}" var="e" varStatus="m">
				<tr>
					<td>${e.cid }</td>
					<td>${e.cname }</td>
					<td>${e.caddress }</td>
					<td>${e.ctelephone }</td>
					
					<td>${e.homePage }</td>
					<c:if test="${e.status=='1'}"><td>启用</td></c:if>	
					<c:if test="${e.status=='0'}"><td>禁用</td></c:if>				
					<td><a href="javascript:void(0);" class="tablelink"
						onclick="updateAgency(${e.cid});">修改</a> 
						<a href="javascript:void(0);"
						class="tablelink" onclick="deleteAgency(${e.cid});"> 删除</a></td>
				</tr>
</c:forEach>



			</tbody>
		</table>


		<div class="pagin">
			<div class="message">
				共<i class="blue">${size }</i>条记录，当前显示第&nbsp;<i class="blue">${ currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<li class="paginItem"><a
					href="centre?currentPage=${currentPage-1}">
						<span class="pagepre"></span>
				</a></li>

				<li class="paginItem"><a
					href="centre?currentPage=${ currentPage}">${currentPage}</a>
				</li>

			


				<li class="paginItem"><a
					href="centre?currentPage=${ currentPage+1}">
						<span class="pagenxt"></span>
				</a></li>
			</ul>
		</div>


		<div class="tip" style="height:300px;">
			<div class="tiptop">
				<span id="tiptop_id">添加中心</span><a></a>
			</div>
			<span style="margin-left:30px; margin-top:10px;"> <label
				style="color:red; font-weight:bold;">注：</label> 带<label
				style="color:red;">*</label>为必填项
			</span>
			<form id="agency_frm_id" method="post"
				action="centre!add"
				onsubmit="return checkForm();">
				<div class="tipinfo"
					style="padding-top:10px; margin-left:50px; height:150px;">
					<li><label style="color:red;">*</label>中心名称<input
						id="agName_id" name="cname" class="agency_input" value=""
						onblur="checkAgName(this.value);" /> <label id="agNameTips_id"></label>
					</li>
					<li><label style="color:red;">*</label>中心地址<input
						id="agAddr_id" name="caddress" class="agency_input" value="" />
					</li>
					<li><label style="color:red;">*</label>座机电话<input
						id="agTel_id" name="ctelephone" class="agency_input" value="" />
					</li>
				
					<li><label style="color:red;">*</label>中心主页<input
						id="agWebSite_id" name="homePage" class="agency_input"
						value="" /></li>
					<li id="sel_li_id" class="hidden">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label
						style="color:red;">*</label>状态<select id="status_sel_id"
						name="status">
							<option value="1">可用</option>
							<option value="0">不可用</option>
					</select>
					</li>
					<li class="hidden">中心id<input id="agId_id" type="hidden"
						name="cid" class="agency_input" value="" />
					</li>
				</div>

				<div class="tipbtn">
					<input type="submit" id="sub_id" class="sure" value="确定" />&nbsp;
					<input type="reset" class="cancel" value="重置" />
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>

