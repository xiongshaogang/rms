<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				$("#searchForm").attr("action","${ctx}/report/sales/exportReletRate");
				$("#searchForm").submit();
				$("#searchForm").attr("action","${ctx}/report/sales/reletRate");
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function changeProject() {
			var project = $("[id='propertyProject.id']").val();
			var html = "<option value='' selected='selected'>全部</option>";
			if("" != project) {
				$.ajaxSetup({ cache: false });
				$.get("${ctx}/inventory/building/findList?id=" + project, function(data){
					for(var i=0;i<data.length;i++) {
						html += "<option value='"+data[i].id+"'>"+data[i].buildingName+"</option>";
					}
					$("[id='building.id']").html(html);
				});
			} else {
				$("[id='building.id']").html(html);
			}
			$("[id='building.id']").val("");
			$("[id='building.id']").prev("[id='s2id_building.id']").find(".select2-chosen").html("全部");
			
			$("[id='house.id']").html(html);
			$("[id='house.id']").val("");
			$("[id='house.id']").prev("[id='s2id_house.id']").find(".select2-chosen").html("全部");
			
			$("[id='room.id']").html(html);
			$("[id='room.id']").val("");
			$("[id='room.id']").prev("[id='s2id_room.id']").find(".select2-chosen").html("全部");
		}
		
		function buildingChange() {
			var building = $("[id='building.id']").val();
			var html = "<option value='' selected='selected'>全部</option>";
			if("" != building) {
				$.ajaxSetup({ cache: false });
				$.get("${ctx}/inventory/house/findList?id=" + building, function(data){
					for(var i=0;i<data.length;i++) {
						html += "<option value='"+data[i].id+"'>"+data[i].houseNo+"</option>";
					}
					$("[id='house.id']").html(html);
				});
			} else {
				$("[id='house.id']").html(html);
			}
			$("[id='house.id']").val("");
			$("[id='house.id']").prev("[id='s2id_house.id']").find(".select2-chosen").html("全部");
			
			$("[id='room.id']").html(html);
			$("[id='room.id']").val("");
			$("[id='room.id']").prev("[id='s2id_room.id']").find(".select2-chosen").html("全部");
		}
		
		function houseChange() {
			var room = $("[id='house.id']").val();
			var html = "<option value='' selected='selected'>全部</option>";
			if("" != room) {
				$.ajaxSetup({ cache: false });
				$.get("${ctx}/inventory/room/findList?id=" + room, function(data){
					for(var i=0;i<data.length;i++) {
						html += "<option value='"+data[i].id+"'>"+data[i].roomNo+"</option>";
					}
					$("[id='room.id']").html(html);
				});
			} else {
				$("[id='room.id']").html(html);
			}
			$("[id='room.id']").val("");
			$("[id='room.id']").prev("[id='s2id_room.id']").find(".select2-chosen").html("全部");
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="reletRateReport" action="${ctx}/report/sales/reletRate" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:message content="${message}" type="${messageType}"/>
		<ul class="ul-form">
			<li><label style="width:120px;">物业项目：</label>
				<form:select path="propertyProject.id" class="input-medium" style="width:190px;" onchange="changeProject()">
					<form:option value="" label="全部"/>
					<form:options items="${projectList}" itemLabel="projectName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>月份</th>
				<th>物业项目</th>
				<th>到期间数</th>
				<th>续租间数</th>
				<th>续租间数比</th>
				<th>到期合同数</th>
				<th>续租合同数</th>
				<th>续租合同比</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="reletRateReport">
			<tr>
				<td>
					${reletRateReport.expiredMonth}
				</td>
				<td>
					${reletRateReport.projectName}
				</td>
				<td>
					${reletRateReport.roomTotal}
				</td>
				<td>
					${reletRateReport.reletTotal}
				</td>
				<td>
					${reletRateReport.reletRate}
				</td>
				<td>
					${reletRateReport.contractTotal}
				</td>
				<td>
					${reletRateReport.reletContractTotal}
				</td>
				<td>
					${reletRateReport.reletContractRate}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>