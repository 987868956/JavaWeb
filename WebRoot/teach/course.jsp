<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>班级</title>
		<link href="../css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>

		<style type="text/css">
.myTab td {
	width: 100px;
	height: 30px;
	border: 1xp solid blue;
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
</style>
		<script type="text/javascript">
		$(document).ready(function(){
			 if(false){
					alert("");
				}
			  $("#addClick").click(function(){
				  clearForm();
				  $(".tip").fadeIn(1000);
			  });
			  $(".tiptop a").click(function(){
			  	$(".tip").fadeOut(200);
			  });
			  $(".sure").click(function(){
			  	$(".tip").fadeOut(100);
			  });
			  $(".cancel").click(function(){
			  	$(".tip").fadeOut(100);
			  });
			  //删除按钮
			 	$("#deleteClick").click(function(){
					//获取用户选中的复选框
					var chks = $(":checkbox[name='ids']:checked");
					if(chks.size()==0){
						$("#clickTip").html("请选择要删除的记录");
						$("#myTip").fadeIn(200);
					}else {
						var url="/crm1501/classes/classesAction!delete.action?";
						  $(chks).each(function(){
							  url += "id="+this.value+"&";
						  });
						  url = url.substring(1,url.length - 1);
						  // 发送请求到服务器
						  location = url;
					}
				 });
			//修改按钮
			  $("#updateClick").click(function(){
				  var chks = $(":checkbox[name='ids']:checked");
				  if(chks.size() != 1) {
				  	  $("#click").html("请选择一条需要修改的数据");
					  $("#myTip").fadeIn(200);
				  } else {
					 ajaxClassesById(chks.val());
				  }
				});
			//导出学员信息
			  $("#export").click(function(){
				  var chks = $(":checkbox[name='ids']:checked");
				  if(chks.size() != 1) {
				  	  $("#click").html("请选择一个需要导出的班级");
					  $("#myTip").fadeIn(200);
				  } else {
					 exportStu(chks.val());
				  }
				});
				function exportStu(id){
					window.location.href="export?classId="+id+"&isShow=1";
				}
			//查询按钮
			  $("#findClick").click(function(){
					this.action="course!listAll";
			  });
			//提交表单，如果uid为空，则做添加，否则做修改
				$("#fm").submit(function(){
					if($("#cid").val()!=""){
						var url="";
						var chks = $(":checkbox[name='ids']:checked");
						$(chks).each(function(){
							  url=this.value;
						  });
						this.action = "course!update?id="+url;
					}else{
						this.action = "course!add";
					}
						return true;
					});
		});

		//修改时用的ajax
		function ajaxClassesById(id) {
			var url="course!findById";
			var data = "id="+id;
			$.post(url,data,function(u){
				$("#cid").val(u.id);
				$("#cname").val(u.className);
				$("#createtime").val(u.open);
				$("#teacher>option[value='"+u.lecid+"']").attr("selected",true);
				$("#headTeacher>option[value='"+u.devid+"']").attr("selected",true);
				$("#address").val(u.classroom);
				$("#stage").val(u.status);
				$("#count").val(u.count);
				$("#centre").val(u.centre);
				$(".tip").fadeIn(100);
			},"json");
		}

		//清除表单
		function clearForm(){
			$("#cname").val("");
			$("#createtime").val("");
			$("#address").val("");
			$("#stage").val("");
			$("#count").val("");
		}

		//表单验证
		 	function jiaoyan(){
				var c = $("#count").val();
				var s = $("#stage").val();
				if($("#cname").val()==""){
					alert("班级名称不能为空");
					return false;
				}else if($("#createtime").val()==""){
					alert("开班时间不能为空");
					return false;
				}else if($("#teacher").val()==""){
					alert("授课讲师不能为空");
					return false;
				}else if($("#headTeacher").val()==""){
					alert("职业发展不能为空");
					return false;
				}else if($("#address").val()==""){
					alert("班级地址不能为空");
					return false;
				}else if($("#stage").val()==""){
					alert("班级阶段不能为空");
					return false;
				}else if(isNaN(s)){
					alert("学习阶段只能是数字");
					return false;
				}
				return true;
			}
/********
------根据模糊查询条件进行页面跳转
********/
			function go(values){
				var courName = $("input[name='courName']").val();		//班级名
				var manager = $("select[name='manager']").val();		//讲师
				var profession = $("select[name='profession']").val();	//职业顾问
				var centreName = $("select[name='core']").val();		//中心
				var classroom = $("input[name='classroom']").val();		//教室
				var section = $("input[name='section']").val();			//阶段
				var currentPage = $("input[name='hid']").val();			//当前页
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
				window.location.href="course?currentPage="+page+
									 "&courName="+courName+
									 "&manager="+manager+
									 "&profession="+profession+
									 "&centreName="+centreName+
				 					 "&classroom="+classroom+
				 					 "&section="+section;
			}
			function aa(cid){
				window.location.href="/crm1501/classes/classesAction!findClasses.action?classes.cid=" + cid;
			}
//查询获取到班级ID下的所有学生
			function ajaxStudentFindAll(id){
				window.location.href="course?afid="+id+"&isShow=1";
					$("#show").fadeIn(500);
					$(".tiptop a").click(function(){
			  			$("#show").fadeOut(500);
			  		});
				}
/****
	弹出学员信息框
****/
	function showBeauty(){
		if($("#isShow").val()=="1"){
			$("#show").fadeIn(500);
		}
	}
/*******
	关闭学员信息框
*******/
	function closeBeauty(){
		$("#show").fadeOut(500);
	}
	</script>

	</head>

	<body onload="showBeauty()">

<!-- 点击班级查看学生的jQuery -->
		<div id="show" style="background-color:#ccc;height:500px;width:1000px;display:none; z-index:5000;position:fixed; top:10%; left:10%;overflow: auto;">
			<div class="tiptop">
					<span id="myTiptop">班级基本信息</span><a onclick="closeBeauty()"></a>
				</div>
			<table class="tablelist">
				<thead>
					<tr>
						<th>学生姓名</th>
						<th>所属班级</th>
						<th>性别</th>
						<th>出生日期</th>
						<th>毕业院校</th>
						<th>学历</th>
						<th>专业</th>
						<th>籍贯</th>
						<th>联系电话</th>
						<th>入学时间</th>
						<th>身份证</th>
						<th>备注</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${stus }" var="sts">
						<tr>
							<td>${sts.name }</td>
							<td>${sts.classId.className }</td>
							<td>${sts.sex }</td>
							<td><fmt:formatDate value="${sts.birthDate }" pattern="yyyy-MM-dd"/></td>
							<td>${sts.college }</td>
							<td>${sts.education }</td>
							<td>${sts.major }</td>
							<td>${sts.origin }</td>
							<td>${sts.telephone }</td>
							<td><fmt:formatDate value="${sts.admissionDate }" pattern="yyyy-MM-dd"/></td>
							<td>${sts.IDCard }</td>
							<td>${sts.note }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="place">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="#">首页</a></li>
				<li><a href="#">数据表</a></li>
				<li><a href="#">基本内容</a></li>
			</ul>
		</div>
		
		<div class="rightinfo">

			<div class="tools">

				<ul class="toolbar">
					<li id="addClick" class="click">
						<span><img src="../images/t01.png" /> </span>添加
					</li>
					<li id="updateClick" class="click">
						<span><img src="../images/t02.png" /> </span>修改
					</li>
					</ul>
						<ul class="toolbar">
					<form id="find" action="course" method="post" onsubmit="">
<!-- <form id="fm" onsubmit="return jiaoyan()" action="course!add" method="post"> -->
					<li>
						班级:<input type="text" name="courName" value="${className }"/>
					</li>
					
				
					<li>
						讲师:<select name="manager" id="tea" class="select2">
									<option value="">====请选择====</option>
											<c:forEach items="${JavaTeacher}" var="us">
												<option value="${us.id}"<c:if test="${us.id==manager}">selected="selected"</c:if>>${us.userName  }
												
												</option>
											</c:forEach>
										</select>
					</li>
					<li>
						职业顾问:<select name="profession" id="headTea" class="select2">
									<option value="">====请选择====</option>
											<c:forEach items="${jobDeveloper}" var="us">
												<option value="${us.id}"<c:if test="${us.id==profession}">selected="selected"</c:if>>${us.userName  }</option>
											</c:forEach>
										</select>
					</li>
					<li>
						教室:<input type="text" name="room" value="${classroom }"/>
					</li>
					<li>
						中心:<select name="core" id="centre" class="select2">
								<option value="">====请选择====</option>
									<c:forEach items="${ces}" var="cens">
										<option value="${cens.cid}"<c:if test="${cens.cid==centreName}">selected="selected"</c:if>>${cens.cname  }</option>
									</c:forEach>
							</select>
					</li>
					
					<li style="float:left;  ">
						阶段:<input type="text" name="section" value="${section }"/>
					</li>
					<li id="export" class="click">
						<span><img src="../images/t02.png" /> </span>导出
					</li>
					<input type="submit" value="查询" style="float:left;width:31px;height:28px;border:1px solid #DDD; text-align:center;line-height:30px;border-left:none;color:#3399d5;"/>
					</ul>
			</form>	
			</ul>
				
			<input id="isShow" type="hidden" value="${isShow }"/>
			</div>
			
			<table class="tablelist">
				<thead>
					<tr>
						<th><input name="" type="checkbox" value="" checked="checked" /></th>
						<th>班级名称</th>
						<th>开班时间<i class="sort"><img src="../images/px.gif" /> </i></th>
						<th>人数</th>
						<th>讲师</th>
						<th>职业发展</th>
						<th>教室</th>
						<th>中心</th>
						<th>阶段状态</th>
						
					</tr>
				</thead>
				<tbody>
				
					<c:forEach items="${css}" var="cs">
						<tr>
							<td><input name="ids" type="checkbox" value="${cs.id }" /></td>
							<td>
<!-- 点击班级获取ID得到该班内所有学员信息 -->
							 	<input type="button" style="cursor: pointer;" onclick="ajaxStudentFindAll(${cs.id })" value="${cs.className }"/>
							</td>
							<td><fmt:formatDate value="${cs.openTime }" pattern="yyyy-MM-dd"/></td>
							<td>${cs.count }</td>
							<td>${cs.lecturer.userName }</td>
							<td>${cs.develop.userName}</td>
							<td>${cs.classroom}</td>
							<td>${cs.centre.cname }</td>
							<td>${cs.status }</td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="pagin">
				<div class="message">共
					<i class="blue">${totalSize }</i>条记录，当前显示第&nbsp;
					<i class="blue">${currentPage }</i>页
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

	<div id="myTip" class="tip">
				<div class="tiptop">
					<span>提示信息</span><a></a>
				</div>
				<div class="tipinfo">
					<span><img src="../images/ticon.png" />
					</span>
					<div id="click" class="tipright"></div>
				</div>
				<div class="tipbtn">
					<input id="cancel" name="" type="button" class="sure" value="确定" />
				</div>
			</div>
			<div class="tip">
				<div class="tiptop">
					<span id="myTiptop">班级基本信息</span><a></a>
				</div>
				
<!-- 添加、修改时弹出的jquery框 -->
				<div>
					<div class="tipright" style="z-index: -10; position: relative;">
						<form id="fm" onsubmit="return jiaoyan()" action="course!add" method="post">
							<table class="myTab" width="450">
								<tr>
									<td><b style="color: red">*</b>班级名称：</td>
									<td><input id="cname" name="className" /></td>
									<td><b style="color: red">*</b>创班时间：</td>
									<td><input id="createtime" onfocus="WdatePicker({minDate:'1942-01-01'})"
											readonly="readonly" name="openTime" />
									</td>
								</tr>
								<tr>
									<td><b style="color: red">*</b>授课讲师：</td>
									<td class="uew-select-text">
										<select name="lid" id="teacher" class="select2">
											<option value="">====请选择====</option>
											<c:forEach items="${JavaTeacher}" var="us">
												<option value="${us.id}">${us.userName  }</option>
											</c:forEach>
										</select>
									</td>
									<td><b style="color: red">*</b>职业顾问：</td>
									<td class="uew-select-text">
										<select name="did" id="headTeacher" class="select2">
											<option value="">====请选择====</option>
											<c:forEach items="${jobDeveloper}" var="us">
												<option value="${us.id}">${us.userName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td><b style="color: red">*</b>班级地址：</td>
									<td><input id="address" name="classroom" /></td>
									<td><b style="color: red">*</b>学习阶段</td>
									<td><input id="stage" name="status" /></td>
								</tr>
								<tr>
									
									<td><b style="color: red">*</b>所属中心：</td>
									<td class="uew-select-text">
										<select name="cid" id="centre" class="select2">
											<option value="">====请选择====</option>
											<c:forEach items="${ces}" var="ces">
												<option value="${ces.cid}">${ces.cname}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<input type="hidden" name="classes.cid" value="" id="cid" />
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
			</div>
		<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

	</body>

</html>