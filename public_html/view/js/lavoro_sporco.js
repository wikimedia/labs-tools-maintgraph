/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

 /**
 * From a previous work of: NG, Yik-wai Jason (Contact & Support: ywng@ust.hk)
 */

_init(); 

var margin = {top: 15, right: 50, bottom: 100, left: 50},
	margin2 = {top: 500, right: 50, bottom: 50, left: 50},
	width = $(window).width() - margin.left - margin.right,
	height = 570 - margin.top - margin.bottom,
	height2 = 570 - margin2.top - margin2.bottom;

var ITWIKI = "https://it.wikipedia.org/wiki/";

var dict = {
    "Aggiungere template": ITWIKI+"Categoria:Aggiungere_template",
    "Aiutare": ITWIKI+"Categoria:Aiutare",
	"Categorizzare": ITWIKI+"Categoria:Categorizzare",
	"Controllare": ITWIKI+"Categoria:Controllare",
	"ControlCopy": ITWIKI+"Categoria:Controllare_copyright",
	"Correggere": ITWIKI+"Categoria:Correggere",
	"Dividere": ITWIKI+"Categoria:Dividere",
	"Enciclopedicita": ITWIKI+"Categoria:Verificare_enciclopedicit%E0",
	"Finzione": ITWIKI+"Categoria:Finzione_non_contestualizzata",
	"Localismo": ITWIKI+"Categoria:Localismo",
	"Organizzare": ITWIKI+"Categoria:Organizzare",
	"Orfane": ITWIKI+"Categoria:Pagine_orfane",
	"Recentismo": ITWIKI+"Categoria:Recentismo",
	"Senza fonti": ITWIKI+"Categoria:Senza_fonti",
	"Chiarire": ITWIKI+"Categoria:Chiarire",
	"Nessuna nota": ITWIKI+"Categoria:Contestualizzare_fonti",
	"Citazione necessaria": ITWIKI+"Categoria:Informazioni_senza_fonte",
	"Stub": ITWIKI+"Categoria:Stub",
	"Stub sezione": ITWIKI+"Categoria:Stub_sezione",
	"Tradurre": ITWIKI+"Categoria:Tradurre",
	"Unire": ITWIKI+"Categoria:Unire",
	"Voci non neutrali": ITWIKI+"Categoria:Voci_non_neutrali",
	"Voci senza uscita": ITWIKI+"Categoria:Voci_senza_uscita",
	"Wikificare": ITWIKI+"Categoria:Wikificare",
};

var maxY=findMaxY();
var minY=findMinY();
var mousePickerDate;
var currIndex=data2[0].priceList.length-1;

var x = d3.time.scale()
	.range([0, width-400]),
	x2 = d3.time.scale()
	.range([0, width-400]);

var y = d3.scale.linear()
	.range([height, 0]),
	y2 = d3.scale.linear()
	.range([height2, 0]);

var xAxis = d3.svg.axis()
	.scale(x)
	.orient("bottom");
	xAxis2 = d3.svg.axis()
	.scale(x2).orient("bottom");

var yAxis = d3.svg.axis()
	.scale(y)
	.orient("left")
	.tickFormat(d3.format("d"));

var line = d3.svg.line()
	.interpolate("linear")
	.x(function(d) { return x(d.date); })
	.y(function(d) { return y(d.price); });

var svg = d3.select("#graph").append("svg")
	.attr("width", width - 90 + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom);

//the main graphic component of the plot
var focus=svg.append("g")
.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//for slider part-----------------------------------------------------------------------------------
var brush = d3.svg.brush()//for slider bar at the bottom
.x(x2)
.on("brush", brushed);

var context = svg.append("g")
.attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");

//append click path for controlling the sliding of curve, clip those part out of bounds
svg.append("defs").append("clipPath") 
.attr("id", "clip")
.append("rect")
.attr("width", width-400)
.attr("height", height); 

x.domain([data2[0].priceList[0].date,data2[0].priceList[data2[0].priceList.length-1].date]); 
y.domain([minY-Math.ceil((maxY-minY)/7),maxY+Math.ceil((maxY-minY)/7)]);
x2.domain(x.domain());//the domain axis for the bar at the bottom

context.append("g")
  .attr("class", "x axis")
  .attr("transform", "translate(0," + height2 + ")")
  .call(xAxis2);
  
var contextArea = d3.svg.area()
	.interpolate("monotone")
	.x(function(d) { return x2(d.date); })
	.y0(height2)
	.y1(0);

//plot the rect as the bar at the bottom
context.append("path")
	.attr("class", "area")
	.attr("d", contextArea(data2[0].priceList))
	.attr("fill", "#FFFF8D");
	
//append the brush for the selection of subsection  
context.append("g")
	.attr("class", "x brush")
	.call(brush)
	.selectAll("rect")
	.attr("height", height2)
	.attr("fill", "SkyBlue");  
//end slider part-----------------------------------------------------------------------------------

//x,y-axis for the plot
focus.append("g")
	.attr("class", "x axis")
	.attr("transform", "translate(0," + height + ")")
	.call(xAxis);

focus.append("g")
	.attr("class", "y axis")
	.call(yAxis)
	.append("text")
	.attr("transform", "rotate(-90)")
	.attr("y", 6)
	.attr("dy", ".71em")
	.style("text-anchor", "end")
	.text("Voci");

//curving part of those funds------------------------------------------------------------------------
var fund = focus.selectAll(".fund")
		.data(data2)
		.enter().append("g")
		.attr("class", "fund");

fund.append("path")
	.attr("class", "line")
	.attr("clip-path", "url(#clip)")//use clip path to make irrelevant part invisible
	.attr("d", function(d) { if(d.vis=="1"){return line(d.priceList);} else{ return null;} })
	.style("stroke", function(d) { return colors(d.name); });

//fund name label
fund.append("text")
	.attr("class", "fundNameLabel")
	.attr("x", function(d, i) {if(i<12) {return width-315;} else {return width-160;}})
	.attr("y", function(d, i) {if(i<12) {return i*45+2;} else {return (i-12)*45+2;}})
	.text( function (d) { return d.name; })
	.style("font-family", "sans-serif")
	.style("font-size", "12px")
	.style("cursor","pointer")
	.style("font-weight", function(d) { if(d.vis=="1") {return "bold";} else{ return null;} })
	.attr("fill", "black")
	.on("click", function(d) { window.open(dict[d.name]); })
	.on("touchstart", function(d) { window.open(dict[d.name]); });

//fund select or dis-select btn
fund.append("rect")
	.attr("height",12)
	.attr("width", 25)
	.attr("x",function(d, i) {if(i<12) {return width-345;} else { return width-190;}})
	.attr("y",function(d, i) {if(i<12) {return i*45-8;} else {return (i-12)*45-8;}})
	.attr("stroke", function(d) {return colors(d.name);})
	.attr("fill",function(d) {if(d.vis=="1"){return colors(d.name);}else{return "white";}})
	.on("touchstart", function(d) { 
				if(d.vis=="1"){
					d.vis="0";
				}
				else{
					d.vis="1";
				} 
				maxY=findMaxY();
				minY=findMinY();
				if (minY == 9999999) {
					y.domain([0,0]);
				} else {
					y.domain([minY-Math.ceil((maxY-minY)/7),maxY+Math.ceil((maxY-minY)/7)]);
				}
				focus.select(".y.axis").call(yAxis);
				
				fund.select("path").transition()//update curve 
					.attr("d", function(d) { if(d.vis=="1"){return line(d.priceList);} else{ return null;} })
			
				fund.select("rect").transition()//update legend 
					.attr("fill",function(d) {if(d.vis=="1"){return colors(d.name);}else{return "white";}});
					
				fund.select("text").transition()//update bold text
					.style("font-weight", function(d) { if(d.vis=="1"){return "bold";} else{ return null;} })
					
		})  
	.on("click", function(d) { 
				if(d.vis=="1"){
					d.vis="0";
				}
				else{
					d.vis="1";
				} 
				maxY=findMaxY();
				minY=findMinY();
				if (minY == 9999999) {
					y.domain([0,0]);
				} else {
					y.domain([minY-Math.ceil((maxY-minY)/7),maxY+Math.ceil((maxY-minY)/7)]);
				}
				focus.select(".y.axis").call(yAxis);
				
				fund.select("path").transition()//update curve 
					.attr("d", function(d) { if(d.vis=="1"){return line(d.priceList);} else{ return null;} })
			
				fund.select("rect").transition()//update rect legend 
					.attr("fill",function(d) {if(d.vis=="1"){return colors(d.name);}else{return "white";}});
					
				fund.select("text").transition()//update bold text
					.style("font-weight", function(d) { if(d.vis=="1"){return "bold";} else{ return null;} })
					
				pickerValue.select("text").transition()//update bold value
					.style("font-weight", function(d) { if(d.vis=="1"){return "bold";} else{ return null;} })
		});  
//end of curving part of those funds-------------------------------------------------------------	
		
//mouse picker related, hover line---------------------------------------------------------------
var pickerValue = focus.selectAll(".pickerValue")//for displaying fund unit price 
	.data(data2)
	.enter().append("g")
	.attr("class", "pickerValue");
	
var valueChange = focus.selectAll(".valueChange")//for displaying unit price percentage change
	.data(data2)
	.enter().append("g")
	.attr("class", "valueChange");
	
var	hoverLineGroup = focus.append("g") //the vertical line across the plots
	.attr("class", "hover-line");
			
var DateLbl = focus.append("g")  //the date label at the right upper corner part
	.attr("class", "dateLabel");

//check the mouse event over the plot area and do the processing 
container = document.querySelector('#graph');
$(container).mouseleave(function(event) {
	handleMouseOutGraph(event);
	//console.log("mouse leave");
})
$(container).mousemove(function(event) {
	handleMouseOverGraph(event);
	//console.log("mouse move on graph");
})		

mousePickerDate=getValueForPositionXFromData(width-400);//initial pick date is the last day of the plot
//for displaying fund unit price
pickerValue.append("text")
	.attr("class", "valuesLabel")
	.attr("x",function(d, i) {if(i<12) {return width-345;} else { return width-190;}})
	.attr("y",function(d, i) {if(i<12) {return i*45+17;} else {return (i-12)*45+17;}})
	.style("font-weight", function(d) { if(d.vis=="1"){return "bold";} else{ return null;} })
	.text( function (d) { 
		var dateStr="";
		//console.log(mousePickerDate);
		dateStr+=mousePickerDate.getFullYear();
		if(mousePickerDate.getMonth()+1<10){
			dateStr+="0"+(mousePickerDate.getMonth()+1);
		}else{
			dateStr+=(mousePickerDate.getMonth()+1);
		}
		if(mousePickerDate.getDate()<10){
			dateStr+="0"+mousePickerDate.getDate();
		}else{
			dateStr+=mousePickerDate.getDate();
		}
		//console.log(dateStr);
		currIndex=DateMapIndex.get(dateStr);
		return d.priceList[currIndex].price; 
	})
	.style("font-family", "sans-serif")
	.style("font-size", "12px")
	.attr("fill", function(d) { return colors(d.name); });  
	   
//for displaying unit price percentage change
valueChange.append("text")
	.attr("class", "valuesLabel")
	.attr("x",function(d, i) {if(i<12) {return width-300;} else { return width-145;}})
	.attr("y",function(d, i) {if(i<12) {return i*45+15;} else {return (i-12)*45+15;}})
	.text( function (d) { 
		var percentChange;
		if(d.priceList[currIndex]&&d.priceList[currIndex-1])
			percentChange=(d.priceList[currIndex].price-d.priceList[currIndex-1].price)/d.priceList[currIndex-1].price*100;
		if(percentChange<0){
			return "("+percentChange.toFixed(2)+"%)" 
		}else{
			return "(+"+percentChange.toFixed(2)+"%)" 
		}
	})
	.attr("font-family", "sans-serif")
	.attr("font-size", "15px")
	.attr("fill", function (d) {
		var percentChange;
		if(d.priceList[currIndex]&&d.priceList[currIndex-1])
			percentChange=(d.priceList[currIndex].price-d.priceList[currIndex-1].price)/d.priceList[currIndex-1].price*100;
		if(percentChange<0){
			return "red" 
		}else{
			return "black" 
		}
	});  
	
//end of mouse picker related, hover line

//for brusher of the slider bar at the bottom
function brushed() {
	x.domain(brush.empty() ? x2.domain() : brush.extent());
	fund.select("path").transition()//update curve 
		.attr("d", function(d) { if(d.vis=="1"){return line(d.priceList);} else{ return null;} })
	focus.select(".x.axis").call(xAxis);
}

//this function is mainly for accessing the colors
function getFundID(fundName){
	for(var i=0; i < data2.length; i++) {
		if(data2[i].name==fundName)
		  return i;
	}
}