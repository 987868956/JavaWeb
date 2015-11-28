<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>模拟面试</title>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
	<style>
		#add_news{width:400px; height:500px; position:absolute;top:10%; left:30%;background:#fcfdfd;box-shadow:1px 8px 10px 1px #9b9b9b;border-radius:1px;behavior:url(js/pie.htc); display:none;}
		.tip{width:485px; height:260px; position:absolute;top:10%; left:30%;background:#fcfdfd;box-shadow:1px 8px 10px 1px #9b9b9b;border-radius:1px;behavior:url(js/pie.htc); display:none; z-index:2;}
		.tiptop{height:40px; line-height:40px; background:url(../images/tcbg.gif)  repeat-x; cursor:pointer;}
		.tiptop span{font-size:14px; font-weight:bold; color:#fff;float:left; text-indent:20px;}
		.tiptop a{display:block; background:url(../images/close.png) no-repeat; width:22px; height:22px;float:right;margin-right:7px; margin-top:10px; cursor:pointer;}
		.tipright span{font-size:14px; font-weight:bold; line-height:45px; position:relative; left:60px;}
		.tipright input{ border:1px solid gray; position:relative; }
		.tipright select{position:relative; left:10px; width:125px;}
		.tiptop a:hover{background:url(../images/close1.png) no-repeat;}
		
		.sepcial{font-size:14px; font-weight:bold; line-height:45px; position:relative; left:60px;}
		#sname{border:1px solid gray; position:relative;margin-left: 130px;}
		#uname{border:1px solid gray; position:relative;margin-left: 130px;}
		
		/*.tipinfo{padding-top:30px;margin-left:65px; height:95px;}
		.tipinfo span{width:95px; height:95px;float:left;}*/
		.tipright{float:left;padding-top:15px; padding-left:10px;}
		.tipright_input{clear:both;border:1px solid black; height:25px; width:140px;}
		.tipright table{border:0px solid red;cellpadding:1;cellspacing:20px;width:450px;}
		.tipright table td{font-size:14px;height:40px;}
		.tipright p{font-size:14px; font-weight:bold; line-height:35px;}
		.tipright cite{color:#858686;}
		.tipbtn{margin-top:25px; margin-left:100px;}
		.sure{position: relative;top:320px; left:-200px;}
		.sure ,.cancel{width:96px; height:35px; line-height:35px; color:#fff; background:url(../images/btnbg1.png) repeat-x; font-size:14px; font-weight:bold;border-radius: 3px; cursor:pointer;}
		.cancel{background:url(../images/btnbg2.png) repeat-x;color:#000;font-weight:normal;position: relative;top:285px; left: -70px;}
		.input{position: relative;top:-32px; left:140px; width:125px;}
		#sel{position: relative;left:70px; top:-32px;}
		#deleteTip{position: relative; top:0px; left:120px;}
	</style>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/index.js"></script>
<script type="text/javascript" src="../js/select-ui.min.js"></script>
<script language="javascript" type="text/javascript"
	src="../My97DatePicker/WdatePicker.js"></script>
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
					var url = "/interview!delete?";
					$(chks).each(function() {
						url += "id=" + this.value + "&";
					});
					url = url.substring(1, url.length - 1);
					// 发送请求到服务器
					location = url;
				}
			}
			
		});

		// 取消按钮
		$(".cancel,#cancel,.tiptop a").click(function() {
			$(".tip").fadeOut(100);
		});

		$("#fm").submit(function() {
			// 如果主键ID不为空，则做修改操作
			if ($("#tid").val() != "") {
				var yyb = 1;
				var chks = $(":checkbox[name='ids']:checked");
				$(chks).each(function() {
					yyb = this.value;
				});
				this.action = "interview!update?cid=" + yyb;
			} else {
				this.action = "interview!add";
			}
			return true;
		});

		$("#stuid").val("");
	});
	
	$("#stuName").blur(function(){
		var url="/crm1501/ajax/ajaxAction!queryByName.action";
		var param="name="+$("#stuName").val();
		$.ajax({
			url:url,
			data:param,
			cache:false, //不要缓存
			type:"post",
			dataType:"json",
			success:function(result){
				if(result.customer) {
					$("#errorName").html("");
					$("#sure").attr("disabled",false);
					$("#cu").val(result.customer.cuId);
				} else {
					$("#errorName").html("学生姓名不存在,请重新输入!");
					$("#sure").attr("disabled",true);
				}
			}
		});
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
		var url = "interview!findById";
		var data = "id=" + id;

		$.post(url, data, function(u) {
			//var result=JSON.parse(u);

			$("#tid").val("yyb");

			$("#sname>option[value='" + u.sid + "']").attr("selected",true);
			//$("#sname").attr("disabled","disabled");

			$("#uname>option[value='" + u.uid + "']").attr("selected", true);

			if (u.time != null) {
				var str = u.time;
				$("#ttime").val(str.substring(0, 10));
				$("#ttime").removeAttr("onclick");//移除onclick事件
				$("#ttime").unbind("click");//解绑click事件
			}
			
			$("#suition").val(u.situation);

			$("#tresult").val(u.content);

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
			<li><a href="#" id="subItem_id">模拟面试情况</a></li>
		</ul>
	</div>

	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li id="addClick" class="click"><span><img
						src="..//images/t01.png" /></span>增加</li>
				<li id="updateClick" class="click"><span><img
						src="../images/t02.png" /></span>修改</li>
				<li id="deleteClick"><span><img src="../images/t03.png" /></span>删除</li>
			</ul>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th></th>
					<th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
					<th>学员姓名</th>
					<th>面试情况</th>
					<th>面试得分</th>
					<th>面试日期</th>
					<th>面试官</th>
				</tr>
			</thead>

			<tbody>
				<%int i=0; %>
				<c:forEach items="${interviews}" var="i">
				<%i=i+1; %>
					<tr>
						<td><input name="ids" type="checkbox" value="${i.id}" /></td>
						<td><%=i %></td>
						<td>${i.sid.name}</td>
						<td>${i.situation}</td>
						<td>${i.result}</td>
						<td><fmt:formatDate value="${i.createDate}" pattern="yyyy-MM-dd" /></td>
						<td>${i.userId.userName}</td>
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
					href="interview?currentPage=${currentPage-1}"><span
						class="pagepre"></span></a></li>

				<li class="paginItem"><a href="interview">1</a></li>

				<li class="paginItem"><a
					href="interview?currentPage=${currentPage+1}"><span
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
				<div id="clickTip" class="tipright">请选择一条要修改的记录</div>
			</div>
			<div class="tipbtn">
				<input type="button" class="cancel" id="deleteTip" value="取消" />
			</div>
		</div>

		<!-- 添加用户 -->
		<div id="add_news" class="tip">
	    	<form id="fm" method="post" name="form1">
				<div class="tiptop">
					<span>添加面试记录</span>
				</div>
		        <div class="tipright">
		        
		        	<span class="sepcial">学生姓名:</span>
		        		<select name="student" id="sname" class="input">
							<c:forEach items="${ss }" var="s">
								<option value="${s.id }">${s.name }</option>
							</c:forEach>
						</select>
		        	
		        	<input type="hidden" id="cu" name="interview.customer.cuId" style="float:left;"/>
		        	<input type="hidden" id="heheid" name="heheid" value=""/> 
		        	<input type="hidden" id="tid" />
		        	<span>面试情况:</span>
		        		<!-- <input type="text" name="situation" value="" id="suition" class="input"/> -->
		        		<textarea name="situation" id="suition" class="input" style="border:1px solid gray;"></textarea>
		        	
		        	<span>面试结果:
		        		
			        		<select id="tresult" name="result" style="border:1px solid gray;margin-left: 5px">
			        			<option value="A">A</option>
			        			<option value="B">B</option>
			        			<option value="C">C</option>
			        			<option value="D">D</option>
			        		</select>
			        	
		        	</span>
		        	<span>面试时间:</span><input type="text" name="createDate" value="" id="ttime" class="input" onfocus="WdatePicker()"/>
		        	<span class="sepcial">面试官:</span>
		        		<select name="user" id="uname" class="input">
							<c:forEach items="${us }" var="u">
								<option value="${u.id }">${u.userName }</option>
							</c:forEach>
						</select>
		        	
		        </div>
				<div class="tipbtn">
					<input type="submit"  class="sure" id="sure" value="确定"/>&nbsp;
					<input type="button"  class="cancel" value="取消" />
				</div>
				<span id="errorName" style="position: relative; left:12px; top:0px; color: red" ></span>
			</form>
	    </div>
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>