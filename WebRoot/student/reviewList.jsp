<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>项目评审记录</title>

<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script language="javascript" type="text/javascript"
	src="../My97DatePicker/WdatePicker.js"></script>
<link href="../css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if (tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->

	<style>
		#add_news{width:400px; height:600px; position:absolute;top:5%; left:30%;background:#fcfdfd;box-shadow:1px 8px 10px 1px #9b9b9b;border-radius:1px;behavior:url(js/pie.htc); display:none;}
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
		.sure{position: relative;top:460px; left:-80px;}
		.sure ,.cancel{width:96px; height:35px; line-height:35px; color:#fff; background:url(../images/btnbg1.png) repeat-x; font-size:14px; font-weight:bold;border-radius: 3px; cursor:pointer;}
		.cancel{background:url(../images/btnbg2.png) repeat-x;color:#000;font-weight:normal;position: relative;top:460px; left: -10px; background-color: #CFD5D9}
		.input{position: relative;top:-32px; left:140px; width:125px;}
		#sel{position: relative;left:70px; top:-32px;}
		#deleteTip{position: relative; top:0px; left:120px;}
	</style>
<script type="text/javascript" src="/crm1501/js/jquery.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		$("#fm").submit(function() {
			// 如果主键ID不为空，则做修改操作
			if ($("#p_id").val() != 0) {
				var yyb=1;
				var chks = $(":checkbox[name='ids']:checked");
				$(chks).each(function(){
					yyb=this.value;
				});
				this.action = "review!update?cid="+yyb;
			} else {
				this.action = "review!add";
			}
		});

		$("#add").click(function() {
			$("#stuName").val("");
			$("#uname").val("");
			$("#pname").val("");
			$("#ptime").val("");
			$("#presult").val("");
			$("#add_news").fadeIn(200);
		});

		$(".cancel").click(function() {
			$(".tip").fadeOut(100);
			location = "review";
		});

		$("#stuName").blur(function() {
			var url = "//review!queryByName";
			var param = "sname=" + $("#stuName").val();
			$.ajax({
				url : url,
				data : param,
				cache : false, //不要缓存
				type : "post",
				dataType : "json",
				success : function(result) {
					if (result.pd!=0) {
						$("#errorName").html("");
						$("#sure").attr("disabled", false);
						$("#stu_id").val(result.pd);
					} else {
						$("#errorName").html("学生姓名不存在,请重新输入!");
						$("#sure").attr("disabled", true);
					}
				}
			});
		});
		
		$("#uname").blur(function() {
			var url = "//review!queryByTeaName";
			var param = "tname=" + $("#uname").val();
			$.ajax({
				url : url,
				data : param,
				cache : false, //不要缓存
				type : "post",
				dataType : "json",
				success : function(result) {
					if (result.user) {
						$("#errorTeaName").html("");
						$("#sure").attr("disabled", false);
						$("#tea_id").val(result.user.uid);
					} else {
						$("#errorTeaName").html("老师姓名不存在,请重新输入!");
						$("#sure").attr("disabled", true);
					}
				}
			});
		});

		$("#delete").click(function() {
			if(confirm("确定要删除吗？数据无价哦！")){
				var chks = $(":checkbox[name='ids']:checked");
				if (chks.size() == 0) {
					$("#clickTip").html("请选中要删除的记录！");
					$("#myTip").fadeIn(200);
				} else {
					var url = "/review!delete?";
					$(chks).each(function() {
						url += "id=" + this.value + "&";
					});
					url = url.substring(1, url.length - 1);
					// 发送请求到服务器
					location = url;
				}
			}
			
		});

		$("#update").click(function() {
			var chks = $(":checkbox[name='ids']:checked");
			if (chks.size() != 1) {
				$("#clickTip").html("请选中要修改的记录！");
				$("#myTip").fadeIn(200);
			} else {
				ajaxById(chks.val());
			}
		});

		function ajaxById(id) {
			var url = "review!findById";
			var param = "id=" + id;
			$.ajax({
				url : url,
				data : param,
				cache : false, //不要缓存
				type : "post",
				dataType : "json",
				success : function(r) {
					
					$("#p_id").val(r.rid);
					$("#stuName>option[value='" + r.sid + "']").attr("selected",true);
					
					$("#pname").val(r.name);
					
					if(r.time!=null){
						var str = r.time;
						$("#ptime").val(str.substring(0,10));
						$("#ptime").removeAttr("onclick");//移除onclick事件
						$("#ptime").unbind("click");//解绑click事件
					}
					
					$("#presult").val(r.phase);
					$("#suit").val(r.suit);
					$("#explain").val(r.explain);
					$("#reply").val(r.reply);
					
					$("#uname>option[value='" + r.uid + "']").attr("selected",true);
					$("#add_news").fadeIn(200);
				}
			});
		}
	});
</script>

</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">学员管理</a></li>
			<li><a href="#">项目评审记录</a></li>
		</ul>
	</div>

	<div class="rightinfo">

		<div class="tools">

			<ul class="toolbar">
				<li id="add"><span><img src="../images/t01.png" /></span>添加
				</li>
				<li id="update"><span><img src="../images/t02.png" /></span>修改
				</li>
				<li id="delete"><span><img
						src="../images/t03.png" /></span>删除</li>
			</ul>


			<ul class="toolbar1">
				<li><span><img src="../images/t05.png" /></span>设置</li>
			</ul>

		</div>


		<table class="tablelist">
			<tr>
				<th></th>
				<th>编号<i class="sort"> <img src="../images/px.gif" /></i></th>
				<th>学生姓名</th>
				<th>项目名称</th>
				<th>评审时间</th>
				<th>项目阶段</th>
				<th>着装礼仪</th>
				<th>项目讲解</th>
				<th>问答得分</th>
				<th>评审老师</th>
			</tr>

			<%int i=0; %>
			<c:forEach items="${reviews}" var="r">
			<%i=i+1; %>
			<tr>
				<td><input name="ids" type="checkbox" value="${r.id}" /></td>
				<td><%=i %></td>
				<td>${r.sid.name}</td>
				<td>${r.projectName}</td>
				<td><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd"/></td>
				<td>${r.projectPhase}</td>
				<td>${r.suitEtiquetteScore}</td>
				<td>${r.explainScore}</td>
				<td>${r.replyScore}</td>
				<td>${r.userId.userName}</td>
			</tr>
			</c:forEach>

		</table>


		<div class="pagin">
			<div class="message">
				共<i class="blue">${count}</i>条记录，当前显示第&nbsp;<i class="blue">${currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
				<li class="paginItem" style="height:10px;"><a
					href="review?currentPage=${currentPage-1}"><span
						class="pagepre"></span></a></li>

				<li class="paginItem"><a
					href="review">1</a></li>

				<li class="paginItem"><a
					href="review?currentPage=${currentPage+1}"><span
						class="pagenxt"></span></a></li>
			</ul>
		</div>
		<div id="myTip" class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>
			<div class="tipinfo">
				<span><img src="../images/ticon.png" /></span>
				<div id="clickTip" class="tipright">请选择一条要修改的记录</div>
			</div>
			<div class="tipbtn">
				<input type="button" class="cancel" id="deleteTip" value="取消" />
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
					
					<span>项目名称:</span>
						<input type="text" name="projectName" value="" id="pname" class="input" /> 
						
					<span>评审时间:</span>
						<input type="text" name="createDate" value="" id="ptime"
						class="input" onfocus="WdatePicker()" readonly="readonly"/> 
					
					<span id="xmjd">项目阶段:</span>
						<select name="projectPhase" id="presult" class="input">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						
					<span>着装礼仪:</span>
						<input type="text" name="suitEtiquetteScore" value="" id="suit" class="input" />
					
					<span>项目讲解:</span>
						<input type="text" name="explainScore" value="" id="explain" class="input" />
						
					<span>问答得分:</span>
						<input type="text" name="replyScore" value="" id="reply" class="input" />
						
					<span>评审老师:</span>
						<!-- <input type="text" name="student" id="stuName" class="input" />  -->
						<select name="user" id="stuName" class="input">
							<c:forEach items="${us }" var="s">
								<option value="${s.id }">${s.userName }</option>
							</c:forEach>
						</select>
						
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
</body>
</html>
