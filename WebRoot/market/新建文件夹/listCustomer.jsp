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
	<script type="text/javascript">
	
	
		$(document).ready(function(){

			  // 提示框的移动效果
			  eleMove_jquery($(".tip"));
			  
			  $(".click").click(function(){
			  	$(".tip").fadeIn(200);
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

			  
			

			// 设置form表单的action为添加的action
			  

			  

			  var roleName = "管理员";
			  
			  if (roleName == "超级管理员" || roleName == "管理员") {
				  $(".tools").removeClass("hidden");
				  $(".toolbar").removeClass("hidden");
				  $(".toolbar1").removeClass("hidden");
			  } else if (roleName == "前台") {
				  $(".tools").removeClass("hidden");
				  $(".toolbar").removeClass("hidden");
				  $(".toolbar1").addClass("hidden");
			  } else {
				  $(".tools").addClass("hidden");
				  $(".toolbar").removeClass("hidden");
				  $(".toolbar1").removeClass("hidden");
			  }

			 
		});
		
		function test() {

		$.ajax({
			type:"POST",
			url:"customer!findProvince",
			data:"",
			success:function(msg){
				var results=JSON.parse(msg);
				if(results.result==0){
					var provinces=results.province;
					$("#province").get(0).options[0]=new Option("请选择",0);
					$("#province").get(0).options.length=provinces.length+1;
					for(var i=0;i<province.length;i++){
						$("#province").get(0).options[i+1]=new Option(provinces[i].proName,provinces[i].proId);
					}
				}
			}
		
		});
		}
		function changeCity(){
		var pid=$("#province").val();
		$.ajax({
				type:"post",
				url:"customer!findCity",
				data:"pid="+pid,
				success:function(msg){
					var results=JSON.parse(msg);
					if(results.result==0){
						var citys=results.citys;
						$("#city").get(0).options[0]=new Option("请选择",0);
						$("#city").get(0).options.length=citys.length+1;
						for(var i=0;i<citys.length;i++){
							$("#city").get(0).options[i+1]=new Option(citys[i].cityName,citys[i].cid);
						}
						
					}
				}
				}
			);
		}
			
		function checkForm() {
			if (0 == $("#cuName_id").val().length) {
				alert("客户姓名不能为空，请输入客户姓名！");
				$("#cuName_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}

			

			if (0 == $("#cuMobile_id").val().length) {
				alert("客户手机号码不能为空，请输入客户手机号码！");
				$("#cuMobile_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}

			if (0 == $("#cuSchool_id").val().length) {
				alert("客户毕业院校不能为空，请输入客户毕业院校！");
				$("#cuSchool_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}

			if (0 == $("#cuContent_id").val().length) {
				alert("客户咨询内容不能为空，请输入客户咨询内容！");
				$("#cuContent_id").focus();
				$(".tip").fadeIn(200);
				return false;
			}

			return true;
		}

		function deleteCustomer(cuId) {
			if (confirm("确认删除该客户吗？")) {
				location = "customer!delete?cusID=" + cuId;
			}
		}
		

		function editCustomer(cuId) {
			if (confirm("确认编辑该客户信息吗？")) {
				location = "customer!getByID?cusID=" + cuId;
			}
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
			width:220px;
			height:30px;
			float:left;
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
		
		#cuContent_id {
			border:1px solid #CED9DF;
			margin-left:10px;
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
		    	<a href="#" id="subItem_id">客户基本内容</a>
		    </li>
	    </ul>
    </div>
    
    <div class="rightinfo">
    
	    <div class="tools">
	    
	    	<ul class="toolbar">
		        <li class="click" onclick="test()">
		        	<span><img src="images/t01.png" /></span>添加
		        </li>
		         </ul>
		         <ul class="toolbar">
		        <form action="customer" method="post">
				<li>姓名<input style="height:25px;" type="text" name="Cname"  value="${Cname}"/></li>
				<li>院校<input style="height:25px;" type="text" name="CschoolName" value="${CschoolName }"/></li>
				<input type="submit"  style="height:38px;width:40px" value="查询"/>
				</form>
	        </ul>
	        
	        
	       
	    </div>
    
    
	    <table class="tablelist">
	    	<thead>
		    	<tr>
		    	<td>序号</td>
			        <th>
			        	姓名<i class="sort">
			        	<img src="images/px.gif" />
			        	</i>
			        </th>
			         <th>性别</th>
			        <th>电话</th>
			        <th>院校</th>
			        <th>创建时间</th>
			        <th>咨询师</th>
			        <th>所在城市</th>
			        <th>中心</th>
			        <th>渠道</th>
			        <th>状态</th>
			        <th>意向</th>
			        <th>操作</th>
		        </tr>
	        </thead>
	        
	        <tbody>
	        	
		        	<c:forEach items="${customers }" var="custo" varStatus="t">
				        <tr>
				        	<td>${t.count+(currentPage-1)*5}</td>
					        <td>${custo.name}</td>
					        <td>${custo.sex}</td>
					        <td>${custo.telephone}</td>
					        <td>${custo.schoolName}</td>
					        <td>${custo.createTime}</td>
					        <td>${custo.user.userName}</td>
					        <td>${custo.location}</td>
					        <td>${custo.centre.cname}</td>
					        <td>${custo.channel.name}</td>
					        <c:if test="${custo.status==1}"><td>未跟进 </td></c:if>
					        <c:if test="${custo.status==2}"><td>已跟进-未上门</td></c:if>
					        <c:if test="${custo.status==3}"><td>已跟进-已上门</td></c:if>
					        <c:if test="${custo.status==4}"><td>已跟进-已报名</td></c:if>
					        <c:if test="${custo.status==5}"><td></td>不考虑</c:if>
					        
					        <c:if test="${custo.intention==1}"><td>积极</td></c:if>
					        <c:if test="${custo.intention==2}"><td>考虑</td></c:if>
					        <c:if test="${custo.intention==3}"><td>拒绝</td></c:if>
					        <td>
					        		<a href="javascript:void(0);" class="tablelink" onclick="editCustomer(${custo.id});">编辑</a>
					        	
					        	     
					        	<a href="javascript:void(0);" class="tablelink" onclick="deleteCustomer(${custo.id});"> 删除</a>
					        </td>
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
					href="customer?Cname=${Cname}&CschoolName=${CschoolName}&currentPage=${currentPage-1}">
						<span class="pagepre"></span>
				</a></li>
	
				<li class="paginItem"><a
					href="customer?Cname=${Cname}&CschoolName=${CschoolName}&currentPage=${currentPage}">${currentPage}</a>
				</li>
				<c:if test="${currentPage<totalPage}">
				<li class="paginItem">
					<a	href="customer?Cname=${Cname}&CschoolName=${CschoolName}&currentPage=${currentPage+1}"><span class="pagenext"></span></a>
				</li>
				</c:if>
				
			</ul>
		</div>
    
    
	    <div class="tip" style="height:500px; width:800px; left:15%;">
    	  <div class="tiptop">
    		  <span id="tiptop_id">新增客户</span><a ></a>
    	  </div>
    	  <span style="margin-left:30px; margin-top:10px;">
    	  	<label style="color:red; font-weight:bold;">注：</label>
    	  	带<label style="color:red;">*</label>为必填项
    	  </span>
	      <form id="customer_frm_id" method="post" action="customer!add" onsubmit="return checkForm();">  
		      <div class="tipinfo" style="height:330px;">
		        <li>
	        		<label style="color:red;">*</label>姓名：<input id="cuName_id" name="name" class="customer_input" value="" />
	        		<label id="cuNameTips_id"></label>
	        	</li>
	        	
	  
	        	<li>
	        		<label style="color:red;">*</label>手机号码：<input id="cuMobile_id" name="telephone"  class="customer_input" value="" />
	        	</li>
	        	<li>
	      	    	<label style="color:red;">*</label>性别：<select class="status_sel_id" name="sex">
	      	    		<option value="男">男</option>
	      	    		<option value="女">女</option>
	      	    	  </select>
	      	    </li>
	        	<li>
	        		QQ：<input id="cuQq_id" name="qq" class="customer_input" value="" />
	        	</li>
	        	
	      	    
	      	   
	      	    <li>
	      	                               渠道：<select class="status_sel_id" name="channelId">
	      	    		
	      	    			<c:forEach items="${channels}" var="ct">
	      	    			<option value="${ct.id}">${ct.name}</option>
	      	    			</c:forEach>
	      	    		
	      	    	  </select>
	      	    </li>
	      	    <li>
	        		<label style="color:red;">*</label>毕业院校：<input id="cuSchool_id" name="schoolName" class="customer_input" value="" />
	        	</li>
	        	<li>
	      	                               所在城市：<select class="status_sel_id"  id="province" onchange="changeCity()"">
	      	                            
	      	    	  </select>
	      	    	  <select class="status_sel_id" name="locationID" id="city">
	      	                             
	      	    	  </select>
	      	    </li>
	      	    <li>
	      	            <label style="color:red;">*</label>所属中心：<select class="status_sel_id" name="centreId">
	      	    		<c:forEach items="${centres}" var="ct">
	      	    			<option value="${ct.cid}">${ct.cname}</option>
	      	    		</c:forEach>
	      	    			
	      	    	  </select>
	      	    </li>
	      	    
	      	    <li>
	      	          <label style="color:red;">*</label> 咨询师：<select class="status_sel_id" name="userId">
	      	    		
	      	    			<c:forEach items="${consulters}" var="cst">
	      	    			<option value="${cst.id}">${cst.userName}</option>
	      	    		</c:forEach>
	      	    		
	      	    	  </select>
	      	    </li>
	      	    <li>
	      	            <label style="color:red;">*</label>客户意向：<select class="status_sel_id" name="intention">
	      	    			<option value="1">积极</option>
	      	    			<option value="2">考虑</option>
	      	    			<option value="3">拒绝</option>
	      	    	  </select>
	      	    </li>
	      	 
	      	    <li style="clear:both;">
	        		<label style="color:red;">*</label>咨询内容：<textarea rows="10" cols="60" id="cuContent_id" name="consultContent" value="" ></textarea>
	        		<label id="cuContentTips_id" class="intention_tip"></label>
	        	</li>
	      	  
		      </div>
		        
	          <div class="tipbtn" style="margin-left:300px;">
		        <input type="submit"  class="sure" value="确定" />&nbsp;
		        <input type="reset"  class="cancel" value="重置" />
	          </div>
          </form>
	    </div>
    </div>
    <div style ="color:red" >
    <s:fielderror />
</div >
    
    <script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
  </body>
</html>
