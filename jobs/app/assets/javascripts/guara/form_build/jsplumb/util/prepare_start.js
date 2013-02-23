(function() {

	// helper method to generate a color from a cycle of colors.
	var curColourIndex = 1, maxColourIndex = 24, nextColour = function() {
		var R,G,B;
		R = parseInt(128+Math.sin((curColourIndex*3+0)*1.3)*128);
		G = parseInt(128+Math.sin((curColourIndex*3+1)*1.3)*128);
		B = parseInt(128+Math.sin((curColourIndex*3+2)*1.3)*128);
		curColourIndex = curColourIndex + 1;
		if (curColourIndex > maxColourIndex) curColourIndex = 1;
		return "rgb(" + R + "," + G + "," + B + ")";
	 };	
		
	window.jsPlumbDemo = { 
		step: 0,

		start: function(){
			//if(!this.started){
				document.onselectstart = function () { return false; };
			    var newMode = jsPlumb.setRenderMode(jsPlumb.SVG);
				this.init();

				this.started = true;
				$('#save_steps').removeAttr('disabled');
			//}
		},

		init: function(){
						
			// setup some defaults for jsPlumb.	
			jsPlumb.importDefaults({
				Endpoint : ["Dot", {radius:2}],
				HoverPaintStyle : {strokeStyle:"#42a62c", lineWidth:2 },
				ConnectionOverlays : [
					[ "Arrow", { 
						location:1,
						id:"arrow",
	                    length:14,
	                    foldback:0.8
					} ],
	                [ "Label", { label:"Start", id:"label" }]
				]
			});

            // initialise draggable elements.  
			jsPlumb.draggable($(".w"));

            // bind a click listener to each connection; the connection is deleted. you could of course
			// just do this: jsPlumb.bind("click", jsPlumb.detach), but I wanted to make it clear what was
			// happening.
			jsPlumb.bind("click", function(c) { 
				jsPlumb.detach(c); 
			});
				
			// make each ".ep" div a source and give it some parameters to work with.  here we tell it
			// to use a Continuous anchor and the StateMachine connectors, and also we give it the
			// connector's paint style.  note that in this demo the strokeStyle is dynamically generated,
			// which prevents us from just setting a jsPlumb.Defaults.PaintStyle.  but that is what i
			// would recommend you do. Note also here that we use the 'parent' option to assign the connections
			// that were dragged from this endpoint to some other element. This allows us to keep the parent element
			// draggable and have only the ".ep" div act as a connection source.
			$(".ep").each(function(i,e) {
				var p = $(e).parent();
				var maxConnections = 5;
				if($(p).attr('id')=='process')	maxConnections = 1;
				
				jsPlumb.makeSource($(e), {
					parent:p,				
					anchor:"Continuous",
					connector:[ "StateMachine", { curviness:20 } ],
					connectorStyle:{ strokeStyle:nextColour(), lineWidth:2 },
					maxConnections: maxConnections,
					onMaxConnections:function(info, e) {
						console.info("Maximum connections (" + info.maxConnections + ") reached");
					}
				});
			});

			// bind a connection listener. note that the parameter passed to this function contains more than
			// just the new connection - see the documentation for a full list of what is included in 'info'.
			// this listener changes the paint style to some random new color and also sets the connection's internal
			// id as the label overlay's text.
            jsPlumb.bind("connection", function(info) {
            	jsPlumbDemo.step++;
            	info.connection.setPaintStyle({strokeStyle:nextColour()});
                //info.connection.getOverlay("label").setLabel(info.connection.id);
                info.connection.getOverlay("label").setLabel('Con. '+jsPlumbDemo.step);
            });

            function eachSons(sons){
            	if(sons.length>0){
            		for(var i=0; i<sons.length; i++){
            			jsPlumb.detachAllConnections(sons[i].source_id);
			   			jsPlumb.detachAllConnections(sons[i].id);
	            		eachSons(sons[i].sons);
			   		}
			   	}
            }

            jsPlumb.bind("jsPlumbConnectionDetached", function(info) {
			   	if(info.sourceId=='process'){
			   		var cols = jsPlumb.getAllConnections();
			   		for(var i in cols){
			   			for(var j in cols[i]){
			   				jsPlumb.detachAllConnections(cols[i][j].sourceId);
			   				jsPlumb.detachAllConnections(cols[i][j].targetId);
			   			}
			   		}
			   	}
			   	else{
			   		var cons = son(info.targetId);
			   		eachSons(cons);
			   	}
			});

			// initialise all '.w' elements as connection targets.
            jsPlumb.makeTarget($(".w"), {
				dropOptions:{ hoverClass:"dragHover" },
				anchor:"Continuous"				
			});
		}
	};
	
})();