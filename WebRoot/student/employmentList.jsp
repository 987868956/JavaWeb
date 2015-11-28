<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>就业情况</title>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script language="javascript" type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if (tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->


<style>
		#add_news{width:400px; height:500px; position:absolute;top:5%; left:30%;background:#fcfdfd;box-shadow:1px 8px 10px 1px #9b9b9b;border-radius:1px;behavior:url(js/pie.htc); display:none;}
		.tip{width:485px; height:260px; position:absolute;top:10%; left:30%;background:#fcfdfd;box-shadow:1px 8px 10px 1px #9b9b9b;border-radius:1px;behavior:url(js/pie.htc); display:none; z-index:2;}
		.tiptop{height:40px; line-height:40px; background:url(../images/tcbg.gif)  repeat-x; background-color: #3F97C9;}
		.tiptop span{font-size:14px; font-weight:bold; color:#fff;float:left; text-indent:20px;}
		.tiptop a{display:block; background:url(../images/close.png) no-repeat; width:22px; height:22px;float:right;margin-right:7px; margin-top:10px;}
		.tipright span{font-size:14px; font-weight:bold; line-height:45px; position:relative; left:60px;}
		.tipright input{ border:1px solid gray; position:relative; }
		#xmjd{font-size:14px; font-weight:bold; line-height:45px; position:relative; left:60px;}
		#presult{border:1px solid gray; position:relative;}
		.tiptop a:hover{background:url(../images/close1.png) no-repeat;}
		/*.tipinfo{padding-top:30px;margin-left:65px; height:95px;}
		.tipinfo span{width:95px; height:95px;float:left;}*/
		.tipright{float:left;padding-top:15px; padding-left:10px;}
		.input{border:1px solid gray;margin-top: 5px;}
		.tipright_input{clear:both;border:1px solid black; height:25px; width:140px;}
		.tipright table{border:0px solid red;cellpadding:1;cellspacing:20px;width:450px;}
		.tipright table td{font-size:14px;height:40px;}
		.tipright span{font-size:14px; font-weight:bold; line-height:35px;}
		.tipright cite{color:#858686;}
		.tipbtn{margin-top:25px; margin-left:125px;}
		.sure{position: relative;top:330px; left:-80px;}
		.sure ,.cancel{width:96px; height:35px; line-height:35px; color:#fff; background:url(../images/btnbg1.png) repeat-x; font-size:14px; font-weight:bold;border-radius: 3px; cursor:pointer;}
		.cancel{background:url(../images/btnbg2.png) repeat-x;color:#000;font-weight:normal;position: relative;top:330px; left: -10px; background-color: #CFD5D9}
		.input{position: relative;top:-32px; left:140px; width:125px;}
		#sel{position: relative;left:70px; top:-32px;}
		#deleteTip{position: relative; top:0px; left:120px;}
	</style>

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
			$("#add_news").fadeIn(200);
		});

		//修改按钮
		$("#updateClick").click(function() {
			
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() != 1) {
				$("#click").html("请选择一条需要修改的数据");
				$("#myTip").fadeIn(200);
			} else {
				// 开始异步请求获取数据
				ajaxUserById(chks.val());
			}
		});

		//删除按钮
		$("#deleteClick").click(function() {
			if(confirm("确定要删除吗？数据无价哦！")){
				var chks = $(":checkbox[name='ids']:checked");
				if (chks.size() == 0) {
					$("#click").html("请选择要删除的数据");
					$("#myTip").fadeIn(200);
				} else {
					var url = "/employment!delete?";
					$(chks).each(function() {
						url += "id=" + this.value + "&";
					});
					url = url.substring(1, url.length - 1);
					// 发送请求到服务器
					location = url;
				}
			}
				
		
		
		});
		//导出就业表
			$("#exports").click(function(){
					window.location.href="export";
				});

		// 取消按钮
		$(".cancel,#cancel,.tiptop a").click(function() {
			$(".tip").fadeOut(100);
		});
		
		
		$("#fm").submit(function() {
			// 如果主键ID不为空，则做修改操作
			if ($("#tid").val() != "") {
				var yyb=1;
				var chks = $(":checkbox[name='ids']:checked");
				$(chks).each(function(){
					yyb=this.value;
				});
				this.action = "employment!update?cid="+yyb;
			} else {
				this.action = "employment!add";
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
		var url = "employment!findById";
		var data = "id=" + id;
		$.post(url, data, function(u) {
			//var result=JSON.parse(u);
			
			 $("#tid").val("yyb");

			$("#stuName>option[value='" + u.sid + "']").attr("selected",true);
			//$("#sname").attr("disabled","disabled");
			$("#presult>option[value='" + u.post + "']").attr("selected",true);
			
			if(u.time!=null){
				var str = u.time;
				$("#ttime").val(str.substring(0,10));
				$("#ttime").removeAttr("onclick");//移除onclick事件
				$("#ttime").unbind("click");//解绑click事件
			}
			
			$("#pname").val(u.unit);
			//$("#presult").val(u.post);
			$("#suit").val(u.salary);
			$("#explain").val(u.addr);
			$("#add_news").fadeIn(200); 
		}, "json");
	}
</script>
</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="/crm1501/null?subUrl=null"> 学员管理 </a></li>
			<li><a href="#" id="subItem_id">就业情况</a></li>
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
				<li id="exports" class="click">
						<span><img src="../images/t02.png" /> </span>导出
					</li>
			</ul>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th></th>
					<th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
					<th>学员姓名</th>
					<th>工作单位</th>
					<th>就业日期</th>
					<th>就业薪资</th>
					<th>应聘职位</th>
					<th>工作地址</th>
				</tr>
			</thead>

			<tbody>
				<%int i=0; %>
				<c:forEach items="${consults}" var="consult">
				<tr>
					<%i=i+1; %>
					<td><input name="ids" type="checkbox" value="${consult.id}" /></td>
					<td><%=i %></td>
					<td>${consult.sid.name}</td>
					<td>${consult.workUnit}</td>
					<td><fmt:formatDate value="${consult.workDate}" pattern="yyyy-MM-dd"/></td>
					<td>${consult.salary}</td>
					<td>${consult.post}</td>
					<td>${consult.workAddress}</td>
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
					href="employment?currentPage=${currentPage-1 }"><span
						class="pagepre"></span></a></li>

				<li class="paginItem"><a
					href="employment">1</a></li>

				<li class="paginItem"><a
					href="employment?currentPage=${currentPage+1 }"><span
						class="pagenxt"></span></a></li>
				<!-- <li class="paginItem more"><a href="javascript:;">...</a></li> -->
			</ul>
		</div>
		<input type="hidden" id="tid" value=""/>
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

		<div id="add_news" class="tip">
			<form id="fm" method="post">
				<div class="tiptop">
					<span>项目评审记录</span>
				</div>
				<div class="tipright">
					<input type="hidden" id="stu_id" name="proreview.customer.cuId" />
					<!-- 学生隐藏域ID -->
					<input type="hidden" id="tea_id" name="proreview.user.uid" />
					<!-- 老师隐藏域ID -->
					<input type="hidden" name="proreview.pid" value="" id="p_id" />
					<!-- 当前用户主键 -->
					<span>学生姓名:</span>
						<!-- <input type="text" name="student" id="stuName" class="input" />  -->
						<select name="student" id="stuName" class="input">
							<c:forEach items="${ss }" var="s">
								<option value="${s.id }">${s.name }</option>
							</c:forEach>
						</select>
					
					<span>工作单位:</span>
						<input type="text" name="workUnit" value="" id="pname" class="input" /> 
						
					<span>就业日期:</span>
						<input type="text" name="workDate" value="" id="ttime"
						class="input" onfocus="WdatePicker()" readonly="readonly"/> 
					
					<span id="xmjd">入岗职位:</span>
						<select name="post" id="presult" class="input">
							<option value="软件工程师">软件工程师</option>
							<option value="程序员">程序员</option>
							<option value="系统架构师">系统架构师</option>
							<option value="软件测试">软件测试</option>
						</select>
						
					<span>就业薪资:</span>
						<input type="text" name="salary" value="" id="suit" class="input" />
					
					<span>工作地址:</span>
						<input type="text" name="workAddress" value="" id="explain" class="input" />
						
						
				</div>
				<div class="tipbtn">
					<input type="submit" class="sure" id="sure" value="确定" style=" background-color: #3F97C9;" />
					&nbsp; <input type="button" class="cancel" value="取消" />
				</div>
				<span id="errorName"
					style="position: absolute; left:145px; top:85px; color: red; font-size: 13px;"></span>
				<span id="errorTeaName"
					style="position: absolute; left:145px; top:150px; color: red; font-size: 13px;"></span>
			</form>
		</div>
		
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>