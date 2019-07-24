define([ 'jquery', 'app' ], function($, app) {
	app.factory('$genHelper', function() {
		var genJson = {
			 "type" : [
				     { "value":"String","label" :"String","jdbcTypes":"varchar,text"},
					 { "value":"Long","label" :"Long","jdbcTypes":"bigint"},
				     { "value":"Integer","label" :"Integer","jdbcTypes":"integer,int,tinyint"},
					 { "value":"Double","label" :"Double","jdbcTypes":"double"},
				     { "value":"java.util.Date","label" :"Date","jdbcTypes":"date,datetime,timestamp"},
					 { "value":"java.math.BigDecimal","label" :"BigDecimal","jdbcTypes":"bigdecimal,decimal"}
				]
		}
		
		
		return {
			getGenJson : function(){
				return genJson;
			},
			getTypes : function(){
				return genJson["type"];
			},
			toType : function(jdbcType){
				var type = jdbcType.split("(")[0];
				var types = this.getTypes();
				for(j in types){
				   var jdbcTypes = types[j]["jdbcTypes"].split(",");
				   for(k in jdbcTypes){
					  if(jdbcTypes[k] == type)
					     return types[j];
				   }
				}
				return "";
			},
			toField : function(jdbcField){
			    var re=/_(\w)/g;
			    return jdbcField.replace(re,function ($0,$1){
			        return $1.toUpperCase();
			    });
			},
			isKey : function(key){
				if(key == "1")
					return {"value":"1","label":"是"};
				return {"value":"0","label":""};
			}
		}
		
		
	
	});
});