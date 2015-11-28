<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>渠道管理</title>

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
	if(tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->


	<script type="text/javascript">
		// 页面加载后进行一些初始化
		$(document).ready(function(){
			  // 设置form表单的action为添加的action
			  

			  // 提示框的移动效果
			  eleMove_jquery($(".tip"));
			  
			  // 点击添加弹出添加的form表单
			  $(".click").click(function(){
				  $("#sel_li_id").removeClass("hidden");
				$(".tip").fadeIn(200);
			  });
		  
			  $(".tiptop a").click(function(){
			  	$(".tip").fadeOut(200);
			  });

			  
		  			
		});

		function checkChName(chName){
			// 没有输入渠道名称
			if (0 == chName.length) {
				$("#chNameTips_id").html("请输入渠道名称！");
				$("#chName_id").focus();
				return;
			}

			var url = "/crm1501/ajax/ajaxAction!isExistedChannelByChName.action";
			var param = "channel.chName=" + chName;

			$.ajax({
				url: url,
				data: param,
				dataType: "json",
				type: "post",
				cache: false,
				success: function(result) {
					if (result) {
						$("#chNameTips_id").html(result.tips);
					} else {
						$("#chNameTips_id").html("");
					}
				}
			});
		}

		function updateChannel(chId) {
			// 确认修改后
			if (confirm("是否确定修改该渠道信息？")) {
				$("#tiptop_id").html("修改渠道");
				// 查询该中心的数据的action
				var url = "channel!getByID";
				// 中心id
				var param = "chID=" + chId;
				// 使用ajax更新
				$.ajax({
					url: url,
					data: param,
					type: "post",
					success: function(results){
				
					var result =JSON.parse(results);
						// 如果有json数据返回
							$("#channel_frm_id")[0].action = "channel!update";

							// 显示查询到的数据
							$("#channel_sel_id").val(result.chan.parentName);
							$("#chName_id").val(result.chan.name);
							$("#status_sel_id").val(result.chan.status);
							$("#chId_id").val(result.chan.id);
							$("#sel_li_id").removeClass("hidden");
							// 显示修改的form表单
							$(".tip").fadeIn(200);
						
					}
				});
			}
		}

		function deleteChannel(chId) {
			if (confirm("是否确定删除该渠道吗？")) {
				location = "channel!delete?chId=" + chId;
			}
		}

		function checkForm () {
			if (0 == $("#chName_id").val().length) {
				alert("渠道名称不能为空！");
				$("#chName_id").focus();
				return false;
			}
			return true;
		}
	</script>
	
	<style type="text/css">
		.channel_input {
			width:180px;
			height:25px;
			border:1px solid #CED9DF;
			margin-left:10px;
		}
		
		.tipinfo li {
			height:30px;
		}
		
		.show {
			display:"";
		}
		
		.hidden {
			display:none;
		}
		
		#chNameTips_id {
			color:red;
		}
		
		.sel_channel {
			border:1px solid #CED9DF;
			margin-left:10px;
			width:180px;
			height:25px;
		}
	</style>
  </head>
  
  <body>
    <div class="place">
	    <span>位置：</span>
	    <ul class="placeul">
		    <li>
		    	<a href="#">营销管理</a>
		    </li>
		    <li>
		    	<a href="#">渠道管理</a>
		    </li>
	    </ul>
    </div>
    
    <div class="rightinfo">
	    <div class="tools">
	    	<ul class="toolbar">
		        <li class="click">
		        	<span><img src="images/t01.png" /></span>添加
		        </li>
	        </ul>
	    </div>
    
    
	    <table class="tablelist">
	    	<thead>
		    	<tr>
			        <th>
			        	编号<i class="sort">
			        	<img src="images/px.gif" />
			        	</i>
			        </th>
			        <th>渠道名称</th>
			        <th>渠道状态</th>
			        <th>父级渠道</th>
			        <th>操作</th>
		        </tr>
	        </thead>
	        
	        <tbody>
	        	
		        	<c:forEach items="${channels }" var="cl">
				        <tr>
					        <td>${cl.id }</td>
					        <td>${cl.name }</td>
					        <c:if test="${cl.status==1}"><td>启用</td></c:if>
					         <c:if test="${cl.status==0}"><td>禁用</td></c:if>
					        <td>${cl.parentChannel.name}</td>
					        
					        <td>
					        	<a href="javascript:void(0);" class="tablelink" onclick="updateChannel(${cl.id });">修改</a>     
					        	<a href="javascript:void(0);" class="tablelink" onclick="deleteChannel(${cl.id });"> 删除</a>
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
					href="channel?currentPage=${currentPage-1}">
						<span class="pagepre"></span>
				</a></li>
	
				<li class="paginItem"><a
					href="channel?currentPage=${currentPage}">${currentPage}</a>
				</li>
				<c:if test="${currentPage<totalPage}">
				<li class="paginItem">
					<a	href="channel?currentPage=${currentPage+1}"><span class="pagenext"></span></a>
				</li>
				</c:if>
				
			</ul>
		</div>
    
	    <div class="tip" style="height:220px;">
    	  <div class="tiptop">
    		  <span id="tiptop_id">添加渠道</span><a></a>
    	  </div>
    	  <span style="margin-left:30px; margin-top:10px;">
    	  	<label style="color:red; font-weight:bold;">注：</label>
    	  	带<label style="color:red;">*</label>为必填项
    	  </span>
	      <form id="channel_frm_id" method="post" action="channel!add" onsubmit="return checkForm();">  
		      <div class="tipinfo" style="padding-top:15px; margin-left:50px; height:75px;">
		      		<li>
		        		<label style="color:red;">*</label>渠道名称<input id="chName_id" name="name" class="channel_input" value="" onblur="checkChName(this.value);" />
		        		<label id="chNameTips_id"></label>
		        	</li>
		        	<li>
		        		<label style="color:red;">*</label>父级渠道<select id="channel_sel_id" class="sel_channel" name="parentID" onchange="this.value()">
		        			
		        				<option value="0">无父级渠道</option>
		        		
							<c:forEach items="${parentChannels}" var="pt">
							<option value="${pt.id }">${pt.name}</option>
							</c:forEach>
								
		        		</select>
		        	</li>
		      	    <li id="sel_li_id" class="hidden">
		      	    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label style="color:red;">*</label>状态<select id="status_sel_id"  class="sel_channel" name="status">
		      	    		<option value="1">可用</option>
		      	    		<option value="0">不可用</option>
		      	    	  </select>
		      	    </li>
		      	    <li class="hidden">
		      	   		<input id="chId_id" type="hidden" name="id" class="channel_input" value="${pt.id }" />
		      	    </li>
		      </div>
		        
	          <div class="tipbtn" style="margin-top:20px;">
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
	