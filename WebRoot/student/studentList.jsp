<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>学员信息</title>
    
	<link href="../css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/select-ui.min.js"></script>
	<script language="javascript" type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		// 每次检查是否有提示信息,有就弹出
		var tip = "";
		if(tip) {
			alert(tip);
		}
	</script>
	<!-- 弹出完毕后，清除session的提示 -->
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="/crm1501/css/style.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript">
		$(document).ready(function(){
			// 好看的select插件
			  
			$("#classCX").change(function(){
				var yyb=$("#classCX").attr("selectde",true).val();
				location="student?theclassId="+yyb;
			});

			// 修改按钮
			$("#updateClick").click(function() {
				var chks = $(":checkbox[name='ids']:checked");
				if (chks.size() != 1) {
					$("#click").html("请选择一条要修改的数据");
					$("#myTip").fadeIn(200);
				} else {
					// 开始异步请求获取数据
					ajaxUserById(chks.val());
				}
			});
			//删除按钮
			$("#deleteClick").click(function() {
				if (confirm("确定要删除吗？数据无价哦！")) {
					var chks = $(":checkbox[name='ids']:checked");
					if (chks.size() == 0) {
						$("#click").html("请选择要删除的数据");
						$("#myTip").fadeIn(200);
					} else {
						var url = "/student!delete?";
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
				if ($("#sid").val() != "") {
					var yyb = 1;
					var chks = $(":checkbox[name='ids']:checked");
					$(chks).each(function() {
						yyb = this.value;
					});
					this.action = "student!update?cid=" + yyb;
				}
				return true;
			});
		});

		function look(id) {
			var url = "student!findById";
			var data = "id=" + id;

			$.post(url, data, function(u) {
				$("#cuid").val(u.student.classId.id);
				$("#sname").val(u.student.name);

				$("#birthday").val(u.student.birthDateStr);
				$("#sname").val(u.student.classId.className);
				$("#class>option[value='" + u.student.classId.id + "']").attr(
						"selected", true);

				$(":radio[name='sex'][value='" + u.student.sex + "']").attr(
						"checked", true);

				$("#school").val(u.student.college);
				$("#xueli").val(u.student.education);

				$("#native").val(u.student.origin);
				$("#tel").val(u.student.telephone);
				$("#tel").attr("readonly", true);
				$("#zhuanye").val(u.student.major);

				$("#qr").hide();
				$("#addTip").fadeIn(200);
			}, "json");
		}

		function ajaxUserById(id) {
			var url = "student!findById";
			var data = "id=" + id;

			$.post(url, data, function(u) {
				$("#sid").val(u.student.id);
				$("#cuid").val(u.student.classId.id);
				$("#sname").val(u.student.name);

				$("#birthday").val(u.student.birthDateStr);
				$("#sname").val(u.student.classId.className);
				$("#class>option[value='" + u.student.classId + "']").attr(
						"selected", true);
				
				$(":radio[name='sex'][value='" + u.student.sex + "']").attr(
						"checked", true);

				$("#school").val(u.student.college);
				$("#xueli").val(u.student.education);

				$("#native").val(u.student.origin);
				$("#tel").val(u.student.telephone);
				$("#tel").attr("readonly", false);
				$("#zhuanye").val(u.student.major);

				$("#qr").show();
				$("#addTip").fadeIn(200);
			}, "json");
		}
	</script>

  </head>
  
  <body>
    <div class="place">
	    <span>位置：</span>
	    <ul class="placeul">
		    <li>
		    	<a href="/crm1501/null?subUrl=null">
		    		
					学员管理
				</a>
		    </li>
		    <li>
		    	<a href="#" id="subItem_id">学员基本信息</a>
		    </li>
	    </ul>
    </div>
    
    <div class="rightinfo">
	    <div class="tools">
	    	<ul class="toolbar">
	        <li id="updateClick" class="click"><span><img src="../images/t02.png" /></span>修改</li>
	        
	        <li style="width:120px;margin-left: 20px;">
	        	<select style="width:100px;height: 23px;margin-left: 15px;" id="classCX">
	        		<c:forEach items="${cs}" var="c">
	        			<option value="${c.id }">${c.className }</option>
	        		</c:forEach>
	        	</select>
	        </li>
	        </ul>
	    </div>
	    <table class="tablelist">
	    	<thead>
		    	<tr>
		    		<th></th>
		    		<th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
			        <th>学员姓名</th>
	    			<th>所在班级</th>
	    			<th>性别</th>
	    			<th>出生日期</th>
	    			<th>毕业院校</th>
	    			<th>学历</th>
	    			<th>专业</th>
	    			<th>电话</th>
	    			<th>籍贯</th>
	    			<th>操作</th>
		        </tr>
	        </thead>
	        
	        <tbody>
		        	<%int i=0; %>
	    			<c:forEach items="${students }" var="s">
	    			<%i=i+1; %>
	    			<tr>
	    				<td><input name="ids" type="checkbox" value="${s.id }" /></td>
	    				<td><%=i %></td>
		    			<td>${s.name }</td>
		    			<td>${s.classId.className }</td>
		    			<td>${s.sex }</td>
		    			<td><fmt:formatDate value="${s.birthDate }" pattern="yyyy-MM-dd"/></td>
		    			<td>${s.college }</td>
		    			<td>${s.education }</td>
		    			<td>${s.major }</td>
		    			<td>${s.telephone }</td>
		    			<td>${s.origin }</td>
		    			<td><input type="button" value="查看" onclick="look(${s.id})"/></td>
	    			</tr>
	    			</c:forEach>
    			
	        </tbody>
	    </table>
    
   
	    <div class="pagin">
	    	<div class="message">共<i class="blue">${count}</i>条记录，当前显示第&nbsp;<i class="blue">${currentPage}&nbsp;</i>页</div>
	        <ul class="paginList">
		        <li class="paginItem"><a href="student?currentPage=${currentPage-1}"><span class="pagepre"></span></a></li>
		        
		        	<li class="paginItem"><a href="student">1</a></li>
		        
		        <li class="paginItem"><a href="student?currentPage=${currentPage+1}"><span class="pagenxt"></span></a></li>
		        <!-- <li class="paginItem more"><a href="javascript:;">...</a></li> -->
	        </ul>
    	</div>
    
    	<div class="tip">
	    	<div class="tiptop"><span>提示信息</span><a></a></div>
	    	<div class="tipinfo">
	        <span><img src="../images/ticon.png" /></span>
	        <div class="tipright">
	        <p>是否确认对信息的修改 ？</p>
	        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
	        </div>
	        </div>
	        <div class="tipbtn">
	        <input name="" type="button"  class="sure" value="确定"/>&nbsp;
	        <input name="" type="button"  class="cancel" value="取消" />
	        </div>
	    </div>
	    
	    <div id="myTip" class="tip">
	    	<div class="tiptop"><span>提示信息</span><a></a></div>
	    	<div class="tipinfo">
	        <span><img src="../images/ticon.png" /></span>
	        <div id="click" class="tipright">
	        	
	        </div>
	        </div>
	        <div class="tipbtn">
	        <input id="cancel" name="" type="button" class="sure" value="确定" />
	        </div>
	    </div>
    
	    <!-- 添加用户 -->
	    <div id="addTip" class="tip addUser" >
	    	<!-- 提示部分 -->
	    	<div class="tiptop"><span>信息</span><a></a></div>
	    	<!-- 正文部分 -->
	    	<div id="addContent" class="formbody">
			    <div class="formtitle"><span>基本信息</span></div>
			    <form id="fm"  method="post">
			    <table class="addTab" cellpadding="5">
			    	<tr>
			    		<td class="td_name">姓名</td>
			    		<td>
			    		<input type="hidden" id="cuid" name="student.customer.cuId">
			    		<input type="hidden" id="time" name="student.time">
			    		
			    		<input type="text" name="name" readonly="readonly" id="sname" class="scinput"/>
			    		</td>
			    		
			    		<td class="td_class">班级</td>
			    		<td>
			    			<select name="course" id="class" class="select2">
									<c:forEach items="${cs }" var="c">
										<option value="${c.id }">${c.className }</option>
									</c:forEach>
							</select></td>
			    		
			    		<td class="td_name">性别</td>
			    		<td>
			    			<input type="radio" name="sex" id="gender1" value="男" disabled="disabled"/><label for="gender1">男</label>
							<input type="radio" name="sex" id="gender0" value="女" disabled="disabled"/><label for="gender0">女</label>

			    		</td>
			    		
			    	</tr>
			    	
			    	<tr>
			    	
			    		<td width="60" class="td_lable">出生日期</td>
			    		<td><input type="text" name="birthDateStr" value="" readonly="readonly" id="birthday" class="scinput"/></td>
			    		
			    		<td width="60" class="td_lable">毕业院校</td>
			    		<td>
			    			<input type="text" name="college" value="" readonly="readonly" id="school" class="scinput"/>
			    		</td>
			    		
			    		<td class="td_lable">学历</td>
			    		<td>
			    			<input type="text" name="education" value="" readonly="readonly" id="xueli" class="scinput"/>
			    		</td>
			    	</tr>
			    	
			    	<tr>
			    		<td class="td_lable">专业</td>
			    		<td><input type="text" name="major" value="" readonly="readonly" id="zhuanye" class="scinput"/></td>
			    		
			    		<td class="td_lable">籍贯</td>
			    		<td><input type="text" name="origin" value="" readonly="readonly" id="native" class="scinput"/></td>
			    		
			    		<td class="td_lable">电话</td>
			    		<td><input type="text" name="telephone" value="" id="tel" class="scinput" readonly="readonly"/></td>
			    		
			    	</tr>
			    	<tr>
			    		<td align="center" colspan="6">
			    		<input type="hidden" name="student.sid" value="" id="sid"/>
			    		<input name="" type="submit" class="btn" value="确认保存" id="qr"/>
			    		<input name="" type="button" class="cancel" value="取消"/>
			    		</td>
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
