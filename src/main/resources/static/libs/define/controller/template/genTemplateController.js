define([ 'app', '$httpRequest', '$page', '$ctx', '$jBoxcm' ], function(app,
		$httpRequest, $state, $page, $ctx, $jBoxcm) {
	return function($scope, $rootScope, $httpRequest, $state, $page, $ctx,
			$jBoxcm) {

		$scope.submitForm = function() {
			$('#addFileModal').modal('show');
		};
		
		$scope.addConfirmForm = function(){
			var fd = new FormData();
			var file = document.querySelector('input[id=addFile]').files[0];
	        fd.append('file', file); 
	        $scope.upload(fd,$ctx.getWebPath() + "template/genTemplate/upload",$scope.genTemplate,'#addFileModal');
		}

		$scope.searchForm = function(message) {
			var pageId = 1;
			if (message != undefined) {
		        pageId = $page.getPageId(message);
				if(pageId == -1){
					return;
				}
			} 
			$scope.query.page = pageId;
			$scope.request.page.current = pageId;
			
			$httpRequest.post($ctx.getWebPath() + "template/genTemplate/list",
					$scope.request).then(function(res) { 
				if (res.success) {
					data = res.data;
					$scope.genTemplateList = data;
					$page.setPage($scope, res.page.total);
					setTimeout(function(){
						$jBoxcm.delConfrim($scope);
					},800);
				} else {
					$jBoxcm.error("查询数据失败," + res.errorMessage);
				}
			});
		};

		$scope.deleteForm = function(index) {
			$httpRequest.post(
					$ctx.getWebPath() + "template/genTemplate/delete/"+$scope.genTemplateList[index].id).then(function(res) {
				if (res.success) {
					$jBoxcm.success("删除数据成功");
					$state.reload($scope.currentRouteName);
				} else {
					$jBoxcm.error("删除数据失败," + res.errorMessage);
				}
			});
		};

		$scope.updateForm = function() {
			$httpRequest.post($ctx.getWebPath() + "template/genTemplate/save",
					$scope.updateGenTemplate).then(function(res) {
				if (res.success) {
					$('#updateModal').modal('hide');
					setTimeout(function() {
						$state.reload($scope.currentRouteName);
						$jBoxcm.success("修改数据成功");
					}, 500);
				} else {
					$jBoxcm.error("修改数据失败," + res.errorMessage);
				}
			});
		}

		$scope.updateModal = function(index) {
			angular.copy($scope.genTemplateList[index],$scope.updateGenTemplate);
			$scope.queryTemplatParam($scope.updateGenTemplate.id,function(data){
				$scope.updateGenTemplate.genFieldColumn = data;
				if($scope.updateGenTemplate.genFieldColumn == undefined) {
					$scope.updateGenTemplate.genFieldColumn = [{}];
				}
				$('#updateModal').modal('show');
			});
		}

		$scope.initPageBack = function(request) {
			if ($scope.query == undefined || $scope.query.page == undefined) {
				$scope.request.page.current = request.page.current;
			} else {
				$scope.request.page.current = $scope.query.page;
			}
			$scope.request.page.size = request.page.size;
			return $scope.searchForm();
		};
		
		$scope.wikiModal = function(index) {
			var wikiUri = $scope.genTemplateList[index].wikiUri;
			if(wikiUri != undefined && wikiUri != null ){
				var wikiUrl = $ctx.getWikiUrl(wikiUri);
			    window.open(wikiUrl);    
			} else {
				$jBoxcm.error("没有填写wiki地址");
			}
		}

		this.init = function() {
			$scope.currentRouteName = $state.current.name;
			$scope.currentRouteUrl = $state.current.url;
			$scope.request = {page : {current : "",size : ""},data : {}};
			$scope.updateGenTemplate = {genFieldColumn:[]};
			$scope.genTemplate = {"version":"1.0.0","genFieldColumn":[{},{}]};
			$page.init($scope, $page.getPageSize());
			$scope.queryBaseTableList();
			$scope.searchLanguageList = [{"name":"-- 全部 --"}]
			$ctx.getEnum($rootScope,"languageEnum",function(result){
				$scope.$apply(function () {
					$scope.languageEnums = result;
					for(var i in result){
						$scope.searchLanguageList.push(result[i]);
					}
				});
			});
			$ctx.getEnum($rootScope,"templateTypeEnum",function(result){
				$scope.$apply(function () {
					$scope.templateTypeEnums = result;
				});
			});
		}
		
		$scope.detailModal = function(index){
			$scope.detailGenTemplate = $scope.genTemplateList[index];
			$scope.queryTemplatParam($scope.detailGenTemplate.id,function(data){
				$scope.detailGenTemplate.genFieldColumn = data;
			    $('#detailModal').modal('show');
			});
		}
		
		$scope.genModal = function(index){
			$scope.createGenTemplate = {templateName:"",params:[],templateId:""};
			$scope.createGenTemplate.templateId = $scope.genTemplateList[index].id;
			$scope.createGenTemplate.templateName = $scope.genTemplateList[index].templateName;
			$scope.createGenTemplate.templateType = $scope.genTemplateList[index].templateType;
			$scope.createGenTemplate.templateTypeName = $scope.genTemplateList[index].templateTypeName;

			$scope.queryTemplatParam($scope.createGenTemplate.templateId,function(data){
			    $scope.createGenTemplate.params = data;
			    $('#genModal').modal('show');
			});
			
		}
		
		$scope.queryTemplatParam  = function(templateId,callback){
			if(templateId != -1 && templateId != 0){
				$httpRequest.post($ctx.getWebPath() + "template/genTemplate/params/"+templateId).then(function(res) {
					if (res.success) {
						data = res.data;
						for(var i in data){
							data[i].value = res.data[i].defaultValue;
							if(data[i].isNull == 0){
								data[i].isNullName = "否";
							} else {
								data[i].isNullName = "是";
							}
						}
						callback(data);
					} else {
						$jBoxcm.error("查询数据失败," + res.errorMessage);
					}
				});
			}
		}
		
		$scope.queryBaseTableList = function() {
			$httpRequest.post($ctx.getWebPath()+"template/genTemplate/queryTableList").then(
					function(res) { 
						$scope.genTableList = [{"genTableName":"--无--"}]
						$scope.tableList = res.data;
						if(res.data != undefined){
							for(var i in res.data){
								$scope.genTableList.push(res.data[i]);
							}
						}
					});
		};
		
		$scope.createGenForm = function(){
			if($scope.createGenTemplate.tableName.indexOf("无") != -1){
				$scope.createGenTemplate.tableName = undefined;
			}
			$httpRequest.post($ctx.getWebPath() + "template/genTemplate/gen",$scope.createGenTemplate).then(
					function(res) { 
						if(res.success){
							var form = $httpRequest.form($ctx.getWebPath() + "template/genTemplate/download/gen/"+res.data,"POST");
							form.submit();
						} else {
							$jBoxcm.error("生成数据失败," + res.errorMessage);
						}
					});
		}
		
		$scope.updateFileModal = function(index){
			$scope.updateFileBasePath =  $scope.genTemplateList[index].fileBasePath;
			angular.copy($scope.genTemplateList[index],$scope.updateGenTemplate);
			$('#updateFileModal').modal('show');
		}
		
		$scope.updateConfirmForm = function(){
			var fd = new FormData();
			var file = document.querySelector('input[id=updateFile]').files[0];
	        fd.append('file', file); 
	        fd.append('fileBasePath', $scope.updateFileBasePath); 
	        $scope.upload(fd,$ctx.getWebPath() + "template/genTemplate/updateFile",$scope.updateGenTemplate,'#updateFileModal');
		}
		
		$scope.upload = function(fd,url,genTemplate,fileId){
			 $httpRequest.upload(url,fd).then(function(res) {
		        		$(fileId).modal('hide');
						if (res.success) { 
							genTemplate.fileBasePath = res.data;
							$httpRequest.post($ctx.getWebPath() + "template/genTemplate/save",
									genTemplate).then(function(res) {
								if (res.success) {
									 setTimeout(function() {
										 $jBoxcm.success("保存数据成功");
										 $state.reload($scope.currentRouteName);
				  					  }, 500);
								} else {
									$jBoxcm.error("保存数据失败," + res.errorMessage);
								}
							});
						} else {
							$jBoxcm.error("保存数据失败," + res.errorMessage);
						}
					});
		}
		
		$scope.downloadModal = function (index){
			var form = $httpRequest.form($ctx.getWebPath() + "template/genTemplate/download/template/"+$scope.genTemplateList[index].id,"POST");
       	 	form.submit();
		}
		
		$scope.addGenFieldColumn = function(){
			$scope.genTemplate.genFieldColumn.push({});
		}
		
		$scope.updateAddGenFieldColumn = function(){
			$scope.updateGenTemplate.genFieldColumn.push({});
		}
		
		$scope.deleteGenFieldColumn = function(index){
			var genFieldColumn = $scope.genTemplate.genFieldColumn;
			var tempFieldColumn = [];
			for(var i = 0 ; i  < genFieldColumn.length; i++) {
			    if(i != index) {
			    	tempFieldColumn.push(genFieldColumn[i]);
			    }
			}
			$scope.genTemplate.genFieldColumn = tempFieldColumn;
		}
		
		$scope.updateDeleteGenFieldColumn = function(index){
			var genFieldColumn = $scope.updateGenTemplate.genFieldColumn;
			var tempFieldColumn = [];
			for(var i = 0 ; i  < genFieldColumn.length; i++) {
			    if(i != index) {
			    	tempFieldColumn.push(genFieldColumn[i]);
			    }
			}
			$scope.updateGenTemplate.genFieldColumn = tempFieldColumn;
		}
		
	};
});