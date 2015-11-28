<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>客户管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
<meta http-equiv="description" content="This is my page"/>
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
	if(tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->
<script type="text/javascript">
		$(document).ready(function(){
			  // 提示框的移动效果
			  eleMove_jquery($(".tip"));
			  
			  $(".tiptop a").click(function(){
			  	$(".tip").fadeOut(200);
			  });
		
			  $(".sure").click(function(){
			  	$(".tip").fadeOut(100);
			  });
		
			  $(".cancel").click(function(){
			  	$(".tip").fadeOut(100);
			  });

			  // 初始化下拉框的值
			  initSel();

			  // 是否显示班级信息
			  
					$("#cl_label_id").removeClass("hidden");
					$("#cl_id").removeClass("customer_input hidden");
					$("#cl_label_id").addClass("show");
					$("#cl_id").addClass("customer_input show");
			  

			  

		});

		// 初始化下拉框的值
		function initSel() {
			$("#gender_id").val("1");
			$("#agency_id").val("30");
			$("#intention_id").val("2");
			$("#type_id").val("2");
			$("#co_id").val("25");
			$("#ic_id").val("2");
			
			
		}

		// 表单校验，所有必须的数据不能为空
		function checkForm() {
			// 回访时间不能空
			if (0 == $("#visitTime_id").val().length) {
				alert("回访时间不能为空，请输入回访时间！");
				$("#visitTime_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}


     			
		if($("#visitNextTime_id").val()< $("#visitTime_id").val()){
			alert("下次回访时间不能小于本次回访时间");
			
			return false;
			
		}

			
			

			// 回访主题不能为空
			if (0 == $("#vtopic_id").val().length) {
				alert("回访主题不能为空，请输入回访主题！");
				$("#vtopic_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}

			// 回访内容不能为空
			if (0 == $("#vcontent_id").val().length) {
				alert("回访内容不能为空，请输入回访内容！");
				$("#cuMobile_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}

			return true;
		}

		function checkNull() {
			if (0 == $("#mobile_id").val().length) {
				alert("客户电话不能为空！");
				return false;
			}
			return true;
		}
		

        // 客户信息修改
		function updateCustomer() {
			if (confirm("确认修改该客户信息吗？")) {
				$("#frm").submit();
			}
		}

		// 是否显示班级信息
		function showClasses(val) {
			// 客户状态为已报名
			if (4 == val) {
				$("#cl_label_id").removeClass("hidden");
				$("#cl_sel_id").removeClass("status_sel_id hidden");
				$("#cl_label_id").addClass("show");
				$("#cl_sel_id").addClass("status_sel_id show");
			} else {
				$("#cl_label_id").removeClass("show");
				$("#cl_sel_id").removeClass("status_sel_id show");
				$("#cl_label_id").addClass("hidden");
				$("#cl_sel_id").addClass("status_sel_id hidden");
			}
		}

		// 添加回访记录
		function addVisit() {
			// 如果登录者不是该客户的咨询师则不能添加回访记录
			
				
				
						$(".tip").fadeIn(200);
				
			
			// 显示添加回访记录的页面
			
			return true;
		}

		// 检查添加的回访记录是否存在
		function checkVisit(vtime) {
			// 检查回访记录是否存在的url
			var url = "";
			// 传递的参数
			var param = "visit.cuId=" + $("#visitCuId_id").val() + "&visit.vtime=" + vtime;
			// ajax发送请求
			$.ajax({
				url: url,
				data: param,
				dataType: "json",
				cache: false,
				type: "post",
				success: function(result) {
					// 回访记录已存在
					if (result) {
						$("#visitTips_id").html(result.tips);
					} else {
						$("#visitTips_id").html();
					}
				}
			});
		}
	</script>
	<style type="text/css">
		.customer_input {
			width:140px;
			height:25px;
			border:1px solid #CED9DF;
			margin-left:10px;
		}
		
		.tipinfo li {
			width:360px;
			height:30px;
			margin-left:10px;
		}
		
		.show {
			display:"";
		}
		
		.hidden {
			display:none;
		}
		
		#cuNameTips_id {
			color:red;
		}
		
		.status_sel_id {
			border:1px solid #CED9DF;
			margin-left:10px;
		}
		.justifAlign {
			width: 85px;
			float: left;
		}
		
		#cuContent_id {
			border:1px solid #CED9DF;
			margin-left:10px;
		}
		
		#vcontent_id {
			border:1px solid #CED9DF; 
			margin-left:12px; 
			vertical-align:top;
		}
		
		#visitTips_id {
			color: red;
		}
	</style>
  </head>
  
  <body>
    <div class="place">
	    <span>位置：</span>
	    <ul class="placeul">
		    <li>
		    	<a href="/crm1501/null?subUrl=null">
		    		
					营销管理
				</a>
		    </li>
		    <li>
		    	<a href="#" id="subItem_id">客户信息</a>
		    </li>
	    </ul>
    </div>
    
    <div class="rightinfo">
    
	    <div class="tools">
	    
	    	<ul class="toolbar">
		        <li class="click" onclick="updateCustomer();">
		        	<span><img src="images/t02.png" /></span>修改
		        </li>
	        </ul>
	        
	        <span style="float:right;">
	    	  	<label style="color:red; font-weight:bold;">注：</label>
	    	  	带<label style="color:red;">*</label>为必填项
	    	</span>
	    
	    </div>
    
    	<form id="frm" method="post" action="customer!update" onsubmit="return checkNull();">
		    <table class="tablelist">
		    	<thead>
			    	<tr>
				        <th colspan="8" style="color:blue;">
				        	基本信息
				        </th>
			        </tr>
		        </thead>
		        
		        <tbody>
		        	<tr>
		        	<input type="hidden" name="id" value="${cus.id}"/>
		        		<td>客户姓名</td>
		        		<td>
		        			<input name="name" class="customer_input" readonly="readonly" value="${cus.name }"/>
		        		</td>
		        		
		        		<td><label style="color:red;">*</label>性别</td>
		        		<td>
		        			<select name="sex" id="gender_id" class="status_sel_id" onchange="this.value()">
		        				
		        				<c:if test="${cus.sex=='男'}">
		        					<option value="男">男</option>
		        					<option value="女">女</option>
		        				</c:if>
		        				<c:if test="${cus.sex=='女'}">
		        					<option value="女">女</option>
		        					<option value="男">男</option>
		        				</c:if>
		        				
		        			</select>
		        		</td>
		        		<td>所在城市</td>
		        		<td>
		        			<input name="location" class="customer_input" value="${cus.location}"/>
		        		</td>
		        		<td>生日</td>
		        		<td>
		        			<input name="birthday" class="customer_input" value="${cus.birthday}" onfocus="WdatePicker({minDate:'1942-01-01'});"/>
		        		</td>
		        	</tr>
		        	
		        	<tr>
		        		
		        		<td><label style="color:red;">*</label>电话</td>
		        		<td>
		        			<input id="mobile_id" name="telephone" class="customer_input" value="${cus.telephone}"/>
		        		</td>
		        		<td>QQ</td>
		        		<td>
		        			<input name="qq" class="customer_input" value="${cus.qq }"/>
		        		</td>
		        		<td>邮箱</td>
		        		<td>
		        			<input name="email" class="customer_input" value="${cus.email}"/>
		        		</td>
		        		<td>住址</td>
		        		<td>
		        			<input name="address" class="customer_input" value="${cus.address}"/>
		        		</td>
		        				        	</tr>
		        	
		        	<tr>
		        	<td>毕业院校</td>
		        		<td>
		        			<input name="schoolName" class="customer_input" value="${cus.schoolName }"/>
		        		</td>
		        		<td>专业</td>
		        		<td>
		        			<input name="major" class="customer_input" value="${cus.major}"/>
		        		</td>
		        	
		        		<td>创建时间</td>
		        		<td>
		        			<input name="createTime" class="customer_input" value="${cus.createTime}" readonly="readonly" />
		        		</td>
		        	
		        	
		        	
		        		<td>渠道</td>
		        		<td>
		        			<select name="channelID" id="channel_id" class="status_sel_id" onchange="this.value()">
		        			<option value="${cus.channel.id}">${cus.channel.name}</option>
		        				<c:forEach items="${channels}" var="ch">
		        					<c:if test="${ch.id!=cus.channel.id }">
	      	    					<option value="${ch.id}">${ch.name}</option>
	      	    					</c:if>
	      	    				</c:forEach>
		        			</select>
		        		</td>
		        		
		        	</tr>
		        	
		        	<tr>
		        			<td><label style="color:red;">*</label>中心</td>
		        		<td>
		        			<select name="centreID" id="agency_id" class="status_sel_id" onchange="this.value()">
		        				
			      	    			<option value="${cus.centre.cid}">${cus.centre.cname}</option>
		        				<c:forEach items="${centres}" var="ch">
		        					<c:if test="${ch.cid!=cus.centre.cid}">
	      	    					<option value="${ch.cid}">${ch.cname}</option>
	      	    					</c:if>
	      	    				</c:forEach>
		        			</select>
		        		</td>
		        		<td>客户意向</td>
		        		<td>
		        			<select name="intention" id="intention_id" class="status_sel_id" onchange="this.value()">
		        			
		        			<option value="1">积极</option>
	      	    			<option value="2">一般</option>
	      	    			<option value="3">拒绝</option>
		        			</select>
		        		</td>
		        		
		        		<td><label style="color:red;"></label>咨询师</td>
		        		<td>
		        			<%-- <select name="userID" id="co_id" class="status_sel_id" onchange="this.value()">
		        				<option value="${cus.user.id}">${cus.user.userName}</option>
		        				<c:forEach items="${consulters}" var="consult">
		        				<c:if test="${consult.id!=cus.user.id}">
			      	    			<option value="${consult.id}">${consult.userName}</option>
			      	    			</c:if>
			      	    		</c:forEach>
		        			</select> --%>
		        			 <input type="hidden" name="userID" value="${cus.user.id}"/>
		        			<input type="text" readonly="readonly" value="${cus.user.userName }"/>
		        		</td>
		        	
		        		<td><label style="color:red;"></label>客户状态</td>
		        		<td>
		        			<select name="status" id="sta_id" class="status_sel_id" >
		        		<c:if test="${cus.status==1}"><option value="1">未跟进</option></c:if>
		        		<c:if test="${cus.status==2}"><option value="2">跟进-未上门</option></c:if>
		        		<c:if test="${cus.status==3}"><option value="3">跟进-已上门</option></c:if>
		        		<c:if test="${cus.status==4}"><option value="4">跟进-已报名</option></c:if>
		        		<c:if test="${cus.status==5}"><option value="5">不考虑</option></c:if>
		        		<c:if test="${cus.status!=1}"><option value="1">未跟进</option></c:if>
		        		<c:if test="${cus.status!=2}"><option value="2">跟进-未上门</option></c:if>
		        		<c:if test="${cus.status!=3}"><option value="3">跟进-已上门</option></c:if>
		        		<c:if test="${cus.status!=4}"><option value="4">跟进-已报名</option></c:if>
		        		<c:if test="${cus.status!=5}"><option value="5">不考虑</option></c:if>
			      	    		
		        			</select>
		        		</td>
		        		
		        	</tr>
		        	<tr>
		        	
		        		<td>咨询信息</td>
		        		<td colspan="6">
		        			<textarea rows="10" cols="60" name="consultContent" style="vetical-align:center;">${cus.consultContent}</textarea>
		        		</td>
		        		
		        	</tr>      
		        </tbody>
		    </table>
    	</form>
   
	   
	    <div class="tools" style="margin-top:20px;">
	    	<ul class="toolbar">
		        <li class="click" onclick="addVisit();">
		        	<span><img src="images/t01.png" /></span>添加回访
		        </li>
	        </ul>
	    </div>
	    
	    <table class="tablelist">
	    	<thead>
		    	<tr>
			        <th colspan="6" style="color:blue;">
			        	回访记录
			        </th>
		        </tr>
		        
		        <tr>
			        <th>编号</th>
			        <th>咨询师</th>
			        <th>回访时间</th>
			        <th>下次回访时间</th>
			        <th>回访主题</th>
			        <th>回访内容</th>
		        </tr>
	        </thead>
	        
	        <tbody>
		        <c:forEach items="${visiteds}" var="vt" varStatus="m">
		        <tr>
		        	 <td>${m.count+(currentPage-1)*5}</td>
		        	 <td>${vt.user.userName}</td>
		        	 <td>${vt.visitedTime}</td>
		        	 <td>${vt.nextVisitedTime}</td>
		        	 <td>${vt.title}</td>
		        	 <td>${vt.content}</td>
		       </tr>
		        	 </c:forEach>    
	        </tbody>
	    </table>
		<div class="pagin">
			<div class="message">
				共<i class="blue">${size }</i>条记录，当前显示第&nbsp;<i class="blue">${ currentPage}&nbsp;</i>页
			</div>
			<ul class="paginList">
			<input type="hidden" name="cusID" value=""/>
				<li class="paginItem"><a
					href="customer!getByID?cusID=${cus.id}&currentPage=${currentPage-1}">
						<span class="pagepre"></span>
				</a></li>
	
				<li class="paginItem"><a
					href="customer!getByID?cusID=${cus.id}&currentPage=${currentPage}">${currentPage}</a>
				</li>
				<c:if test="${currentPage<totalPage}">
				<li class="paginItem">
					<a	href="customer!getByID?cusID=${cus.id}&currentPage=${currentPage+1}"><span class="pagenex"></span></a>
				</li>
				</c:if>
				
			</ul>
		</div>
	        
	    <div class="tip" style="height:500px; width:800px; left:15%;">
    	  <div class="tiptop">
    		  <span id="tiptop_id">添加回访</span><a></a>
    	  </div>
    	  
    	  <span style="margin-left:30px; margin-top:10px;">
    	  	<label style="color:red; font-weight:bold;">注：</label>
    	  	带<label style="color:red;">*</label>为必填项
    	  </span>
    	  
	      <form id="visit_frm_id" method="post" action="visited!add" onsubmit="return checkForm();">  
		      <div class="tipinfo" style="height:330px;">
		        <li>
		        
		        <input type="hidden" name="customerId" value="${cus.id}"/>
		        		<input type="hidden" name="consulterId" value="${cus.user.id}"/>
	        		<div class="justifAlign">客户姓名：</div>
	        		<input id="cuName_id" name="customerName" class="customer_input" readonly="readonly" value="${cus.name}" />
	        		
	        		<label id="visitTips_id"></label>
	        	</li>
	        	<li>
	        		<div class="justifAlign">咨询师：</div>
	        		<input id="uname_id" name="" class="customer_input" readonly="readonly" value="${cus.user.userName}" />
	        		<input type="hidden" name="" value="25" />
	        	</li>
	  
	        	<li>
	        		<div class="justifAlign"><label style="color:red;">*</label>回访时间：</div>
	        		
	        		<input id="visitTime_id" name="visitedTime"  class="customer_input" value="" onfocus="WdatePicker({minDate:'1942-01-01 00:00:00', dateFmt:'yyyy-MM-dd HH:mm:ss'});" onblur="checkVisit(this.value);"/>
	        	</li>
	        	<li> 
	      	    	<div class="justifAlign">下次回访时间：</div>
	      	    	
	      	    	<input id="visitNextTime_id" name="nextVisitedTime"  class="customer_input" value="" onfocus="WdatePicker({minDate:'1942-01-01 00:00:00', dateFmt:'yyyy-MM-dd HH:mm:ss'});" />
	      	    </li>
	        	<li>
	        		<div class="justifAlign"><label style="color:red;">*</label>回访主题：</div>
	        		<input id="vtopic_id" name="title" class="customer_input" value="" />
	        	</li>
	        	
	      	    <li>
	      	    	<div class="justifAlign"><label style="color:red;">*</label>回访内容：</div>
	      	    	<textarea rows="10" cols="100" id="vcontent_id" name="content"></textarea>
	      	    </li> 
		      </div>
		        
	          <div class="tipbtn" style="margin-left:300px;">
		        <input type="submit"  class="sure" value="确定" />&nbsp;
		        <input type="reset"  class="cancel" value="重置" />
	          </div>
          </form>
	    </div>
    </div>
    
    <script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
  </body>
</html>
