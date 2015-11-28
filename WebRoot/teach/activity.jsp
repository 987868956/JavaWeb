<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>活动</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="../css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
		<style type="text/css">
.myTab td {
	width: 100px;
	height: 30px;
	font-size: 14px;
}

.myTab input {
	clear: both !important;
	width: 130px !important;
	border: 1px solid black !important;
	height: 30px !important;
}

.select2 {
	width: 130px;
	height: 30px;
	border: 1px solid black;
}

#classes {
	width: 130px;
	height: 30px;
	border: 1px solid black;
}

#teacher {
	width: 130px;
	height: 30px;
	border: 1px solid black;
}
</style>
		<script language="javascript">
	$(function() {
		//导航切换
		$(".imglist li").click(function() {
			$(".imglist li.selected").removeClass("selected")
			$(this).addClass("selected");
		})
	})
</script>
		<script type="text/javascript">
	$(document).ready(function(){
				if (false) {
					alert("");

				}

				$(".addClick").click(function() {
					checkForm();
					$(".tip").fadeIn(200);
				});
				$(".tiptop a").click(function() {
					$(".tip").fadeOut(200);
				});
				$(".sure").click(function() {
					$(".tip").fadeOut(100);
				});
				$(".cancel").click(function() {
					$(".tip").fadeOut(100);
				});
				//修改按钮
					$(".updateClick").click(function() {
						var chks = $(":checkbox[name='ids']:checked");
						if (chks.size() != 1) {
							$("#myTip").fadeIn(200);
						} else {
							ajaxActivityById(chks.val());
						}
					});
					//删除按钮
					$(".deleteClick").click(function() {
								//获取用户选中的复选框
									var chks = $(":checkbox[name='ids']:checked");
									if (chks.size() == 0) {
										$("#clickTip").html("请选择要删除的记录");
										$("#myTip").fadeIn(200);
									} else {
										var url = "activityAction!delete";
										$(chks).each(function() {
											url += "id=" + this.value + "&";
										});
										url = url.substring(1, url.length - 1);
										// 发送请求到服务器
										location = url;
									}
								});
					//提交表单，如果uid为空，则做添加，否则做修改
					$("#fm").submit(
									function() {
										if ($("#aid").val() != "") {
											var url="";
											var chks = $(":checkbox[name='ids']:checked");
											$(chks).each(function(){
										  	url=this.value
						  				});
										this.action = "activity!update?id="+url;
										} else {
											this.action = "activity!add";
										}
										return true;
									});

				});

	//表单验证
	function jiaoyan() {
		
		if ($("#type").val() == "") {
			alert("活动类型不能为空");
			return false;
		}  
	}

	function ajaxActivityById(id) {
		var url = "activity!findById";
		var data = "id=" + id;
		$.post(url, data, function(u) {
			$("#aid").val(u.id);
			$("#classes>option[value='" + u.couid + "']").attr("selected", true);
			$("#type").val(u.theme);
			$("#activityTime").val(u.activityTime);
			$("#place").val(u.place);
			$(".tip").fadeIn(100);
		}, "json");
	}
	function checkForm() {
		$("#type").val("");
		$("#activitytime").val("");
		$("#count").val("");
	}
	function go(values){
		//根据button传值判断"首页"、"上一页"、"下一页"、"尾页"
				if(0==values){
					currentPage=1;
				}else if(1==values){
					currentPage = parseInt(currentPage)-parseInt(1);
				}else if(2==values){
					currentPage = parseInt(currentPage)+parseInt(1);
				}else if(3==values){
					currentPage=1;
				}
				var page=currentPage;
				$("#page").val(page);
				$("#find").submit();
				window.location.href="course?currentPage="+page
			}
</script>
	</head>
	<body>
		<div class="place">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="course!listAll">班级表</a></li>
				<li>班级活动表</li>
			</ul>
		</div>
		<div id="myTip" class="tip">
			<div class="tiptop">
				<span>提示信息</span><a></a>
			</div>
			<div class="tipinfo">
				<span><img src="../images/ticon.png" />
				</span>
				<div id="clickTip" class="tipright">
					请选择一条要修改的记录
				</div>
			</div>
			<div class="tipbtn">
				<input id="cancel" name="" type="button" class="sure" value="确定" />
			</div>
		</div>


		<div class="rightinfo">
			<div class="tools">
				<ul class="toolbar">
					<li class="addClick">
						<span><img src="../images/t01.png"></img> </span>添加
					</li>
					<li class="updateClick">
						<span><img src="../images/t02.png"></img> </span>修改
					</li>
					
				</ul>
			</div>
			<table class="imgtable">
				<thead>
					<tr>
						<th><input name="" type="checkbox" value="" /></th>
						<th>编号</th>
						<th>班级名称</th>
						<th>活动主题</th>
						<th>活动时间</th>
						<th>活动地点</th>
						<!-- <th>
							操作
						Course className;		//班级名称
	 					String theme;			//活动主题
						Date activityTime;		//活动时间
	 					String place;	
						</th> -->
	
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${as}" var="as">
						<tr>
							<td><input name="ids" type="checkbox" value="${as.id }" /></td>
							<td>
								<a href="#"  onclick="ajaxStudentFindAll(${as.id })" id="${as.id }">${as.id}</a>
							</td>
							<td>${as.className.className}</td>
							<td>${as.theme}</td>
							<td><fmt:formatDate value="${as.activityTime }" pattern="yyyy-MM-dd"/></td>
							<td>${as.place}</td>
							
							
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagin">
				<div class="message">共
					<i class="blue">${totalSize }&nbsp;</i>条记录，当前显示第&nbsp;
					<i class="blue">${currentPage }&nbsp;</i>页
				</div>
				<ul class="paginList">
					<!-- 隐藏域存放当前页 -->
					<input type="hidden" id="hid" name="hid" value="${currentPage }"/>
<!-- 跳转上一页 -->
					<li class="paginItem">
						<c:if test="${currentPage>1}">
						<input id="page" type="button" value="Back" onclick="go(1)" style="float:left;width:31px;height:28px;border:1px solid #DDD; text-align:center;line-height:30px;border-left:none;color:#3399d5;"/><span class="pagenxt"></span>
						</c:if>
					</li>
<!-- 跳转下一页  -->
					<li class="paginItem">
						<c:if test="${currentPage<totalPage}">
						<input id="page" type="button" value="Next" onclick="go(2)" style="float:left;width:31px;height:28px;border:1px solid #DDD; text-align:center;line-height:30px;border-left:none;color:#3399d5;"/><span class="pagenxt"></span>
						</c:if>
					</li>
					
				</ul>
			</div>
		</div>
		<br />
		<script type="text/javascript">
	$('.imgtable tbody tr:odd').addClass('odd');
</script>
		<!--遮罩层显示的DIV1-->
		<div class="tip">
			<div class="tiptop">
				<span id="myTiptop">班级基本信息</span><a></a>
			</div>
			<div>
				<div class="tipright" style="z-index: -10; position: relative;">
					<form id="fm" onsubmit="return jiaoyan()"
						action="activity!add" method="post">
						<table class="myTab" width="450">
							<tr>
								<td><b style="color: red">*</b>班级名称：</td>
								<td>
									<select name="cid" id="classes" class="select2">
										<c:forEach items="${cs}" var="cs">
											<option value="${cs.id }">${cs.className }</option>
										</c:forEach>
									</select>

								</td>
								<td>
									<b style="color: red">*</b>活动时间：
								</td>
								<td>
									<input id="activityTime"
										onfocus="WdatePicker({minDate:'1942-01-01'})"
										readonly="readonly" name="activityTime" />
								</td>
							</tr>
							<tr>
								<td>
									<b style="color: red">*</b>活动类型：
								</td>

								<td class="uew-select-text">
									<input id="type" name="theme" />
								</td>
								<td>
									<b style="color:red">*</b>活动地点
								</td>
								<td>
									<input id="place" name="place"/>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" align="center">
									<input type="hidden" name="activity.aid" value="" id="aid" />
									<input
										style="font-size: 20px; background: blue; color: white; margin-top: 20px;"
										type="reset" value="重置" />
									&nbsp;
									<input
										style="font-size: 20px; background: blue; color: white; margin-top: 20px;"
										type="submit" value="确定" />
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div>
			</div>
		</div>
	</body>

</html>



