
function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady',   function() {
                                  callback(WebViewJavascriptBridge)
                                  }, false)
    }
}


connectWebViewJavascriptBridge(function(bridge) {
                               
                               bridge.init(function(message, responseCallback) {
                                           
                                           // 返回顶部
                                           if (message == "1")
                                           document.getElementById('top').scrollIntoView(true);
                                           
                                           // 跳到详情
                                           if (message == "2")
                                           document.getElementById('detail').scrollIntoView(true);
                                           })
                               
                               
                               
                               bridge.registerHandler('imagesDownloadComplete',
                                                      
                                                      function(data,responseCallback){
                                                      var allImage = document.querySelectorAll("img");
                                                      allImage = Array.prototype.slice.call(allImage, 0);
                                                        
                                                      allImage.forEach(function(image) {
                                                                       if (image.getAttribute("esrc") == data[0] || image.getAttribute("esrc") == decodeURIComponent(data[0])) {
                                                                       image.src = data[1];
                                                                       }
                                                                       });
                                                      
                                                      })
                               
                               })




function onLoaded() {
    
    connectWebViewJavascriptBridge(function(bridge) {
                                   
                                   var allImage = document.querySelectorAll("img");
                                   allImage = Array.prototype.slice.call(allImage, 0);
                                   var imageUrlsArray = new Array();
                                   allImage.forEach(function(image) {
                                                    var esrc = image.getAttribute("esrc");
                                                    var newLength = imageUrlsArray.push(esrc);
                                                    });
                                   
                                   bridge.send(imageUrlsArray);
                                   
                                   });
    
    
}




