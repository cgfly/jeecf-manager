define([ 'app', '$httpRequest', '$page', '$ctx', '$jBoxcm' ], function(app,
		$httpRequest, $state, $page, $ctx, $jBoxcm) {
	return function($scope, $rootScope, $httpRequest, $state, $page, $ctx,
			$jBoxcm) {

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
			
			$httpRequest.post($ctx.getWebPath() + "template/genTemplateAll/list",
					$scope.request).then(function(res) { 
				if (res.success) {
					data = res.data;
					$scope.genTemplateAllList = data;
					$page.setPage($scope, res.page.total);
					setTimeout(function(){
						$jBoxcm.delConfrim($scope);
					},800);
				} else {
					$jBoxcm.error("查询数据失败," + res.errorMessage);
				}
			});
		};

		$scope.initPageBack = function(request) {
			if ($scope.query == undefined || $scope.query.page == undefined) {
				$scope.request.page.current = request.page.current;
			} else {
				$scope.request.page.current = $scope.query.page;
			}
			$scope.request.page.size = request.page.size;
			return $scope.searchForm();
		};

		this.init = function() {
			$scope.currentRouteName = $state.current.name;
			$scope.currentRouteUrl = $state.current.url;
			$scope.request = {page : {current : "",size : ""},data : {}};
			$page.init($scope, $page.getPageSize());
			$scope.searchLanguageList = [{"name":"-- 全部 --"}]
			$ctx.getEnum($rootScope,"languageEnum",function(result){
				$scope.$apply(function () {
					$scope.languageEnums = result;
					for(var i in result){
						$scope.searchLanguageList.push(result[i]);
					}
				});
			});
		}

		
		$scope.downloadModal = function (index){
			var form = $httpRequest.form($ctx.getWebPath() + "template/genTemplateAll/download/template/"+$scope.genTemplateAllList[index].id,"POST");
       	 	form.submit();
		}
		
		$scope.wikiModal = function(index) {
			var wikiUri = $scope.genTemplateAllList[index].wikiUri;
			if(wikiUri != undefined && wikiUri != null ){
				var wikiUrl = $ctx.getWikiUrl(wikiUri);
			    window.open(wikiUrl);    
			} else {
				$jBoxcm.error("没有填写wiki地址");
			}
		}
		
		$scope.addModal = function(index){
			$httpRequest.post($ctx.getWebPath() + "template/genTemplateAll/add/"+ $scope.genTemplateAllList[index].id,
					null).then(function(res) { 
				if (res.success) {
					$jBoxcm.success("添加数据成功");
				} else {
					$jBoxcm.error("添加数据失败," + res.errorMessage);
				}
			});
		}
		
		$scope.detailModal = function(index){
			$scope.detailGenTemplate = $scope.genTemplateAllList[index];
			$scope.queryTemplatParam($scope.detailGenTemplate.id,function(data){
				$scope.detailGenTemplate.genFieldColumn = data;
			    $('#detailModal').modal('show');
			});
		}
		
		$scope.queryTemplatParam  = function(templateId,callback){
			if(templateId != -1 && templateId != 0){
				$httpRequest.post($ctx.getWebPath() + "template/genTemplateAll/params/"+templateId).then(function(res) {
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
		
	};
});