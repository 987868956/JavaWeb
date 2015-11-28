<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>中心管理</title>

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
	


<link href="/crm1501/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/crm1501/js/jquery.js"></script>
<script type="text/javascript" src="/crm1501/js/index.js"></script>
<script type="text/javascript" src="/crm1501/js/select-ui.min.js"></script>
<script language="javascript" type="text/javascript" src="/crm1501/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	// 每次检查是否有提示信息,有就弹出
	var tip = "";
	if(tip) {
		alert(tip);
	}
</script>
<!-- 弹出完毕后，清除session的提示 -->


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript" src="/crm1501/js/jsapi.js"></script>
	<script type="text/javascript" src="/crm1501/js/format+zh_CN,default,corechart.I.js"></script>		
	<script type="text/javascript" src="/crm1501/js/jquery.gvChart-1.0.1.min.js"></script>
	<script type="text/javascript" src="/crm1501/js/jquery.ba-resize.min.js"></script>
	
	<script type="text/javascript">
		gvChartInit();
		jQuery(document).ready(function(){
		window.location.href="customer";
			// 提示框的移动效果
			eleMove_jquery($(".tip"));
			
			jQuery('#myTable5').gvChart({
					chartType: 'PieChart',
					gvSettings: {
						vAxis: {title: 'No of players'},
						hAxis: {title: 'Month'},
						width: 650,
						height: 250
						}
				});
		});

		function showVisit(cuId, obj) {
			$(obj).css("cursor", "pointer");
			var url = "/crm1501/ajax/ajaxAction!queryVisitByCuid.action";
			var param = "customer.cuId=" + cuId;

			$.ajax({
				url: url,
				data: param,
				type: "post",
				dataType: "json",
				cache: false,
				success: function (result) {
				    var temp = "该客户没有预约下次回访，继续努力哦";
					if (result) {
						if (result.visit) {
							var nextTime = result.visit.vnextTime.replace("T", " ");
							var contentTip = "该客户的下次回访时间为：<label style=\"font-weight:bold;\">" + nextTime + "</label>";
							$("#visit_id").html(contentTip);
						} else {
							$("#visit_id").html(temp);
						}
					} else {
						$("#visit_id").html(temp);
					}

					$(".tip").fadeIn(200);
				}

			});
		}

		function hideVisit(obj) {
			$(obj).css("cursor", "default");
			$(".tip").fadeOut(200);
		}

		function gotoCustInfor(cuId, obj){
			$(".tip").fadeOut(200);
			if (confirm("是否确认跳到客户信息页面？")) {
				location = "customer!getByID?cusID=" + cuId;
			}
		}
	</script>
  </head>
  
  <body>
   <div class="place">
	    <span>位置：</span>
	    <ul class="placeul">
	    <li><a href="#">主页</a></li>
	    <li><a href="#">工作台</a></li>
	    </ul>
    </div>
    
    
    <div class="mainbox">
    	<div class="mainleft">
    		<div class="leftinfo">
    			<div class="maintj">
    				<div class="listtitle" style="text-align:left;">
    					数据统计
    					
    				</div>    
    				<img  src="index!picture"/>
    			</div>
    		</div>
    	<!--leftinfo end-->
    	<div class="leftinfos">
	    	<div class="infoleft">
			    <div class="listtitle">
					待办事项
				</div>    
			    <table class="tablelist">
			    	<thead>
				    	<tr>
					        <th>
					        	姓名
								<i class="sort">
					        		<img src="images/px.gif" />
					        	</i>
					        </th>
					        <th>联系电话</th>
					        <th>毕业院校</th>
					        <th>专业</th>
					        <th>客户状态</th>
				        </tr>
			        </thead>
			        
			        <tbody>
			        	
				        	<c:forEach items="${items}" var="its">
						        <tr onclick="gotoCustInfor(${its.id}, this);" style="cursor:pointer;">
							        <td onmouseover="showVisit(1, this);" onmouseout="hideVisit(this);">${its.name }</td>
							        <td>${its.telephone}</td>
							        <td>${its.schoolName}</td>
							          <td>${its.major}</td>
							        <td>
						<c:if test="${its.status==1}"><option value="1">未跟进</option></c:if>
		        		<c:if test="${its.status==2}"><option value="2">跟进-未上门</option></c:if>
		        		<c:if test="${its.status==3}"><option value="3">跟进-已上门</option></c:if>
		        		<c:if test="${its.status==4}"><option value="4">跟进-已报名</option></c:if>
		        		<c:if test="${its.status==5}"><option value="5">不考虑</option></c:if>
							        </td>
						        </tr>
						     </c:forEach>    
				        
				               
			        </tbody>
			    </table>
		    
		   
			    <div class="pagin">
			    	
			       
			    </div>
		    </div>
    
	    	<div class="inforight">
	    		<div class="listtitle">
					已办事项
				</div>
			    <table class="tablelist">
			    	<thead>
				    	<tr>
					        <th>
					        	姓名
					        	<i class="sort">
					        	<img src="images/px.gif" />
					        	</i>
					        </th>
					        <th>联系电话</th>
					        <th>毕业院校</th>
					        <th>专业</th>
					        <th>客户状态</th>
				        </tr>
			        </thead>
			        
			        <tbody>
			        	
				        	<c:forEach items="${Mitems}" var="mit">
						        <tr onclick="gotoCustInfor(${mit.id}, this);" style="cursor:pointer;">
							         <td onmouseover="showVisit(1, this);" onmouseout="hideVisit(this);">${mit.name }</td>
							        <td>${mit.telephone}</td>
							        <td>${mit.schoolName}</td>
							        <td>${mit.major}</td>
							        <td>
							        			<c:if test="${mit.status==1}"><option value="1">未跟进</option></c:if>
		        		<c:if test="${mit.status==2}"><option value="2">跟进-未上门</option></c:if>
		        		<c:if test="${mit.status==3}"><option value="3">跟进-已上门</option></c:if>
		        		<c:if test="${mit.status==4}"><option value="4">跟进-已报名</option></c:if>
		        		<c:if test="${mit.status==5}"><option value="5">不考虑</option></c:if>
							        </td>	
						        </tr>
						    </c:forEach>     
				        
				               
			        </tbody>
			    </table>
		    
		   
			    <div class="pagin">
			    	
			    </div>
			</div>
    	</div>
    </div>
    <div class="tip" style="height:120px; width:360px;">
    	  <div class="tiptop">
    		  <span id="tiptop_id">
    		  	回访预约
    		  </span><a href="javascript:void(0);" onclick="hideVisit();"></a>
    	  </div>
    	  <span style="margin-left:50px; margin-top:30px;" id="visit_id">
    	  	该客户的下次回访时间为：<label style="font-weight:bold;" id="visitTime_id"></label>
    	  </span>
	</div>
	    
	    <!--mainleft end-->
	    <div class="mainright">
		    <div class="dflist">
			    <div class="listtitle">
			    	最新信息
			    </div>    
			    <ul class="newlist">
			    	
			    		<li><a href="#">思诚继新年后动后初夏惊喜再来袭</a></li>
					    <li><a href="#">Seecen,we are family!</a></li>
					    <li><a href="#">在思诚，我们这样玩</a></li>
					    <li><a href="#">SC1503实训营第一阶段项目评审之初体验</a></li>
					    <li><a href="#">SC1503实训营第二阶段项目评审圆满成功</a></li>
					    <li><a href="#">地震救援，互联网公司都做了什么？</a></li>
					    <li><a href="#">看好还是拍砖，亲临实训现场说了才算</a></li>
			    	
			    	
			    </ul>        
		    </div>
	    	
		    <div class="dflist1">
			    <div class="listtitle">
			    	数据统计
			    </div>    
			    <ul class="newlist">
				    <li><label style="font-weight:bold;">
				    今日待跟进
					</label>：<label style="color:red;">${readySize}</label>人</li>
				    <li>本月未上门量：<label style="color:red;">${Mitems.size()}</label>人</li>
				    <li>本月已上门量：<label style="color:red;">${doorSize}</label>人</li>
				    
				    
				    	<li>本月上门率：<label style="color:red;">0.0%</label></li>
				    
				    <li>本月未报名量：<label style="color:red;">4</label>人</li>
				    <li>本月已报名量：<label style="color:red;">0</label>人</li>
				    
				    
				    	<li>本月报名率：<label style="color:red;">0.0%</label></li>
				            
			    </ul>        
		    </div>
	    </div>
    <!--mainright end-->
    </div>

</body>
<script type="text/javascript">
	setWidth();
	$(window).resize(function(){
		setWidth();	
	});
	function setWidth(){
		var width = ($('.leftinfos').width()-12)/2;
		$('.infoleft,.inforight').width(width);
	}
</script>
</html>
