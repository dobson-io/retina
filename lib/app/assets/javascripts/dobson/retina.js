(function() {
  window.dobson = window.dobson || {};
  window.dobson.retina = {};
  
  window.dobson.retina.img = function(natWidth, natHeight, sources) {
  
    // Sanity
    if (sources.length == 0) {
      console.log("[dobson.retina]: error, no sources given");
      return;
    }
  
    // Init 
    var pr = Math.ceil(window.devicePixelRatio);  // always favor higher-res
    var path = sources[0][1]
    var dimArgs = ""
    
    for(i=0; i < sources.length; i++) {
      var thisMult = sources[i][0]
      var thisPath = sources[i][1]
      if (thisMult == pr) {
        path = thisPath;
      }
    }
    
    if (natWidth) {
      dimArgs = dimArgs + " width=" + natWidth
    }
    if (natHeight) {
      dimArgs = dimArgs + " height=" + natHeight
    }
    
    // Done
    document.write('<img src="' + path + '" ' + dimArgs + ' />')
    
  };
  
  // alias
  window.dobson.ri = window.dobson.retina.img
  
})();
