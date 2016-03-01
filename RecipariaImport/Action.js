var Action = function() {};

Action.prototype = {
  
run: function(parameters) {
   parameters.completionFunction({"body": document.body.innerHTML});
},
  
finalize: function(parameters) {
  
}
  
};

var ExtensionPreprocessingJS = new Action