<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>考勤</title>

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
					var url = "/attendance!delete?";
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
				var yyb=1;
				var chks = $(":checkbox[name='ids']:checked");
				$(chks).each(function(){
					yyb=this.value;
				});
				this.action = "attendance!update?cid="+yyb;
			} else {
				this.action = "attendance!add";
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
		var url = "attendance!findById";
		var data = "id=" + id;
		
		$.post(url, data, function(u) {
			//var result=JSON.parse(u);
			
			 $("#tid").val("yyb");

			$("#sname>option[value='" + u.studentID + "']").attr("selected",true);
			
			$("#tname>option[value='"+u.uid+"']").attr("selected",true);
			
			if(u.time!=null){
				var str = u.time;
				$("#ttime").val(str.substring(0,10));
				$("#ttime").removeAttr("onclick");//移除onclick事件
				$("#ttime").unbind("click");//解绑click事件
			}
			
			$("#tresult").val(u.content);

			$("#addTip").fadeIn(200); 
		}, "json");
	}
</script>
</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="/crm1501/null?subUrl=null"> 学员管理 </a></li>
			<li><a href="#" id="subItem_id">学员考勤</a></li>
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
					<th></th>
					<th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
					<th>学生</th>
					<th>考勤结果</th>
					<th>日期</th>
					<th>考勤人</th>
				</tr>
			</thead>

			<tbody>
				<%int i=0; %>
				<c:forEach items="${attendances}" var="a">
				<%i=i+1; %>
				<tr>
					<td><input name="ids" type="checkbox" value="${a.id}" /></td>
					<td><%=i %></td>
					<td>${a.sid.name}</td>
					<td>${a.result}</td>
					<td><fmt:formatDate value="${a.createDate}" pattern="YYYY-MM-dd"/></td>
					<td>${a.userId.userName}</td>
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
					href="attendance?currentPage=${currentPage-1 }"><span
						class="pagepre"></span></a></li>

				<li class="paginItem"><a
					href="attendance">1</a></li>

				<li class="paginItem"><a
					href="attendance?currentPage=${currentPage+1 }"><span
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
		<div id="addTip" class="tip addUser">
			<!-- 提示部分 -->
			<div class="tiptop">
				<span>信息</span><a></a>
			</div>
			<!-- 正文部分 -->
			<div id="addContent" class="formbody">
				<div class="formtitle">
					<span>面谈信息</span>
				</div>
				<form id="fm" method="post">
					<table class="addTab" cellpadding="5">
						<tr>
							<td class="td_lable">姓名 <input type="hidden" id="tid"
								name="talk.tid" />
							</td>

							<td>
							
							<select name="student" id="sname" >
									<c:forEach items="${students}" var="s">
										<option value="${s.id}">${s.name}</option>
									</c:forEach>
							</select>
							
							
							
							</td>

							<td width="60" class="td_lable">考勤时间</td>
							<td><input id="ttime" name="createDate" class="scinput"
								readonly="readonly" onclick="WdatePicker()" /></td>
						</tr>
						<tr>
							<td class="td_lable">考勤人</td>
							<td><select name="user" id="tname">
									
									<c:forEach items="${users}" var="u">
										<option value="${u.id}">${u.userName}</option>
									</c:forEach>

									

							</select></td>

							<td class="td_lable">考勤结果</td>
							<td>
								<select name="result" id="tresult" class="scinput">
									<option value="正常">正常</option>
									<option value="迟到">迟到</option>
									<option value="请假">请假</option>
									<option value="早退">早退</option>
								</select>
							</td>
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