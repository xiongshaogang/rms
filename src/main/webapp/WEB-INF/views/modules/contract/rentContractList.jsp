<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>出租合同管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
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
		function toAudit(id) {
			var html = "<table style='margin:20px;'><tr><td><label>审核意见：</label></td><td><textarea id='auditMsg'></textarea></td></tr></table>";
			var content = {
		    	state1:{
					content: html,
				    buttons: { '同意': 1, '拒绝':2, '取消': 0 },
				    buttonsFocus: 0,
				    submit: function (v, h, f) {
				    	if (v == 0) {
				        	return true; // close the window
				        } else if(v==1){
				        	saveAudit(id,'1');
				        } else if(v==2){
				        	saveAudit(id,'2');
				        }
				        return false;
				    }
				}
			};
			$.jBox.open(content,"审核",350,220,{});
		}
		
		function saveAudit(id,status) {
			loading('正在提交，请稍等...');
			var msg = $("#auditMsg").val();
			window.location.href="${ctx}/contract/rentContract/audit?objectId="+id+"&auditMsg="+msg+"&auditStatus="+status;
		}
		
		function auditHis(id) {
			$.jBox.open("iframe:${ctx}/contract/leaseContract/auditHis?objectId="+id,'审核记录',650,400,{buttons:{'关闭':true}});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/contract/rentContract/">出租合同列表</a></li>
		<shiro:hasPermission name="contract:rentContract:edit"><li><a href="${ctx}/contract/rentContract/form">出租合同添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="rentContract" action="${ctx}/contract/rentContract/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<!-- <li><label>原出租合同：</label>
				<form:input path="contractId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li> -->
			<li><label style="width:120px;">合同名称：</label>
				<form:input path="contractName" htmlEscape="false" maxlength="100" class="input-medium" style="width:195px;"/>
			</li>
			<li><label style="width:120px;">出租方式：</label>
				<form:select path="rentMode" class="input-medium" style="width:210px;">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('rent_mode')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">物业项目：</label>
				<form:select path="propertyProject.id" class="input-medium" style="width:210px;" onchange="changeProject()">
					<form:option value="" label="全部"/>
					<form:options items="${projectList}" itemLabel="projectName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">楼宇：</label>
				<form:select path="building.id" class="input-medium" style="width:210px;" onchange="buildingChange()">
					<form:option value="" label="全部"/>
					<form:options items="${buildingList}" itemLabel="buildingName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">房屋：</label>
				<form:select path="house.id" class="input-medium" style="width:210px;" onchange="houseChange()">
					<form:option value="" label="全部"/>
					<form:options items="${houseList}" itemLabel="houseNo" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">房间：</label>
				<form:select path="room.id" class="input-medium" style="width:210px;">
					<form:option value="" label="全部"/>
					<form:options items="${roomList}" itemLabel="roomNo" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">销售：</label>
				<sys:treeselect id="user" name="user.id" value="${rentContract.user.id}" labelName="user.name" labelValue="${rentContract.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true" cssStyle="width:150px;"/>
			</li>
			<li><label style="width:120px;">合同来源：</label>
				<form:select path="contractSource" class="input-medium" style="width:210px;">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('contract_source')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">月租金：</label>
				<form:input path="rental" htmlEscape="false" class="input-medium" style="width:195px;"/>
			</li>
			<li><label style="width:120px;">合同生效时间：</label>
				<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${rentContract.startDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:196px;"/>
			</li>
			<li><label style="width:120px;">合同过期时间：</label>
				<input name="expiredDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${rentContract.expiredDate}" pattern="yyyy-MM-dd、"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:196px;"/>
			</li>
			<li><label style="width:120px;">合同签订时间：</label>
				<input name="signDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${rentContract.signDate}" pattern="yyyy-MM-dd、"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:196px;"/>
			</li>
			<li><label style="width:120px;">合同状态：</label>
				<form:select path="contractStatus" class="input-medium" style="width:210px;">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('rent_contract_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label style="width:120px;">合同业务状态：</label>
				<form:select path="contractBusiStatus" class="input-medium" style="width:210px;">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('rent_contract_busi_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!--<th>原出租合同</th>-->
				<th>合同名称</th>
				<th>出租方式</th>
				<th>物业项目</th>
				<th>楼宇</th>
				<th>房屋</th>
				<th>房间</th>
				<th>销售</th>
				<th>合同来源</th>
				<th>月租金</th>
				<th>合同生效时间</th>
				<th>合同过期时间</th>
				<th>合同签订时间</th>
				<th>合同状态</th>
				<th>合同业务状态</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="contract:rentContract:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="rentContract">
			<tr>
				<!--<td><a href="${ctx}/contract/rentContract/form?id=${rentContract.id}">
					${rentContract.contractId}
				</a></td>-->
				<td>
					<a href="${ctx}/contract/rentContract/form?id=${rentContract.id}">
					${rentContract.contractName}
					</a>
				</td>
				<td>
					${fns:getDictLabel(rentContract.rentMode, 'rent_mode', '')}
				</td>
				<td>
					${rentContract.projectName}
				</td>
				<td>
					${rentContract.buildingBame}
				</td>
				<td>
					${rentContract.houseNo}
				</td>
				<td>
					${rentContract.roomNo}
				</td>
				<td>
					${rentContract.user.name}
				</td>
				<td>
					${fns:getDictLabel(rentContract.contractSource, 'contract_source', '')}
				</td>
				<td>
					${rentContract.rental}
				</td>
				<td>
					<fmt:formatDate value="${rentContract.startDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${rentContract.expiredDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${rentContract.signDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(rentContract.contractStatus, 'rent_contract_status', '')}
				</td>
				<td>
					${fns:getDictLabel(rentContract.contractBusiStatus, 'rent_contract_busi_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${rentContract.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${rentContract.remarks}
				</td>
				<shiro:hasPermission name="contract:rentContract:edit"><td>
					<c:if test="${rentContract.contractStatus=='3'}">
    					<a href="${ctx}/contract/rentContract/form?id=${rentContract.id}">修改</a>
					</c:if>
					<c:if test="${rentContract.contractStatus=='2'}">
    					<a href="javascript:void(0);" onclick="toAudit('${rentContract.id}')">审核</a>
					</c:if>
					<c:if test="${rentContract.contractStatus=='6' && rentContract.contractBusiStatus=='0'}">
    					<a href="${ctx}/contract/rentContract/returnContract?id=${rentContract.id}" onclick="return confirmx('确认要正常退租吗?', this.href)">正常退租</a>
    					<a href="${ctx}/contract/rentContract/earlyReturnContract?id=${rentContract.id}" onclick="return confirmx('确认要提前退租吗?', this.href)">提前退租</a>
    					<a href="${ctx}/contract/rentContract/lateReturnContract?id=${rentContract.id}" onclick="return confirmx('确认要逾期退租吗?', this.href)">逾期退租</a>
    					<a href="${ctx}/contract/rentContract/specialReturnContract?id=${rentContract.id}" onclick="return confirmx('确认要特殊退租吗?', this.href)">特殊退租</a>
    					<a href="${ctx}/contract/rentContract/changeContract?id=${rentContract.id}" onclick="return confirmx('确认要协议变更吗?', this.href)">协议变更</a>
    					<a href="${ctx}/contract/rentContract/renewContract?id=${rentContract.id}" onclick="return confirmx('确认要人工续签吗?', this.href)">人工续签</a>
					</c:if>
					<c:if test="${rentContract.contractStatus=='6' && rentContract.contractBusiStatus=='2'}">
    					<a href="${ctx}/contract/rentContract/toReturnCheck?id=${rentContract.id}" onclick="return confirmx('确认要正常退租核算吗?', this.href)">正常退租核算</a>
					</c:if>
					<c:if test="${rentContract.contractStatus=='6' && rentContract.contractBusiStatus=='1'}">
    					<a href="${ctx}/contract/rentContract/toEarlyReturnCheck?id=${rentContract.id}" onclick="return confirmx('确认要提前退租核算吗?', this.href)">提前退租核算</a>
					</c:if>
					<c:if test="${rentContract.contractStatus=='6' && rentContract.contractBusiStatus=='3'}">
    					<a href="${ctx}/contract/rentContract/toLateReturnCheck?id=${rentContract.id}" onclick="return confirmx('确认要逾期退租核算吗?', this.href)">逾期退租核算</a>
					</c:if>
					<c:if test="${rentContract.contractStatus=='6' && rentContract.contractBusiStatus=='10'}">
    					<a href="${ctx}/contract/rentContract/toSpecialReturnCheck?id=${rentContract.id}" onclick="return confirmx('确认要特殊退租核算吗?', this.href)">特殊退租核算</a>
					</c:if>
					<c:if test="${rentContract.contractStatus!='0' && rentContract.contractStatus!='1'}">
    					<a href="javascript:void(0);" onclick="auditHis('${rentContract.id}')">审核记录</a>
					</c:if>
					<!--<a href="${ctx}/contract/rentContract/delete?id=${rentContract.id}" onclick="return confirmx('确认要删除该出租合同吗?', this.href)">删除</a>-->
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>